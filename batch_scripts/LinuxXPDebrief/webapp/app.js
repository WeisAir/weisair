const DISPLAY_COLUMNS = [
  "Date",
  "Aircraft",
  "Departure ICAO",
  "Departure APT",
  "Arrival ICAO",
  "Arrival APT",
  "TakeOff (Z)",
  "Land (Z)",
  "TakeOff (Local)",
  "Land (Local)",
  "Duration (h:m:s)",
  "Duration (hour)",
  "Distance (nm)",
];

const AIRPORTS = {
  EDAB: { latitude: 51.193530556, longitude: 14.519747222 },
  EDDC: { latitude: 51.134344444, longitude: 13.768 },
  EDDF: { latitude: 50.033305556, longitude: 8.570455556 },
  ENBN: { latitude: 65.461111111, longitude: 12.2175 },
  ENFL: { latitude: 61.583611111, longitude: 5.024722222 },
  ENKB: { latitude: 63.111944444, longitude: 7.826111111 },
  ENOV: { latitude: 62.18, longitude: 6.074166667 },
  ENRM: { latitude: 64.838333333, longitude: 11.146111111 },
  ENVA: { latitude: 63.4575, longitude: 10.924166667 },
  LKVR: { latitude: 50.624166667, longitude: 15.646388889 },
  LPMA: { latitude: 32.69425, longitude: -16.778055556 },
  KSFO: { latitude: 37.618805556, longitude: -122.375416667 },
};

const MAP_WIDTH = 960;
const MAP_HEIGHT = 460;
const MIN_MAP_ZOOM = 1;
const MAX_MAP_ZOOM = 24;
const mapView = { zoom: 1, centerX: MAP_WIDTH / 2, centerY: MAP_HEIGHT / 2 };
const flightRows = document.querySelector("#flight-rows");
const errorState = document.querySelector("#error-state");
const emptyState = document.querySelector("#empty-state");
const logStatus = document.querySelector("#log-status");
const logStatusContainer = document.querySelector(".log-status");
let flights = [];
let selectedFlightIndex = null;
let photoManifest = null;
let photoManifestError = "";
let statisticsManifest = null;
let statisticsManifestError = "";
let flightPathManifest = null;
let flightPathManifestError = "";
let flightFolders = new Set();
let flightFoldersManifestError = "";
let landmassPath = "";
let mapGeometryError = "";
let mapPanStart = null;
let activePanelFlightIndex = null;
let activePanelAction = null;
let activeViewerImageIndex = null;
let cesiumLoadPromise = null;
let cesiumViewer = null;
const CESIUM_BASE_URL =
  "https://cesium.com/downloads/cesiumjs/releases/1.146/Build/Cesium/";

function parseCsv(text) {
  const rows = [];
  let row = [];
  let value = "";
  let insideQuotes = false;

  for (let index = 0; index < text.length; index += 1) {
    const character = text[index];

    if (insideQuotes) {
      if (character === '"' && text[index + 1] === '"') {
        value += '"';
        index += 1;
      } else if (character === '"') {
        insideQuotes = false;
      } else {
        value += character;
      }
    } else if (character === '"') {
      insideQuotes = true;
    } else if (character === ",") {
      row.push(value);
      value = "";
    } else if (character === "\n" || character === "\r") {
      row.push(value);
      if (row.some((cell) => cell.trim() !== "")) {
        rows.push(row);
      }
      row = [];
      value = "";
      if (character === "\r" && text[index + 1] === "\n") {
        index += 1;
      }
    } else {
      value += character;
    }
  }

  if (value !== "" || row.length > 0) {
    row.push(value);
    if (row.some((cell) => cell.trim() !== "")) {
      rows.push(row);
    }
  }

  if (insideQuotes) {
    throw new Error("The flight log contains an unterminated quoted field.");
  }
  if (rows.length === 0) {
    throw new Error("The flight log is empty.");
  }

  const headers = rows[0].map((header) => header.trim().replace(/^\uFEFF/, ""));
  const missingColumns = DISPLAY_COLUMNS.filter((column) => !headers.includes(column));
  if (missingColumns.length > 0) {
    throw new Error(`The flight log is missing columns: ${missingColumns.join(", ")}.`);
  }

  return rows.slice(1).map((cells, rowIndex) => {
    if (cells.length !== headers.length) {
      throw new Error(`Flight log row ${rowIndex + 2} has an unexpected number of columns.`);
    }
    return Object.fromEntries(headers.map((header, index) => [header, cells[index].trim()]));
  });
}

function parseDuration(value) {
  const match = /^(\d+):([0-5]\d):([0-5]\d)$/.exec(value);
  if (!match) {
    throw new Error(`Invalid flight duration "${value}". Expected HH:MM:SS.`);
  }
  return Number(match[1]) * 3600 + Number(match[2]) * 60 + Number(match[3]);
}

function formatAirTime(seconds) {
  const totalMinutes = Math.round(seconds / 60);
  const hours = Math.floor(totalMinutes / 60);
  const minutes = totalMinutes % 60;
  return `${hours}h ${minutes.toString().padStart(2, "0")}m`;
}

function formatDate(value) {
  const date = new Date(`${value}T00:00:00Z`);
  if (Number.isNaN(date.getTime())) {
    return value;
  }
  return new Intl.DateTimeFormat("en", {
    day: "2-digit",
    month: "short",
    year: "numeric",
    timeZone: "UTC",
  }).format(date);
}

function createIcon(paths) {
  const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute("viewBox", "0 0 24 24");
  svg.setAttribute("aria-hidden", "true");
  for (const pathData of paths) {
    const path = document.createElementNS("http://www.w3.org/2000/svg", "path");
    path.setAttribute("d", pathData);
    svg.append(path);
  }
  return svg;
}

const ACTIONS = [
  { label: "Photos", paths: ["M4 7h3l1.5-2h7L17 7h3v12H4z", "M8 13a4 4 0 1 0 8 0a4 4 0 1 0-8 0"] },
  { label: "Flight path", paths: ["M3 18c4-8 6-10 9-10s5 2 9-2", "M16 6h5v5"] },
  { label: "Statistics", paths: ["M4 19V5", "M4 19h17", "M8 16v-4", "M13 16V8", "M18 16V5"] },
];

