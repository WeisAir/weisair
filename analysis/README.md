# X-Plane Flight Log Plotter

`plot_xplane_flight.py` reads an X-Plane UDP CSV log and creates a gnuplot
script, its numeric input data, and a PNG flight profile.
Rendering the PNG requires the `gnuplot` executable to be available in `PATH`.

```sh
python analysis/plot_xplane_flight.py path/to/xplane_log.csv
```

The default plot uses Zulu time on the x-axis; pressure altitude and indicated
airspeed on the left y-axis; and flap, speedbrake, and landing-gear deployment
on a 0-to-1 right y-axis. The filename is shown literally as the chart title,
without gnuplot interpreting underscores or other enhanced-text characters.
The x-axis has 10-minute ticks and labels the exact starting and ending Zulu
times at its boundaries.
The plotter resolves either generic UDP headers or
the readable names from `batch_scripts/udpLogger/xplane_udp_mapping.csv`.
Fields not present in a log are reported and skipped. The provided
`xplane_log_b738_enva_enrm.csv` does not contain the mapped indicated-airspeed
field (`vind_kias`), so its speed series is omitted unless that field is logged.

Change `X_AXIS` and the `SERIES` tuple near the top of the script to select
other mapped headers. Use `--mapping` to specify a different mapping file,
`--output-prefix` to choose where output files are written, or `--no-render` to
write the `.dat` and `.gnuplot` files without invoking gnuplot.
