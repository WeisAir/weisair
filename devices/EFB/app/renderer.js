const CONFIG_URL = './websites.json';
const websiteArea = document.getElementById('website-area');
const buttonBar = document.getElementById('button-bar');
const websiteButtons = document.getElementById('website-buttons');
const checklistButton = document.getElementById('checklist-button');
const checklistView = document.getElementById('checklist-view');
const checklistMessage = document.getElementById('checklist-message');
const brandLogo = document.getElementById('brand-logo');
const logoSpacer = document.getElementById('logo-spacer');
const aircraftName = document.getElementById('aircraft-name');
const closeButton = document.getElementById('close-button');
const airManagerToggle = document.getElementById('airmanager-toggle');
const streamDeckToggle = document.getElementById('streamdeck-toggle');
const views = [];
let appConfig;
let currentAircraftPath = '';

function matchLogoSpacer() {
	logoSpacer.style.height = `${brandLogo.getBoundingClientRect().height}px`;
}

brandLogo.addEventListener('load', matchLogoSpacer);
window.addEventListener('resize', matchLogoSpacer);

closeButton.addEventListener('click', () => window.efb.closeApp());
airManagerToggle.addEventListener('click', () => window.efb.toggleAirManager());
streamDeckToggle.addEventListener('click', () => window.efb.toggleStreamDeck());
window.efb.onAirManagerStatus(running => {
	airManagerToggle.classList.toggle('running', running);
	airManagerToggle.setAttribute('aria-pressed', String(running));
	airManagerToggle.textContent = `AirManager: ${running ? 'ON' : 'OFF'}`;
});
window.efb.onStreamDeckStatus(running => {
	streamDeckToggle.classList.toggle('running', running);
	streamDeckToggle.setAttribute('aria-pressed', String(running));
	streamDeckToggle.textContent = `StreamDeck: ${running ? 'ON' : 'OFF'}`;
});
window.efb.onAircraftStatus(aircraft => {
	currentAircraftPath = aircraft.path || '';
	aircraftName.textContent = aircraft.name;
	updateChecklistButton();
});

async function loadAppConfig() {
	const response = await fetch('./app-config.json', { cache: 'no-store' });
	if (!response.ok) throw new Error(`HTTP ${response.status}`);
	return response.json();
}

function globMatches(pattern, value) {
	const expression = '^' + pattern.replace(/[.+^${}()|[\]\\]/g, '\\$&').replace(/\*/g, '.*').replace(/\?/g, '.') + '$';
	return new RegExp(expression, 'i').test(value);
}

function checklistForAircraft() {
	const mappings = Array.isArray(appConfig?.checklistMappings) ? appConfig.checklistMappings : [];
	return mappings.find(entry => entry && typeof entry.pattern === 'string' && typeof entry.pdf === 'string' && globMatches(entry.pattern, currentAircraftPath));
}

function updateChecklistButton() {
	const checklist = checklistForAircraft();
	checklistButton.title = checklist ? checklist.pdf : 'No checklist configured for the current aircraft';
}

function showChecklist() {
	const checklist = checklistForAircraft();
	views.forEach(view => view.classList.add('hidden'));
	checklistMessage.classList.toggle('hidden', Boolean(checklist));
	checklistView.classList.toggle('hidden', !checklist);
	if (checklist) checklistView.src = `file://${encodeURI(checklist.pdf)}`;
	buttonBar.querySelectorAll('button').forEach(button => button.classList.remove('active'));
	checklistButton.classList.add('active');
}

checklistButton.addEventListener('click', showChecklist);

function applyColors(config) {
	const root = document.documentElement;
	if (typeof config.buttonAreaBackground === 'string') {
		root.style.setProperty('--button-area-background', config.buttonAreaBackground);
	}
	if (typeof config.activeButtonColor === 'string') {
		root.style.setProperty('--active-button-color', config.activeButtonColor);
	}
	if (typeof config.inactiveButtonColor === 'string') {
		root.style.setProperty('--inactive-button-color', config.inactiveButtonColor);
	}
	if (typeof config.buttonHeight === 'string') {
		root.style.setProperty('--button-height', config.buttonHeight);
	}
	if (typeof config.buttonFontSize === 'string') {
		root.style.setProperty('--button-font-size', config.buttonFontSize);
	}
	if (typeof config.airManagerExitSpacing === 'string') {
		root.style.setProperty('--airmanager-exit-spacing', config.airManagerExitSpacing);
	}
}

function showWebsite(site, index, button) {
	let view = views[index];

	if (!view) {
		view = document.createElement('webview');
		view.className = 'hidden';
		view.setAttribute('partition', 'persist:efb-hub');
		view.setAttribute('allowpopups', 'true');
		view.src = site.url;
		websiteArea.appendChild(view);
		views[index] = view;
	}

	views.forEach(candidate => candidate.classList.add('hidden'));
	checklistView.classList.add('hidden');
	checklistMessage.classList.add('hidden');
	view.classList.remove('hidden');
	buttonBar.querySelectorAll('button').forEach(candidate => candidate.classList.remove('active'));
	button.classList.add('active');
}

async function loadWebsites() {
	try {
		appConfig = await loadAppConfig();
		applyColors(appConfig);
		updateChecklistButton();
		const response = await fetch(CONFIG_URL, { cache: 'no-store' });
		if (!response.ok) throw new Error(`HTTP ${response.status}`);
		const websites = await response.json();
		if (!Array.isArray(websites)) throw new Error('Configuration must be an array');

		websites.slice(0, 3).forEach((site, index) => {
			if (!site || typeof site.label !== 'string' || typeof site.url !== 'string') return;
			const button = document.createElement('button');
			button.type = 'button';
			button.className = 'website-button';
			button.textContent = site.label;
			button.title = site.url;
			button.addEventListener('click', () => showWebsite(site, index, button));
			websiteButtons.appendChild(button);
		});

		const firstButton = websiteButtons.querySelector('.website-button');
		if (firstButton) firstButton.click();
		else throw new Error('No valid websites configured');
	} catch (error) {
		console.error(error);
	}
}

loadWebsites();
