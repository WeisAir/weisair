# X-Plane Flight Log Plotter

`plot_xplane_flight.py` reads an X-Plane UDP CSV log and creates a gnuplot
script, its numeric input data, a PNG flight profile, and an interactive HTML
version of the plot.
Rendering the PNG requires the `gnuplot` executable to be available in `PATH`.

```sh
python analysis/plot_xplane_flight.py path/to/xplane_log.csv
```

The default plot uses Zulu time on the x-axis, pressure altitude on the left
y-axis, and indicated airspeed in knots on the right y-axis. The filename is
shown literally as the chart title, without gnuplot interpreting underscores
or other enhanced-text characters. The speed axis displays automatically
scaled numeric ticks. The x-axis has 10-minute ticks and labels the exact
starting and ending Zulu times at its boundaries; nearby interior ticks are
hidden to prevent overlap with those boundary labels.
Landing-gear deployment is annotated at each 0/1 state change with an up/down
triangle and percentage label instead of a plotted gear line. Flap changes
are annotated at each crossed 25% position with an up/down triangle and
percentage label instead of a plotted flap line. Speedbrake changes use the
same triangle-and-percentage style, including 100% for full deployment. The
FLAPS, GEAR, and SPDBRK row headings identify each event type vertically
outside the left edge of their boxes. Events are shown in separate boxed
timeline rows below the x-axis, keeping their labels clear of the plotted
data. Dotted vertical guides connect each event time through the graph and
event rows. Nearby events within a row are staggered into separate lanes to
keep their labels readable.
The plotter resolves either generic UDP headers or
the readable names from `batch_scripts/udpLogger/xplane_udp_mapping.csv`.
Fields not present in a log are reported and skipped. The provided
`xplane_log_b738_enva_enrm.csv` does not contain the mapped indicated-airspeed
field (`vind_kias`), so its speed series is omitted unless that field is logged.

Change `X_AXIS` and the `SERIES` tuple near the top of the script to select
other mapped headers. Use `--mapping` to specify a different mapping file,
`--output-prefix` to choose where output files are written, or `--no-render` to
write the `.dat` and `.gnuplot` files without invoking gnuplot. In the HTML
plot, right-drag to zoom, use the controls below the plot to restore or revisit
a zoom, and move the pointer over the graph for coordinate readouts. The
required Gnuplot JavaScript, stylesheet, and icons are copied into a companion
`_assets` directory so the page works when moved together with that directory.
