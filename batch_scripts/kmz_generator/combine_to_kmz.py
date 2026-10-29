import os
import zipfile
import shutil
import re
import base64
import argparse
import csv
import struct
from datetime import datetime, timezone, timedelta
from zoneinfo import ZoneInfo
import piexif

# ==========================================
# KONFIGURATION DER BILDABMESSUNGEN & STYLES
# ==========================================
IMAGE_WIDTH = "900"
IMAGE_HEIGHT = "auto"
TIME_TOLERANCE_MINUTES = 15
LOCAL_TIMEZONE = ZoneInfo("Europe/Oslo")
SCREENSHOT_AIRCRAFT_ALIASES = {"be58": {"baron58"}}
# ==========================================

# Transparentes Kamera-Icon (Base64), das im KMZ-Hauptverzeichnis abgelegt wird
BASE64_CAMERA_ICON = (
    "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAOCSURBVGhD7VhNS1RRGPa/tAiiRbURCWEWQiAULfpYiIs+Ftmm3ORGRMJNEVRkJppKBUqBfYAiWIQhkpk59IFkaI5pWjpIM+V4x49z4jnOOxzfe+feO8O9l1ncBx5G577nnOc55z3vOXNLSkKECBEiRIgCIKWMSCkbC2SE9xc4MkIKRSPvL3CQgbHxia079zo23BCxRWcAwvbsL11zQ8SGBrxC0RrIo7oMQUlza+f23gOHN9wQsRkDaMv7c0v7CpYJco2x8ahsaetyRcR6APvVIwNO1eXd+wmazbyBtrw/J7quYGQAjXgO66w6c9Hgg7gl2vL+nIh2nhoImoEbOHL09DpmmnjsRPU6j8mHgRg4WFaRQruZ2Zjl/lheiYueJ882YY631QnD+w6V7/rOdwNnL9QaEEhik8a2/DCfynIxsZk1YhhpWVfflOZ9QDSZTySToixSmaJnvhnArD990Z9V93lpXV7pW5Klt6dNrO6el29jaxQqh0dGt3SRMJV9KKW8caslq8E3AyQ+vSnk3ZG4SbQVrw7+VisERD9+2aZ0gRmsDuFk1flsqvliAGlD4jG7XKgdK9tnZXxtp7TrY2F/4H/0rY/luQGkDuW825nnvPR8USnCrOuzbUXPDbR1PlIdIue5MCJWpab3p+3q9H5KKFVIJT6GrwbmFxbV7EMgF1XR+n3XZgVg9NTDOVNsefOMSkFA39CcnhrAoYQY5DAXBKJsWiG2uqEE8/jBqb/qeW1dQ84rhqcGai7Xqc07NP3PJObc4wVNshlWJbZ9dFU9sxvTUwMNTddVreubTJrEXHu9rMk1A2J5G5RVACWZj+WLASw1YqwMUGXJBYjlbVDFABQGPpYvBnBXQczUsmESgxzXrw060ltC1X/ehioRVpaP5YsBnJx0Yh7vipkEYR/QIUWA+PqBX6ZYkAzb3Vg9NQD2D7xUCjF7XBCIUnrzzYrKeXxazTxI+Y+yzMfw1QBOzkyHlmeBG2L1ksbOStmljy8G9E6RLphxLtCJdF7gVsr75vTFAPbC5Ndv6lqJQwq5z0VaEelEJzXuU3YnsK8GQNwe9V9gThc7bGRKG/xo4bfOXMzbgNNrFZ2o37QSAFIKZwQ2MPYHTPVE/6hVIsTmfoiOBz2mvnIx79cqRQxHA25fLeakEKJVCPEK1yUhxKwQYjjz930eWwDtXy2GCBEiRKD4D4WdJ6by/EHiAAAAAElFTkSuQmCC"
)

