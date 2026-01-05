#!/bin/sh


########################## VARIABLES

#X-Plane App paths
var_XP12_path_latest="/cygdrive/g/X-Plane_12_latest"
var_XP12_path_stable="/cygdrive/g/X-Plane_12_latest_stable"

#current date and time
var_date=$(date '+%Y_%m_%d')
var_time=$(date '+%H_%M_%S')
var_start_time=$(date +%s%N | cut -b1-13)

#test parameters
var_XP12_fps_recording="b738_london_land.fps"
var_viewpoint=100 # 0 = default cockpit day / 100 = above view / 200 = cockpit night
var_scenario=34 # performance test pattern according to https://www.x-plane.com/kb/frame-rate-test/
var_fps_test_scenario=$(($var_viewpoint+$var_scenario)) # addtion of viewpoint and scenario
var_additional_params="--weather_seed=1 --time_seed=1 --no_prefs --event_trace --safe_mode=SCN,PLG,ART" # additional unclear / undocumented params 

var_fps_run_command="${var_XP12_path_stable}/X-Plane.exe --fps_test="${var_fps_test_scenario}" --load_smo=Output/replays/"${var_XP12_fps_recording}

########################## VARIABLES


#create directories to backup diagnostics data from X-Plane
mkdir -p ./${var_date}
mkdir -p ./${var_date}/${var_time}

#run built-in fps test

echo $var_fps_run_command
#$(${var_fps_run_command})
#$(${var_XP12_path_stable}/X-Plane.exe --lock_fr=30)

#copy original X-Plane generated log, data and telemetry files
$(cp ${var_XP12_path_stable}/Log.txt ./${var_date}/${var_time})
$(cp ${var_XP12_path_stable}/Data.txt ./${var_date}/${var_time})
$(cp "${var_XP12_path_stable}/Output/diagnostic reports/telemetry_0.tlm" ./${var_date}/${var_time})

#TESTPHASE ONLY: Overwrite copied log.txt with test_fps_log.txt which contains an FPS value
#$(cp ./test_fps_log.txt ./${var_date}/${var_time}/Log.txt)

#extract fps average from log.txt
var_fps_value=$(grep "fps=" ./${var_date}/${var_time}/Log.txt | cut -f3 -d ',' | tr -d '[:blank:]' | cut -f2 -d'=' | tr -d '\n' | tr -d '\r')
#extract XP Version from log.txt
var_xp_version=$(grep "Log.txt for X-Plane" ./${var_date}/${var_time}/Log.txt | cut -f4 -d " ")
#extract aircraft information from recording
var_aircraft=$(cat ./${var_XP12_fps_recording} | grep Aircraft | cut -f3 -d " " | cut -f2,3 -d "/")

#calculate test duration
var_stop_time=$(date +%s%N | cut -b1-13)
var_test_duration_s=$((($var_stop_time-$var_start_time) / 1000))

#concatenate csv record
var_record="${var_date},${var_time},${var_fps_value},${var_aircraft},${var_fps_test_scenario},${var_xp_version},${var_test_duration_s}"

echo $var_record >> statistics.csv