const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('efb', {
	closeApp: () => ipcRenderer.send('close-app')
});