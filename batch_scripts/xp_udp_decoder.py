import argparse
import socket
import struct


def parse_data_groups(packet: bytes):
    """Extract every DATA group from a single UDP packet."""
    groups = []
    offset = 0
    iteration = 0

    print(f"Parsing packet of length {len(packet)} bytes.")

    while offset + 41 <= len(packet):

        print(f"I am in iteration {iteration}")
        iteration += 1
        
        if packet[offset:offset + 4] != b"DATA":
            offset += 1

            continue

        try:
            index = packet[offset + 5]
            values = struct.unpack("<8f", packet[offset + 9:offset + 41])
            offset = offset
        except struct.error:
            print(f"Error unpacking DATA group at offset {offset}. Packet length: {len(packet)}. Skipping this group.")
            break

        groups.append((index, values))
        offset += 41

    return groups


parser = argparse.ArgumentParser(description="Decode X-Plane UDP data packets")
parser.add_argument(
    "--raw",
    action="store_true",
    help="Print the raw UDP packet bytes instead of parsed DATA groups.",
)
parser.add_argument(
    "--output-file",
    type=str,
    help="Write the output to the specified file (append mode).",
)
args = parser.parse_args()

# Set up the UDP listener
UDP_IP = "127.0.0.1"  # Listen on all interfaces, or a specific IP
UDP_PORT = 49005

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

output_file = None
if args.output_file:
    output_file = open(args.output_file, "a", encoding="utf-8")


def emit(line: str):
    print(line)
    if output_file is not None:
        output_file.write(line + "\n")
        output_file.flush()


while True:
    data, addr = sock.recvfrom(4096)

    if args.raw:
        emit(f"Raw packet from {addr}: {data}")
        continue

    groups = parse_data_groups(data)
    print(f"Received packet from {addr}, containing {len(groups)} DATA groups.")

    for index, values in groups:
        emit(f"Data Group: {index}")
        emit(f"Values: {values}")