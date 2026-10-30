#!/usr/bin/env python3
"""Download selected Linux AIRAC packages from Navigraph's downloads page."""

import argparse
import json
import re
import sys
from pathlib import Path

from playwright.sync_api import (
    Locator,
    Page,
    TimeoutError as PlaywrightTimeoutError,
    sync_playwright,
)


SCRIPT_DIRECTORY = Path(__file__).resolve().parent
DEFAULT_CONFIG = SCRIPT_DIRECTORY / "config.json"
DOWNLOADS_URL = "https://navigraph.com/downloads"
TABLE_READY_TIMEOUT_MS = 180_000
PROFILE_DIRECTORY = (
    Path.home()
    / ".local"
    / "share"
    / "navigraph-airac-downloader"
    / "browser-profile"
)
DOWNLOAD_TIMEOUT_MS = 120_000


def load_config(config_path: Path) -> tuple[Path, list[str]]:
    config = json.loads(config_path.read_text(encoding="utf-8"))
    if not isinstance(config, dict):
        raise ValueError("The config file must contain a JSON object.")

    target_path = config.get("target_download_path")
    packages = config.get("packages")
    if not isinstance(target_path, str) or not target_path.strip():
        raise ValueError("'target_download_path' must be a non-empty path string.")
    if (
        not isinstance(packages, list)
        or not packages
        or any(not isinstance(package, str) or not package.strip() for package in packages)
    ):
        raise ValueError("'packages' must be a non-empty list of package name strings.")

    target_directory = Path(target_path).expanduser()
    if not target_directory.is_absolute():
        target_directory = config_path.parent / target_directory
    return target_directory, packages


def find_package_row(page: Page, package_name: str) -> Locator | None:
    matching_rows = []
    for row in page.locator("tr, [role='row']").all():
        cells = row.locator("td, [role='cell'], [role='gridcell']")
        if cells.count() >= 2 and cells.nth(1).inner_text().strip() == package_name:
            matching_rows.append(row)

    if len(matching_rows) > 1:
        raise ValueError(f"More than one downloads row matched {package_name!r}.")
    return matching_rows[0] if matching_rows else None


def linux_download_control(row: Locator) -> Locator | None:
    for role in ("button", "link"):
        control = row.get_by_role(role, name=re.compile(r"^Linux$", re.IGNORECASE))
        if control.count():
            return control.first
    return None


def wait_for_download_table(page: Page, packages: list[str]) -> None:
    page.wait_for_function(
        """(packageNames) => {
            const normalize = (value) => value.replace(/\\s+/g, " ").trim();
            const rows = Array.from(document.querySelectorAll("tr, [role='row']"));
            return packageNames.every((packageName) =>
                rows.some((row) => {
                    const cells = Array.from(
                        row.querySelectorAll("td, [role='cell'], [role='gridcell']")
                    );
                    if (cells.length < 2 || normalize(cells[1].innerText) !== packageName) {
                        return false;
                    }

                    return Array.from(
                        row.querySelectorAll("button, a, [role='button'], [role='link']")
                    ).some((control) => {
                        const label = normalize(
                            control.innerText ||
                            control.getAttribute("aria-label") ||
                            control.getAttribute("title") ||
                            ""
                        );
                        return label.toLowerCase() === "linux" &&
                            control.getClientRects().length > 0;
                    });
                })
            );
        }""",
        arg=packages,
        timeout=TABLE_READY_TIMEOUT_MS,
    )


def download_packages(page: Page, target_directory: Path, packages: list[str]) -> int:
    failures = 0
    for package in packages:
        row = find_package_row(page, package)
        if row is None:
            print(f"ERROR: Package not found in the downloads table: {package}")
            failures += 1
            continue

        control = linux_download_control(row)
        if control is None:
            print(f"ERROR: No Linux download control found for: {package}")
            failures += 1
            continue

        try:
            with page.expect_download(timeout=DOWNLOAD_TIMEOUT_MS) as download_info:
                control.click()
            download = download_info.value
            destination = target_directory / download.suggested_filename
            download.save_as(destination)
        except PlaywrightTimeoutError:
            print(f"ERROR: Timed out waiting for the Linux download: {package}")
            failures += 1
            continue

        print(f"Downloaded {package} -> {destination}")

    return failures


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--config",
        type=Path,
        default=DEFAULT_CONFIG,
        help=f"JSON config path (default: {DEFAULT_CONFIG})",
    )
    arguments = parser.parse_args()

    try:
        target_directory, packages = load_config(arguments.config)
        target_directory.mkdir(parents=True, exist_ok=True)
        PROFILE_DIRECTORY.mkdir(parents=True, exist_ok=True)
    except (OSError, json.JSONDecodeError, ValueError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 1

    print(f"Downloads will be saved in: {target_directory}")
    print("A browser will open. Sign in to Navigraph if prompted.")

    with sync_playwright() as playwright:
        context = playwright.chromium.launch_persistent_context(
            user_data_dir=str(PROFILE_DIRECTORY),
            headless=False,
            accept_downloads=True,
        )
        try:
            page = context.pages[0] if context.pages else context.new_page()
            page.goto(DOWNLOADS_URL, wait_until="domcontentloaded")
            print(
                "Waiting for all configured packages and their Linux download "
                f"controls (up to {TABLE_READY_TIMEOUT_MS // 1000} seconds)..."
            )
            try:
                wait_for_download_table(page, packages)
            except PlaywrightTimeoutError:
                print(
                    "ERROR: The downloads table did not become ready in time. "
                    "Check that you are signed in and that all configured package "
                    "names are available.",
                    file=sys.stderr,
                )
                return 1
            failures = download_packages(page, target_directory, packages)
        finally:
            context.close()

    if failures:
        print(f"Finished with {failures} download error(s).", file=sys.stderr)
        return 1
    print("All configured downloads completed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
