const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('efb', {
	closeApp: () => ipcRenderer.send('close-app'),
	toggleAirManager: () => ipcRenderer.send('toggle-airmanager'),
	onAirManagerStatus: callback => ipcRenderer.on('airmanager-status', (_event, running) => callback(running)),
	toggleStreamDeck: () => ipcRenderer.send('toggle-streamdeck'),
	onStreamDeckStatus: callback => ipcRenderer.on('streamdeck-status', (_event, running) => callback(running)),
	onAircraftStatus: callback => ipcRenderer.on('aircraft-status', (_event, aircraft) => callback(aircraft))
});