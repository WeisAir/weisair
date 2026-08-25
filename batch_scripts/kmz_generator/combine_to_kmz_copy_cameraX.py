import os
import argparse
import zipfile
import shutil
import re
import base64
from datetime import datetime, timezone, timedelta
import piexif

# ==========================================
# KONFIGURATION DER BILDABMESSUNGEN & STYLES
# ==========================================
IMAGE_WIDTH = "500"
IMAGE_HEIGHT = "auto"
TIME_TOLERANCE_MINUTES = 15
# ==========================================

# Ein eingebettetes, transparentes PNG-Kamera-Icon (Base64), damit das Skript autark arbeitet
BASE64_CAMERA_ICON = (
    "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAACBjSFJN"
    "AAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/APgvaeTAAAA"
    "Cx0RVh0U29mdHdhcmUAcGFpbnQubmV0IDUuMC4xM3b830YAAAJBSURBVFhHxZcxSxsxFIYfS6vV"
    "ih0cdXByqYidHArpIkiXgEun7p38B86Of0InRwc7OunSpSIdbAdHByfBTrpYpYsVv9fwpbaRphwN"
    "9wYChByS9+S9uclFf9YshmO1Wq0uYAmwD9wBv4D7mBvH8bLneXvA78XFxfscv9oF9vV/H3gArvM4"
    "D8wDWeAOmAduM6v+3eXfAor6XfX6Uf9D7vNfQA6YBlY6Z963P1vAsv7nE/gK7D8R6EwD88A88G3M"
    "jefbX+Rvs6m/2eTftXunwAdgBfgGrALvYm48r/0Y8EwDX8bctP3G6vI7Uf+y3f8WeM38f7Wp/wX8"
    "A96NufF8q20Bq/wL8An89Zf5G9GgEegE7gI/gV3ggXN0CtwDP7RPHmP+oX378602b/9I8w6Zp5T3"
    "wAbwAfgVcwf977p+pA38Zp566oE/wGtgK+be9XwV8FfU9wKWY25U73Fp/jHwvYgM4FvUeeo9g6b5"
    "PphvN7VvP5GvAsb96n2Xep9C03yNfI98v9A03wH/Bvgv9vAn8lXAn+Sppx7U63bVf6N988b8VwGj"
    "fV0S6O9rVv072uMffV9vYv6hffvzzWfAXwGPdf1Ie3ijL9L8P/X8f8C6V7WfGvMv7dtfYL4WUG8"
    "j/30v5p6NufF8617VfmrMX7Wv936GfC3wZcK6W3v0H5v6P3OOf+S7GvOf7Otr9zZof3w3gDqN6u"
    "8F6A3gPrAasH/GfOzvXwK6jfoZ/0H7v8v86A3gFrAK6D9Vf8p86A1gP+Zebv8Y+FrAW8TffbO4"
    "Zf8CAnfP+799mFAAAAAElFTkSuQmCC"
)

