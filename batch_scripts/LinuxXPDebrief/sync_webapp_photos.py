#!/usr/bin/env python3
"""Publish optimized flight captures and a static gallery manifest."""

import json
import os
import re
import sys
from pathlib import Path
from urllib.parse import quote

from PIL import Image, ImageOps

SCRIPT_DIR = Path(__file__).resolve().parent
FLIGHT_DIRECTORY = SCRIPT_DIR / "flights"
PHOTO_DIRECTORY = SCRIPT_DIR / "webapp" / "data" / "photos"
MANIFEST_PATH = PHOTO_DIRECTORY / "manifest.json"
FLIGHT_NAME_PATTERN = re.compile(r"^\d{8}_\d{4}_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+$")
IMAGE_SUFFIXES = {".png", ".jpg", ".jpeg", ".webp"}
MAX_IMAGE_DIMENSION = 1920
WEBP_QUALITY = 84


def load_previous_manifest():
    if not MANIFEST_PATH.exists():
        return {}
    with MANIFEST_PATH.open(encoding="utf-8") as manifest_file:
        manifest = json.load(manifest_file)
    if manifest.get("version") != 1 or not isinstance(manifest.get("flights"), dict):
        raise ValueError(f"Unsupported photo manifest format: {MANIFEST_PATH}")
    if (
        manifest.get("maxImageDimension") != MAX_IMAGE_DIMENSION
        or manifest.get("webpQuality") != WEBP_QUALITY
    ):
        return {}
    return manifest["flights"]


def optimize_capture(source, destination):
    with Image.open(source) as opened_image:
        image = ImageOps.exif_transpose(opened_image)
        image.thumbnail(
            (MAX_IMAGE_DIMENSION, MAX_IMAGE_DIMENSION),
            Image.Resampling.LANCZOS,
        )
        if image.mode not in ("RGB", "RGBA"):
            image = image.convert("RGBA" if "A" in image.getbands() else "RGB")

        temporary_path = destination.with_name(f".{destination.name}.{os.getpid()}.tmp")
        try:
            image.save(temporary_path, "WEBP", quality=WEBP_QUALITY, method=6)
            os.replace(temporary_path, destination)
        finally:
            temporary_path.unlink(missing_ok=True)

        return image.width, image.height


def sync_flight(flight_directory, previous_photos):
    flight_name = flight_directory.name
    if not FLIGHT_NAME_PATTERN.fullmatch(flight_name):
        raise ValueError(f"Unexpected flight directory name: {flight_name}")

    capture_directory = flight_directory / "capture"
    if not capture_directory.is_dir():
        return []

    output_directory = PHOTO_DIRECTORY / flight_name
    output_directory.mkdir(parents=True, exist_ok=True)
    previous_by_name = {
        photo["originalName"]: photo
        for photo in previous_photos
        if isinstance(photo, dict) and isinstance(photo.get("originalName"), str)
    }

    captures = sorted(
        (
            path
            for path in capture_directory.iterdir()
            if path.is_file() and path.suffix.lower() in IMAGE_SUFFIXES
        ),
        key=lambda path: path.name.casefold(),
    )
    photos = []

    for index, source in enumerate(captures, start=1):
        destination_name = f"photo-{index:03d}.webp"
        destination = output_directory / destination_name
        relative_path = (Path("data") / "photos" / flight_name / destination_name).as_posix()
        published_path = quote(relative_path, safe="/")
        source_stat = source.stat()
        previous = previous_by_name.get(source.name, {})

        unchanged = (
            previous.get("sourceSize") == source_stat.st_size
            and previous.get("sourceModifiedNs") == str(source_stat.st_mtime_ns)
            and previous.get("src") == published_path
            and destination.is_file()
            and isinstance(previous.get("width"), int)
            and isinstance(previous.get("height"), int)
        )
        if unchanged:
            width = previous["width"]
            height = previous["height"]
        else:
            width, height = optimize_capture(source, destination)

        photos.append(
            {
                "src": published_path,
                "originalName": source.name,
                "sourceSize": source_stat.st_size,
                "sourceModifiedNs": str(source_stat.st_mtime_ns),
                "size": destination.stat().st_size,
                "width": width,
                "height": height,
            }
        )

    active_files = {f"photo-{index:03d}.webp" for index in range(1, len(captures) + 1)}
    for generated_file in output_directory.glob("photo-*.webp"):
        if generated_file.name not in active_files:
            generated_file.unlink()

    return photos


def main():
    PHOTO_DIRECTORY.mkdir(parents=True, exist_ok=True)
    previous_flights = load_previous_manifest()
    flights = {}

    if FLIGHT_DIRECTORY.is_dir():
        for flight_directory in sorted(FLIGHT_DIRECTORY.iterdir()):
            if not flight_directory.is_dir():
                continue
            photos = sync_flight(flight_directory, previous_flights.get(flight_directory.name, []))
            if photos:
                flights[flight_directory.name] = photos

    manifest = {
        "version": 1,
        "maxImageDimension": MAX_IMAGE_DIMENSION,
        "webpQuality": WEBP_QUALITY,
        "flights": flights,
    }
    temporary_manifest = MANIFEST_PATH.with_name(f".{MANIFEST_PATH.name}.{os.getpid()}.tmp")
    try:
        with temporary_manifest.open("w", encoding="utf-8") as manifest_file:
            json.dump(manifest, manifest_file, ensure_ascii=False, indent=2)
            manifest_file.write("\n")
        os.replace(temporary_manifest, MANIFEST_PATH)
    finally:
        temporary_manifest.unlink(missing_ok=True)

    photo_count = sum(len(photos) for photos in flights.values())
    print(f"Published {photo_count} optimized screenshots for {len(flights)} flights to {PHOTO_DIRECTORY}")


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, json.JSONDecodeError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        raise SystemExit(1) from error
