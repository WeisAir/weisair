#!/usr/bin/env python3

import argparse
import csv
import logging
import os
import signal
from pathlib import Path
import re
import subprocess
import tkinter as tk

COMPONENTS = (
    ("usb", "USB"),
    ("udp_logger", "UDP Logger"),
    ("littlenavmap", "LittleNavmap"),
    ("debrief", "Debrief"),
    ("xplane", "X-Plane 12"),
)
STATES = {"not_started", "passed", "started", "failed"}
COLORS = {
    "not_started": "#777d86",
    "passed": "#38c172",
    "started": "#38c172",
    "failed": "#e34b4b",
}
BACKGROUND = "#171a1f"
FOREGROUND = "#f5f5f5"
POLL_INTERVAL_MS = 2000
HIDDEN_HEIGHT = 2
IMAGE_SUFFIXES = {".bmp", ".jpeg", ".jpg", ".png", ".tif", ".tiff", ".webp"}
DEFAULT_SCREENSHOTS_DIR = Path("/home/stephan/X-Plane 12/Output/screenshots")
MONITOR_PATTERN = re.compile(
    r"^\s*\d+:\s+\S+\s+(\d+)/\d+x(\d+)/\d+([+-]\d+)([+-]\d+)"
)


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="X-Plane launcher status bar")
    parser.add_argument("--height", type=int, default=20)
    parser.add_argument(
        "--screen",
        type=int,
        default=0,
        help="0-based monitor index from `xrandr --listmonitors`",
    )
    parser.add_argument(
        "--hover-width",
        type=int,
        default=100,
        help="width in pixels of the top-right hover trigger area",
    )
    parser.add_argument(
        "--close-action",
        choices=("close", "shutdown_apps"),
        default="close",
        help="whether the close button only closes the bar or also stops launcher apps",
    )
    parser.add_argument("--state-file", type=Path, required=True)
    parser.add_argument("--csv-file", type=Path, required=True)
    parser.add_argument(
        "--screenshots-dir", type=Path, default=DEFAULT_SCREENSHOTS_DIR
    )
    arguments = parser.parse_args()
    if arguments.height < 1:
        parser.error("--height must be a positive number of pixels")
    if arguments.screen < 0:
        parser.error("--screen must be a non-negative monitor index")
    if arguments.hover_width < 1:
        parser.error("--hover-width must be a positive number of pixels")
    return arguments


def list_monitor_geometries() -> list[tuple[int, int, int, int]]:
    result = subprocess.run(
        ["xrandr", "--listmonitors"],
        check=True,
        capture_output=True,
        text=True,
    )
    monitors = []
    for line in result.stdout.splitlines():
        match = MONITOR_PATTERN.match(line)
        if match:
            width, height, x, y = (int(value) for value in match.groups())
            monitors.append((width, height, x, y))
    if not monitors:
        raise RuntimeError("xrandr did not report any connected monitors")
    return monitors


def read_states(path: Path) -> dict[str, str]:
    states = {key: "not_started" for key, _ in COMPONENTS}
    states.update(
        {
            "debrief_pid": "",
            "simbrief_pid": "",
            "littlenavmap_pid": "",
        }
    )
    states["launcher_finished"] = "0"
    process_keys = {"debrief_pid", "simbrief_pid", "littlenavmap_pid"}
    with path.open(encoding="utf-8") as state_file:
        for line in state_file:
            key, separator, value = line.strip().partition("=")
            if separator and key in process_keys | {"launcher_finished"}:
                states[key] = value
            elif separator and key in states and value in STATES:
                states[key] = value
    return states


def process_is_running(process_id: int) -> bool:
    try:
        process_stat = Path(f"/proc/{process_id}/stat").read_text(encoding="utf-8")
    except FileNotFoundError:
        return False
    except OSError:
        logging.exception("Unable to inspect debrief process %s", process_id)
        return True

    _, separator, process_details = process_stat.rpartition(")")
    if not separator:
        logging.error("Unable to parse process state for PID %s", process_id)
        return True
    process_fields = process_details.split()
    return bool(process_fields and process_fields[0] != "Z")


def count_csv_records(path: Path) -> int:
    if not path.exists():
        return 0
    with path.open(newline="", encoding="utf-8") as csv_file:
        return max(sum(1 for _ in csv.reader(csv_file)) - 1, 0)


