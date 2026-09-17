const { app, BrowserWindow, ipcMain, screen, session } = require('electron');
const { spawn } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');

function loadAppConfig() {
	const configPath = path.join(__dirname, 'app-config.json');
	return JSON.parse(fs.readFileSync(configPath, 'utf8'));
}

const appConfig = loadAppConfig();

let mainWindow;
let airManagerProcess;
let aircraftDatarefId;
let aircraftPollTimer;
let xPlaneTunnelProcess;

function sendAirManagerStatus() {
	if (mainWindow && !mainWindow.isDestroyed()) {
		mainWindow.webContents.send('airmanager-status', Boolean(airManagerProcess));
	}
}

function sendAircraftStatus(name) {
	if (mainWindow && !mainWindow.isDestroyed()) mainWindow.webContents.send('aircraft-status', name);
}

function startXPlaneTunnel() {
	const tunnel = appConfig.xPlaneSshTunnel;
	if (!tunnel || tunnel.enabled !== true) return;
	if (typeof tunnel.host !== 'string' || typeof tunnel.user !== 'string') {
		console.error('X-Plane SSH tunnel requires host and user.');
		return;
	}

	const localPort = Number(tunnel.localPort) || 8086;
	const remotePort = Number(tunnel.remotePort) || 8086;
	const sshArguments = [
		'-N', '-T',
		'-o', 'BatchMode=yes',
		'-o', 'ExitOnForwardFailure=yes',
		'-o', 'ServerAliveInterval=30',
		'-o', 'ServerAliveCountMax=3'
	];
	if (typeof tunnel.identityFile === 'string' && tunnel.identityFile.length > 0) {
		sshArguments.push('-i', tunnel.identityFile);
	}
	sshArguments.push('-L', `${localPort}:127.0.0.1:${remotePort}`, `${tunnel.user}@${tunnel.host}`);

	xPlaneTunnelProcess = spawn(tunnel.sshPath || 'ssh', sshArguments, { stdio: 'ignore' });
	xPlaneTunnelProcess.once('error', error => {
		console.error('Could not start X-Plane SSH tunnel:', error.message);
		xPlaneTunnelProcess = null;
	});
	xPlaneTunnelProcess.once('exit', (code, signal) => {
		if (xPlaneTunnelProcess) {
			console.error(`X-Plane SSH tunnel exited (code ${code}, signal ${signal || 'none'}).`);
			xPlaneTunnelProcess = null;
		}
	});
}

function stopXPlaneTunnel() {
	if (xPlaneTunnelProcess) {
		xPlaneTunnelProcess.kill('SIGTERM');
		xPlaneTunnelProcess = null;
	}
}

function globMatches(pattern, value) {
	const expression = '^' + pattern.replace(/[.+^${}()|[\]\\]/g, '\\$&').replace(/\*/g, '.*').replace(/\?/g, '.') + '$';
	return new RegExp(expression, 'i').test(value);
}

function mapAircraftPath(aircraftPath) {
	const mappings = Array.isArray(appConfig.aircraftMappings) ? appConfig.aircraftMappings : [];
	const mapping = mappings.find(entry => entry && typeof entry.pattern === 'string' && typeof entry.label === 'string' && globMatches(entry.pattern, aircraftPath));
	return mapping ? mapping.label : aircraftPath.split('/').pop() || 'Unknown aircraft';
}

function decodeDatarefValue(value) {
	if (typeof value !== 'string') return '';
	try {
		return Buffer.from(value, 'base64').toString('utf8').replace(/\0+$/, '');
	} catch {
		return value;
	}
}

async function xPlaneRequest(url) {
	const response = await fetch(url, { headers: { Accept: 'application/json' } });
	if (!response.ok) throw new Error(`HTTP ${response.status}`);
	return response.json();
}

async function updateAircraftStatus() {
	try {
		const baseUrl = String(appConfig.xPlaneApiBaseUrl || 'http://127.0.0.1:8086/api/v3').replace(/\/$/, '');
		if (!aircraftDatarefId) {
			const result = await xPlaneRequest(`${baseUrl}/datarefs?filter[name]=${encodeURIComponent(appConfig.xPlaneAircraftDataref || 'sim/aircraft/view/acf_relative_path')}`);
			const datarefs = Array.isArray(result.data) ? result.data : [];
			const dataref = datarefs[0];
			if (!dataref) throw new Error('Aircraft dataref not found');
			aircraftDatarefId = dataref.id;
		}
		const result = await xPlaneRequest(`${baseUrl}/datarefs/${aircraftDatarefId}/value`);
		const aircraftPath = decodeDatarefValue(result.data);
		sendAircraftStatus(aircraftPath ? mapAircraftPath(aircraftPath) : 'Loading aircraft...');
	} catch (error) {
		aircraftDatarefId = undefined;
		sendAircraftStatus('X-Plane offline');
		console.error('Could not read X-Plane aircraft:', error.message);
	}
}

