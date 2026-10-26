#!/usr/bin/env python3
"""Generate a gnuplot flight profile from an X-Plane UDP CSV log.

Edit X_AXIS and SERIES below to select the mapped fields to plot.
"""

from __future__ import annotations

import argparse
import csv
import math
import shutil
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


MAPPING_PATH = (
    Path(__file__).resolve().parent.parent
    / "batch_scripts"
    / "udpLogger"
    / "xplane_udp_mapping.csv"
)

X_AXIS = "zulu_time_h"
INVALID_VALUES = {-999.0}
TIME_TICK_SECONDS = 600


@dataclass(frozen=True)
class Series:
    column: str
    label: str
    axis: str = "y1"
    style: str = "lines"


SERIES = (
    Series("p-alt_ftMSL", "Altitude (ft)"),
    Series("vind_kias", "Indicated airspeed (kts)"),
    Series("flap_postn", "Flaps (deployment ratio)", "y2", "steps"),
    Series("sbrak_postn", "Speedbrake (deployment ratio)", "y2"),
    Series("gear_01", "Landing gear (deployed)", "y2", "steps"),
)

#Altitude:	group_20_field_6,p-alt_ftMSL
#Airspeed:	group_3_field_1,vind_kias
#Flaps: 		group_13_field_5,flap_postn
#Speedbrakes: 	group_13_field_8,sbrak_postn
#Gear:		group_14_field_1,gear_01
#Throttle 1:	group_26_field_1,thro1_engin
#Throttle 2:	group_26_field_2,thro2_engin
#Fuel Flow 1:	group_45_field_1,FF_1_gal_h
#Fuel Flow 2:	group_45_field_2,FF_2_gal_h


def load_mapping(path: Path) -> dict[str, str]:
    with path.open(newline="", encoding="utf-8-sig") as file:
        reader = csv.DictReader(file)
        if not reader.fieldnames or not {
            "generic_header",
            "human_readable_name",
        }.issubset(reader.fieldnames):
            raise ValueError(
                f"{path} must contain generic_header and human_readable_name columns"
            )
        return {
            row["human_readable_name"]: row["generic_header"]
            for row in reader
            if row.get("human_readable_name") and row.get("generic_header")
        }


def resolve_column(
    requested_name: str, fieldnames: list[str], mapping: dict[str, str]
) -> str | None:
    if requested_name in fieldnames:
        return requested_name
    generic_name = mapping.get(requested_name)
    if generic_name in fieldnames:
        return generic_name
    return None


def parse_zulu_seconds(value: str) -> float:
    hours = float(value)
    if not math.isfinite(hours) or not 0 <= hours < 24:
        raise ValueError(
            f"Zulu time must be a finite number from 0 to <24, got {value!r}"
        )
    return hours * 3600


def parse_measurement(value: str | None) -> float:
    if value is None or not value.strip():
        return math.nan
    measurement = float(value)
    if not math.isfinite(measurement) or measurement in INVALID_VALUES:
        return math.nan
    return measurement


def gnuplot_quote(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "\\'") + "'"


def zulu_label(seconds: float) -> str:
    whole_seconds = round(seconds) % 86400
    hours, remainder = divmod(whole_seconds, 3600)
    minutes = remainder // 60
    return f"{hours:02d}:{minutes:02d}Z"


def zulu_boundary_label(seconds: float) -> str:
    whole_seconds = round(seconds) % 86400
    hours, remainder = divmod(whole_seconds, 3600)
    minutes, seconds = divmod(remainder, 60)
    return f"{hours:02d}:{minutes:02d}:{seconds:02d}Z"


def make_xtics(minimum: float, maximum: float) -> str:
    first_tick = math.ceil(minimum / TIME_TICK_SECONDS) * TIME_TICK_SECONDS
    ticks = [(minimum, zulu_boundary_label(minimum))]
    ticks.extend(
        (tick, zulu_label(tick))
        for tick in range(first_tick, math.floor(maximum) + 1, TIME_TICK_SECONDS)
        if minimum < tick < maximum
    )
    if maximum != minimum:
        ticks.append((maximum, zulu_boundary_label(maximum)))
    return ", ".join(
        f"{gnuplot_quote(label)} {position:.3f}" for position, label in ticks
    )


