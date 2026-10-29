# WeisAir FlightLog

A static single-page flight log. It reads `data/FlightLog1.0.csv` and can be
hosted on any static web host.

## Run locally

From this directory, start a local web server:

```sh
python3 -m http.server 8000
```

Open <http://localhost:8000>. The page uses `fetch()` to load the CSV, so it
must be served over HTTP rather than opened directly as a `file://` URL.

The debrief watcher copies the latest X-Plane flight log into the `data`
directory whenever the source log changes. It also publishes flight screenshots
from each `flights/<flight>/capture` folder to `data/photos` and writes a static
gallery index. Screenshots are resized to a maximum 1920-pixel edge and
converted to WebP (quality 84); Pillow must be available to the Python
interpreter used by the debrief script. The settings are in
`sync_webapp_photos.py`.

The watcher also publishes each flight's interactive gnuplot HTML, required
local assets, and PNG fallback from `flights/<flight>/data` to
`data/statistics`. The Statistics button displays the interactive plot in the
dashboard panel when available, otherwise it displays the PNG.

Flight KML files from `flights/<flight>/geo` are copied to `data/flight-paths`
with a static manifest. The Flight Path button loads the complete KML into an
interactive CesiumJS 3D globe, including its recorded altitude, waypoint
balloons, and ExtendedData. Google Earth itself cannot currently be embedded:
its browser API is discontinued. CesiumJS is used here as a static-hostable
KML-capable alternative. Drag to orbit, Ctrl-drag to tilt, and click a
waypoint to inspect its details. The globe library is loaded from the Cesium
CDN and imagery from Esri World Imagery, so the 3D view requires an internet
connection; the local track view remains available if the globe cannot load.
Flight altitude comes from the KML coordinates and waypoint metadata; no
separate terrain-elevation service is configured.

Open a gallery image to view it enlarged. Use the viewer's previous/next
buttons or the left/right arrow keys to browse that flight's screenshots; the
gallery wraps from the last image to the first and vice versa.

For manual updates, replace `data/FlightLog1.0.csv` with the latest log and run
`python3 ../sync_webapp_photos.py` and
`python3 ../sync_webapp_statistics.py` and
`python3 ../sync_webapp_flight_paths.py` from this directory.

## Host online

Upload the contents of this directory, including `data/FlightLog1.0.csv`,
`data/photos`, `data/statistics`, and `data/flight-paths`, to your static
hosting space. Keep the `data` and `custom_assets` directories alongside
`index.html`.

The map uses a compact built-in world illustration and does not rely on map
tiles or a mapping service. Airport locations are defined in `app.js`; add
coordinates there when a new airport code appears in the flight log.