def count_screenshots(directory: Path) -> int:
    return sum(
        1
        for path in directory.iterdir()
        if path.is_file() and path.suffix.casefold() in IMAGE_SUFFIXES
    )


class LauncherStatusBar:
    def __init__(
        self,
        height: int,
        screen: int,
        hover_width: int,
        close_action: str,
        state_file: Path,
        csv_file: Path,
        screenshots_dir: Path,
    ) -> None:
        self.state_file = state_file
        self.csv_file = csv_file
        self.screenshots_dir = screenshots_dir
        try:
            self.initial_screenshot_count: int | None = count_screenshots(
                self.screenshots_dir
            )
        except OSError:
            logging.exception(
                "Unable to count screenshots in %s", self.screenshots_dir
            )
            self.initial_screenshot_count = None
        self.height = height
        self.hover_width = hover_width
        self.close_action = close_action
        self.root = tk.Tk()
        monitors = list_monitor_geometries()
        if screen >= len(monitors):
            self.root.destroy()
            raise ValueError(
                f"Screen index {screen} is unavailable; "
                f"{len(monitors)} monitor(s) were found"
            )
        self.screen_width, _, self.screen_x, self.screen_y = monitors[screen]
        self.hover_width = min(self.hover_width, self.screen_width)
        self.is_visible = True
        self.root.title("WeisAir X-Plane 12 Launcher Status")
        self.root.overrideredirect(True)
        self.root.attributes("-topmost", True)
        self.root.attributes("-type", "dock")
        self.root.configure(bg=BACKGROUND)
        self.root.resizable(False, False)
        self.set_window_height(height)
        self.root.bind("<Escape>", lambda _event: self.request_close())
        self.root.bind("<Button-3>", lambda _event: self.request_close())
        self.root.bind("<Enter>", self.show)
        self.root.bind("<Leave>", self.schedule_hide)
        self.root.protocol("WM_DELETE_WINDOW", self.request_close)
        self.hide_after_id: str | None = None

        container = tk.Frame(self.root, bg=BACKGROUND)
        container.pack(fill="both", expand=True)
        self.indicators: dict[str, tk.Canvas] = {}
        self.labels: dict[str, tk.Label] = {}

        for column, (key, label) in enumerate(COMPONENTS):
            container.grid_columnconfigure(column, weight=1)
            cell = tk.Frame(container, bg=BACKGROUND)
            cell.grid(row=0, column=column, sticky="nsew")
            content = tk.Frame(cell, bg=BACKGROUND)
            content.pack(expand=True)

            indicator = tk.Canvas(
                content,
                width=10,
                height=10,
                bg=BACKGROUND,
                highlightthickness=0,
            )
            indicator.create_oval(1, 1, 9, 9, fill=COLORS["not_started"], outline="")
            indicator.pack(side="left", padx=(0, 4))
            self.indicators[key] = indicator

            label_widget = tk.Label(
                content,
                text=label,
                bg=BACKGROUND,
                fg=FOREGROUND,
                font=("Sans", 8),
            )
            label_widget.pack(side="left")
            self.labels[key] = label_widget

        close_button = tk.Button(
            self.root,
            text="x",
            command=self.request_close,
            bg=BACKGROUND,
            fg=FOREGROUND,
            activebackground=BACKGROUND,
            activeforeground=FOREGROUND,
            borderwidth=0,
            font=("Sans", 8),
            padx=4,
            pady=0,
        )
        close_button.place(relx=1.0, x=-2, y=0, anchor="ne")
        self.screenshots_label = tk.Label(
            container,
            text="Screenshots: 0",
            bg=BACKGROUND,
            fg=FOREGROUND,
            font=("Sans", 8),
        )
        self.screenshots_label.grid(
            row=0, column=len(COMPONENTS), sticky="nsew", padx=(4, 14)
        )
        container.grid_columnconfigure(len(COMPONENTS), weight=1)
        self.root.after(1500, self.hide_if_pointer_outside)

    def request_close(self) -> None:
        if self.close_action == "shutdown_apps":
            try:
                states = read_states(self.state_file)
            except OSError:
                logging.exception("Unable to read app PIDs for status-bar shutdown")
                states = {}

            for key in ("littlenavmap_pid", "simbrief_pid"):
                value = states.get(key, "")
                if not value.isdecimal() or int(value) <= 1:
                    continue
                process_id = int(value)
                try:
                    process_group = os.getpgid(process_id)
                    if process_group != process_id:
                        logging.error(
                            "Not stopping %s: PID %s is not its process-group leader",
                            key,
                            process_id,
                        )
                        continue
                    os.killpg(process_group, signal.SIGTERM)
                    logging.info("Sent SIGTERM to %s process group %s", key, process_group)
                except ProcessLookupError:
                    logging.info("%s process %s has already exited", key, process_id)
                except OSError:
                    logging.exception("Unable to stop %s process group %s", key, process_id)
        self.close()

    def close(self) -> None:
        self.root.destroy()
        try:
            self.state_file.unlink(missing_ok=True)
        except OSError:
            logging.exception("Unable to remove launcher status state file")

    def set_window_height(self, height: int) -> None:
        self.root.geometry(
            f"{self.screen_width}x{height}{self.screen_x:+d}{self.screen_y:+d}"
        )

    def show(self, _event: tk.Event | None = None) -> None:
        if not self.is_visible and not self.pointer_is_in_hover_area():
            return
        if self.hide_after_id is not None:
            self.root.after_cancel(self.hide_after_id)
            self.hide_after_id = None
        self.set_window_height(self.height)
        self.is_visible = True

    def schedule_hide(self, _event: tk.Event) -> None:
        if self.hide_after_id is not None:
            self.root.after_cancel(self.hide_after_id)
        self.hide_after_id = self.root.after(250, self.hide_if_pointer_outside)

    def hide_if_pointer_outside(self) -> None:
        self.hide_after_id = None
        pointer_x, pointer_y = self.root.winfo_pointerxy()
        pointer_is_over_bar = (
            self.screen_x <= pointer_x < self.screen_x + self.screen_width
            and self.screen_y <= pointer_y < self.screen_y + self.height
        )
        if pointer_is_over_bar:
            return
        self.set_window_height(HIDDEN_HEIGHT)
        self.is_visible = False

    def pointer_is_in_hover_area(self) -> bool:
        pointer_x, pointer_y = self.root.winfo_pointerxy()
        return (
            self.screen_x + self.screen_width - self.hover_width
            <= pointer_x
            < self.screen_x + self.screen_width
            and self.screen_y <= pointer_y < self.screen_y + HIDDEN_HEIGHT
        )

    def refresh(self) -> None:
        try:
            states = read_states(self.state_file)
        except OSError:
            logging.exception("Unable to read launcher status state")
            states = {}

        for key, _ in COMPONENTS:
            state = states.get(key, "not_started")
            self.indicators[key].itemconfigure(
                1, fill=COLORS.get(state, COLORS["not_started"])
            )

        debrief_pid = states.get("debrief_pid", "")
        if debrief_pid.isdecimal() and not process_is_running(int(debrief_pid)):
            self.close()
            return
        if states.get("launcher_finished") == "1" and not debrief_pid:
            self.close()
            return

        try:
            record_count = count_csv_records(self.csv_file)
            self.labels["udp_logger"].configure(text=f"UDP Logger: {record_count}")
        except (OSError, csv.Error):
            logging.exception("Unable to count UDP logger CSV records")
            self.labels["udp_logger"].configure(text="UDP Logger: ?")

        try:
            screenshot_count = count_screenshots(self.screenshots_dir)
            if self.initial_screenshot_count is None:
                self.initial_screenshot_count = screenshot_count
            new_screenshots = max(
                screenshot_count - self.initial_screenshot_count, 0
            )
            self.screenshots_label.configure(
                text=f"Screenshots: {new_screenshots}"
            )
        except OSError:
            logging.exception(
                "Unable to count screenshots in %s", self.screenshots_dir
            )
            self.screenshots_label.configure(text="Screenshots: ?")

        self.root.after(POLL_INTERVAL_MS, self.refresh)

    def run(self) -> None:
        self.refresh()
        self.root.mainloop()


def main() -> None:
    arguments = parse_arguments()
    LauncherStatusBar(
        arguments.height,
        arguments.screen,
        arguments.hover_width,
        arguments.close_action,
        arguments.state_file,
        arguments.csv_file,
        arguments.screenshots_dir,
    ).run()


if __name__ == "__main__":
    main()