def parse_kml_time_range(kml_path):
    """Scannt die KML nach Zeitstempeln (<when> oder <TimeStamp>) und ermittelt das Start- und Endzeitfenster."""
    print("-> Analysiere KML-Route auf Zeitstempel...")
    with open(kml_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    time_matches = re.findall(r'<(?:when|TimeStamp[^>]*><when>|string[^>]*>)([^<\n]+)', content)
    
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

    if not parsed_times:
        print("⚠️ Hinweis: Keine Zeitstempel in der KML gefunden. Zeitfilter wird deaktiviert.")
        return None, None
        
    start_time = min(parsed_times)
    end_time = max(parsed_times)
    
    tolerance = timedelta(minutes=TIME_TOLERANCE_MINUTES)
    allowed_start = start_time - tolerance
    allowed_end = end_time + tolerance
    
    print(f"   Originale Route:       {start_time} bis {end_time}")
    print(f"   Erlaubtes Zeitfenster: {allowed_start} bis {allowed_end} (Inkl. {TIME_TOLERANCE_MINUTES} Min Toleranz)")
    return allowed_start, allowed_end

def get_image_data(image_path):
    """Extrahiert Koordinaten und den Aufnahme-Zeitstempel (EXIF) eines Bildes."""
    try:
        exif_dict = piexif.load(image_path)
        gps = exif_dict.get("GPS")
        exif = exif_dict.get("Exif")
        
        if not gps or piexif.GPSIFD.GPSLatitude not in gps or piexif.GPSIFD.GPSLongitude not in gps:
            return None

        def to_decimal(rational_triple, ref):
            d = float(rational_triple[0]) / float(rational_triple[1])
            m = float(rational_triple[0]) / float(rational_triple[1])
            s = float(rational_triple[0]) / float(rational_triple[1])
            
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
    except Exception:
        return None

def create_kmz(kml_path, image_folder, output_kmz, use_time_filter=True):
    if not os.path.exists(kml_path):
        print(f"Fehler: Die KML-Datei '{kml_path}' wurde nicht gefunden.")
        return
    if not os.path.exists(image_folder):
        print(f"Fehler: Der Bildordner '{image_folder}' wurde nicht gefunden.")
        return

    route_start, route_end = None, None
    if use_time_filter:
        route_start, route_end = parse_kml_time_range(kml_path)
    else:
        print("ℹ️ Zeitfilter manuell deaktiviert. Alle geolokalisierten Bilder werden verarbeitet.")

    temp_dir = "kmz_temp_build"
    temp_images_dir = os.path.join(temp_dir, "images")
    os.makedirs(temp_images_dir, exist_ok=True)

    try:
        # Generiere das Kamera-Icon lokal im images-Ordner
        icon_path = os.path.join(temp_images_dir, "custom_camera_icon.png")
        with open(icon_path, "wb") as icon_file:
            icon_file.write(base64.b64decode(BASE64_CAMERA_ICON))

        generated_placemarks = []
        image_count = 0
        skipped_time_count = 0
        
        for root, dirs, files in os.walk(image_folder):
            for file in files:
                if file.lower().endswith(('.jpg', '.jpeg', '.png')):
                    source_file = os.path.join(root, file)
                    img_data = get_image_data(source_file)
                    
                    if img_data:
                        lon, lat = img_data["coords"]
                        img_time = img_data["time"]
                        
                        if use_time_filter and route_start and route_end and img_time:
                            if not (route_start <= img_time <= route_end):
                                skipped_time_count += 1
                                continue
                        
                        shutil.copy(source_file, os.path.join(temp_images_dir, file))
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

        with open(kml_path, 'r', encoding='utf-8') as f:
            kml_content = f.read()

        # Der Style verweist jetzt auf das lokale Icon im KMZ-Archiv ("images/custom_camera_icon.png")
        style_block = (
            "  <Style id=\"photoStyle\">\n"
            "    <IconStyle>\n"
            "      <Icon><href>images/custom_camera_icon.png</href></Icon>\n"
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
            return

        with open(os.path.join(temp_dir, "doc.kml"), 'w', encoding='utf-8') as f:
            f.write(kml_content)

        print(f"\n-> KML wurde erfolgreich um {image_count} passende Bild-Placemarks erweitert.")
        if skipped_time_count > 0:
            print(f"-> {skipped_time_count} Bilder wurden aufgrund des Zeitfilters aussortiert.")

        with zipfile.ZipFile(output_kmz, 'w', zipfile.ZIP_DEFLATED) as kmz:
            for root, dirs, files in os.walk(temp_dir):
                for file in files:
                    file_path = os.path.join(root, file)
                    arcname = os.path.relpath(file_path, temp_dir)
                    kmz.write(file_path, arcname)
        
        print(f" 🎉 Erfolg: KMZ-Datei wurde unter '{output_kmz}' erstellt!")

    except Exception as e:
        print(f"Ein Fehler ist aufgetreten: {e}")
    finally:
        if os.path.exists(temp_dir):
            shutil.rmtree(temp_dir)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Integriert Bilder in eine KML und packt sie als KMZ mit lokalen Custom Styles.")
    parser.add_argument("kml_file", help="Pfad zur Quell-KML-Datei")
    parser.add_argument("image_folder", help="Pfad zum Ordner mit den geotaggten Bildern")
    parser.add_argument("output_kmz", help="Name der zu erstellenden KMZ-Zieldatei")
    
    parser.add_argument(
        "--no-time-filter", 
        action="store_false", 
        dest="use_time_filter",
        help="Deaktiviert die zeitliche Prüfung der Bilder anhand der KML-Daten."
    )
    args = parser.parse_args()

