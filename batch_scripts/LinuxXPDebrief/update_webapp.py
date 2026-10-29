#!/usr/bin/env python3
"""Refresh the static webapp from the debrief flight data."""

import filecmp
import os
import shutil
import subprocess
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
WEBAPP_DATA_DIRECTORY = SCRIPT_DIR / "webapp" / "data"
FLIGHT_LOG_SOURCE = SCRIPT_DIR / "FlightLog1.0.csv"
FLIGHT_LOG_DESTINATION = WEBAPP_DATA_DIRECTORY / "FlightLog1.0.csv"
SYNC_SCRIPTS = (
    "sync_webapp_photos.py",
    "sync_webapp_statistics.py",
    "sync_webapp_flight_paths.py",
)


def update_flight_log():
    if not FLIGHT_LOG_SOURCE.is_file() or not os.access(FLIGHT_LOG_SOURCE, os.R_OK):
        raise OSError(f"Flight log is missing or unreadable: {FLIGHT_LOG_SOURCE}")

    WEBAPP_DATA_DIRECTORY.mkdir(parents=True, exist_ok=True)
    if FLIGHT_LOG_DESTINATION.is_file() and filecmp.cmp(
        FLIGHT_LOG_SOURCE, FLIGHT_LOG_DESTINATION, shallow=False
    ):
        print(f"Flight log is already current: {FLIGHT_LOG_DESTINATION}")
        return

    temporary_path = FLIGHT_LOG_DESTINATION.with_name(
        f".{FLIGHT_LOG_DESTINATION.name}.{os.getpid()}.tmp"
    )
    try:
        shutil.copy2(FLIGHT_LOG_SOURCE, temporary_path)
        os.replace(temporary_path, FLIGHT_LOG_DESTINATION)
    finally:
        temporary_path.unlink(missing_ok=True)

    print(f"Updated flight log: {FLIGHT_LOG_DESTINATION}")


def update_flight_resources():
    for script_name in SYNC_SCRIPTS:
        script_path = SCRIPT_DIR / script_name
        if not script_path.is_file() or not os.access(script_path, os.R_OK):
            raise OSError(f"Webapp sync script is missing or unreadable: {script_path}")
        print(f"Running {script_name}")
        subprocess.run([sys.executable, str(script_path)], check=True)


def main():
    update_flight_log()
    update_flight_resources()


if __name__ == "__main__":
    try:
        main()
    except (OSError, subprocess.CalledProcessError) as error:
        print(f"ERROR: Webapp update failed: {error}", file=sys.stderr)
        raise SystemExit(1) from error
