import csv
import socket

# Set up socket to listen for X-Plane UDP packets
UDP_IP = "0.0.0.0"  # Listen on all local interfaces
UDP_PORT = 49000  # Match the port set in X-Plane

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

print(f"Listening for X-Plane UDP on port {UDP_PORT}...")

# Open CSV file for writing
with open("xplane_log.csv", mode="w", newline="") as f:
  writer = csv.writer(f)
  # Write header (adjust based on your tracked data indexes)
  writer.writerow(["Packet_Type", "Index", "Data_Values"])

  while True:
    data, addr = sock.recvfrom(1024)
    # X-Plane packets start with "DATA" (4 bytes) + 1 null byte
    if data.startswith(b"DATA"):
      # Each block after header is 36 bytes: 1 int index (4 bytes) + 8 floats (32 bytes)
      header = data[:5]
      values = data[5:]

      # Simple raw write or parse chunks
      writer.writerow([header.decode("ascii", errors="ignore"), data[5], data])
      f.flush()
