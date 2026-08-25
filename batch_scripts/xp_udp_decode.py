import argparse
import socket
import struct

udp_telegram= bytearray()
udp_telegram.extend(b'DATA*\x03\x00\x00\x00N\xca\x1eC\x05\xa8\x1eCg\x83&Cg\x83&C\x00\xc0y\xc4\x89\xbb6C\xbe\x9e?C\xbd\x9e?C\x04\x00\x00\x00p[\x82>\x00\xc0y\xc4Y6z><\x8f}>\xb2\xe1\x7f?)\x0b\x07<f\xc5\x1a9\x00\xc0y\xc4\x15\x00\x00\x00\xac]\x0eF\x11xdD\xd9\xbc\xf0\xc6\x14\xbd\xaa\xc2\r\xc8\xb5=\x02V\xe2\xc0\xb5\xdbdH\xd8F\x1aB')

def parse_data_groups(packet: bytes):
    """Extract every DATA group from a single UDP packet."""
    groups = []
    offset = 0
    iteration = 0

    print(f"Parsing packet of length {len(packet)} bytes.")

    while offset + 41 <= len(packet):

        #print(f"I am in iteration {iteration}")
        #iteration += 1
        
        if packet[offset:offset + 4] != b"DATA":
            offset += 1
            continue

        try:
            index = packet[offset + 5]
            values = struct.unpack("<8f", packet[offset + 9:offset + 41])
            print(f"Values: {values}")
            print(f"Index: {index}")
            print(f"offset: {offset}")
            offset = offset
        except struct.error:
            print(f"Error unpacking DATA group at offset {offset}. Packet length: {len(packet)}. Skipping this group.")
            break

        groups.append((index, values))
        offset += 41
    return groups

groups = parse_data_groups(udp_telegram)

for index, values in groups:
    print(f"Data Group: {index}")
    print(f"Values: {values}")