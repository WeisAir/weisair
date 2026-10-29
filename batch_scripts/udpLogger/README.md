# X-Plane UDP Logger

`xplane_udp_csv.py` listens for X-Plane `DATA` packets on `127.0.0.1:49005` and writes each decoded packet as a row in `xplane_log.csv`. Rows include a UTC timestamp and the packet values. Column names are translated to readable names using `xplane_udp_mapping.csv`.

## Flight log rotation

- At startup, an existing `xplane_log.csv` is moved to `xplane_log_lastrun.csv`. If that backup already exists, it is preserved with a timestamped filename.
- While logging, five seconds without any UDP packets is treated as a flight boundary. A non-empty current log is moved to `xplane_log_lastrun.csv`; the next valid packet starts a new `xplane_log.csv`.
- Empty or not-yet-created logs are not rotated.

The five-second quiet period is a heuristic: any interruption in UDP transmission of that duration can split a log, even if a new flight was not configured.
