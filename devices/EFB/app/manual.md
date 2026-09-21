cd /home/stephan/dev/xplane/weisair/devices/EFB/app
npm install
npm start

## Configuration

Edit `app-config.json` before starting the app:

- `hardwareAcceleration`: keep `true` for best Navigraph Charts performance.
- `gpuRasterization`: keep `true` to enable GPU rasterization.
- `unsafeSwiftShader`: use `true` only if the graphics driver cannot start. This enables software WebGL and may be slower.
- `buttonAreaBackground`: background color of the 10% button area.
- `activeButtonColor`: color of the selected or hovered button.
- `inactiveButtonColor`: color of the other buttons.
- `buttonHeight`: height of each website button, for example `"60px"`.
- `buttonFontSize`: font size of website button labels, for example `"20px"`.
- `airManagerExecutable`: full path to the AirManager executable.
- `airManagerExitSpacing`: spacing between the AirManager toggle and EXIT, for example `"16px"`.
- `xPlaneApiBaseUrl`: X-Plane Web API base URL, for example `"http://192.168.2.112:8086/api/v3"`.
- `xPlaneAircraftDataref`: dataref used to read the loaded aircraft path. X-Plane returns this `data` value as base64, which the app decodes automatically.
- `xPlanePollIntervalMs`: interval for refreshing the aircraft name.
- `xPlaneSshTunnel`: starts an SSH tunnel automatically when `enabled` is `true`. Configure `host`, `user`, ports, and an SSH `identityFile`. Key authentication is required because the tunnel runs without an interactive password prompt.
- `aircraftMappings`: glob patterns and labels for aircraft paths. For example, `*/b738.acf` maps to `Boeing 737-800NG`.
- `checklistMappings`: glob patterns and absolute PDF paths for aircraft checklists. For example, `*/b738.acf` can map to `/home/stephan/dev/xplane/weisair/docs/checklists/B737/Checklist B737.pdf`.
- `streamDeckPython`: Python executable used to run StreamDeck. Use the virtual-environment interpreter when dependencies such as `pyxpudpserver` are installed there.
- `streamDeckStartScript`: configurable path to `start.py`.
- `streamDeckProfilesPath`: working directory containing aircraft-specific StreamDeck profiles.
- `streamDeckConfigPath`: path to the StreamDeck `config.yaml` whose `active-preset` is updated.
- `streamDeckMappings`: glob patterns mapping aircraft `.acf` paths to preset directory names.

The current recommended settings are:

```json
{
	"fullscreen": true,
	"maximized": true,
	"displayIndex": 0,
	"hardwareAcceleration": true,
	"gpuRasterization": true,
	"unsafeSwiftShader": false,
	"buttonAreaBackground": "#1f2937",
	"activeButtonColor": "#2563eb",
	"inactiveButtonColor": "#374151",
	"buttonHeight": "48px",
	"buttonFontSize": "16px",
	"airManagerExecutable": "/home/stephan/Air Manager 5.2.7 Home use/Bootloader",
	"airManagerExitSpacing": "16px",
	"xPlaneApiBaseUrl": "http://192.168.2.112:8086/api/v3",
	"xPlaneAircraftDataref": "sim/aircraft/view/acf_relative_path",
	"xPlanePollIntervalMs": 1000,
	"xPlaneSshTunnel": {
		"enabled": true,
		"host": "192.168.2.112",
		"user": "Pilot",
		"localPort": 8086,
		"remotePort": 8086,
		"identityFile": ""
	},
	"aircraftMappings": [
		{ "pattern": "*/b738.acf", "label": "Boeing 737-800NG" }
		{ "pattern": "*/Baron_58.acf", "label": "Beechcraft Baron 58" }
	]
}
```

## optional SSH Tunnel to enable communication with remote xplane webapi

```open tunnel with: ssh -N -T -o ExitOnForwardFailure=yes   -L 8086:127.0.0.1:8086   Pilot@192.168.2.112```