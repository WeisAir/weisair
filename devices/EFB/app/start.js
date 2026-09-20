const { spawn } = require('node:child_process');
const electronPath = require('electron');

const child = spawn(electronPath, ['.'], {
	stdio: 'inherit',
	windowsHide: false
});

child.on('error', error => {
	console.error('Could not start Electron:', error);
	process.exit(1);
});

child.on('exit', (code, signal) => {
	if (signal) process.kill(process.pid, signal);
	else process.exit(code ?? 1);
});
