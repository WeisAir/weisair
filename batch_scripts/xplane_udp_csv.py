import csv
import socket
import struct
from datetime import datetime, timezone
from pathlib import Path

#UDP_IP = "0.0.0.0" #UDP_IP = "192.168.2.202
UDP_IP = "127.0.0.1"
UDP_PORT = 49005
CSV_PATH = Path(__file__).with_name("xplane_log.csv")
MAPPING_PATH = Path(__file__).with_name("xplane_udp_mapping.csv")


def decode_data_packet(data):
    print(
        f"raw packet: length={len(data)}, "
        f"prefix={data[:5]!r}, hex={data[:16].hex()}"
    )

    # X-Plane DATA packets may use DATA*, DATA\x00, etc.
    if data[:4] != b"DATA":
        print("Ignoring packet: missing DATA header")
        return []

    payload = data[5:]
    records = []

    if len(payload) % 36 != 0:
        print(f"Warning: payload length {len(payload)} is not a multiple of 36")

    for offset in range(0, len(payload) - 35, 36):
        group_id = struct.unpack_from("<i", payload, offset)[0]
        values = struct.unpack_from("<8f", payload, offset + 4)
        records.append((group_id, values))

    return records


def load_header_mapping():
    with MAPPING_PATH.open(newline="", encoding="utf-8-sig") as file:
        reader = csv.DictReader(file)
        if reader.fieldnames != ["generic_header", "human_readable_name"]:
            raise ValueError(
                f"{MAPPING_PATH} must have columns "
                "'generic_header,human_readable_name'"
            )

        mapping = {}
        for line_number, row in enumerate(reader, start=2):
            generic_header = (row["generic_header"] or "").strip()
            human_readable_name = (row["human_readable_name"] or "").strip()
            if not generic_header or not human_readable_name:
                raise ValueError(
                    f"{MAPPING_PATH}:{line_number} has an empty header name"
                )
            if generic_header in mapping:
                raise ValueError(
                    f"{MAPPING_PATH}:{line_number} maps "
                    f"{generic_header!r} more than once"
                )
            if human_readable_name == "udp_timestamp" or (
                human_readable_name in mapping.values()
            ):
                raise ValueError(
                    f"{MAPPING_PATH}:{line_number} has a duplicate or "
                    "reserved human-readable name"
                )
            mapping[generic_header] = human_readable_name

        return mapping


def write_csv(rows, fieldnames, header_mapping):
    output_fieldnames = [
        header_mapping.get(fieldname, fieldname) for fieldname in fieldnames
    ]
    if len(output_fieldnames) != len(set(output_fieldnames)):
        raise ValueError("The header mapping produces duplicate CSV columns")

    with CSV_PATH.open("w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=output_fieldnames)
        writer.writeheader()
        writer.writerows(
            {
                header_mapping.get(fieldname, fieldname): value
                for fieldname, value in row.items()
            }
            for row in rows
        )


header_mapping = load_header_mapping()

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
sock.bind((UDP_IP, UDP_PORT))

print(f"Listening on {UDP_IP}:{UDP_PORT}")
print(f"Writing CSV to: {CSV_PATH}")

fieldnames = ["udp_timestamp"]
rows = []

while True:
    data, address = sock.recvfrom(4096)
    records = decode_data_packet(data)

    print(
        f"Received {len(data)} bytes from {address}; "
        f"groups={[group_id for group_id, _ in records]}"
    )

    if not records:
        continue

    row = {
        "udp_timestamp": datetime.now(timezone.utc).isoformat()
    }

    for group_id, values in records:
        for field_number, value in enumerate(values, start=1):
            column = f"group_{group_id}_field_{field_number}"
            row[column] = value

            if column not in fieldnames:
                fieldnames.append(column)

    rows.append(row)
    write_csv(rows, fieldnames, header_mapping)