function createActionButtons(flightIndex) {
  const container = document.createElement("div");
  container.className = "action-buttons";
  for (const action of ACTIONS) {
    const button = document.createElement("button");
    button.className = "action-button";
    button.type = "button";
    button.setAttribute("aria-label", action.label);
    button.title = action.label;
    button.dataset.action = action.label.toLowerCase().replaceAll(" ", "-");
    button.setAttribute("aria-pressed", "false");
    button.append(createIcon(action.paths));
    button.addEventListener("click", (event) => {
      event.stopPropagation();
      if (action.label === "Photos") {
        togglePhotoGallery(flightIndex);
      } else if (action.label === "Flight path") {
        toggleFlightPathView(flightIndex);
      } else if (action.label === "Statistics") {
        toggleStatisticsView(flightIndex);
      }
    });
    container.append(button);
  }
  return container;
}

function createFlightRow(flight, index) {
  const row = document.createElement("tr");
  row.tabIndex = 0;
  row.setAttribute("aria-selected", "false");
  row.dataset.flightIndex = String(index);

  for (const column of DISPLAY_COLUMNS) {
    const cell = document.createElement("td");
    const value = flight[column] || "—";
    if (column === "Date") {
      cell.textContent = formatDate(value);
    } else if (column === "Aircraft") {
      const badge = document.createElement("span");
      badge.className = "aircraft-badge";
      badge.textContent = value;
      cell.append(badge);
    } else if (column === "Departure ICAO" || column === "Arrival ICAO") {
      cell.className = "airport-code";
      cell.textContent = value;
    } else {
      cell.textContent = value;
    }
    row.append(cell);
  }

  const actionsCell = document.createElement("td");
  const folderName = getFlightFolderName(flight);
  if (folderName && flightFolders.has(folderName)) {
    actionsCell.append(createActionButtons(index));
  }
  row.append(actionsCell);

  row.addEventListener("click", () => selectFlight(index));
  row.addEventListener("keydown", (event) => {
    if (event.target !== row) {
      return;
    }
    if (event.key === "Enter" || event.key === " ") {
      event.preventDefault();
      selectFlight(index);
    }
  });
  return row;
}

function project(latitude, longitude) {
  return {
    x: ((longitude + 180) / 360) * MAP_WIDTH,
    y: ((90 - latitude) / 180) * MAP_HEIGHT,
  };
}

function renderLandmasses() {
  const layer = document.querySelector("#landmasses");
  const path = document.createElementNS("http://www.w3.org/2000/svg", "path");
  path.setAttribute("d", landmassPath);
  path.setAttribute("class", "landmass");
  path.setAttribute("fill-rule", "evenodd");
  layer.replaceChildren(path);
}

function applyMapView() {
  const translateX = MAP_WIDTH / 2 - mapView.centerX * mapView.zoom;
  const translateY = MAP_HEIGHT / 2 - mapView.centerY * mapView.zoom;
  document.querySelector("#map-viewport").setAttribute(
    "transform",
    `translate(${translateX} ${translateY}) scale(${mapView.zoom})`,
  );
  document.querySelectorAll(".airport-symbols").forEach((symbols) => {
    symbols.setAttribute("transform", `scale(${1 / mapView.zoom})`);
  });
  document.querySelector("#zoom-to-flight").disabled = selectedFlightIndex === null;
}

function setMapZoom(zoom, focusPoint) {
  const nextZoom = Math.min(MAX_MAP_ZOOM, Math.max(MIN_MAP_ZOOM, zoom));
  if (focusPoint && nextZoom !== mapView.zoom) {
    const worldX = mapView.centerX + (focusPoint.x - MAP_WIDTH / 2) / mapView.zoom;
    const worldY = mapView.centerY + (focusPoint.y - MAP_HEIGHT / 2) / mapView.zoom;
    mapView.centerX = worldX - (focusPoint.x - MAP_WIDTH / 2) / nextZoom;
    mapView.centerY = worldY - (focusPoint.y - MAP_HEIGHT / 2) / nextZoom;
  }
  mapView.zoom = nextZoom;
  applyMapView();
}

function fitFlightOnMap(flightIndex) {
  const flight = flights[flightIndex];
  if (!flight) {
    return;
  }

  const start = AIRPORTS[flight["Departure ICAO"].toUpperCase()];
  const end = AIRPORTS[flight["Arrival ICAO"].toUpperCase()];
  if (!start || !end) {
    return;
  }

  const startPoint = project(start.latitude, start.longitude);
  const endPoint = project(end.latitude, end.longitude);
  let endX = endPoint.x;
  if (endX - startPoint.x > MAP_WIDTH / 2) {
    endX -= MAP_WIDTH;
  } else if (endX - startPoint.x < -MAP_WIDTH / 2) {
    endX += MAP_WIDTH;
  }
  const width = Math.abs(endX - startPoint.x);
  const height = Math.abs(endPoint.y - startPoint.y);
  mapView.centerX = (startPoint.x + endX) / 2;
  mapView.centerY = (startPoint.y + endPoint.y) / 2;
  mapView.zoom = width < 0.1 && height < 0.1
    ? 1
    : Math.min(MAX_MAP_ZOOM, Math.max(MIN_MAP_ZOOM, Math.min(
      (MAP_WIDTH - 140) / Math.max(width, 1),
      (MAP_HEIGHT - 120) / Math.max(height, 1),
    )));
  applyMapView();
}

function svgPointFromEvent(event) {
  const svg = document.querySelector("#world-map");
  const point = svg.createSVGPoint();
  point.x = event.clientX;
  point.y = event.clientY;
  return point.matrixTransform(svg.getScreenCTM().inverse());
}

async function loadLandmasses() {
  try {
    const response = await fetch("./data/world-land.json", { cache: "force-cache" });
    if (!response.ok) {
      throw new Error(`Coastline data request failed (${response.status} ${response.statusText}).`);
    }
    const data = await response.json();
    if (typeof data.path !== "string" || data.path.length === 0) {
      throw new Error("The coastline data has an unsupported format.");
    }
    landmassPath = data.path;
    renderLandmasses();
  } catch (error) {
    mapGeometryError =
      error instanceof Error ? error.message : "An unexpected error occurred.";
  }
}

function createAirportList() {
  const found = new Map();
  for (const flight of flights) {
    for (const field of ["Departure ICAO", "Arrival ICAO"]) {
      const code = flight[field].trim().toUpperCase();
      if (code && AIRPORTS[code] && !found.has(code)) {
        found.set(code, { code, ...AIRPORTS[code] });
      }
    }
  }
  return [...found.values()].sort((first, second) => first.code.localeCompare(second.code));
}

