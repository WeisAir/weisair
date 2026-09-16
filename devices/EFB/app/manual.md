cd /home/stephan/dev/xplane/weisair/devices/EFB/app
npm install
npm start

## Configuration

Edit `app-config.json` before starting the app:

- `hardwareAcceleration`: keep `true` for best Navigraph Charts performance.
- `gpuRasterization`: keep `true` to enable GPU rasterization.
- `unsafeSwiftShader`: use `true` only if the graphics driver cannot start. This enables software WebGL and may be slower.

The current recommended settings are:

```json
{
	"fullscreen": true,
	"maximized": true,
	"displayIndex": 0,
	"hardwareAcceleration": true,
	"gpuRasterization": true,
	"unsafeSwiftShader": false
}
```