def generate_plot(
    input_path: Path, mapping_path: Path, output_prefix: Path
) -> tuple[Path, Path]:
    mapping = load_mapping(mapping_path)
    with input_path.open(newline="", encoding="utf-8-sig") as file:
        reader = csv.DictReader(file)
        fieldnames = reader.fieldnames
        if not fieldnames:
            raise ValueError(f"{input_path} has no CSV header")
        rows = list(reader)

    x_column = resolve_column(X_AXIS, fieldnames, mapping)
    if x_column is None:
        raise ValueError(
            f"X-axis field {X_AXIS!r} is missing from {input_path}; "
            "check X_AXIS and the mapping file"
        )

    available_series: list[tuple[Series, str]] = []
    for series in SERIES:
        column = resolve_column(series.column, fieldnames, mapping)
        if column is None:
            print(
                f"Warning: field {series.column!r} ({series.label}) is missing; "
                "skipping this series.",
                file=sys.stderr,
            )
            continue
        available_series.append((series, column))
    if not available_series:
        raise ValueError(f"No configured plot fields were found in {input_path}")

    output_prefix.parent.mkdir(parents=True, exist_ok=True)
    data_path = output_prefix.with_suffix(".dat")
    plot_path = output_prefix.with_suffix(".gnuplot")
    image_path = output_prefix.with_suffix(".png")

    processed_rows: list[tuple[float, list[float]]] = []
    previous_seconds: float | None = None
    day_offset = 0.0
    skipped_time_rows = 0
    for row in rows:
        try:
            zulu_seconds = parse_zulu_seconds(row.get(x_column, ""))
        except (TypeError, ValueError):
            skipped_time_rows += 1
            continue
        if previous_seconds is not None and previous_seconds - zulu_seconds > 43200:
            day_offset += 86400
        previous_seconds = zulu_seconds
        x_value = zulu_seconds + day_offset
        measurements = [
            parse_measurement(row.get(column)) for _, column in available_series
        ]
        processed_rows.append((x_value, measurements))

    if not processed_rows:
        raise ValueError(f"No rows with valid Zulu time were found in {input_path}")
    if skipped_time_rows:
        print(
            f"Warning: skipped {skipped_time_rows} row(s) with invalid Zulu time.",
            file=sys.stderr,
        )

    with data_path.open("w", encoding="utf-8", newline="\n") as file:
        for x_value, measurements in processed_rows:
            values = [
                "NaN" if math.isnan(value) else f"{value:.10g}"
                for value in measurements
            ]
            file.write(f"{x_value:.3f} " + " ".join(values) + "\n")

    minimum_x = min(x for x, _ in processed_rows)
    maximum_x = max(x for x, _ in processed_rows)
    if minimum_x == maximum_x:
        minimum_x -= 30
        maximum_x += 30
    plot_terms = []
    for data_column, (series, _) in enumerate(available_series, start=2):
        axis = " axes x1y2" if series.axis == "y2" else ""
        plot_terms.append(
            f"{gnuplot_quote(str(data_path.resolve()))} using 1:{data_column} "
            f"with {series.style}{axis} title {gnuplot_quote(series.label)}"
        )

    script = [
        "set terminal pngcairo size 1600,900",
        f"set output {gnuplot_quote(str(image_path.resolve()))}",
        f"set title {gnuplot_quote(input_path.stem)} noenhanced",
        'set xlabel "Zulu time"',
        'set ylabel "Altitude (ft) / airspeed (kt)"',
        'set y2label "Deployment (0-1)"',
        "set y2range [0:1]",
        "set y2tics 0, 0.2, 1",
        "set ytics nomirror",
        "set grid",
        "set key outside right center",
        f"set xrange [{minimum_x:.3f}:{maximum_x:.3f}]",
        f"set xtics ({make_xtics(minimum_x, maximum_x)})",
        "plot " + ", \\\n     ".join(plot_terms),
        "",
    ]
    plot_path.write_text("\n".join(script), encoding="utf-8")
    return data_path, plot_path


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Plot selected X-Plane flight log fields with gnuplot."
    )
    parser.add_argument("csv_file", type=Path, help="X-Plane UDP CSV log to plot")
    parser.add_argument(
        "--mapping",
        type=Path,
        default=MAPPING_PATH,
        help=f"CSV field mapping (default: {MAPPING_PATH})",
    )
    parser.add_argument(
        "--output-prefix",
        type=Path,
        help="output filename prefix (default: the input file without its extension)",
    )
    parser.add_argument(
        "--no-render",
        action="store_true",
        help="write the gnuplot data and script without invoking gnuplot",
    )
    args = parser.parse_args()

    if not args.csv_file.is_file():
        parser.error(f"CSV file does not exist: {args.csv_file}")
    if not args.mapping.is_file():
        parser.error(f"Mapping file does not exist: {args.mapping}")
    output_prefix = args.output_prefix or args.csv_file.with_suffix("")

    try:
        data_path, plot_path = generate_plot(
            args.csv_file, args.mapping, output_prefix
        )
    except (OSError, ValueError, csv.Error) as error:
        parser.error(str(error))

    print(f"Gnuplot data:   {data_path}")
    print(f"Gnuplot script: {plot_path}")
    if args.no_render:
        return 0

    gnuplot = shutil.which("gnuplot")
    if gnuplot is None:
        parser.error(
            "gnuplot was not found; the .dat and .gnuplot files were generated. "
            "Install gnuplot, then run it with the generated .gnuplot file."
        )
    try:
        subprocess.run([gnuplot, str(plot_path)], check=True)
    except subprocess.CalledProcessError as error:
        parser.error(
            f"gnuplot failed with exit code {error.returncode}; "
            f"see {plot_path} for the generated plot script"
        )
    print(f"Plot image:     {output_prefix.with_suffix('.png')}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