function createRoutePath(start, end) {
  const startPoint = project(start.latitude, start.longitude);
  const endPoint = project(end.latitude, end.longitude);
  let deltaX = endPoint.x - startPoint.x;
  if (deltaX > MAP_WIDTH / 2) {
    deltaX -= MAP_WIDTH;
  } else if (deltaX < -MAP_WIDTH / 2) {
    deltaX += MAP_WIDTH;
  }

  if (Math.abs(deltaX) < 0.5 && Math.abs(endPoint.y - startPoint.y) < 0.5) {
    const offset = 12;
    return `M${startPoint.x},${startPoint.y} C${startPoint.x + offset},${startPoint.y - offset} ${startPoint.x - offset},${startPoint.y - offset} ${endPoint.x},${endPoint.y}`;
  }

  const endX = startPoint.x + deltaX;
  const bend = Math.min(28, Math.max(3, Math.hypot(deltaX, endPoint.y - startPoint.y) * 0.04));
  const controlX = (startPoint.x + endX) / 2;
  const controlY = (startPoint.y + endPoint.y) / 2 - bend;
  return `M${startPoint.x},${startPoint.y} Q${controlX},${controlY} ${endX},${endPoint.y}`;
}

function renderMap() {
  const airportLayer = document.querySelector("#airport-layer");
  const routeLayer = document.querySelector("#route-layer");
  airportLayer.replaceChildren();
  routeLayer.replaceChildren();

  const airports = createAirportList();
  const selectedFlight = selectedFlightIndex === null ? null : flights[selectedFlightIndex];
  const selectedCodes = selectedFlight
    ? new Set([selectedFlight["Departure ICAO"].toUpperCase(), selectedFlight["Arrival ICAO"].toUpperCase()])
    : new Set();
  const activeFlightAirports = selectedFlight
    ? [AIRPORTS[selectedFlight["Departure ICAO"].toUpperCase()], AIRPORTS[selectedFlight["Arrival ICAO"].toUpperCase()]]
    : [];

  if (activeFlightAirports.length === 2 && activeFlightAirports.every(Boolean)) {
    const route = document.createElementNS("http://www.w3.org/2000/svg", "path");
    route.setAttribute("class", "route-line");
    route.setAttribute("d", createRoutePath(activeFlightAirports[0], activeFlightAirports[1]));
    routeLayer.append(route);
    for (const offset of [-MAP_WIDTH, MAP_WIDTH]) {
      const wrappedRoute = route.cloneNode();
      wrappedRoute.setAttribute("transform", `translate(${offset} 0)`);
      routeLayer.append(wrappedRoute);
    }
  }

  for (const airport of airports) {
    const point = project(airport.latitude, airport.longitude);
    const selected = selectedCodes.has(airport.code);
    for (const offset of [-MAP_WIDTH, 0, MAP_WIDTH]) {
      const marker = document.createElementNS("http://www.w3.org/2000/svg", "g");
      marker.setAttribute(
        "class",
        `airport-marker${selected ? " is-active" : ""}${selectedFlight && !selected ? " is-dimmed" : ""}`,
      );
      marker.setAttribute("transform", `translate(${point.x + offset} ${point.y})`);
      const symbols = document.createElementNS("http://www.w3.org/2000/svg", "g");
      symbols.setAttribute("class", "airport-symbols");
      symbols.setAttribute("transform", `scale(${1 / mapView.zoom})`);

      const halo = document.createElementNS("http://www.w3.org/2000/svg", "circle");
      halo.setAttribute("class", "marker-halo");
      halo.setAttribute("r", selected ? "10" : "7");
      const dot = document.createElementNS("http://www.w3.org/2000/svg", "circle");
      dot.setAttribute("class", "marker-dot");
      dot.setAttribute("r", selected ? "4.5" : "3.5");
      const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
      label.setAttribute("x", "8");
      label.setAttribute("y", "-8");
      label.textContent = airport.code;
      symbols.append(halo, dot, label);
      marker.append(symbols);
      airportLayer.append(marker);
    }
  }

  const unknownCodes = new Set();
  for (const flight of flights) {
    for (const field of ["Departure ICAO", "Arrival ICAO"]) {
      const code = flight[field].trim().toUpperCase();
      if (code && !AIRPORTS[code]) {
        unknownCodes.add(code);
      }
    }
  }
  const note = document.querySelector("#map-note");
  const messages = [];
  if (unknownCodes.size > 0) {
    messages.push(
      `Airport coordinates are not available for ${[...unknownCodes].sort().join(", ")}. Add their coordinates in app.js to show them on the map.`,
    );
  }
  if (mapGeometryError) {
    messages.push(`${mapGeometryError} The coastlines could not be displayed.`);
  }
  note.textContent = messages.join(" ");
  note.hidden = messages.length === 0;

  document.querySelector("#map-airport-count").textContent =
    `${airports.length} ${airports.length === 1 ? "airport" : "airports"}`;
  document.querySelector("#map-selection").textContent = selectedFlight
    ? `${selectedFlight["Departure ICAO"]} → ${selectedFlight["Arrival ICAO"]}`
    : "Select a flight to trace its route · Scroll to zoom, drag to pan";
  applyMapView();
}

function selectFlight(index) {
  if (activePanelFlightIndex !== null) {
    closeActivePanel();
  }
  selectedFlightIndex = index;
  for (const row of flightRows.querySelectorAll("tr")) {
    const selected = Number(row.dataset.flightIndex) === index;
    row.classList.toggle("is-selected", selected);
    row.setAttribute("aria-selected", String(selected));
  }
  fitFlightOnMap(index);
  renderMap();
}

function getFlightFolderName(flight) {
  const start = /^(\d{4})-(\d{2})-(\d{2}) (\d{1,2})\.(\d{2})\.\d{2} (AM|PM)$/.exec(
    flight["system_time_start"] || "",
  );
  if (!start) {
    return null;
  }

  const hour = Number(start[4]);
  const minute = Number(start[5]);
  if (hour < 1 || hour > 12 || minute > 59) {
    return null;
  }
  const hour24 = (hour % 12) + (start[6] === "PM" ? 12 : 0);
  const date = `${start[1]}${start[2]}${start[3]}`;
  const aircraft = flight.Aircraft;
  const departure = flight["Departure ICAO"];
  const arrival = flight["Arrival ICAO"];
  if (![aircraft, departure, arrival].every((part) => /^[A-Za-z0-9_-]+$/.test(part || ""))) {
    return null;
  }
  return `${date}_${String(hour24).padStart(2, "0")}${start[5]}_${aircraft}_${departure}_${arrival}`;
}

