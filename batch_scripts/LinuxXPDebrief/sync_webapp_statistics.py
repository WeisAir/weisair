#!/usr/bin/env python3
"""Publish interactive flight plots and PNG fallbacks for the static web app."""

import json
import os
import re
import shutil
import sys
from pathlib import Path
from urllib.parse import quote

SCRIPT_DIR = Path(__file__).resolve().parent
FLIGHT_DIRECTORY = SCRIPT_DIR / "flights"
STATISTICS_DIRECTORY = SCRIPT_DIR / "webapp" / "data" / "statistics"
MANIFEST_PATH = STATISTICS_DIRECTORY / "manifest.json"
FLIGHT_NAME_PATTERN = re.compile(
    r"^\d{8}_\d{4}_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+$"
)
RESPONSIVE_PLOT_CSS = """
html, body {
  width: 100%;
  min-width: 0;
  margin: 0;
}

div.gnuplot {
  width: 100%;
  overflow: hidden;
}

table.mbleft {
  width: 100%;
  table-layout: fixed;
}

table.mbleft > tbody > tr > td:first-child {
  width: 150px;
}

table.mbleft > tbody > tr > td:last-child {
  min-width: 0;
}

table.plot {
  width: 100%;
  table-layout: fixed;
}

canvas#gnuplot_canvas {
  display: block;
  width: 100%;
  height: auto;
}
"""
RESPONSIVE_PLOT_JS = """

gnuplot.getMouseCoordsWithinTarget = (function (getMouseCoords) {
  return function (event) {
    getMouseCoords.call(gnuplot, event);
    var plot = document.getElementById("gnuplot_canvas");
    if (plot) {
      var bounds = plot.getBoundingClientRect();
      if (bounds.width > 0 && bounds.height > 0) {
        gnuplot.mousex *= plot.width / bounds.width;
        gnuplot.mousey *= plot.height / bounds.height;
      }
    }
  };
})(gnuplot.getMouseCoordsWithinTarget);
"""


def prepare_interactive_plot(html_source, assets_name):
    html = html_source.read_text(encoding="utf-8")
    source_assets_name = html_source.stem + "_assets"
    if source_assets_name not in html or "</head>" not in html:
        raise ValueError(f"Interactive plot HTML has an unexpected format: {html_source}")

    html = html.replace(source_assets_name, assets_name)
    html = html.replace(
        "</head>",
        f"<style>{RESPONSIVE_PLOT_CSS}</style>"
        f"<script>{RESPONSIVE_PLOT_JS}</script>\n</head>",
        1,
    )
    return html


def publish_flight(flight_directory):
    flight_name = flight_directory.name
    if not FLIGHT_NAME_PATTERN.fullmatch(flight_name):
        raise ValueError(f"Unexpected flight directory name: {flight_name}")

    data_directory = flight_directory / "data"
    html_source = data_directory / f"{flight_name}.html"
    png_source = data_directory / f"{flight_name}.png"
    if not html_source.is_file() and not png_source.is_file():
        return None

    output_directory = STATISTICS_DIRECTORY / flight_name
    output_directory.mkdir(parents=True, exist_ok=True)
    html_path = None
    png_path = None
    version = str(
        max(
            source.stat().st_mtime_ns
            for source in (html_source, png_source)
            if source.is_file()
        )
    )

    if html_source.is_file():
        assets_source = data_directory / f"{flight_name}_assets"
        if not assets_source.is_dir():
            raise ValueError(f"Interactive plot assets are missing: {assets_source}")
        assets_name = f"{flight_name}_assets_{version}"
        assets_output = output_directory / assets_name
        shutil.copytree(assets_source, assets_output, dirs_exist_ok=True)
        html_output = output_directory / html_source.name
        html_output.write_text(
            prepare_interactive_plot(html_source, assets_name),
            encoding="utf-8",
        )
        html_path = quote(
            (Path("data") / "statistics" / flight_name / html_source.name).as_posix(),
            safe="/",
        )

    if png_source.is_file():
        shutil.copy2(png_source, output_directory / png_source.name)
        png_path = quote(
            (Path("data") / "statistics" / flight_name / png_source.name).as_posix(),
            safe="/",
        )

    return {"html": html_path, "png": png_path, "version": version}


def main():
    STATISTICS_DIRECTORY.mkdir(parents=True, exist_ok=True)
    flights = {}
    if FLIGHT_DIRECTORY.is_dir():
        for flight_directory in sorted(FLIGHT_DIRECTORY.iterdir()):
            if not flight_directory.is_dir():
                continue
            plot = publish_flight(flight_directory)
            if plot is not None:
                flights[flight_directory.name] = plot

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

    html_count = sum(plot["html"] is not None for plot in flights.values())
    png_count = sum(plot["png"] is not None for plot in flights.values())
    print(
        f"Published plots for {len(flights)} flights "
        f"({html_count} interactive, {png_count} PNG) to {STATISTICS_DIRECTORY}"
    )


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, json.JSONDecodeError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        raise SystemExit(1) from error
