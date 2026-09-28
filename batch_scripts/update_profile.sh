#!/usr/bin/env bash

#This is a helper script that is used to develop streamdeck profiles used by the linux-compatible plugin by wortelus
#Usage: drop the update_profile.sh script into the aircraft specific profile directory and run it. It will update the config.yaml file to point to the correct profile, generate a new html file for the streamdeck plugin, and start the plugin to see the result on the streamdeck immediately. 

#assumptions: 
#   the binary of the streamdeck plugin is located in ~/dev/xplane/xplane-streamdeck-master (as a venv)
#   the config.yaml file is located in the same directory
#   The script will also remove the sd32.pkl file from the profile directory to ensure that the new profile is loaded correctly. 
#   In order to keep only the aircraft specific profiles in my repo, the aircraft directory is symlinked to the xplane-streamdeck-master directory. This is not a requirement, but it is a good practice to keep the repo clean.

#To be tested: You can also run this script from the batch_scripts directory and pass the profile directory as an argument, e.g. ./update_profile.sh ../devices/streamdeck/xplane-streamdeck-profiles/WeisAir_B58


####################################


#get the name of the current directory, which is the name of the profile
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd | rev | cut -d / -f 1 | rev)

#Modify the config.yaml file to point to the correct profile
sed -i -E "s/^([[:space:]]*active-preset:[[:space:]]*).*/\1${SCRIPT_DIR}/" /home/stephan/dev/xplane/xplane-streamdeck-master/config.yaml

#Generate a new html file for the current aircraft profile
../generate_streamdeck_html.py ./sd32 --icons-dir ./icons/ --icons-dir ~/dev/xplane/xplane-streamdeck-master/icons/ --output "$SCRIPT_DIR"_config.html

#Remove the sd32.pkl file from the profile directory to ensure that the new profile is loaded correctly
rm /home/stephan/dev/xplane/xplane-streamdeck-master/"$SCRIPT_DIR"/sd32.pkl

#start the streamdeck plugin to see the result on the streamdeck immediately (started through the venv)
cd /home/stephan/dev/xplane/xplane-streamdeck-master
source /home/stephan/dev/xplane/xplane-streamdeck-master/venv/bin/activate
python /home/stephan/dev/xplane/xplane-streamdeck-master/start.py