function getActionButton(flightIndex, action) {
  return flightRows.querySelector(
    `tr[data-flight-index="${flightIndex}"] button[data-action="${action}"]`,
  );
}

function setActionButtonActive(flightIndex, action, active) {
  const button = getActionButton(flightIndex, action);
  if (button) {
    button.classList.toggle("is-active", active);
    button.setAttribute("aria-pressed", String(active));
  }
}

function setMapView() {
  const panel = document.querySelector("#map-panel");
  panel.classList.remove("is-content-mode");
  activeViewerImageIndex = null;
  document.querySelector("#map-eyebrow").textContent = "FLIGHT NETWORK";
  document.querySelector("#map-title").textContent = "Your world, from above";
  document.querySelector("#photo-gallery").hidden = true;
  document.querySelector("#statistics-view").hidden = true;
  document.querySelector("#flight-path-view").hidden = true;
  document.querySelector("#image-viewer").hidden = true;
  document.querySelector("#statistics-plot").removeAttribute("src");
  document.querySelector("#statistics-image").removeAttribute("src");
  document.querySelector("#flight-path-layer").replaceChildren();
  document.querySelector("#cesium-globe").hidden = true;
  if (cesiumViewer) {
    cesiumViewer.destroy();
    cesiumViewer = null;
  }
  document.querySelector("#world-map").setAttribute("aria-hidden", "false");
}

function closeActivePanel() {
  if (activePanelFlightIndex !== null && activePanelAction !== null) {
    setActionButtonActive(activePanelFlightIndex, activePanelAction, false);
  }
  activePanelFlightIndex = null;
  activePanelAction = null;
  setMapView();
}

function getImageUrl(photo) {
  if (typeof photo.src !== "string" || !photo.src.startsWith("data/photos/")) {
    throw new Error("The photo index contains an invalid image path.");
  }
  const encodedPath = photo.src.split("/").map(encodeURIComponent).join("/");
  const imageUrl = new URL(`./${encodedPath}`, document.baseURI);
  if (typeof photo.sourceModifiedNs === "string" && /^\d+$/.test(photo.sourceModifiedNs)) {
    imageUrl.searchParams.set("v", photo.sourceModifiedNs);
  }
  return imageUrl.href;
}

function showImageViewer(photo, imageIndex, moveFocus = true) {
  activeViewerImageIndex = imageIndex;
  const image = document.querySelector("#image-viewer-image");
  image.src = getImageUrl(photo);
  image.alt = photo.originalName || `Flight screenshot ${imageIndex + 1}`;
  const flight = flights[activePanelFlightIndex];
  const folderName = flight ? getFlightFolderName(flight) : null;
  const photos = folderName ? photoManifest?.[folderName] || [] : [];
  document.querySelector("#image-viewer-title").textContent =
    `${photo.originalName || `Screenshot ${imageIndex + 1}`} · ${imageIndex + 1} / ${photos.length}`;
  document.querySelector("#image-viewer-previous").disabled = photos.length < 2;
  document.querySelector("#image-viewer-next").disabled = photos.length < 2;
  document.querySelector("#image-viewer").hidden = false;
  if (moveFocus) {
    document.querySelector("#image-viewer-close").focus();
  }
}

function navigateImageViewer(direction) {
  if (activePanelFlightIndex === null || activeViewerImageIndex === null) {
    return;
  }
  const flight = flights[activePanelFlightIndex];
  const folderName = flight ? getFlightFolderName(flight) : null;
  const photos = folderName ? photoManifest?.[folderName] || [] : [];
  if (photos.length < 2) {
    return;
  }
  const imageIndex = (activeViewerImageIndex + direction + photos.length) % photos.length;
  showImageViewer(photos[imageIndex], imageIndex, false);
}

function closeImageViewer() {
  document.querySelector("#image-viewer").hidden = true;
  document.querySelector("#image-viewer-image").removeAttribute("src");
  activeViewerImageIndex = null;
  const closeButton = document.querySelector("#gallery-close");
  closeButton.focus();
}

function renderPhotoGallery(flightIndex) {
  const flight = flights[flightIndex];
  if (!flight) {
    return;
  }

  const folderName = getFlightFolderName(flight);
  const photos = folderName ? photoManifest?.[folderName] || [] : [];
  const panel = document.querySelector("#map-panel");
  panel.classList.add("is-content-mode");
  document.querySelector("#map-eyebrow").textContent = "FLIGHT PHOTOS";
  document.querySelector("#map-title").textContent =
    `${flight["Departure ICAO"]} → ${flight["Arrival ICAO"]}`;
  document.querySelector("#world-map").setAttribute("aria-hidden", "true");
  document.querySelector("#photo-gallery").hidden = false;
  document.querySelector("#statistics-view").hidden = true;
  document.querySelector("#flight-path-view").hidden = true;
  document.querySelector("#image-viewer").hidden = true;
  document.querySelector("#photo-gallery-route").textContent =
    `${flight.Aircraft} · ${formatDate(flight.Date)}`;
  document.querySelector("#photo-gallery-count").textContent =
    `${photos.length} ${photos.length === 1 ? "screenshot" : "screenshots"}`;

  const photoGrid = document.querySelector("#photo-grid");
  const photoEmpty = document.querySelector("#photo-empty");
  photoGrid.replaceChildren();
  photoEmpty.hidden = photos.length > 0;
  if (photos.length === 0) {
    document.querySelector("#photo-empty-title").textContent =
      photoManifestError ? "Screenshot index unavailable" : "No screenshots for this flight";
    document.querySelector("#photo-empty-message").textContent = photoManifestError
      ? `${photoManifestError} Run the debrief screenshot sync to publish the gallery.`
      : "Screenshots will appear here after the debrief sync.";
    return;
  }

  for (const [imageIndex, photo] of photos.entries()) {
    const card = document.createElement("button");
    card.type = "button";
    card.className = "photo-card";
    card.setAttribute("aria-label", `Open screenshot: ${photo.originalName}`);

    const image = document.createElement("img");
    image.src = getImageUrl(photo);
    image.alt = "";
    image.loading = "eager";
    image.decoding = "async";
    card.append(image);

    const caption = document.createElement("span");
    caption.className = "photo-card-caption";
    caption.textContent = photo.originalName;
    card.append(caption);
    card.addEventListener("click", () => showImageViewer(photo, imageIndex));
    photoGrid.append(card);
  }
}

