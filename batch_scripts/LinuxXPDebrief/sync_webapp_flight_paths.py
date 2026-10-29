#!/usr/bin/env python3
"""Publish flight KML tracks and a manifest for the static web app."""

import json
import os
import re
import shutil
import sys
from pathlib import Path
from urllib.parse import quote

SCRIPT_DIR = Path(__file__).resolve().parent
FLIGHT_DIRECTORY = SCRIPT_DIR / "flights"
FLIGHT_PATH_DIRECTORY = SCRIPT_DIR / "webapp" / "data" / "flight-paths"
MANIFEST_PATH = FLIGHT_PATH_DIRECTORY / "manifest.json"
FLIGHT_NAME_PATTERN = re.compile(
    r"^\d{8}_\d{4}_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+$"
)


def publish_flight(flight_directory):
    flight_name = flight_directory.name
    if not FLIGHT_NAME_PATTERN.fullmatch(flight_name):
        raise ValueError(f"Unexpected flight directory name: {flight_name}")

    parts = flight_name.split("_")
    date, time = parts[:2]
    departure, arrival = parts[-2:]
    kml_source = flight_directory / "geo" / f"{departure}-{arrival}_{date}_{time}.kml"
    if not kml_source.is_file():
        return None

    output_name = f"{flight_name}.kml"
    output_path = FLIGHT_PATH_DIRECTORY / output_name
    kml_text = kml_source.read_text(encoding="utf-8")
    kml_text = kml_text.replace(
        "http://maps.google.com/mapfiles/kml/",
        "https://maps.google.com/mapfiles/kml/",
    )
    output_path.write_text(kml_text, encoding="utf-8")
    shutil.copystat(kml_source, output_path)
    return {
        "src": quote((Path("data") / "flight-paths" / output_name).as_posix(), safe="/"),
        "version": str(kml_source.stat().st_mtime_ns),
    }


def main():
    FLIGHT_PATH_DIRECTORY.mkdir(parents=True, exist_ok=True)
    flights = {}
    if FLIGHT_DIRECTORY.is_dir():
        for flight_directory in sorted(FLIGHT_DIRECTORY.iterdir()):
            if not flight_directory.is_dir():
                continue
            flight_path = publish_flight(flight_directory)
            if flight_path is not None:
                flights[flight_directory.name] = flight_path

    manifest = {"version": 1, "flights": flights}
    temporary_manifest = MANIFEST_PATH.with_name(
        f".{MANIFEST_PATH.name}.{os.getpid()}.tmp"
    )
    try:
        with temporary_manifest.open("w", encoding="utf-8") as manifest_file:
            json.dump(manifest, manifest_file, ensure_ascii=False, indent=2)
            manifest_file.write("\n")
        os.replace(temporary_manifest, MANIFEST_PATH)
    finally:
        temporary_manifest.unlink(missing_ok=True)

    print(f"Published flight paths for {len(flights)} flights to {FLIGHT_PATH_DIRECTORY}")


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, json.JSONDecodeError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        raise SystemExit(1) from error
