# Navigraph AIRAC downloader

This script opens the Navigraph downloads page in a dedicated Chromium profile,
then downloads the Linux package for each configured package name. It does not
store or automate Navigraph credentials. Sign in manually in the opened browser
when necessary.

## Setup

From this directory, create a virtual environment and install the dependency and
its Chromium browser:

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
.venv/bin/playwright install chromium
```

## Configure and run

Edit `config.json`:

- `target_download_path`: directory for downloaded files. `~` expands to the
  home directory; a relative path is resolved from this directory.
- `packages`: exact package names as they appear in the second column of the
  downloads table.

Run:

```bash
.venv/bin/python download_airac.py
```

The browser opens `https://navigraph.com/downloads`. Sign in if needed; the
script automatically waits up to three minutes for every configured package
row and its Linux download control to appear. It then clicks each control and
saves the resulting file to the configured directory. If the table does not
become ready in time, check the sign-in status and package names. Download
errors are reported and cause a non-zero exit status.

An alternate JSON config can be selected with `--config /path/to/config.json`.
The browser session is kept in `~/.local/share/navigraph-airac-downloader/` so
you do not need to sign in on every run.