function renderStatisticsView(flightIndex) {
  const flight = flights[flightIndex];
  if (!flight) {
    return;
  }

  const folderName = getFlightFolderName(flight);
  const plot = folderName ? statisticsManifest?.[folderName] : null;
  const panel = document.querySelector("#map-panel");
  const view = document.querySelector("#statistics-view");
  const frame = document.querySelector("#statistics-plot");
  const image = document.querySelector("#statistics-image");
  const empty = document.querySelector("#statistics-empty");
  panel.classList.add("is-content-mode");
  document.querySelector("#map-eyebrow").textContent = "FLIGHT STATISTICS";
  document.querySelector("#map-title").textContent =
    `${flight["Departure ICAO"]} → ${flight["Arrival ICAO"]}`;
  document.querySelector("#world-map").setAttribute("aria-hidden", "true");
  document.querySelector("#photo-gallery").hidden = true;
  document.querySelector("#flight-path-view").hidden = true;
  view.hidden = false;
  document.querySelector("#statistics-route").textContent =
    `${flight.Aircraft} · ${formatDate(flight.Date)}`;
  frame.hidden = true;
  image.hidden = true;
  empty.hidden = true;
  frame.removeAttribute("src");
  image.removeAttribute("src");

  if (typeof plot?.html === "string" && plot.html.startsWith("data/statistics/")) {
    const plotUrl = new URL(
      `./${plot.html.split("/").map(encodeURIComponent).join("/")}`,
      document.baseURI,
    );
    if (typeof plot.version === "string" && /^\d+$/.test(plot.version)) {
      plotUrl.searchParams.set("v", plot.version);
    }
    frame.src = plotUrl.href;
    frame.hidden = false;
    document.querySelector("#statistics-format").textContent = "Interactive flight plot";
  } else if (typeof plot?.png === "string" && plot.png.startsWith("data/statistics/")) {
    const imageUrl = new URL(
      `./${plot.png.split("/").map(encodeURIComponent).join("/")}`,
      document.baseURI,
    );
    if (typeof plot.version === "string" && /^\d+$/.test(plot.version)) {
      imageUrl.searchParams.set("v", plot.version);
    }
    image.src = imageUrl.href;
    image.hidden = false;
    document.querySelector("#statistics-format").textContent = "Flight plot · PNG";
  } else {
    document.querySelector("#statistics-empty-title").textContent =
      statisticsManifestError ? "Statistics index unavailable" : "No statistics for this flight";
    document.querySelector("#statistics-empty-message").textContent =
      statisticsManifestError
        ? `${statisticsManifestError} Run the debrief plot sync to publish statistics.`
        : "Statistics will appear here after the debrief plot is generated.";
    document.querySelector("#statistics-format").textContent = "Flight plot";
    empty.hidden = false;
  }
}

function parseKmlTrack(xmlText) {
  const documentXml = new DOMParser().parseFromString(xmlText, "application/xml");
  if (documentXml.querySelector("parsererror")) {
    throw new Error("The KML file is not valid XML.");
  }

  const lineStrings = Array.from(documentXml.getElementsByTagNameNS("*", "LineString"));
  const segments = [];
  for (const lineString of lineStrings) {
    const coordinateNode = lineString.getElementsByTagNameNS("*", "coordinates")[0];
    if (!coordinateNode) {
      continue;
    }

    const coordinates = coordinateNode.textContent
      .trim()
      .split(/\s+/)
      .filter(Boolean)
      .map((coordinate) => {
        const [longitudeText, latitudeText] = coordinate.split(",");
        const longitude = Number(longitudeText);
        const latitude = Number(latitudeText);
        if (
          !Number.isFinite(longitude) ||
          !Number.isFinite(latitude) ||
          longitude < -180 ||
          longitude > 180 ||
          latitude < -90 ||
          latitude > 90
        ) {
          throw new Error("The KML track contains invalid coordinates.");
        }
        return { longitude, latitude };
      });

    if (coordinates.length > 1) {
      segments.push(coordinates);
    }
  }
  if (segments.length === 0) {
    throw new Error("The KML file does not contain a flight track.");
  }
  return segments;
}

function createSvgElement(tagName, attributes = {}) {
  const element = document.createElementNS("http://www.w3.org/2000/svg", tagName);
  for (const [name, value] of Object.entries(attributes)) {
    element.setAttribute(name, String(value));
  }
  return element;
}

function renderFlightPathTrack(segments, flight) {
  const layer = document.querySelector("#flight-path-layer");
  layer.replaceChildren();

  const allCoordinates = segments.flat();
  const averageLatitude =
    allCoordinates.reduce((sum, point) => sum + point.latitude, 0) / allCoordinates.length;
  const longitudeScale = Math.max(Math.cos((averageLatitude * Math.PI) / 180), 0.15);
  const projectedSegments = segments.map((segment) =>
    segment.map((point) => ({
      x: point.longitude * longitudeScale,
      y: -point.latitude,
    })),
  );
  const projectedPoints = projectedSegments.flat();
  const minX = Math.min(...projectedPoints.map((point) => point.x));
  const maxX = Math.max(...projectedPoints.map((point) => point.x));
  const minY = Math.min(...projectedPoints.map((point) => point.y));
  const maxY = Math.max(...projectedPoints.map((point) => point.y));
  const centerX = (minX + maxX) / 2;
  const centerY = (minY + maxY) / 2;
  const spanX = Math.max(maxX - minX, 0.001);
  const spanY = Math.max(maxY - minY, 0.001);
  const margin = 55;
  const scale = Math.min((960 - margin * 2) / spanX, (460 - margin * 2) / spanY);
  const toViewPoint = (point) => ({
    x: 480 + (point.x - centerX) * scale,
    y: 230 + (point.y - centerY) * scale,
  });

  for (const segment of projectedSegments) {
    const commands = segment.map((point, index) => {
      const viewPoint = toViewPoint(point);
      return `${index === 0 ? "M" : "L"}${viewPoint.x.toFixed(2)},${viewPoint.y.toFixed(2)}`;
    });
    layer.append(createSvgElement("path", {
      class: "flight-track-line",
      d: commands.join(" "),
    }));
  }

  const endpoints = [
    { point: projectedSegments[0][0], code: flight["Departure ICAO"], type: "start" },
    {
      point: projectedSegments.at(-1).at(-1),
      code: flight["Arrival ICAO"],
      type: "end",
    },
  ];
  for (const endpoint of endpoints) {
    const point = toViewPoint(endpoint.point);
    layer.append(createSvgElement("circle", {
      class: `flight-track-marker is-${endpoint.type}`,
      cx: point.x,
      cy: point.y,
      r: 7,
    }));
    const label = createSvgElement("text", {
      class: "flight-track-label",
      x: point.x + 12,
      y: point.y - 12,
    });
    label.textContent = endpoint.code;
    layer.append(label);
  }
}

