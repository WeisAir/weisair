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
	"buttonFontSize": "16px"
}
```