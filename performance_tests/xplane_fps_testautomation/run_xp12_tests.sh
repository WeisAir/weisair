#!/bin/sh

########################## PRECONFIG

#set DISPLAY VARIABLE
$(export DISPLAY=:0.0)
gnuplot plotstats
#gnuplot -c plotstats 5 #https://stackoverflow.com/questions/12328603/how-to-pass-command-line-argument-to-gnuplot

########################## VARIABLES

var_script_log_dir="XPFiles"

#X-Plane App paths
var_XP12_path_latest="/cygdrive/g/X-Plane_12_latest"
var_XP12_path_stable="/cygdrive/g/X-Plane_12_latest_stable"
var_XP_current_test_path=$var_XP12_path_latest

#current date and time
var_date=$(date '+%Y_%m_%d')
var_time=$(date '+%H_%M_%S')
var_start_time=$(date +%s%N | cut -b1-13)

#test parameters
var_XP12_fps_recording="b738_london_land.fps"
var_viewpoint=2 # 0 = default cockpit day / 100 = above view / 200 = cockpit night
var_scenario_weather=3 # performance test pattern according to https://www.x-plane.com/kb/frame-rate-test/
var_scenario_rendering_preset=5 # performance test pattern according to https://www.x-plane.com/kb/frame-rate-test/
var_safe_mode="" #SCN -> default scenery, PLG -> default plugins, ART -> default ART controls
#var_fps_test_scenario=$(($var_viewpoint+$var_scenario)) # addtion of viewpoint and scenario
var_fps_test_scenario=$(($var_viewpoint*100+$var_scenario_weather*10+$var_scenario_rendering_preset)) # addtion of viewpoint and scenario
var_additional_params="--weather_seed=1 --time_seed=1 --no_prefs --event_trace --safe_mode=SCN,PLG,ART" # additional unclear / undocumented params 

if [ -z "$var_safe_mode" ]; 
	then
		var_fps_run_command="${var_XP_current_test_path}/X-Plane.exe --fps_test="${var_fps_test_scenario}" --load_smo=Output/replays/"${var_XP12_fps_recording}
	else
		var_fps_run_command="${var_XP_current_test_path}/X-Plane.exe --fps_test="${var_fps_test_scenario}" --safe_mode="${var_safe_mode}" --load_smo=Output/replays/"${var_XP12_fps_recording}
fi

########################## VARIABLES


#create directories to backup diagnostics data from X-Plane
mkdir -p ./${var_script_log_dir}/${var_date}
mkdir -p ./${var_script_log_dir}/${var_date}/${var_time}

#run built-in fps test

echo $var_fps_run_command
#$(${var_fps_run_command})
#$(${var_XP_current_test_path}/X-Plane.exe --lock_fr=30)

#copy original X-Plane generated log, data and telemetry files
#$(cp ${var_XP_current_test_path}/Log.txt ./${var_script_log_dir}/${var_date}/${var_time})
#$(cp ${var_XP_current_test_path}/Data.txt ./${var_script_log_dir}/${var_date}/${var_time})
#$(cp "${var_XP_current_test_path}/Output/diagnostic reports/telemetry_0.tlm" ./${var_script_log_dir}/${var_date}/${var_time})

#TESTPHASE ONLY: Overwrite copied log.txt with test_fps_log.txt which contains an FPS value
$(cp ./test_fps_log.txt ./${var_script_log_dir}/${var_date}/${var_time}/Log.txt)

#extract fps average from log.txt
var_fps_value=$(grep "fps=" ./${var_script_log_dir}/${var_date}/${var_time}/Log.txt | cut -f3 -d ',' | tr -d '[:blank:]' | cut -f2 -d'=' | tr -d '\n' | tr -d '\r')
#extract XP Version from log.txt
var_xp_version=$(grep "Log.txt for X-Plane" ./${var_script_log_dir}/${var_date}/${var_time}/Log.txt | cut -f4 -d " ")
#extract aircraft information from recording
var_aircraft=$(cat ./${var_XP12_fps_recording} | grep Aircraft | cut -f3 -d " " | cut -f2,3 -d "/")

#calculate test duration
var_stop_time=$(date +%s%N | cut -b1-13)
var_test_duration_s=$((($var_stop_time-$var_start_time) / 1000))

#concatenate csv record

if [ -z "$var_safe_mode" ]; 
	then
		var_record="${var_date},${var_time},${var_fps_value},${var_aircraft},${var_fps_test_scenario},${var_xp_version},${var_XP12_fps_recording},${var_test_duration_s},NOSAFEMODE"
	else
		var_record="${var_date},${var_time},${var_fps_value},${var_aircraft},${var_fps_test_scenario},${var_xp_version},${var_XP12_fps_recording},${var_test_duration_s},${var_safe_mode}"
fi

echo $var_record >> statistics.csv



###gnuplot

# pro test.fps ein Diagramm erstellen
# 	latest/stable
# 		ortho/vanilla
# 			fps

# ./stats/[TESTNAME]_statistics.csv
# vanilla;34;fps_latest;fps_stable
# ortho;34;fps_latest;fps_stable
# vanilla;45;fps_latest;fps_stable
# ortho;45;fps_latest;fps_stable

# ./stats/[TESTNAME]_plot.png