function showFlightPathFallback(segments, flight, reason) {
  renderFlightPathTrack(segments, flight);
  document.querySelector("#cesium-globe").hidden = true;
  document.querySelector("#flight-path-map").removeAttribute("hidden");
  document.querySelector("#flight-path-details").textContent =
    `2D track fallback · ${reason}`;
  document.querySelector("#flight-path-empty").hidden = true;
}

function loadCesiumLibrary() {
  if (globalThis.Cesium) {
    return Promise.resolve(globalThis.Cesium);
  }
  if (cesiumLoadPromise) {
    return cesiumLoadPromise;
  }

  cesiumLoadPromise = new Promise((resolve, reject) => {
    globalThis.CESIUM_BASE_URL = CESIUM_BASE_URL;

    const stylesheet = document.createElement("link");
    stylesheet.rel = "stylesheet";
    stylesheet.href = `${CESIUM_BASE_URL}Widgets/widgets.css`;
    document.head.append(stylesheet);

    const script = document.createElement("script");
    script.src = `${CESIUM_BASE_URL}Cesium.js`;
    script.onload = () => {
      if (globalThis.Cesium) {
        resolve(globalThis.Cesium);
      } else {
        reject(new Error("CesiumJS loaded without exposing its API."));
      }
    };
    script.onerror = () => reject(new Error("The CesiumJS library could not be downloaded."));
    document.head.append(script);
  });
  return cesiumLoadPromise;
}

function createCesiumViewer(Cesium) {
  if (cesiumViewer && !cesiumViewer.isDestroyed()) {
    cesiumViewer.resize();
    return cesiumViewer;
  }

  cesiumViewer = new Cesium.Viewer("cesium-globe", {
    animation: false,
    baseLayerPicker: false,
    fullscreenButton: false,
    geocoder: false,
    homeButton: false,
    imageryProvider: false,
    infoBox: true,
    navigationHelpButton: false,
    sceneModePicker: false,
    selectionIndicator: true,
    timeline: false,
    terrainProvider: new Cesium.EllipsoidTerrainProvider(),
  });
  cesiumViewer.imageryLayers.addImageryProvider(
    new Cesium.UrlTemplateImageryProvider({
      url: "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
      credit: new Cesium.Credit("Imagery © Esri, Maxar, Earthstar Geographics, and the GIS User Community"),
    }),
  );
  cesiumViewer.scene.screenSpaceCameraController.enableRotate = true;
  cesiumViewer.scene.screenSpaceCameraController.enableTilt = true;
  cesiumViewer.scene.globe.baseColor = Cesium.Color.fromCssColorString("#12222e");
  return cesiumViewer;
}

async function renderFlightPathView(flightIndex) {
  const flight = flights[flightIndex];
  if (!flight) {
    return;
  }

  const isCurrentView = () =>
    activePanelFlightIndex === flightIndex && activePanelAction === "flight-path";
  const panel = document.querySelector("#map-panel");
  const view = document.querySelector("#flight-path-view");
  const map = document.querySelector("#flight-path-map");
  const globe = document.querySelector("#cesium-globe");
  const empty = document.querySelector("#flight-path-empty");
  const title = document.querySelector("#flight-path-empty-title");
  const message = document.querySelector("#flight-path-empty-message");
  panel.classList.add("is-content-mode");
  document.querySelector("#map-eyebrow").textContent = "FLIGHT PATH";
  document.querySelector("#map-title").textContent =
    `${flight["Departure ICAO"]} → ${flight["Arrival ICAO"]}`;
  document.querySelector("#world-map").setAttribute("aria-hidden", "true");
  map.setAttribute(
    "aria-label",
    `Recorded flight path from ${flight["Departure ICAO"]} to ${flight["Arrival ICAO"]}`,
  );
  document.querySelector("#photo-gallery").hidden = true;
  document.querySelector("#statistics-view").hidden = true;
  document.querySelector("#image-viewer").hidden = true;
  view.hidden = false;
  map.setAttribute("hidden", "");
  globe.hidden = true;
  empty.hidden = false;
  title.textContent = "Loading flight path";
  message.textContent = "Preparing the interactive 3D globe.";
  document.querySelector("#flight-path-route").textContent =
    `${flight.Aircraft} · ${formatDate(flight.Date)}`;
  document.querySelector("#flight-path-details").textContent = "Recorded KML track";

  const folderName = getFlightFolderName(flight);
  const flightPath = folderName ? flightPathManifest?.[folderName] : null;
  const isValidPath =
    typeof flightPath?.src === "string" &&
    /^data\/flight-paths\/\d{8}_\d{4}_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+\.kml$/.test(
      flightPath.src,
    );
  if (!isValidPath) {
    title.textContent = flightPathManifestError
      ? "Flight path index unavailable"
      : "No flight path for this flight";
    message.textContent = flightPathManifestError
      ? `${flightPathManifestError} Run the debrief flight path sync to publish KML tracks.`
      : "A KML track will appear here after the debrief sync.";
    return;
  }

  try {
    const kmlUrl = new URL(
      `./${flightPath.src.split("/").map(encodeURIComponent).join("/")}`,
      document.baseURI,
    );
    if (typeof flightPath.version === "string" && /^\d+$/.test(flightPath.version)) {
      kmlUrl.searchParams.set("v", flightPath.version);
    }
    const response = await fetch(kmlUrl, { cache: "no-store" });
    if (!response.ok) {
      throw new Error(`KML request failed (${response.status} ${response.statusText}).`);
    }
    const kmlText = await response.text();
    const documentXml = new DOMParser().parseFromString(kmlText, "application/xml");
    if (documentXml.querySelector("parsererror")) {
      throw new Error("The KML file is not valid XML.");
    }
    const segments = parseKmlTrack(kmlText);
    if (!isCurrentView()) {
      return;
    }

    const trackPointCount = segments.reduce((count, segment) => count + segment.length, 0);
    const waypointCount = Array.from(documentXml.getElementsByTagNameNS("*", "Placemark"))
      .filter((placemark) => placemark.getElementsByTagNameNS("*", "Point").length > 0)
      .length;
    document.querySelector("#flight-path-details").textContent =
      `${waypointCount.toLocaleString()} waypoints · ${trackPointCount.toLocaleString()} trackpoints · Click a waypoint for details`;

    try {
      const Cesium = await loadCesiumLibrary();
      if (!isCurrentView()) {
        return;
      }
      globe.hidden = false;
      const viewer = createCesiumViewer(Cesium);
      viewer.selectedEntity = undefined;
      viewer.dataSources.removeAll(true);
      viewer.scene.rethrowRenderErrors = false;
      viewer.scene.renderError.addEventListener((scene, error) => {
        if (!isCurrentView()) {
          return;
        }
        viewer.useDefaultRenderLoop = false;
        showFlightPathFallback(
          segments,
          flight,
          `3D globe rendering failed: ${error instanceof Error ? error.message : "Unexpected error"}`,
        );
        window.setTimeout(() => {
          if (cesiumViewer === viewer && !viewer.isDestroyed()) {
            viewer.destroy();
            cesiumViewer = null;
          }
        }, 0);
      });
      const source = await Cesium.KmlDataSource.load(documentXml, {
        camera: viewer.scene.camera,
        canvas: viewer.scene.canvas,
        sourceUri: kmlUrl.href,
      });
      if (!isCurrentView()) {
        source.destroy();
        return;
      }
      await viewer.dataSources.add(source);
      await viewer.zoomTo(
        source,
        new Cesium.HeadingPitchRange(
          0,
          Cesium.Math.toRadians(-60),
          Math.max(80000, Number(flight["Distance (nm)"]) * 1852 * 0.85 + 45000),
        ),
      );
      if (!isCurrentView()) {
        return;
      }
      title.textContent = "Flight path loaded";
      empty.hidden = true;
    } catch (error) {
      if (!isCurrentView()) {
        return;
      }
      showFlightPathFallback(
        segments,
        flight,
        `3D globe unavailable: ${error instanceof Error ? error.message : "Unexpected error"}`,
      );
    }
  } catch (error) {
    if (!isCurrentView()) {
      return;
    }
    title.textContent = "Unable to display flight path";
    message.textContent = error instanceof Error ? error.message : "An unexpected error occurred.";
  }
}

