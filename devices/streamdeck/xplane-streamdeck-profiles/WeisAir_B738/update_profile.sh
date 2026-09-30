#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd | rev | cut -d / -f 1 | rev)

sed -i -E "s/^([[:space:]]*active-preset:[[:space:]]*).*/\1${SCRIPT_DIR}/" /home/stephan/dev/xplane/xplane-streamdeck-master/config.yaml

../generate_streamdeck_html.py ./sd32 --icons-dir ./icons/ --icons-dir ~/dev/xplane/xplane-streamdeck-master/icons/ --icons-dir /home/stephan/dev/xplane/weisair/junctions/streamdeck_icons/weisair_ops --output "$SCRIPT_DIR"_config.html
rm /home/stephan/dev/xplane/xplane-streamdeck-master/"$SCRIPT_DIR"/sd32.pkl
cd /home/stephan/dev/xplane/xplane-streamdeck-master
source /home/stephan/dev/xplane/xplane-streamdeck-master/venv/bin/activate
python /home/stephan/dev/xplane/xplane-streamdeck-master/start.py