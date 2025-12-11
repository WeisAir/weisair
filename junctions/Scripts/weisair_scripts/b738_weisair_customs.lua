--|-----------------------------------|--
--|--//WeisAIR EFIS Panel Commands//--|--
--|-----------------------------------|--

--MINS Encoder A
	--> laminar/B738/pfd/dh_pilot_up
--MINS Encoder B
	--> laminar/B738/pfd/dh_pilot_dn
--BARO Encoder A
	-->laminar/B738/pilot/barometer_down
--BARO Encoder B
	-->laminar/B738/pilot/barometer_up
--MINS Encoder Button (RST)
	-->laminar/B738/EFIS_control/capt/push_button/rst_press
--BARO Encoder Button (STD)
	--> laminar/B738/EFIS_control/capt/push_button/std_press
--Switch 1 RADIO
	--> laminar/B738/EFIS_control/cpt/minimums_dn
--Switch 1 BARO
	--> laminar/B738/EFIS_control/cpt/minimums_up
--Switch 2 IN
	--> laminar/B738/EFIS_control/capt/baro_in_hpa_dn
--Switch 2 HPA
	--> laminar/B738/EFIS_control/capt/baro_in_hpa_up
--Switch 3 VOR 1
function b738_vor_left_set_VOR()
		
	set("laminar/B738/EFIS_control/capt/vor1_off_pos", 1.0)
	set("laminar/B738/EFIS_control/capt/vor1_off_pfd", 1.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_left_set_VOR", "vor_left_set_VOR", "b738_vor_left_set_VOR()", "", "")
	
--Switch 3 ADF 1
function b738_vor_left_set_ADF()
		
	set("laminar/B738/EFIS_control/capt/vor1_off_pos", -1.0)
	set("laminar/B738/EFIS_control/capt/vor1_off_pfd", -1.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_left_set_ADF", "vor_left_set_ADF", "b738_vor_left_set_ADF()", "", "")
	
--Switch 4 VOR 2
function b738_vor_right_set_VOR()
		
	set("laminar/B738/EFIS_control/capt/vor2_off_pos", 1.0)
	set("laminar/B738/EFIS_control/capt/vor2_off_pfd", 1.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_right_set_VOR", "vor_right_set_VOR", "b738_vor_right_set_VOR()", "", "")

--Switch 4 ADF 2
function b738_vor_right_set_ADF()
		
	set("laminar/B738/EFIS_control/capt/vor2_off_pos", -1.0)
	set("laminar/B738/EFIS_control/capt/vor2_off_pfd", -1.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_right_set_ADF", "vor_right_set_ADF", "b738_vor_right_set_ADF()", "", "")

--MAP MODE PREV
function b738_mode_dec()
	
	dataref("map_mode", "laminar/B738/EFIS_control/capt/map_mode_pos", "writable")
	
	mode_current = map_mode
	mode_new = mode_current - 1.0

	if (mode_new <=3.0 and mode_new >=0.0) 
		then set("laminar/B738/EFIS_control/capt/map_mode_pos", mode_new)
	end
end
create_command("WeisAIR/b738/EFIS/mode_dec", "mode_dec", "b738_mode_dec()", "", "")	
--MAP MODE CTR
	--> laminar/B738/EFIS_control/capt/push_button/ctr_press
--MAP MODE NEXT
function b738_mode_inc()
	
	dataref("map_mode", "laminar/B738/EFIS_control/capt/map_mode_pos", "writable")
	
	mode_current = map_mode
	mode_new = mode_current + 1.0

	if (mode_new <=3.0 and mode_new >=0.0) 
		then set("laminar/B738/EFIS_control/capt/map_mode_pos", mode_new)
	end
end
create_command("WeisAIR/b738/EFIS/mode_inc", "mode_inc", "b738_mode_inc()", "", "")


--MAP RANGE DEC
function b738_range_dec()
	dataref("range", "laminar/B738/EFIS/capt/map_range", "writable")
	
	range_current = range
	range_new = range - 1.0
	
	if (range_new >= 0.0 and range_new <= 7.0) then set("laminar/B738/EFIS/capt/map_range", range_new) end
	
end
create_command("WeisAIR/b738/EFIS/range_dec", "range_dec", "b738_range_dec()", "", "")
	
--MAP RANGE TFC
	--> laminar/B738/EFIS_control/capt/push_button/tfc_press
	
--MAP RANGE INC
function b738_range_inc()
	dataref("range", "laminar/B738/EFIS/capt/map_range", "writable")
	
	range_current = range
	range_new = range + 1.0
	
	if (range_new >= 0.0 and range_new <= 7.0) then set("laminar/B738/EFIS/capt/map_range", range_new) end
	
end
create_command("WeisAIR/b738/EFIS/range_inc", "range_inc", "b738_range_inc()", "", "")

--BTN WXR
	-->laminar/B738/EFIS_control/capt/push_button/wxr_press
--BTN STA
	-->laminar/B738/EFIS_control/capt/push_button/sta_press
--BTN WPT
	-->laminar/B738/EFIS_control/capt/push_button/wpt_press
--BTN APRT
	-->laminar/B738/EFIS_control/capt/push_button/arpt_press
--BTN DATA
	-->laminar/B738/EFIS_control/capt/push_button/data_press
--BTN POS
	-->laminar/B738/EFIS_control/capt/push_button/pos_press
--BTN TERR
	-->laminar/B738/EFIS_control/capt/push_button/terr_press
--BTN FPV
	-->laminar/B738/EFIS_control/capt/push_button/fpv_press
--BTN MTRS
	-->laminar/B738/EFIS_control/capt/push_button/mtrs_press

--|-----------------------------------|--
--|--//WeisAIR GEAR Panel Commands//--|--
--|-----------------------------------|--
--GEAR POS 1
	--> laminar/B738/push_button/gear_up
--GEAR POS 2
	-->laminar/B738/push_button/gear_off
--GEAR POS 3
	--> laminar/B738/push_button/gear_down
--|-----------------------------------|--
--|--//WeisAIR Multipanel Commands//--|--
--|-----------------------------------|--
	
--Multipanel Switch 1 ON (FD)
function b738_switch_fdirs_on()

	dataref("fd_state_cpt", "laminar/B738/autopilot/flight_director_toggle", "writable")
	dataref("fd_state_fo", "laminar/B738/autopilot/flight_director_fo_toggle", "writable")

	if (fd_state_cpt == 0 and fd_state_fo == 0) then 
		command_once("laminar/B738/autopilot/flight_director_toggle")
		command_once("laminar/B738/autopilot/flight_director_fo_toggle")	
	end

end
create_command("WeisAIR/b738/MultiPanel/switch_fdirs_on", "switch_fdirs_on", "b738_switch_fdirs_on()", "", "")
	
--Multipanel Switch 1 OFF (FD)
function b738_switch_fdirs_off()

	dataref("fd_state_cpt", "laminar/B738/autopilot/flight_director_toggle", "writable")
	dataref("fd_state_fo", "laminar/B738/autopilot/flight_director_fo_toggle", "writable")

	if (fd_state_cpt == 1 and fd_state_fo == 1) then
		command_once("laminar/B738/autopilot/flight_director_toggle")
		command_once("laminar/B738/autopilot/flight_director_fo_toggle")	
	end

end
create_command("WeisAIR/b738/MultiPanel/switch_fdirs_off", "switch_fdirs_off", "b738_switch_fdirs_off()", "", "")

function b738_toggle_both_fdirs()

	dataref("fd_state_cpt", "laminar/B738/autopilot/flight_director_toggle", "writable")
	dataref("fd_state_fo", "laminar/B738/autopilot/flight_director_fo_toggle", "writable")

	if (fd_state_cpt == 1 and fd_state_fo == 1) then
		command_once("laminar/B738/autopilot/flight_director_toggle")
		command_once("laminar/B738/autopilot/flight_director_fo_toggle")	
	end
	
	if (fd_state_cpt == 0 and fd_state_fo == 0) then 
		command_once("laminar/B738/autopilot/flight_director_toggle")
		command_once("laminar/B738/autopilot/flight_director_fo_toggle")	
	end


end
create_command("WeisAIR/b738/MultiPanel/toggle_both_fdirs", "toggle_both_fdirs", "b738_toggle_both_fdirs()", "", "")
	
--Multipanel Switch 2 ON (ATHR)
function b738_switch_athr_on()

	dataref("athr_state", "laminar/B738/switches/autopilot/at_arm", "writable")

	if (athr_state == 0) then 
		command_once("laminar/B738/autopilot/autothrottle_arm_toggle")
	end

end
create_command("WeisAIR/b738/MultiPanel/switch_athr_on", "switch_athr_on", "b738_switch_athr_on()", "", "")	

--Multipanel Switch 2 OFF (ATHR)
function b738_switch_athr_off()

	dataref("athr_state", "laminar/B738/switches/autopilot/at_arm", "writable")

	if (athr_state == 1) then 
		command_once("laminar/B738/autopilot/autothrottle_arm_toggle")
	end

end
create_command("WeisAIR/b738/MultiPanel/switch_athr_off", "switch_athr_off", "b738_switch_athr_off()", "", "")	


Used within AirManager Multipanel:
	--laminar/B738/push_button/transponder_ident_dn
	--laminar/B738/autopilot/n1_press						Autopilot N1 press
	--laminar/B738/autopilot/speed_press					Autopilot SPEED press
	--laminar/B738/autopilot/lvl_chg_press					Autopilot LVL CHG press
	--laminar/B738/autopilot/vnav_press						Autopilot VNAV press
	--laminar/B738/autopilot/change_over_press				Autopilot IAS MACH change over press
	--laminar/B738/autopilot/lnav_press						Autopilot LNAV press
	--laminar/B738/autopilot/vorloc_press					Autopilot VOR LOC press
	--laminar/B738/autopilot/app_press						Autopilot APP press
	--laminar/B738/autopilot/hdg_sel_press					Autopilot HDG press
	--laminar/B738/autopilot/alt_hld_press					Autopilot ALT HLD press
	--laminar/B738/autopilot/vs_press						Autopilot VS press
	--laminar/B738/autopilot/disconnect_toggle				Autopilot A/P disconnect toggle
	--laminar/B738/autopilot/autothrottle_arm_toggle		Autopilot A/T arm toggle
	--laminar/B738/autopilot/flight_director_toggle			Autopilot F/D captain toggle
	--laminar/B738/autopilot/flight_director_fo_toggle		Autopilot F/D first officer toggle
	--laminar/B738/autopilot/bank_angle_up					Autopilot bank angle increase
	--laminar/B738/autopilot/bank_angle_dn					Autopilot bank angle decrease
	--laminar/B738/autopilot/cmd_a_press					Autopilot CMD A press
	--laminar/B738/autopilot/cmd_b_press					Autopilot CMD B press
	--laminar/B738/autopilot/cws_a_press					Autopilot CWS A press
	--laminar/B738/autopilot/cws_b_press					Autopilot CWS B press
	--laminar/B738/autopilot/altitude_up					AP altitude Up
	--laminar/B738/autopilot/altitude_dn					AP altitude Down
	--laminar/B738/autopilot/heading_up						AP heading Up
	--laminar/B738/autopilot/heading_dn						AP heading Down
	--laminar/B738/autopilot/course_pilot_up				Autopilot CRS pilot up
	--laminar/B738/autopilot/course_pilot_dn				Autopilot CRS pilot down
	--laminar/B738/autopilot/course_copilot_up				Autopilot CRS copilot up
	--laminar/B738/autopilot/course_copilot_dn				Autopilot CRS copilot down
	--laminar/B738/autopilot/spd_interv						Autopilot SPD INTRV press
	--laminar/B738/autopilot/left_toga_press				Left TO/GA
	--laminar/B738/autopilot/right_toga_press				Right TO/GA
	--laminar/B738/autopilot/left_at_dis_press				Left A/T disengage
	--laminar/B738/autopilot/right_at_dis_press				Right A/T disengage
	--laminar/B738/push_button/ap_light_pilot				A/P light captain button
	--laminar/B738/push_button/at_light_pilot				A/T light captain button


--|-------------------------------------|--
--|--//WeisAIR Lights panel Commands//--|--
--|-------------------------------------|--

--Landing Light ON
	--> laminar/B738/spring_switch/landing_lights_all
	
--Landing Light OFF
function b738_land_lights_off()
	
		command_once("laminar/B738/switch/land_lights_left_off")
		command_once("laminar/B738/switch/land_lights_ret_left_off")
		command_once("laminar/B738/switch/land_lights_right_off")
		command_once("laminar/B738/switch/land_lights_ret_right_off")

	end
	
end
create_command("WeisAIR/b738/LIGHTS/land_lights_off", "land_lights_off", "b738_land_lights_off()", "", "")

--RWTO Light ON
function b738_rwto_lights_on()
	
	command_once("laminar/B738/switch/rwy_light_left_on")
	command_once("laminar/B738/switch/rwy_light_right_on")
	
end
create_command("WeisAIR/b738/LIGHTS/rwto_lights_on", "rwto_lights_on", "b738_rwto_lights_on()", "", "")

--RWTO Light OFF
function b738_rwto_lights_off()
	
	command_once("laminar/B738/switch/rwy_light_left_off")
	command_once("laminar/B738/switch/rwy_light_right_off")
	
end
create_command("WeisAIR/b738/LIGHTS/rwto_lights_off", "rwto_lights_off", "b738_rwto_lights_off()", "", "")

--TAXI Light ON
	--> laminar/B738/toggle_switch/taxi_light_brightness_on

--TAXI Light OFF
	--> laminar/B738/toggle_switch/taxi_light_brightness_off
--LOGO Light ON
	--> laminar/B738/switch/logo_light_on
--LOGO Light OFF
	--> laminar/B738/switch/logo_light_off
--STROBE Light ON (Position Lights - Strobe and Steady)
	--> laminar/B738/toggle_switch/position_light_steady 
--STROBE Light OFF
	--> laminar/B738/toggle_switch/position_light_off
--STROBE Light ON (Position Lights - Steady)
	--> laminar/B738/toggle_switch/position_light_steady
--BEACON Light ON
function b738_beacon_anti_collision_lights_on()
	
	dataref("beacon_anti_collision_light_state", "sim/cockpit/electrical/beacon_lights_on", "writable")
	
	if (beacon_anti_collision_light_state == 0) then 

		command_once("sim/lights/beacon_lights_on")

	end
	
end
create_command("WeisAIR/b738/LIGHTS/beacon_anti_collision_lights_on", "beacon_anti_collision_lights_on", "b738_beacon_anti_collision_lights_on()", "", "")

--BEACON Light OFF
function b738_beacon_anti_collision_lights_off()
	
	dataref("beacon_anti_collision_light_state", "sim/cockpit/electrical/beacon_lights_on", "writable")
	
	if (beacon_anti_collision_light_state == 1) then 

		command_once("sim/lights/beacon_lights_off")

	end
	
end
create_command("WeisAIR/b738/LIGHTS/beacon_anti_collision_lights_off", "beacon_anti_collision_lights_off", "b738_beacon_anti_collision_lights_off()", "", "")

--WING Light ON
	--> laminar/B738/switch/wing_light_on

--WING Light OFF
	--> laminar/B738/switch/wing_light_off

--WHEEL WELL Light ON
function b738_wheel_lights_on()

	dataref("wheel_light_state", "laminar/B738/toggle_switch/wheel_light", "writable")
	
	if (wheel_light_state == 0.0) then 

		set("laminar/B738/toggle_switch/wheel_light",1.0)

	end
	
end
create_command("WeisAIR/b738/LIGHTS/wheel_lights_on", "wheel_lights_on", "b738_wheel_lights_on()", "", "")

--WHEEL WELL OFF
function b738_wheel_lights_off()
	
	dataref("wheel_light_state", "laminar/B738/toggle_switch/wheel_light", "writable")
	
	if (wheel_light_state == 1.0) then 

		set("laminar/B738/toggle_switch/wheel_light",0.0)

	end
	
end
create_command("WeisAIR/b738/LIGHTS/wheel_lights_off", "wheel_lights_off", "b738_wheel_lights_off()", "", "")

--COCKPIT Light ON
function b738_cockpit_lights_max()
		
	dataref("panel_brightness_background", "laminar/B738/electric/generic_brightness", "writable",6)
	dataref("panel_brightness_afds", "laminar/B738/electric/generic_brightness", "writable",7)
	dataref("panel_brightness_overhead", "laminar/B738/electric/panel_brightness", "writable",2)
	dataref("panel_brightness_main", "laminar/B738/electric/panel_brightness", "writable",0)
	set_array("laminar/B738/electric/generic_brightness", 6 , 1 )
	set_array("laminar/B738/electric/generic_brightness", 7 , 1 )
	set_array("laminar/B738/electric/panel_brightness",2,1)
	set_array("laminar/B738/electric/panel_brightness",0,1)
	
	command_once("laminar/B738/toggle_switch/cockpit_dome_dn")
	command_once("laminar/B738/toggle_switch/cockpit_dome_dn")
	
end
create_command("WeisAIR/b738/LIGHTS/cockpit_lights_max", "cockpit_lights_max", "b738_cockpit_lights_max()", "", "")

--COCKPIT Light OFF
function b738_cockpit_lights_off()
		
	dataref("panel_brightness_background", "laminar/B738/electric/generic_brightness", "writable",6)
	dataref("panel_brightness_afds", "laminar/B738/electric/generic_brightness", "writable",7)
	dataref("panel_brightness_overhead", "laminar/B738/electric/panel_brightness", "writable",2)
	dataref("panel_brightness_main", "laminar/B738/electric/panel_brightness", "writable",0)
	set_array("laminar/B738/electric/generic_brightness", 6 , 0 )
	set_array("laminar/B738/electric/generic_brightness", 7 , 0 )
	set_array("laminar/B738/electric/panel_brightness",2,0)
	set_array("laminar/B738/electric/panel_brightness",0,0)
	
	command_once("laminar/B738/toggle_switch/cockpit_dome_up")
	
end
create_command("WeisAIR/b738/LIGHTS/cockpit_lights_off", "b738_cockpit_lights_off", "b738_cockpit_lights_off()", "", "")

--|-----------------------------------|--
--|--//WeisAIR MFD Commands//---------|--
--|-----------------------------------|--

--Generic Lower Button 1
function b738_syncCRS()
	dataref("course_pilot", "laminar/B738/autopilot/course_pilot", "readonly")
	dataref("course_copilot", "laminar/B738/autopilot/course_copilot", "writable")
	if (course_pilot ~= course_copilot) then set("laminar/B738/autopilot/course_copilot", course_pilot) end
end
create_command("WeisAIR/b738/MFDPanel/syncCRS", "syncCRS", "b738_syncCRS()", "", "")
--Generic Lower Button 2
	-->laminar/B738/LDU_control/push_button/MFD_SYS		
--Generic Lower Button 3
	-->laminar/B738/LDU_control/push_button/MFD_ENG
--Generic Lower Button 4
--Generic Lower Button 5
--Generic Lower Button 6
--Generic Lower Button 7
--Generic Lower Button 8
--Generic Lower Button 9
--Generic Lower Button 10
--Generic Lower Button 11
--Generic Lower Button 12
--Generic Right Button 13
--Generic Right Button 14
--Generic Right Button 15
--Generic Right Button 16
--Generic Right Button 17
--Generic Right Button 18
--GA Outer Enc ++
--GA Outer Enc --
--GA Inner Enc ++
--GA Inner Enc --
--GA Outer Button
--GA Inner Button
--|-----------------------------------|--
--|--//WeisAIR Systems Commands//-----|--
--|-----------------------------------|--

--FUEL PUMP ON (for priming APU)
function b738_fuel_pump_rgt1_on()
	
	dataref("fuel_pump_rgt1_state", "laminar/B738/fuel/fuel_tank_pos_rgt1", "writable")
	
	if (fuel_pump_rgt1_state == 0.0) then 

		command_once("laminar/B738/toggle_switch/fuel_pump_rgt1")

	end
	
end
create_command("WeisAIR/b738/Systems/fuel_pump_rgt1_on", "fuel_pump_rgt1_on", "fuel_pump_rgt1_on()", "", "")

--FUEL PUMP OFF
function b738_fuel_pump_rgt1_off()
	
	dataref("fuel_pump_rgt1_state", "laminar/B738/fuel/fuel_tank_pos_rgt1", "writable")
	
	if (fuel_pump_rgt1_state == 1.0) then 

		command_once("laminar/B738/toggle_switch/fuel_pump_rgt1")

	end
	
end
create_command("WeisAIR/b738/Systems/fuel_pump_rgt1_off", "fuel_pump_rgt1_off", "fuel_pump_rgt1_off()", "", "")

--ANTI ICE ON
function b738_anti_ice_on()
	
	dataref(wing_heat_pos, "laminar/B738/ice/wing_heat_pos", "writable")
	dataref(eng1_heat_pos, "laminar/B738/ice/eng1_heat_pos", "writable")
	dataref(eng2_heat_pos, "laminar/B738/ice/eng2_heat_pos", "writable")
	dataref(capt_probes_pos, "laminar/B738/toggle_switch/capt_probes_pos", "writable")
	dataref(fo_probes_pos,   "laminar/B738/toggle_switch/fo_probes_pos", "writable")
	dataref(window_heat_l_side_state,"laminar/B738/annunciator/window_heat_l_side", "writable")
	dataref(window_heat_l_fwd_state,"laminar/B738/annunciator/window_heat_l_fwd", "writable")
	dataref(window_heat_r_side_state,"laminar/B738/annunciator/window_heat_r_side", "writable")
	dataref(window_heat_r_fwd_state,"laminar/B738/annunciator/window_heat_r_fwd", "writable")
	
	if(	wing_heat_pos == 0.0 and 
		eng1_heat_pos == 0.0 and 
		eng2_heat_pos == 0.0 and 
		capt_probes_pos == 0.0 and 
		fo_probes_pos == 0.0 and
		window_heat_l_side_state == 0.0 and
		window_heat_l_fwd_state  == 0.0 and
		window_heat_r_side_state == 0.0 and
		window_heat_r_fwd_state  == 0.0) then
		
			command_once("laminar/B738/toggle_switch/eng1_heat")				
			command_once("laminar/B738/toggle_switch/eng2_heat")				
			command_once("laminar/B738/toggle_switch/wing_heat")			
			command_once("laminar/B738/toggle_switch/window_heat_l_side")		
			command_once("laminar/B738/toggle_switch/window_heat_l_fwd")		
			command_once("laminar/B738/toggle_switch/window_heat_r_side")		
			command_once("laminar/B738/toggle_switch/window_heat_r_fwd")
			set("laminar/B738/toggle_switch/capt_probes_pos", 1.0) 
			set("laminar/B738/toggle_switch/fo_probes_pos", 1.0)
	end
		
end
create_command("WeisAIR/b738/Systems/b738_anti_ice_on", "anti_ice_on", "anti_ice_on()", "", "")



--ANTI ICE OFF
function b738_anti_ice_on()
	
	dataref(wing_heat_pos, "laminar/B738/ice/wing_heat_pos", "writable")
	dataref(eng1_heat_pos, "laminar/B738/ice/eng1_heat_pos", "writable")
	dataref(eng2_heat_pos, "laminar/B738/ice/eng2_heat_pos", "writable")
	dataref(capt_probes_pos, "laminar/B738/toggle_switch/capt_probes_pos", "writable")
	dataref(fo_probes_pos,   "laminar/B738/toggle_switch/fo_probes_pos", "writable")
	dataref(window_heat_l_side_state,"laminar/B738/annunciator/window_heat_l_side", "writable")
	dataref(window_heat_l_fwd_state,"laminar/B738/annunciator/window_heat_l_fwd", "writable")
	dataref(window_heat_r_side_state,"laminar/B738/annunciator/window_heat_r_side", "writable")
	dataref(window_heat_r_fwd_state,"laminar/B738/annunciator/window_heat_r_fwd", "writable")
	
	if(	wing_heat_pos == 1.0 and 
		eng1_heat_pos == 1.0 and 
		eng2_heat_pos == 1.0 and 
		capt_probes_pos == 1.0 and 
		fo_probes_pos == 1.0 and
		window_heat_l_side_state == 1.0 and
		window_heat_l_fwd_state  == 1.0 and
		window_heat_r_side_state == 1.0 and
		window_heat_r_fwd_state  == 1.0) then
		
			command_once("laminar/B738/toggle_switch/eng1_heat")				
			command_once("laminar/B738/toggle_switch/eng2_heat")				
			command_once("laminar/B738/toggle_switch/wing_heat")			
			command_once("laminar/B738/toggle_switch/window_heat_l_side")		
			command_once("laminar/B738/toggle_switch/window_heat_l_fwd")		
			command_once("laminar/B738/toggle_switch/window_heat_r_side")		
			command_once("laminar/B738/toggle_switch/window_heat_r_fwd")
			set("laminar/B738/toggle_switch/capt_probes_pos", 0.0) 
			set("laminar/B738/toggle_switch/fo_probes_pos", 0.0)
	end
		
end
create_command("WeisAIR/b738/Systems/b738_anti_ice_off", "anti_ice_off", "anti_ice_off()", "", "")

--PITOT HEAT ON
	--INOP
--PITOT HEAT OFF
	--INOP
	
--YAW DAMPER ON
function b738_yaw_damper_on()
	dataref("yaw_damper_state", "laminar/B738/toggle_switch/yaw_dumper_pos", "writable")

	if (yaw_damper_state == 0.0) then set("laminar/B738/toggle_switch/yaw_dumper_pos", 1.0) end
end
create_command("WeisAIR/b738/Systems/yaw_damper_on", "yaw_damper_on", "b738_yaw_damper_on()", "", "")

--YAW DAMPER OFF
function b738_yaw_damper_off()
	dataref("yaw_damper_state", "laminar/B738/toggle_switch/yaw_dumper_pos", "writable")

	if (yaw_damper_state == 1.0) then set("laminar/B738/toggle_switch/yaw_dumper_pos", 0.0) end
end
create_command("WeisAIR/b738/Systems/yaw_damper_off", "yaw_damper_off", "b738_yaw_damper_off()", "", "")

--XPDR MODE ++
	-->laminar/B738/knob/transponder_mode_up
--XPDR MODE --
	-->laminar/B738/knob/transponder_mode_dn

--IRS ALIGN ON
function b738_irs_align_on()

	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	
	command_once("laminar/B738/toggle_switch/irs_L_right")
	command_once("laminar/B738/toggle_switch/irs_L_right")
	command_once("laminar/B738/toggle_switch/irs_R_right")
	command_once("laminar/B738/toggle_switch/irs_R_right")

end
create_command("WeisAIR/b738/Systems/irs_align_on", "irs_align_on", "b738_irs_align_on()", "", "")	

--IRS ALIGN OFF
function b738_irs_align_off()

	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")

end
create_command("WeisAIR/b738/Systems/irs_align_off", "irs_align_off", "b738_irs_align_off()", "", "")	
	
--|------------------------------------|--
--|--//WeisAIR Lower Panel Commands//--|--
--|------------------------------------|--

--Switch Park Brk ON
function b738_park_brake_on()
	dataref("park_brake_state", "laminar/B738/parking_brake_pos", "writable")

	if (park_brake_state == 0.0) then set("laminar/B738/parking_brake_pos", 1.0) end
end
create_command("WeisAIR/b738/OtherFunctionality/park_brake_on", "park_brake_on", "b738_park_brake_on()", "", "")

--Switch Park Brk OFF
function b738_park_brake_off()
	dataref("park_brake_state", "laminar/B738/parking_brake_pos", "writable")

	if (park_brake_state == 1.0) then set("laminar/B738/parking_brake_pos", 0.0) end
end
create_command("WeisAIR/b738/OtherFunctionality/park_brake_off", "park_brake_off", "b738_park_brake_off()", "", "")

--Switch Cabin Sign ON
function b738_seatbelt_nosmoke_sign_on()
		
	command_once("laminar/B738/toggle_switch/no_smoking_dn")
	command_once("laminar/B738/toggle_switch/no_smoking_dn")
	command_once("laminar/B738/toggle_switch/seatbelt_sign_dn")
	command_once("laminar/B738/toggle_switch/seatbelt_sign_dn")	
	
end
create_command("WeisAIR/b738/OtherFunctionality/seatbelt_nosmoke_sign_on", "seatbelt_nosmoke_sign_on", "b738_seatbelt_nosmoke_sign_on()", "", "")

--Switch Cabin Sign OFF
function b738_seatbelt_nosmoke_sign_off()
		
	command_once("laminar/B738/toggle_switch/no_smoking_up")
	command_once("laminar/B738/toggle_switch/no_smoking_up")
	command_once("laminar/B738/toggle_switch/seatbelt_sign_up")
	command_once("laminar/B738/toggle_switch/seatbelt_sign_up")	
	
end
create_command("WeisAIR/b738/OtherFunctionality/seatbelt_nosmoke_sign_off", "seatbelt_nosmoke_sign_off", "b738_seatbelt_nosmoke_sign_off()", "", "")

--Toggle LIGHTS Test
function b738_lights_test_on()
		
	command_once("laminar/B738/toggle_switch/bright_test_up")
	command_once("laminar/B738/toggle_switch/bright_test_up")
	command_once("laminar/B738/toggle_switch/ap_disconnect_test2_up")

end

function b738_lights_test_off()
		
	command_once("laminar/B738/toggle_switch/bright_test_dn")
	command_once("laminar/B738/toggle_switch/ap_disconnect_test2_dn")
end

create_command("WeisAIR/b738/OtherFunctionality/toggle_ann_lights_test", "toggle_ann_lights_test", "b738_lights_test_on()", "", "b738_lights_test_off()")

--Toggle FIRE WARN Test
function b738_fire_warn_test_toggle()
--idea: short press = bell cutout
	--laminar/B738/push_button/fire_bell_light1				Captain fire warning bell cutout press
	--laminar/B738/push_button/fire_bell_light2				First officer warning bell cutout press
--idea: long press = Fire Test
	--laminar/B738/toggle_switch/fire_test_lft				Fire panel test left
	--laminar/B738/toggle_switch/fire_test_rgt				Fire panel test right


	command_once("laminar/B738/toggle_switch/fire_test_lft")
	command_once("laminar/B738/toggle_switch/fire_test_rgt")
	command_once("laminar/B738/toggle_switch/exting_test_lft")
	command_once("laminar/B738/toggle_switch/exting_test_rgt")

end
create_command("WeisAIR/b738/OtherFunctionality/fire_warn_test_toggle", "fire_warn_test_toggle", "b738_fire_warn_test_toggle()", "", "")

--|-------------------------------------|--
--|--//WeisAIR Energy Panel Commands//--|--
--|-------------------------------------|--

--BAT ON
	-->laminar/B738/switch/battery_dn
--BAT OFF
	-->laminar/B738/switch/battery_up
--GPU ON
function b738_gpu_on()
	
	dataref("gpu_is_available", "laminar/B738/gpu_available", "readonly")
	dataref("asu_is_available", "sim/cockpit2/bleedair/actuators/gpu_bleed", "readonly")
		
	if (gpu_is_available == 1.0 and asu_is_available == 1) then 
				
		command_once("laminar/B738/toggle_switch/gpu_dn")
		command_once("sim/electrical/generator_1_off")
		command_once("sim/electrical/generator_2_off")
		command_once("sim/electrical/GPU_on")
		command_once("sim/radios/power_com2_on")
	
	end
	
end
create_command("WeisAIR/b738/Energy/gpu_on", "gpu_on", "b738_gpu_on()", "", "")

--GPU OFF
function b738_gpu_off()
		
	command_once("laminar/B738/toggle_switch/gpu_up")
	command_once("sim/electrical/GPU_off")
	command_once("sim/radios/power_com2_off")
	
end
create_command("WeisAIR/b738/Energy/gpu_off", "gpu_off", "b738_gpu_off()", "", "")

--APU TOGGLE GEN
function b738_apu_generators_start_stop_toggle()

	dataref("apu_bus_available", "laminar/B738/electrical/apu_bus_enable", "readonly")	
	
	if (apu_bus_available == 0.0) then 

		command_once("laminar/B738/toggle_switch/apu_gen1_dn")
		command_once("laminar/B738/toggle_switch/apu_gen2_dn")
		
	end
	
	if (apu_bus_available == 1.0) then 

	command_once("laminar/B738/toggle_switch/apu_gen1_up")
	command_once("laminar/B738/toggle_switch/apu_gen2_up")

	end
	
end
create_command("WeisAIR/b738/Energy/apu_generators_start_stop_toggle", "apu_generators_start_stop_toggle", "b738_apu_generators_start_stop_toggle()", "", "")
	
--APU TOGGLE STARTER
function b738_apu_start_stop_toggle()

	dataref("apu_bus_available", "laminar/B738/electrical/apu_bus_enable", "readonly")
	dataref("apu_bleed_is_open", "laminar/B738/toggle_switch/bleed_air_apu_pos", "readonly")		
	
	if (apu_bus_available == 0.0) then 

		if (apu_bleed_is_open == 0.0) then command_once("laminar/B738/toggle_switch/bleed_air_apu") end	
		command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
		command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
	
	end
	
	if (apu_bus_available == 1.0) then 

		if (apu_bleed_is_open == 1.0) then command_once("laminar/B738/toggle_switch/bleed_air_apu") end
		command_once("laminar/B738/spring_toggle_switch/APU_start_pos_up")

	end	
	
end
create_command("WeisAIR/b738/Energy/apu_start_stop_toggle", "apu_start_stop_toggle", "b738_apu_start_stop_toggle()", "", "")


--ENG 1 TOGGLE GEN
	
function b738_toggle_engine1_generator()

	--> check dataref for energy availability
	dataref("gen1_available", "XXX", "writable/readonly")	
	
	if (gen1_available == 0.0) then 

		command_once("laminar/B738/toggle_switch/gen1_dn")
		
	end
	
	if (gen1_available == 1.0) then 

		command_once("laminar/B738/toggle_switch/gen1_up")
		
	end
	
end
create_command("WeisAIR/b738/Energy/toggle_engine1_generator", "toggle_engine1_generator", "b738_toggle_engine1_generator()", "", "")

--ENG 1 TOGGLE STARTER
function b738_toggle_engine1_starter()

	dataref("starter1_pos", "laminar/B738/engine/starter1_pos", "writable")	
	
	if (starter1_pos == 1.0) then 

		command_once("laminar/B738/knob/eng1_start_left")
		
	end
	
	if (starter1_pos > 1.0) then 

		command_once("laminar/B738/knob/eng1_start_right")
		command_once("laminar/B738/knob/eng1_start_left")
		command_once("laminar/B738/knob/eng1_start_left")
		
	end
	
end
create_command("WeisAIR/b738/Energy/toggle_engine1_starter", "toggle_engine1_starter", "b738_toggle_engine1_starter()", "", "")


--ENG 2 TOGGLE GEN
function b738_toggle_engine2_generator()

	--> check dataref for energy availability
	dataref("gen2_available", "XXX", "writable/readonly")	
	
	if (gen2_available == 0.0) then 

		command_once("laminar/B738/toggle_switch/gen2_dn")
		
	end
	
	if (gen2_available == 1.0) then 

		command_once("laminar/B738/toggle_switch/gen2_up")
		
	end
	
end
create_command("WeisAIR/b738/Energy/toggle_engine2_generator", "toggle_engine2_generator", "b738_toggle_engine2_generator()", "", "")

--ENG 2 TOGGLE STARTER
function b738_toggle_engine2_starter()

	dataref("starter2_pos", "laminar/B738/engine/starter2_pos", "writable")	
	
	if (starter2_pos == 1.0) then 

		command_once("laminar/B738/knob/eng2_start_left")
		
	end
	
	if (starter2_pos > 1.0) then 

		command_once("laminar/B738/knob/eng2_start_right")
		command_once("laminar/B738/knob/eng2_start_left")
		command_once("laminar/B738/knob/eng2_start_left")
		
	end
	
end
create_command("WeisAIR/b738/Energy/toggle_engine2_starter", "toggle_engine2_starter", "b738_toggle_engine2_starter()", "", "")
--ENG 3 TOGGLE GEN
	--> INOP
--ENG 3 TOGGLE STARTER
	--> INOP
--ENG 4 TOGGLE GEN
	--> INOP
--ENG 4 TOGGLE STARTER
		--> INOP
--|-----------------------------------|--
--|--//WeisAIR Yoke Commands//--------|--
--|-----------------------------------|--
	--left button top
	--left button back
	--left Hatswitch Up
	--left Hatswitch Dn
	--left Hatswitch Left
	--left Hatswitch Right
	--left trim A
	--left trim B
	--right white button
	--right red button
	--right trim A
	--right trim B
	--MASTER ALT
	--MASTER BAT
	--BUS 1
	--BUS 2
	--Light BCN
	--Light LAND
	--Light TAXI
	--Light NAV
	--Light Strobe
	--IGN OFF
		--> AutoBreak?
	--IGN R
		--> AutoBreak?
	--IGN L
		--> AutoBreak?
	--IGN BOTH
		--> AutoBreak?
	--IGN START
		--> AutoBreak?
		
--|-----------------------------------|--
--|--//WeisAIR Throttle Commands//----|--
--|-----------------------------------|--
--T1.1
function b738_wipersUP()

	command_once("laminar/B738/knob/left_wiper_up")
	command_once("laminar/B738/knob/right_wiper_up")

end
create_command("WeisAIR/b738/OtherFunctionality/wipersUP", "wipersUP", "b738_wipersUP()", "", "")
--T1.2 (Wipers)
function b738_wipersDN()

	command_once("laminar/B738/knob/left_wiper_dn")
	command_once("laminar/B738/knob/right_wiper_dn")

end
create_command("WeisAIR/b738/OtherFunctionality/wipersDN", "wipersDN", "b738_wipersDN()", "", "")

--T1.3 (Engine 1 Mixture)
	--> laminar/B738/engine/mixture1_toggle
--T1.4
--T1.5 (Engine 2 Mixture)
	--> laminar/B738/engine/mixture2_toggle
--T1.6
--T2.1
--T2.2
--T2.3
--T2.4
--T2.5 (Timer Start?) -> this toggle start/stop/reset
	--> laminar/B738/push_button/chrono_cycle_capt
--T2.6
	


--|-----------------------------------|--
--|--//Too good to throw it away//----|--
--|-----------------------------------|--


function b738_fd_toggle_both()

		command_once("laminar/B738/autopilot/flight_director_toggle")
		command_once("laminar/B738/autopilot/flight_director_fo_toggle")

end
create_command("WeisAIR/b738/ZZZZ_OTHERS/fd_toggle_both", "fd_toggle_both", "b738_fd_toggle_both()", "", "")

function b738_TOGA_ATHR_ARM_toggle()


	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("laminar/B738/autopilot/left_toga_press")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("laminar/B738/autopilot/autothrottle_arm_toggle")
	
	end

end
create_command("WeisAIR/b738/ZZZZ_OTHERS/TOGA_ATHR_ARM_toggle", "TOGA_ATHR_ARM_toggle", "b738_TOGA_ATHR_ARM_toggle()", "", "")

function b738_mode_APP()
		
	set("laminar/B738/EFIS_control/capt/map_mode_pos", 0.0)
	
end
create_command("WeisAIR/b738/EFIS/mode_APP", "mode_APP", "b738_mode_APP()", "", "")

function b738_mode_VOR()
		
	set("laminar/B738/EFIS_control/capt/map_mode_pos", 1.0)
	
end
create_command("WeisAIR/b738/EFIS/mode_VOR", "mode_VOR", "b738_mode_VOR()", "", "")

function b738_mode_MAP()
		
	set("laminar/B738/EFIS_control/capt/map_mode_pos", 2.0)
	
end
create_command("WeisAIR/b738/EFIS/mode_MAP", "mode_MAP", "b738_mode_MAP()", "", "")

function b738_mode_PLN()
		
	set("laminar/B738/EFIS_control/capt/map_mode_pos", 3.0)
	
end
create_command("WeisAIR/b738/EFIS/mode_PLN", "mode_PLN", "b738_mode_PLN()", "", "")


function b738_minsrot_inc()
	
	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("laminar/B738/EFIS_control/cpt/minimums_dn")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("laminar/B738/pfd/dh_pilot_up")
	
	end

end
create_command("WeisAIR/b738/EFIS/minsrot_inc", "minsrot_inc", "b738_minsrot_inc()", "", "")

function b738_minsrot_dec()
	
	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("laminar/B738/EFIS_control/cpt/minimums_up")
	
	end
	
	if FN_BUTTON == 0 then 
			
		command_once("laminar/B738/pfd/dh_pilot_dn")

	end
	
end
create_command("WeisAIR/b738/EFIS/minsrot_dec", "minsrot_dec", "b738_minsrot_dec()", "", "")

function b738_range_set_R5()

	set("laminar/B738/EFIS/capt/map_range", 0.0) 
	
end
create_command("WeisAIR/b738/EFIS/range_set_R5", "range_set_R5", "b738_range_set_R5()", "", "")

function b738_range_set_R10()

	set("laminar/B738/EFIS/capt/map_range", 1.0) 
	
end
create_command("WeisAIR/b738/EFIS/range_set_R10", "range_set_R10", "b738_range_set_R10()", "", "")

function b738_range_set_R20()

	set("laminar/B738/EFIS/capt/map_range", 2.0) 
	
end
create_command("WeisAIR/b738/EFIS/range_set_R20", "range_set_R20", "b738_range_set_R20()", "", "")

function b738_range_set_R40()

	set("laminar/B738/EFIS/capt/map_range", 3.0) 
	
end
create_command("WeisAIR/b738/EFIS/range_set_R40", "range_set_R40", "b738_range_set_R40()", "", "")

function b738_range_set_R80()

	set("laminar/B738/EFIS/capt/map_range", 4.0) 
	
end
create_command("WeisAIR/b738/EFIS/range_set_R80", "range_set_R80", "b738_range_set_R80()", "", "")

function b738_range_set_R160()

	set("laminar/B738/EFIS/capt/map_range", 5.0) 
	
end
create_command("WeisAIR/b738/EFIS/range_set_R160", "range_set_R160", "b738_range_set_R160()", "", "")

function b738_range_set_R320()

	set("laminar/B738/EFIS/capt/map_range", 6.0) 
	
end
create_command("WeisAIR/b738/EFIS/range_set_R320", "range_set_R320", "b738_range_set_R320()", "", "")

function b738_range_set_R640()

	set("laminar/B738/EFIS/capt/map_range", 7.0) 
	
end
create_command("WeisAIR/b738/EFIS/range_set_R640", "range_set_R640", "b738_range_set_R640()", "", "")

function b738_vor_left_set_OFF()
		
	set("laminar/B738/EFIS_control/capt/vor1_off_pos", 0.0)
	set("laminar/B738/EFIS_control/capt/vor1_off_pfd", 0.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_left_set_OFF", "vor_left_set_OFF", "b738_vor_left_set_OFF()", "", "")


function b738_vor_right_set_OFF()
		
	set("laminar/B738/EFIS_control/capt/vor2_off_pos", 0.0)
	set("laminar/B738/EFIS_control/capt/vor2_off_pfd", 0.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_right_set_OFF", "vor_right_set_OFF", "b738_vor_right_set_OFF()", "", "")

function b738_apu_start()
		
	command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
	command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
	
end
create_command("WeisAIR/b738/ENGINES/apu_start", "apu_start", "b738_apu_start()", "", "")

function b738_apu_stop()
		
	command_once("laminar/B738/spring_toggle_switch/APU_start_pos_up")
	command_once("laminar/B738/spring_toggle_switch/APU_start_pos_up")
	
end
create_command("WeisAIR/b738/ENGINES/apu_stop", "apu_stop", "b738_apu_stop()", "", "")


function b738_activate_apu_generators_if_available()
	
	dataref("apu_bus_available", "laminar/B738/electrical/apu_bus_enable", "readonly")	
	
	if (apu_bus_available == 1.0) then 
	
	command_once("laminar/B738/toggle_switch/apu_gen1_dn")
	command_once("laminar/B738/toggle_switch/apu_gen2_dn")
		
	end
	
end

function b738_save_flight_8()
		
	command_once("laminar/B738/tab/home")
	command_once("laminar/B738/tab/menu8")
	command_once("laminar/B738/tab/menu8")
	command_once("laminar/B738/tab/right")
	command_once("laminar/B738/tab/menu8")
	
end
create_command("WeisAIR/b738/simops/save_flight_8", "save_flight_8", "b738_save_flight_8()", "", "")

function b738_load_flight_8()
		
	command_once("laminar/B738/tab/home")
	command_once("laminar/B738/tab/menu8")
	command_once("laminar/B738/tab/menu8")
	command_once("laminar/B738/tab/right")
	command_once("laminar/B738/tab/menu4")
	
end
create_command("WeisAIR/b738/simops/load_flight_8", "load_flight_8", "b738_load_flight_8()", "", "")

function b738_apu_on()
		
	dataref("apu_bleed_is_open", "laminar/B738/toggle_switch/bleed_air_apu_pos", "readonly")	
	
	if (apu_bleed_is_open == 0.0) then command_once("laminar/B738/toggle_switch/bleed_air_apu") end	
		
	command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
	command_once("laminar/B738/spring_toggle_switch/APU_start_pos_dn")
	
end
create_command("WeisAIR/b738/elec/apu_on", "apu_on", "b738_apu_on()", "", "")

function b738_apu_off()
	

	dataref("apu_bleed_is_open", "laminar/B738/toggle_switch/bleed_air_apu_pos", "readonly")	
	
	if (apu_bleed_is_open == 1.0) then command_once("laminar/B738/toggle_switch/bleed_air_apu") end
	
	command_once("laminar/B738/spring_toggle_switch/APU_start_pos_up")
	
	
end
create_command("WeisAIR/b738/elec/apu_off", "apu_off", "b738_apu_off()", "", "")

--do_sometimes("b738_activate_apu_generators_if_available()")
--sim/instruments/timer_start_stop