def parse_kml_time_range(kml_path):
    print("-> Analysiere KML-Route auf Zeitstempel...")
    try:
        with open(kml_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        time_matches = re.findall(
            r'<(?:when|TimeStamp[^>]*><when>|string[^>]*>)([^<\n]+)',
            content,
            flags=re.IGNORECASE,
        )
        kml_date_match = re.search(r'\bDate\s*:\s*(\d{4}-\d{2}-\d{2})', content)
        if kml_date_match:
            time_matches.extend(re.findall(
                r'<Data\b[^>]*\bname=["\']time["\'][^>]*>\s*'
                r'<value>\s*(\d{2}:\d{2}:\d{2}(?:\.\d+)?)\s*</value>',
                content,
                flags=re.IGNORECASE,
            ))
        
        parsed_times = []
        for t_str in time_matches:
            t_clean = t_str.strip()
            for fmt in ("%Y-%m-%dT%H:%M:%SZ", "%Y-%m-%dT%H:%M:%S.%fZ", "%Y-%m-%d"):
                try:
                    dt = datetime.strptime(t_clean, fmt).replace(tzinfo=timezone.utc)
                    parsed_times.append(dt)
                    break
                except ValueError:
                    continue
            if kml_date_match and not t_clean.endswith("Z") and ":" in t_clean:
                try:
                    parsed_times.append(datetime.strptime(
                        f"{kml_date_match.group(1)} {t_clean}",
                        "%Y-%m-%d %H:%M:%S",
                    ).replace(tzinfo=timezone.utc))
                except ValueError:
                    continue

        if not parsed_times:
            print("⚠️ Hinweis: Keine Zeitstempel in der KML gefunden. Zeitfilter wird deaktiviert.")
            return None, None
            
        start_time = min(parsed_times)
        end_time = max(parsed_times)
        
        tolerance = timedelta(minutes=TIME_TOLERANCE_MINUTES)
        allowed_start = start_time - tolerance
        allowed_end = end_time + tolerance
        
        print(f"   Originale Route:       {start_time} bis {end_time}")
        print(f"   Erlaubtes Zeitfenster: {allowed_start} bis {allowed_end}")
        return allowed_start, allowed_end
    except Exception as e:
        print(f"⚠️ Fehler beim Parsen der KML-Zeitstempel: {e}")
        return None, None

def load_image_exif(image_path):
    with open(image_path, "rb") as image_file:
        if image_file.read(8) != b"\x89PNG\r\n\x1a\n":
            return piexif.load(image_path)

        while True:
            chunk_header = image_file.read(8)
            if len(chunk_header) != 8:
                break

            chunk_length = struct.unpack(">I", chunk_header[:4])[0]
            chunk_type = chunk_header[4:]
            if chunk_type == b"eXIf":
                exif_data = image_file.read(chunk_length)
                if len(exif_data) != chunk_length:
                    raise ValueError("PNG eXIf chunk is truncated")
                return piexif.load(exif_data)

            image_file.seek(chunk_length + 4, os.SEEK_CUR)

    raise ValueError("PNG does not contain an eXIf metadata chunk")

def get_image_data(image_path):
    try:
        exif_dict = load_image_exif(image_path)
        gps = exif_dict.get("GPS")
        exif = exif_dict.get("Exif")
        
        if not gps or piexif.GPSIFD.GPSLatitude not in gps or piexif.GPSIFD.GPSLongitude not in gps:
            print(
                f"[GPS DEBUG] {os.path.basename(image_path)}: "
                "lon=<unavailable>, lat=<unavailable>; GPS tags are missing"
            )
            return None

        # Sicherer Zugriff ohne eckige Indizes im mathematischen Code
        def to_decimal(rational_triple, ref):
            triple_list = list(rational_triple)
            d_val = triple_list.pop(0)
            m_val = triple_list.pop(0)
            s_val = triple_list.pop(0)
            
            d = float(d_val[0]) / float(d_val[1])
            m = float(m_val[0]) / float(m_val[1])
            s = float(s_val[0]) / float(s_val[1])
            
            decimal = d + (m / 60.0) + (s / 3600.0)
            if ref in [b'S', b'W', 'S', 'W']:
                decimal = -decimal
            return decimal

        lon = to_decimal(gps[piexif.GPSIFD.GPSLongitude], gps[piexif.GPSIFD.GPSLongitudeRef])
        lat = to_decimal(gps[piexif.GPSIFD.GPSLatitude], gps[piexif.GPSIFD.GPSLatitudeRef])
        
        img_time = None
        if exif and piexif.ExifIFD.DateTimeOriginal in exif:
            date_str = exif[piexif.ExifIFD.DateTimeOriginal].decode('utf-8')
            img_time = datetime.strptime(date_str, "%Y:%m:%d %H:%M:%S").replace(tzinfo=timezone.utc)
            
        return {"coords": (lon, lat), "time": img_time}
    except ValueError as error:
        print(
            f"[GPS DEBUG] {os.path.basename(image_path)}: "
            f"lon=<unavailable>, lat=<unavailable>; EXIF metadata cannot be read: {error}"
        )
        return None
    except (OSError, KeyError, IndexError, TypeError, ZeroDivisionError) as error:
        print(
            f"[GPS DEBUG] {os.path.basename(image_path)}: "
            f"lon=<unavailable>, lat=<unavailable>; GPS metadata error: {error}"
        )
        return None

def get_filename_time(file_name):
    match = re.search(
        r'(\d{4}-\d{2}-\d{2})\s+(\d{2}\.\d{2}\.\d{2})(?:\s+(AM|PM))?',
        file_name,
        flags=re.IGNORECASE,
    )
    if not match:
        return None
    try:
        time_format = "%Y-%m-%d %I.%M.%S %p" if match.group(3) else "%Y-%m-%d %H.%M.%S"
        time_text = f"{match.group(1)} {match.group(2)}"
        if match.group(3):
            time_text += f" {match.group(3)}"
        local_time = datetime.strptime(time_text, time_format).replace(tzinfo=LOCAL_TIMEZONE)
        return local_time.astimezone(timezone.utc)
    except ValueError:
        return None


def normalize_aircraft_name(value):
    return re.sub(r"[^a-z0-9]", "", value.casefold())


def get_filename_aircraft(file_name):
    match = re.match(
        r"^(.+?)\s+-\s+\d{4}-\d{2}-\d{2}\s+",
        file_name,
        flags=re.IGNORECASE,
    )
    return match.group(1).strip() if match else None


def get_filename_date(file_name):
    match = re.search(
        r"(\d{4})-(\d{2})-(\d{2})\s+\d{2}\.\d{2}\.\d{2}",
        file_name,
    )
    return "".join(match.groups()) if match else None


def screenshot_matches_aircraft(file_name, aircraft):
    screenshot_aircraft = get_filename_aircraft(file_name)
    if screenshot_aircraft is None:
        return False

    normalized_aircraft = normalize_aircraft_name(aircraft)
    accepted_names = {normalized_aircraft}
    accepted_names.update(SCREENSHOT_AIRCRAFT_ALIASES.get(normalized_aircraft, set()))
    return normalize_aircraft_name(screenshot_aircraft) in accepted_names


def parse_flight_log_time_ranges(
    flight_log_path,
    aircraft=None,
    flight_date=None,
    departure_icao=None,
    arrival_icao=None,
    flight_start_time=None,
):
    flight_identity = (
        aircraft,
        flight_date,
        departure_icao,
        arrival_icao,
        flight_start_time,
    )
    if any(value is not None for value in flight_identity) and any(
        value is None for value in flight_identity
    ):
        raise ValueError(
            "Aircraft, flight date, departure/arrival ICAO, and flight start time "
            "must all be supplied to select one flight"
        )

    time_formats = (
        "%Y-%m-%d %I.%M.%S %p",
        "%Y-%m-%d %H.%M.%S",
    )

    def parse_local_time(value):
        for time_format in time_formats:
            try:
                return datetime.strptime(value, time_format).replace(
                    tzinfo=LOCAL_TIMEZONE
                ).astimezone(timezone.utc)
            except ValueError:
                continue
        raise ValueError(f"Invalid system timestamp: {value!r}")

    ranges = []
    matching_rows = 0
    with open(flight_log_path, "r", encoding="utf-8-sig", newline="") as flight_log:
        reader = csv.DictReader(flight_log)
        fieldnames = reader.fieldnames or []
        if "system_time_start" not in fieldnames:
            raise ValueError("CSV is missing the 'system_time_start' column")
        if not ({"system_time_end", "system_time_stop"} & set(fieldnames)):
            raise ValueError(
                "CSV is missing a 'system_time_end' or 'system_time_stop' column"
            )

        for row_number, row in enumerate(reader, start=2):
            if aircraft is not None:
                try:
                    row_date = datetime.strptime(
                        (row.get("Date") or "").strip(), "%Y-%m-%d"
                    ).strftime("%Y%m%d")
                except ValueError:
                    continue
                if (
                    (row.get("Aircraft") or "").strip().casefold()
                    != aircraft.casefold()
                    or row_date != flight_date
                    or (row.get("Departure ICAO") or "").strip().casefold()
                    != departure_icao.casefold()
                    or (row.get("Arrival ICAO") or "").strip().casefold()
                    != arrival_icao.casefold()
                ):
                    continue

            start_text = (row.get("system_time_start") or "").strip()
            end_text = (
                row.get("system_time_end") or row.get("system_time_stop") or ""
            ).strip()
            if aircraft is not None:
                row_start = None
                for time_format in time_formats:
                    try:
                        row_start = datetime.strptime(start_text, time_format)
                        break
                    except ValueError:
                        continue
                if row_start is None:
                    continue
                if row_start.strftime("%H%M") != flight_start_time:
                    continue

            if not start_text and not end_text:
                continue
            if not start_text or not end_text:
                raise ValueError(
                    f"CSV row {row_number} must contain both system-time values"
                )
            try:
                start_time = parse_local_time(start_text)
                end_time = parse_local_time(end_text)
            except ValueError as error:
                raise ValueError(f"CSV row {row_number}: {error}") from error
            if start_time > end_time:
                raise ValueError(
                    f"CSV row {row_number}: system_time_start is after the end time"
                )
            ranges.append((start_time, end_time))
            matching_rows += 1

    if not ranges:
        if aircraft is not None:
            raise ValueError(
                "CSV contains no flight record matching the requested aircraft, "
                "date, route, and start time"
            )
        raise ValueError("CSV contains no flight records with system-time ranges")
    if aircraft is not None and len(set(ranges)) != 1:
        raise ValueError(
            f"CSV contains {matching_rows} different records matching the requested flight"
        )
    if aircraft is not None:
        return [ranges[0]]
    return ranges


def create_kmz(
    kml_path,
    image_folder,
    output_kmz,
    use_time_filter=True,
    flight_log_path=None,
    capture_output_dir=None,
    flight_aircraft=None,
    flight_date=None,
    departure_icao=None,
    arrival_icao=None,
    flight_start_time=None,
):
    print("-> Starte Erstellung des KMZ-Pakets...")
    if not os.path.exists(kml_path):
        print(f"Fehler: Die KML-Datei '{kml_path}' wurde nicht gefunden.")
        return False
    if not os.path.exists(image_folder):
        print(f"Fehler: Der Bildordner '{image_folder}' wurde nicht gefunden.")
        return False
    flight_identity = (
        flight_aircraft,
        flight_date,
        departure_icao,
        arrival_icao,
        flight_start_time,
    )
    if any(value is not None for value in flight_identity) and any(
        value is None for value in flight_identity
    ):
        print(
            "Fehler: Flugzeug, Flugdatum, Abflug/Ziel-ICAO und Startzeit müssen "
            "zusammen angegeben werden."
        )
        return False
    if any(value is not None for value in flight_identity) and not flight_log_path:
        print("Fehler: Fluglog ist für eine flugspezifische Filterung erforderlich.")
        return False
    if flight_date is not None and not re.fullmatch(r"\d{8}", flight_date):
        print("Fehler: Flugdatum muss das Format YYYYMMDD haben.")
        return False
    if capture_output_dir is not None:
        image_folder_real = os.path.realpath(image_folder)
        capture_output_real = os.path.realpath(capture_output_dir)
        if os.path.commonpath((image_folder_real, capture_output_real)) in (
            image_folder_real,
            capture_output_real,
        ):
            print(
                "Fehler: Capture-Ziel darf sich nicht mit dem Screenshot-Quellordner "
                "überschneiden."
            )
            return False

    route_start, route_end = None, None
    flight_log_ranges = None
    if use_time_filter:
        if flight_log_path:
            try:
                flight_log_ranges = parse_flight_log_time_ranges(
                    flight_log_path,
                    aircraft=flight_aircraft,
                    flight_date=flight_date,
                    departure_icao=departure_icao,
                    arrival_icao=arrival_icao,
                    flight_start_time=flight_start_time,
                )
            except (OSError, ValueError) as error:
                print(f"Fehler beim Lesen des Fluglogs '{flight_log_path}': {error}")
                return False
            print(
                f"-> Screenshot-Zeitfilter anhand von {len(flight_log_ranges)} "
                "Fluglog-Zeitfenster(n)."
            )
        else:
            route_start, route_end = parse_kml_time_range(kml_path)
    else:
        print("ℹ️ Zeitfilter manuell deaktiviert. Alle geolokalisierten Bilder werden verarbeitet.")

    temp_dir = "kmz_temp_build"
    temp_images_dir = os.path.join(temp_dir, "images")
    temp_capture_dir = os.path.join(temp_dir, "capture")
    
    if os.path.exists(temp_dir):
        shutil.rmtree(temp_dir)
    os.makedirs(temp_images_dir, exist_ok=True)
    success = False

    try:
        if capture_output_dir is not None:
            os.makedirs(capture_output_dir, exist_ok=True)
            os.makedirs(temp_capture_dir, exist_ok=True)

        # Icon liegt im Hauptverzeichnis des KMZ-Archivs
        icon_path = os.path.join(temp_dir, "camera_icon.png")
        with open(icon_path, "wb") as icon_file:
            icon_file.write(base64.b64decode(BASE64_CAMERA_ICON))

        generated_placemarks = []
        image_count = 0
        skipped_time_count = 0
        skipped_metadata_count = 0
        skipped_aircraft_count = 0
        skipped_date_count = 0
        
        for root, dirs, files in os.walk(image_folder):
            for file in files:
                if file.lower().endswith(('.jpg', '.jpeg', '.png')):
                    if flight_aircraft is not None and not screenshot_matches_aircraft(
                        file, flight_aircraft
                    ):
                        print(
                            f"[FLIGHT DEBUG] {file}: SKIPPED (aircraft does not "
                            f"match {flight_aircraft})"
                        )
                        skipped_aircraft_count += 1
                        continue
                    if (
                        flight_date is not None
                        and get_filename_date(file) != flight_date
                    ):
                        print(
                            f"[FLIGHT DEBUG] {file}: SKIPPED (date does not match "
                            f"{flight_date})"
                        )
                        skipped_date_count += 1
                        continue

                    source_file = os.path.join(root, file)
                    img_data = get_image_data(source_file)
                    
                    if img_data:
                        lon, lat = img_data["coords"]
                        print(
                            f"[GPS DEBUG] {file}: lon={lon:.8f}, lat={lat:.8f}"
                        )
                        exif_time = img_data["time"]
                        filename_time = get_filename_time(file)
                        filter_time = (
                            filename_time
                            if flight_log_ranges is not None
                            else exif_time or filename_time
                        )
                        if flight_log_ranges is not None:
                            timestamp_source = "filename" if filename_time else "none"
                        else:
                            timestamp_source = "EXIF" if exif_time else (
                                "filename" if filename_time else "none"
                            )
                        timestamp_text = filter_time.isoformat() if filter_time else "<none>"
                        
                        if use_time_filter and flight_log_ranges is not None:
                            if not filter_time:
                                print(
                                    f"[TIME DEBUG] {file}: timestamp=<none>; source={timestamp_source}; "
                                    "SKIPPED (no usable timestamp)"
                                )
                                skipped_time_count += 1
                                continue
                            if not any(
                                start <= filter_time <= end
                                for start, end in flight_log_ranges
                            ):
                                log_ranges_text = "; ".join(
                                    f"{start.isoformat()} to {end.isoformat()}"
                                    for start, end in flight_log_ranges
                                )
                                print(
                                    f"[TIME DEBUG] {file}: timestamp={filter_time.isoformat()}; "
                                    f"source=filename; flight-log-ranges={log_ranges_text}; "
                                    "SKIPPED (outside flight-log window)"
                                )
                                skipped_time_count += 1
                                continue
                        elif use_time_filter and route_start and route_end:
                            if not filter_time:
                                print(
                                    f"[TIME DEBUG] {file}: timestamp=<none>; source={timestamp_source}; "
                                    "SKIPPED (no usable timestamp)"
                                )
                                skipped_time_count += 1
                                continue
                            if not (route_start <= filter_time <= route_end):
                                print(
                                    f"[TIME DEBUG] {file}: timestamp={timestamp_text}; source={timestamp_source}; "
                                    f"route={route_start.isoformat()} to {route_end.isoformat()}; "
                                    "SKIPPED (outside route window)"
                                )
                                skipped_time_count += 1
                                continue
                        print(
                            f"[TIME DEBUG] {file}: timestamp={timestamp_text}; source={timestamp_source}; "
                            f"flight-log-ranges={len(flight_log_ranges) if flight_log_ranges is not None else '<not used>'}; "
                            f"route={route_start.isoformat() if route_start else '<none>'} to "
                            f"{route_end.isoformat() if route_end else '<none>'}; INCLUDED"
                        )
                        
                        shutil.copy(source_file, os.path.join(temp_images_dir, file))
                        if capture_output_dir is not None:
                            shutil.copy2(source_file, temp_capture_dir)
                        image_count += 1
                        
                        style_w = f"width:{IMAGE_WIDTH}px;" if IMAGE_WIDTH != "auto" else ""
                        style_h = f"height:{IMAGE_HEIGHT}px;" if IMAGE_HEIGHT != "auto" else ""
                        style_str = f'style="{style_w}{style_h}"' if (style_w or style_h) else ""

                        placemark_str = (
                            "  <Placemark>\n"
                            f"    <name>{file}</name>\n"
                            "    <styleUrl>#photoStyle</styleUrl>\n"
                            f"    <description><![CDATA[<img src=\"images/{file}\" {style_str} /><br/>Bild: {file}]]></description>\n"
                            "    <Point>\n"
                            f"      <coordinates>{lon},{lat},0</coordinates>\n"
                            "    </Point>\n"
                            "  </Placemark>\n"
                        )
                        generated_placemarks.append(placemark_str)
                    else:
                        skipped_metadata_count += 1

        with open(kml_path, 'r', encoding='utf-8') as f:
            kml_content = f.read()

        # Korrekter relativer Verweis auf das Icon im Hauptverzeichnis
        style_block = (
            "  <Style id=\"photoStyle\">\n"
            "    <IconStyle>\n"
            "      <Icon><href>camera_icon.png</href></Icon>\n"
            "      <scale>1.3</scale>\n"
            "    </IconStyle>\n"
            "    <LabelStyle>\n"
            "      <scale>0</scale>\n"
            "    </LabelStyle>\n"
            "  </Style>\n"
        )

        injection_block = style_block + "".join(generated_placemarks)
        
        if "</Document>" in kml_content:
            kml_content = kml_content.replace("</Document>", f"{injection_block}</Document>")
        elif "</kml>" in kml_content:
            kml_content = kml_content.replace("</kml>", f"{injection_block}</kml>")
        else:
            print("Fehler: Ungültiges KML-Format.")
            return False

        with open(os.path.join(temp_dir, "doc.kml"), 'w', encoding='utf-8') as f:
            f.write(kml_content)

        print(f"\n-> KML wurde erfolgreich um {image_count} passende Bild-Placemarks erweitert.")
        if skipped_time_count > 0:
            print(f"-> {skipped_time_count} Bilder wurden aufgrund des Zeitfilters aussortiert.")
        if skipped_metadata_count > 0:
            print(
                f"-> {skipped_metadata_count} Bilder wurden aussortiert, "
                "weil GPS-Koordinaten nicht gelesen werden konnten."
            )
        if skipped_aircraft_count > 0:
            print(f"-> {skipped_aircraft_count} Bilder passten nicht zum Flugzeug.")
        if skipped_date_count > 0:
            print(f"-> {skipped_date_count} Bilder passten nicht zum Flugdatum.")
        if capture_output_dir is not None:
            print(
                f"-> {image_count} passende Bilder wurden nach "
                f"'{capture_output_dir}' kopiert."
            )

        with zipfile.ZipFile(output_kmz, 'w', zipfile.ZIP_DEFLATED) as kmz:
            for root, dirs, files in os.walk(temp_dir):
                for file in files:
                    file_path = os.path.join(root, file)
                    arcname = os.path.relpath(file_path, temp_dir)
                    if not file_path.startswith(f"{temp_capture_dir}{os.sep}"):
                        kmz.write(file_path, arcname)

        if capture_output_dir is not None:
            image_extensions = (".jpg", ".jpeg", ".png")
            for entry in os.scandir(capture_output_dir):
                if (
                    entry.is_file(follow_symlinks=False)
                    and entry.name.lower().endswith(image_extensions)
                ):
                    os.unlink(entry.path)
            for file in os.listdir(temp_capture_dir):
                shutil.copy2(
                    os.path.join(temp_capture_dir, file),
                    capture_output_dir,
                )
        
        print(f" 🎉 Erfolg: KMZ-Datei wurde unter '{output_kmz}' erstellt!")
        success = True

    except Exception as e:
        print(f"Ein schwerwiegender Fehler ist aufgetreten: {e}")
    finally:
        if os.path.exists(temp_dir):
            shutil.rmtree(temp_dir)
    return success

if __name__ == "__main__":
    argument_parser = argparse.ArgumentParser()
    argument_parser.add_argument("kml_file", help="KML file written by the simulator")
    argument_parser.add_argument("image_folder", help="Folder containing screenshots")
    argument_parser.add_argument("output_kmz", help="Path for the output KMZ file")
    argument_parser.add_argument(
        "--flight-log",
        help="Flight log CSV used to filter screenshots by system-time range",
    )
    argument_parser.add_argument(
        "--capture-output",
        help="optional directory to receive copies of the filtered screenshots",
    )
    argument_parser.add_argument(
        "--flight-aircraft",
        help="aircraft code for selecting one flight and matching screenshot names",
    )
    argument_parser.add_argument(
        "--flight-date",
        help="flight date in YYYYMMDD format",
    )
    argument_parser.add_argument(
        "--departure-icao",
        help="departure ICAO code for selecting one flight",
    )
    argument_parser.add_argument(
        "--arrival-icao",
        help="arrival ICAO code for selecting one flight",
    )
    argument_parser.add_argument(
        "--flight-start-time",
        help="flight system start time in HHMM format",
    )
    argument_parser.add_argument(
        "--no-time-filter",
        action="store_true",
        help="Process every geolocated screenshot without a time filter",
    )
    arguments = argument_parser.parse_args()
    success = create_kmz(
        arguments.kml_file,
        arguments.image_folder,
        arguments.output_kmz,
        use_time_filter=not arguments.no_time_filter,
        flight_log_path=arguments.flight_log,
        capture_output_dir=arguments.capture_output,
        flight_aircraft=arguments.flight_aircraft,
        flight_date=arguments.flight_date,
        departure_icao=arguments.departure_icao,
        arrival_icao=arguments.arrival_icao,
        flight_start_time=arguments.flight_start_time,
    )
    if not success:
        raise SystemExit(1)