function togglePanelView(flightIndex, action) {
  if (activePanelFlightIndex === flightIndex && activePanelAction === action) {
    closeActivePanel();
    getActionButton(flightIndex, action)?.focus();
    return;
  }

  if (activePanelFlightIndex !== null) {
    closeActivePanel();
  }
  selectFlight(flightIndex);
  activePanelFlightIndex = flightIndex;
  activePanelAction = action;
  setActionButtonActive(flightIndex, action, true);
  if (action === "photos") {
    renderPhotoGallery(flightIndex);
  } else if (action === "flight-path") {
    renderFlightPathView(flightIndex);
  } else {
    renderStatisticsView(flightIndex);
  }
}

function togglePhotoGallery(flightIndex) {
  togglePanelView(flightIndex, "photos");
}

function toggleStatisticsView(flightIndex) {
  togglePanelView(flightIndex, "statistics");
}

function toggleFlightPathView(flightIndex) {
  togglePanelView(flightIndex, "flight-path");
}

function updateStatistics() {
  const airports = new Set();
  let distance = 0;
  let airTimeSeconds = 0;

  for (const flight of flights) {
    airports.add(flight["Departure ICAO"].trim().toUpperCase());
    airports.add(flight["Arrival ICAO"].trim().toUpperCase());
    const rawDistance = flight["Distance (nm)"];
    const flightDistance = Number(rawDistance);
    if (!rawDistance || !Number.isFinite(flightDistance)) {
      throw new Error(`Invalid flight distance "${rawDistance}".`);
    }
    distance += flightDistance;
    airTimeSeconds += parseDuration(flight["Duration (h:m:s)"]);
  }

  document.querySelector("#stat-flights").textContent = flights.length.toLocaleString();
  document.querySelector("#stat-airports").textContent = airports.size.toLocaleString();
  document.querySelector("#stat-time").textContent = formatAirTime(airTimeSeconds);
  const distanceValue = document.querySelector("#stat-distance");
  distanceValue.textContent = distance.toLocaleString();
  const distanceUnit = document.createElement("small");
  distanceUnit.textContent = "nm";
  distanceValue.append(distanceUnit);
  document.querySelector("#flight-count").textContent =
    `${flights.length.toLocaleString()} ${flights.length === 1 ? "flight" : "flights"}`;
}

async function loadPhotoManifest() {
  try {
    const response = await fetch("./data/photos/manifest.json", { cache: "no-store" });
    if (!response.ok) {
      throw new Error(`Screenshot index request failed (${response.status} ${response.statusText}).`);
    }
    const manifest = await response.json();
    if (manifest.version !== 1 || !manifest.flights || typeof manifest.flights !== "object") {
      throw new Error("The screenshot index has an unsupported format.");
    }
    photoManifest = manifest.flights;
  } catch (error) {
    photoManifestError = error instanceof Error ? error.message : "An unexpected error occurred.";
  }
}

async function loadStatisticsManifest() {
  try {
    const response = await fetch("./data/statistics/manifest.json", { cache: "no-store" });
    if (!response.ok) {
      throw new Error(
        `Statistics index request failed (${response.status} ${response.statusText}).`,
      );
    }
    const manifest = await response.json();
    if (
      manifest.version !== 1 ||
      !manifest.flights ||
      typeof manifest.flights !== "object"
    ) {
      throw new Error("The statistics index has an unsupported format.");
    }
    statisticsManifest = manifest.flights;
  } catch (error) {
    statisticsManifestError =
      error instanceof Error ? error.message : "An unexpected error occurred.";
  }
}

async function loadFlightPathManifest() {
  try {
    const response = await fetch("./data/flight-paths/manifest.json", { cache: "no-store" });
    if (!response.ok) {
      throw new Error(
        `Flight path index request failed (${response.status} ${response.statusText}).`,
      );
    }
    const manifest = await response.json();
    if (manifest.version !== 1 || !manifest.flights || typeof manifest.flights !== "object") {
      throw new Error("The flight path index has an unsupported format.");
    }
    flightPathManifest = manifest.flights;
  } catch (error) {
    flightPathManifestError =
      error instanceof Error ? error.message : "An unexpected error occurred.";
  }
}