function startAircraftPolling() {
	updateAircraftStatus();
	aircraftPollTimer = setInterval(updateAircraftStatus, Number(appConfig.xPlanePollIntervalMs) || 1000);
}

function airManagerGroupIsRunning() {
	if (!airManagerProcess || !airManagerProcess.pid) return false;
	try {
		process.kill(-airManagerProcess.pid, 0);
		return true;
	} catch {
		return false;
	}
}

function toggleAirManager() {
	if (airManagerProcess) {
		if (airManagerGroupIsRunning()) {
			try {
				process.kill(-airManagerProcess.pid, 'SIGTERM');
			} catch (error) {
				console.error('Could not stop AirManager:', error);
			}
			airManagerProcess = null;
			sendAirManagerStatus();
			return;
		}
		airManagerProcess = null;
	}

	const executable = appConfig.airManagerExecutable;
	if (typeof executable !== 'string' || executable.length === 0) {
		console.error('AirManager executable is not configured.');
		sendAirManagerStatus();
		return;
	}

	const airManagerEnvironment = {};
	for (const key of [
		'HOME', 'USER', 'LOGNAME', 'PATH', 'DISPLAY', 'WAYLAND_DISPLAY',
		'XAUTHORITY', 'XDG_RUNTIME_DIR', 'DBUS_SESSION_BUS_ADDRESS', 'LANG',
		'LANGUAGE', 'LC_ALL', 'LC_CTYPE'
	]) {
		if (process.env[key]) airManagerEnvironment[key] = process.env[key];
	}

	const child = spawn(executable, [], {
		cwd: path.dirname(executable),
		stdio: 'ignore',
		env: airManagerEnvironment,
		detached: true
	});
	airManagerProcess = child;
	sendAirManagerStatus();
	child.once('error', error => {
		console.error('Could not start AirManager:', error);
		if (airManagerProcess === child) airManagerProcess = null;
		sendAirManagerStatus();
	});
	child.once('exit', () => {
		if (airManagerProcess === child && !airManagerGroupIsRunning()) {
			airManagerProcess = null;
			sendAirManagerStatus();
		}
	});
	child.unref();
}

if (appConfig.hardwareAcceleration !== true) app.disableHardwareAcceleration();
if (appConfig.gpuRasterization === true) app.commandLine.appendSwitch('enable-gpu-rasterization');
if (appConfig.unsafeSwiftShader === true) app.commandLine.appendSwitch('enable-unsafe-swiftshader');

function createWindow() {
	const config = appConfig;
	const displays = screen.getAllDisplays();
	const display = displays[config.displayIndex] || screen.getPrimaryDisplay();
	const { x, y, width, height } = display.workArea;
	mainWindow = new BrowserWindow({
		x,
		y,
		width,
		height,
		backgroundColor: '#111827',
		webPreferences: {
			contextIsolation: true,
			nodeIntegration: false,
			preload: path.join(__dirname, 'preload.js'),
			webviewTag: true,
			partition: 'persist:efb-hub'
		}
	});

	mainWindow.webContents.on('before-input-event', (event, input) => {
		if (input.type === 'keyDown' && input.key === 'F11') {
			event.preventDefault();
			mainWindow.setFullScreen(!mainWindow.isFullScreen());
		}
	});

	mainWindow.once('ready-to-show', () => {
		mainWindow.setPosition(x, y);
		if (config.fullscreen === true) mainWindow.setFullScreen(true);
		else if (config.maximized === true) mainWindow.maximize();
	});
	mainWindow.on('closed', () => {
		mainWindow = null;
	});
	mainWindow.loadFile(path.join(__dirname, 'index.html'));
	mainWindow.webContents.once('did-finish-load', startAircraftPolling);
}

app.whenReady().then(() => {
	session.fromPartition('persist:efb-hub');
	ipcMain.on('close-app', () => app.quit());
	ipcMain.on('toggle-airmanager', toggleAirManager);
	startXPlaneTunnel();
	createWindow();
	app.on('activate', () => {
		if (BrowserWindow.getAllWindows().length === 0) createWindow();
	});
});

app.on('window-all-closed', () => {
	if (aircraftPollTimer) clearInterval(aircraftPollTimer);
	stopXPlaneTunnel();
	if (process.platform !== 'darwin') app.quit();
});

app.on('before-quit', () => {
	if (aircraftPollTimer) clearInterval(aircraftPollTimer);
	stopXPlaneTunnel();
});
