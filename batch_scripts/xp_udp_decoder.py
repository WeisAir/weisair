import socket
import struct

# Set up the UDP listener
UDP_IP = "127.0.0.1" # Listen on all interfaces, or a specific IP
UDP_PORT = 49005

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(1024)
    
    # Check if packet starts with 'DATA'
    if data[0:4] == b'DATA':
        # The data group index is the 5th byte
        index = data[5]
        
        # Read the 8 floats (8 * 4 bytes = 32 bytes)
        # Starting from byte 9 up to byte 41
        values = struct.unpack('<8f', data[9:41])
        
        print(f"Data Group: {index}")
        print(f"Values: {values}")