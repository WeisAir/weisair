const CONFIG_URL = './websites.json';
const websiteArea = document.getElementById('website-area');
const buttonBar = document.getElementById('button-bar');
const status = document.getElementById('status');
const views = [];

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
		const response = await fetch(CONFIG_URL, { cache: 'no-store' });
		if (!response.ok) throw new Error(`HTTP ${response.status}`);
		const websites = await response.json();
		if (!Array.isArray(websites)) throw new Error('Configuration must be an array');

		status.remove();
		websites.slice(0, 3).forEach((site, index) => {
			if (!site || typeof site.label !== 'string' || typeof site.url !== 'string') return;
			const button = document.createElement('button');
			button.type = 'button';
			button.textContent = site.label;
			button.title = site.url;
			button.addEventListener('click', () => showWebsite(site, index, button));
			buttonBar.appendChild(button);
		});

		const firstButton = buttonBar.querySelector('button');
		if (firstButton) firstButton.click();
		else throw new Error('No valid websites configured');
	} catch (error) {
		status.textContent = `Could not load ${CONFIG_URL}`;
		console.error(error);
	}
}

loadWebsites();
