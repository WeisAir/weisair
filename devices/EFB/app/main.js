const { app, BrowserWindow, screen, session } = require('electron');
const fs = require('node:fs');
const path = require('node:path');

function loadAppConfig() {
	const configPath = path.join(__dirname, 'app-config.json');
	return JSON.parse(fs.readFileSync(configPath, 'utf8'));
}

const appConfig = loadAppConfig();

if (appConfig.hardwareAcceleration !== true) app.disableHardwareAcceleration();
if (appConfig.gpuRasterization === true) app.commandLine.appendSwitch('enable-gpu-rasterization');
if (appConfig.unsafeSwiftShader === true) app.commandLine.appendSwitch('enable-unsafe-swiftshader');

function createWindow() {
	const config = appConfig;
	const displays = screen.getAllDisplays();
	const display = displays[config.displayIndex] || screen.getPrimaryDisplay();
	const { x, y, width, height } = display.workArea;
	const window = new BrowserWindow({
		x,
		y,
		width,
		height,
		backgroundColor: '#111827',
		webPreferences: {
			contextIsolation: true,
			nodeIntegration: false,
			webviewTag: true,
			partition: 'persist:efb-hub'
		}
	});

	window.webContents.on('before-input-event', (event, input) => {
		if (input.type === 'keyDown' && input.key === 'F11') {
			event.preventDefault();
			window.setFullScreen(!window.isFullScreen());
		}
	});

	window.once('ready-to-show', () => {
		window.setPosition(x, y);
		if (config.fullscreen === true) window.setFullScreen(true);
		else if (config.maximized === true) window.maximize();
	});
	window.loadFile(path.join(__dirname, 'index.html'));
}

app.whenReady().then(() => {
	session.fromPartition('persist:efb-hub');
	createWindow();
	app.on('activate', () => {
		if (BrowserWindow.getAllWindows().length === 0) createWindow();
	});
});

app.on('window-all-closed', () => {
	if (process.platform !== 'darwin') app.quit();
});
