const CONFIG_URL = './websites.json';
const websiteArea = document.getElementById('website-area');
const buttonBar = document.getElementById('button-bar');
const websiteButtons = document.getElementById('website-buttons');
const brandLogo = document.getElementById('brand-logo');
const logoSpacer = document.getElementById('logo-spacer');
const status = document.getElementById('status');
const closeButton = document.getElementById('close-button');
const views = [];

function matchLogoSpacer() {
	logoSpacer.style.height = `${brandLogo.getBoundingClientRect().height}px`;
}

brandLogo.addEventListener('load', matchLogoSpacer);
window.addEventListener('resize', matchLogoSpacer);

closeButton.addEventListener('click', () => window.efb.closeApp());

async function loadAppConfig() {
	const response = await fetch('./app-config.json', { cache: 'no-store' });
	if (!response.ok) throw new Error(`HTTP ${response.status}`);
	return response.json();
}

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
	view.classList.remove('hidden');
	buttonBar.querySelectorAll('button').forEach(candidate => candidate.classList.remove('active'));
	button.classList.add('active');
	status.textContent = site.label;
}

async function loadWebsites() {
	try {
		applyColors(await loadAppConfig());
		const response = await fetch(CONFIG_URL, { cache: 'no-store' });
		if (!response.ok) throw new Error(`HTTP ${response.status}`);
		const websites = await response.json();
		if (!Array.isArray(websites)) throw new Error('Configuration must be an array');

		status.remove();
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

		const firstButton = buttonBar.querySelector('.website-button');
		if (firstButton) firstButton.click();
		else throw new Error('No valid websites configured');
	} catch (error) {
		status.textContent = `Could not load ${CONFIG_URL}`;
		console.error(error);
	}
}

loadWebsites();
