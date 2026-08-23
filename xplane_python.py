import socket
import struct

def send_xplane_command(remote_ip, command_string, port=49000):
    """
    Sendet einen nativen X-Plane Befehl via UDP an einen Remote-PC.
    
    :param remote_ip: Die IP-Adresse des PCs, auf dem X-Plane 12 läuft.
    :param command_string: Der X-Plane Command-String (z.B. 'sim/operation/pause_toggle').
    :param port: Der UDP-Port von X-Plane (Standard ist 49000).
    """
    # X-Plane erwartet das 4-Byte-Header-Label 'CMND' gefolgt von einem Null-Byte (0x00)
    header = b'CMND\x00'
    
    # Der Befehl muss als Byte-String vorliegen
    cmd_bytes = command_string.encode('utf-8')
    
    # Das Paket zusammensetzen: Header + Befehls-String
    packet = header + cmd_bytes
    
    # UDP Socket initialisieren
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    
    try:
        # Paket an den X-Plane PC senden
        sock.sendto(packet, (remote_ip, port))
        print(f"[Erfolg] Befehl '{command_string}' an {remote_ip}:{port} gesendet.")
    except Exception as e:
        print(f"[Fehler] Konnte Befehl nicht senden: {e}")
    finally:
        sock.close()

if __name__ == "__main__":
    # ÄNDERN SIE DIESE IP-ADRESSE AUF DIE IHRES REMOTE-PCS
    REMOTE_XPLANE_IP = "192.168.1.50" 
    
    # Beispiel 1: Simulator pausieren / fortsetzen
    send_xplane_command(REMOTE_XPLANE_IP, "sim/operation/pause_toggle")
    
    # Beispiel 2: Fahrwerk ausfahren (uncomment zum Testen)
    # send_xplane_command(REMOTE_XPLANE_IP, "sim/flight_controls/landing_gear_down")
