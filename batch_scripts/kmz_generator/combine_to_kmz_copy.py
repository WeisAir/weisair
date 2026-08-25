import os
import argparse
import zipfile
import shutil
import piexif

def get_gps_coordinates(image_path):
    """Extrahiert Breitengrad und Längengrad aus den EXIF-Daten eines Bildes."""
    try:
        exif_dict = piexif.load(image_path)
        gps = exif_dict.get("GPS")
        if not gps or piexif.GPSIFD.GPSLatitude not in gps or piexif.GPSIFD.GPSLongitude not in gps:
            return None

        # Hilfsfunktion zur Umrechnung von Grad/Minuten/Sekunden-Tupeln (Zähler, Nenner) in Dezimalgrad
        def to_decimal(rational_triple, ref):
            d = rational_triple[0][0] / rational_triple[0][1]
            m = rational_triple[1][0] / rational_triple[1][1]
            s = rational_triple[2][0] / rational_triple[2][1]
            
            decimal = d + (m / 60.0) + (s / 3600.0)
            if ref in [b'S', b'W', 'S', 'W']:
                decimal = -decimal
            return decimal

        lat = to_decimal(gps[piexif.GPSIFD.GPSLatitude], gps[piexif.GPSIFD.GPSLatitudeRef])
        lon = to_decimal(gps[piexif.GPSIFD.GPSLongitude], gps[piexif.GPSIFD.GPSLongitudeRef])
        return lon, lat
    except Exception as e:
        # Falls ein unerwarteter Fehler auftritt, wird er hier ignoriert und None geliefert
        return None

def create_kmz(kml_path, image_folder, output_kmz):
    if not os.path.exists(kml_path):
        print(f"Fehler: Die KML-Datei '{kml_path}' wurde nicht gefunden.")
        return
    if not os.path.exists(image_folder):
        print(f"Fehler: Der Bildordner '{image_folder}' wurde nicht gefunden.")
        return

    temp_dir = "kmz_temp_build"
    temp_images_dir = os.path.join(temp_dir, "images")
    os.makedirs(temp_images_dir, exist_ok=True)

    try:
        generated_placemarks = []
        image_count = 0
        
        for root, dirs, files in os.walk(image_folder):
            for file in files:
                if file.lower().endswith(('.jpg', '.jpeg', '.png')):
                    source_file = os.path.join(root, file)
                    coords = get_gps_coordinates(source_file)
                    
                    if coords:
                        lon, lat = coords
                        shutil.copy(source_file, os.path.join(temp_images_dir, file))
                        image_count += 1
                        
                        # Einsetzen des Dateinamens mittels f-String (wichtig: geschweifte Klammern verdoppeln bei {file} im HTML, wenn es ein f-String ist)
                        placemark_str = (
                            "  <Placemark>\n"
                            f"    <name>{file}</name>\n"
                            f"    <description><![CDATA[<img src=\"images/{file}\" width=\"400\" /><br/>Bild: {file}]]></description>\n"
                            "    <Point>\n"
                            f"      <coordinates>{lon},{lat},0</coordinates>\n"
                            "    </Point>\n"
                            "  </Placemark>\n"
                        )
                        generated_placemarks.append(placemark_str)
                    else:
                        print(f"Hinweis: Keine GPS-Daten in '{file}' gefunden.")

        with open(kml_path, 'r', encoding='utf-8') as f:
            kml_content = f.read()

        placemarks_block = "".join(generated_placemarks)
        
        if "</Document>" in kml_content:
            kml_content = kml_content.replace("</Document>", f"{placemarks_block}</Document>")
        elif "</kml>" in kml_content:
            kml_content = kml_content.replace("</kml>", f"{placemarks_block}</kml>")
        else:
            print("Fehler: Ungültiges KML-Format (weder </Document> noch </kml> gefunden).")
            return

        with open(os.path.join(temp_dir, "doc.kml"), 'w', encoding='utf-8') as f:
            f.write(kml_content)

        print(f"-> KML wurde erfolgreich um {image_count} Bild-Placemarks erweitert.")

        with zipfile.ZipFile(output_kmz, 'w', zipfile.ZIP_DEFLATED) as kmz:
            for root, dirs, files in os.walk(temp_dir):
                for file in files:
                    file_path = os.path.join(root, file)
                    arcname = os.path.relpath(file_path, temp_dir)
                    kmz.write(file_path, arcname)
        
        print(f" 🎉 Erfolg: KMZ-Datei inklusive Bildern wurde unter '{output_kmz}' erstellt!")

    except Exception as e:
        print(f"Ein Fehler ist aufgetreten: {e}")
    finally:
        if os.path.exists(temp_dir):
            shutil.rmtree(temp_dir)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Integriert geotaggte Bilder textbasiert in eine KML und packt sie als KMZ.")
    parser.add_argument("kml_file", help="Pfad zur Quell-KML-Datei")
    parser.add_argument("image_folder", help="Pfad zum Ordner mit den geotaggten Bildern")
    parser.add_argument("output_kmz", help="Name der zu erstellenden KMZ-Zieldatei")
    args = parser.parse_args()

    create_kmz(args.kml_file, args.image_folder, args.output_kmz)