async function loadFlightFoldersManifest() {
  try {
    const response = await fetch("./data/flight-folders.json", { cache: "no-store" });
    if (!response.ok) {
      throw new Error(
        `Flight folder index request failed (${response.status} ${response.statusText}).`,
      );
    }
    const manifest = await response.json();
    if (
      manifest.version !== 1 ||
      !Array.isArray(manifest.folders) ||
      !manifest.folders.every(
        (folder) =>
          typeof folder === "string" &&
          /^\d{8}_\d{4}_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+_[A-Za-z0-9_-]+$/.test(folder),
      )
    ) {
      throw new Error("The flight folder index has an unsupported format.");
    }
    flightFolders = new Set(manifest.folders);
  } catch (error) {
    flightFoldersManifestError =
      error instanceof Error ? error.message : "An unexpected error occurred.";
  }
}

function showError(message) {
  logStatus.textContent = "Unable to load flight log";
  logStatusContainer.classList.add("is-error");
  errorState.textContent =
    `${message} Check that data/FlightLog1.0.csv is valid and available, and serve this page over HTTP.`;
  errorState.hidden = false;
}

async function loadFlightLog() {
  try {
    await Promise.all([
      loadPhotoManifest(),
      loadStatisticsManifest(),
      loadFlightPathManifest(),
      loadFlightFoldersManifest(),
      loadLandmasses(),
    ]);
    const response = await fetch("./data/FlightLog1.0.csv", { cache: "no-store" });
    if (!response.ok) {
      throw new Error(`Flight log request failed (${response.status} ${response.statusText}).`);
    }
    flights = parseCsv(await response.text()).filter((flight) =>
      DISPLAY_COLUMNS.some((column) => flight[column]?.trim()),
    );
    if (flights.length === 0) {
      emptyState.hidden = false;
      logStatus.textContent = "Flight log is empty";
    } else {
      flightRows.replaceChildren(...flights.map(createFlightRow));
      logStatus.textContent = "Flight log loaded";
    }
    if (flightFoldersManifestError) {
      logStatus.textContent = "Flight folder index unavailable";
      logStatusContainer.classList.add("is-error");
      errorState.textContent =
        `${flightFoldersManifestError} Flight-specific actions are hidden; run ../update_webapp.py to publish the folder index.`;
      errorState.hidden = false;
    }
    updateStatistics();
    renderMap();
  } catch (error) {
    showError(error instanceof Error ? error.message : "An unexpected error occurred.");
  }
}

document.querySelector("#gallery-close").addEventListener("click", () => {
  if (activePanelFlightIndex !== null && activePanelAction === "photos") {
    togglePhotoGallery(activePanelFlightIndex);
  }
});
document.querySelector("#zoom-in").addEventListener("click", () => {
  setMapZoom(mapView.zoom * 1.5);
});
document.querySelector("#zoom-out").addEventListener("click", () => {
  setMapZoom(mapView.zoom / 1.5);
});
document.querySelector("#zoom-reset").addEventListener("click", () => {
  mapView.zoom = 1;
  mapView.centerX = MAP_WIDTH / 2;
  mapView.centerY = MAP_HEIGHT / 2;
  applyMapView();
});
document.querySelector("#zoom-to-flight").addEventListener("click", () => {
  if (selectedFlightIndex !== null) {
    fitFlightOnMap(selectedFlightIndex);
  }
});
document.querySelector("#map-canvas").addEventListener(
  "wheel",
  (event) => {
    if (document.querySelector("#world-map").getAttribute("aria-hidden") === "true") {
      return;
    }
    event.preventDefault();
    const point = svgPointFromEvent(event);
    setMapZoom(mapView.zoom * (event.deltaY < 0 ? 1.2 : 1 / 1.2), point);
  },
  { passive: false },
);
document.querySelector("#world-map").addEventListener("pointerdown", (event) => {
  if (event.button !== 0) {
    return;
  }
  mapPanStart = {
    point: svgPointFromEvent(event),
    centerX: mapView.centerX,
    centerY: mapView.centerY,
  };
  event.currentTarget.setPointerCapture(event.pointerId);
  document.querySelector("#map-canvas").classList.add("is-panning");
});
document.querySelector("#world-map").addEventListener("pointermove", (event) => {
  if (!mapPanStart) {
    return;
  }
  const point = svgPointFromEvent(event);
  mapView.centerX = mapPanStart.centerX - (point.x - mapPanStart.point.x) / mapView.zoom;
  mapView.centerY = mapPanStart.centerY - (point.y - mapPanStart.point.y) / mapView.zoom;
  applyMapView();
});
document.querySelector("#world-map").addEventListener("pointerup", (event) => {
  mapPanStart = null;
  document.querySelector("#map-canvas").classList.remove("is-panning");
  if (event.currentTarget.hasPointerCapture(event.pointerId)) {
    event.currentTarget.releasePointerCapture(event.pointerId);
  }
});
document.querySelector("#world-map").addEventListener("pointercancel", () => {
  mapPanStart = null;
  document.querySelector("#map-canvas").classList.remove("is-panning");
});
document.querySelector("#statistics-close").addEventListener("click", () => {
  if (activePanelFlightIndex !== null && activePanelAction === "statistics") {
    toggleStatisticsView(activePanelFlightIndex);
  }
});
document.querySelector("#flight-path-close").addEventListener("click", () => {
  if (activePanelFlightIndex !== null && activePanelAction === "flight-path") {
    toggleFlightPathView(activePanelFlightIndex);
  }
});
document.querySelector("#image-viewer-close").addEventListener("click", closeImageViewer);
document.querySelector("#image-viewer-previous").addEventListener("click", () => {
  navigateImageViewer(-1);
});
document.querySelector("#image-viewer-next").addEventListener("click", () => {
  navigateImageViewer(1);
});
document.querySelector("#image-viewer").addEventListener("click", (event) => {
  if (event.target === event.currentTarget) {
    closeImageViewer();
  }
});
document.addEventListener("keydown", (event) => {
  if (!document.querySelector("#image-viewer").hidden) {
    if (event.key === "ArrowLeft") {
      event.preventDefault();
      navigateImageViewer(-1);
    } else if (event.key === "ArrowRight") {
      event.preventDefault();
      navigateImageViewer(1);
    }
  }
  if (event.key === "Escape") {
    if (!document.querySelector("#image-viewer").hidden) {
      closeImageViewer();
    } else if (activePanelFlightIndex !== null) {
      const flightIndex = activePanelFlightIndex;
      const action = activePanelAction;
      closeActivePanel();
      if (action !== null) {
        getActionButton(flightIndex, action)?.focus();
      }
    }
  }
});
loadFlightLog();
