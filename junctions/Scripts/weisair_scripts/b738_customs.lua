function b738_syncCRS()
	dataref("course_pilot", "laminar/B738/autopilot/course_pilot", "readonly")
	dataref("course_copilot", "laminar/B738/autopilot/course_copilot", "writable")
	if (course_pilot ~= course_copilot) then set("laminar/B738/autopilot/course_copilot", course_pilot) end
end
create_command("WeisAIR/b738/syncCRS", "syncCRS", "b738_syncCRS()", "", "")

function b738_fd_toggle_both()

		command_once("laminar/B738/autopilot/flight_director_toggle")
		command_once("laminar/B738/autopilot/flight_director_fo_toggle")

end
create_command("WeisAIR/b738/fd_toggle_both", "fd_toggle_both", "b738_fd_toggle_both()", "", "")

function b738_TOGA_ATHR_ARM_toggle()


	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("laminar/B738/autopilot/left_toga_press")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("laminar/B738/autopilot/autothrottle_arm_toggle")
	
	end

end
create_command("WeisAIR/b738/TOGA_ATHR_ARM_toggle", "TOGA_ATHR_ARM_toggle", "b738_TOGA_ATHR_ARM_toggle()", "", "")

function b738_wipersUP()

		command_once("laminar/B738/knob/left_wiper_up")
		command_once("laminar/B738/knob/right_wiper_up")

end
create_command("WeisAIR/b738/wipersUP", "wipersUP", "b738_wipersUP()", "", "")

function b738_wipersDN()

		command_once("laminar/B738/knob/left_wiper_dn")
		command_once("laminar/B738/knob/right_wiper_dn")

end
create_command("WeisAIR/b738/wipersDN", "wipersDN", "b738_wipersDN()", "", "")

function b738_toggle_map_mode()
		
	dataref("map_mode", "laminar/B738/EFIS_control/capt/map_mode_pos", "writable")
	
	current_map_mode = map_mode
	next_mode = map_mode + 1.0
	
	if (next_mode < 4.0) then set("laminar/B738/EFIS_control/capt/map_mode_pos", next_mode)
		else set("laminar/B738/EFIS_control/capt/map_mode_pos", 0.0)
	end
	
end
create_command("WeisAIR/b738/EFIS/b738_toggle_map_mode", "b738_toggle_map_mode", "b738_toggle_map_mode()", "", "")

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

function b738_mode_inc()
	
	dataref("map_mode", "laminar/B738/EFIS_control/capt/map_mode_pos", "writable")
	
	mode_current = map_mode
	mode_new = mode_current + 1.0

	if (mode_new <=3.0 and mode_new >=0.0) 
		then set("laminar/B738/EFIS_control/capt/map_mode_pos", mode_new)
	end
end
create_command("laminar/B738/EFIS_control/capt/map_mode_pos", "mode_inc", "b738_mode_inc()", "", "")

function b738_mode_dec()
	
	dataref("map_mode", "laminar/B738/EFIS_control/capt/map_mode_pos", "writable")
	
	mode_current = map_mode
	mode_new = mode_current - 1.0

	if (mode_new <=3.0 and mode_new >=0.0) 
		then set("laminar/B738/EFIS_control/capt/map_mode_pos", mode_new)
	end
end
create_command("WeisAIR/b738/EFIS/mode_dec", "mode_dec", "b738_mode_dec()", "", "")


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


function b738_toggle_map_range()
		
	dataref("selected_range", "laminar/B738/EFIS/capt/map_range", "writable")
	
	current_range = selected_range
	next_range = current_range + 1.0
	
	if (next_range < 8.0) then set("laminar/B738/EFIS/capt/map_range", next_range)
		else set("laminar/B738/EFIS/capt/map_range", 0.0)
	end
	
end
create_command("WeisAIR/b738/EFIS/b738_toggle_map_range", "b738_toggle_map_range", "b738_toggle_map_range()", "", "")


function b738_range_inc()
	dataref("range", "laminar/B738/EFIS/capt/map_range", "writable")
	
	range_current = range
	range_new = range + 1.0
	
	if (range_new >= 0.0 and range_new <= 7.0) then set("laminar/B738/EFIS/capt/map_range", range_new) end
	
end
create_command("WeisAIR/b738/EFIS/range_inc", "range_inc", "b738_range_inc()", "", "")

function b738_range_dec()
	dataref("range", "laminar/B738/EFIS/capt/map_range", "writable")
	
	range_current = range
	range_new = range - 1.0
	
	if (range_new >= 0.0 and range_new <= 7.0) then set("laminar/B738/EFIS/capt/map_range", range_new) end
	
end
create_command("WeisAIR/b738/EFIS/range_dec", "range_dec", "b738_range_dec()", "", "")

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

function b738_autobrake_pos_toggle()

	dataref("autobrake_pos", "laminar/B738/autobrake/autobrake_pos", "readonly")
		
	if (autobrake_pos < 5.0) then
		command_once("laminar/B738/knob/autobrake_up") 
	elseif (autobrake_pos == 5.0) then
		command_once("laminar/B738/knob/autobrake_rto")
	end

end
create_command("WeisAIR/b738/b738_autobrake_pos_toggle", "b738_autobrake_pos_toggle", "b738_autobrake_pos_toggle()", "", "")

function b738_autobrake_set_rto()
	
	dataref("autobrake_pos", "laminar/B738/autobrake/autobrake_pos", "writable")
	set("laminar/B738/autobrake/autobrake_pos", 0.0) 

end
create_command("WeisAIR/b738/b738_autobrake_set_rto", "b738_autobrake_set_rto", "b738_autobrake_set_rto()", "", "")

function b738_toggle_left_VOR()
		
	dataref("left_vor_pos", "laminar/B738/EFIS_control/capt/vor1_off_pos", "readonly")
	dataref("left_vor_pfd", "laminar/B738/EFIS_control/capt/vor1_off_pfd", "readonly")
	
	-- 	1 == VOR
	-- 	0 == OFF
	-- -1 == ADF
	
	if (left_vor_pos == 0.0 and left_vor_pfd == 0.0) then 
		command_once("laminar/B738/EFIS_control/capt/vor1_off_dn")
	end
	
	if (left_vor_pos == -1.0 and left_vor_pfd == -1.0) then 
		command_once("laminar/B738/EFIS_control/capt/vor1_off_up")
		command_once("laminar/B738/EFIS_control/capt/vor1_off_up")
	end
	
	if (left_vor_pos == 1.0 and left_vor_pfd == 1.0) then 
		command_once("laminar/B738/EFIS_control/capt/vor1_off_dn")
	end
	
end
create_command("WeisAIR/b738/EFIS/toggle_left_VOR", "toggle_left_VOR", "b738_toggle_left_VOR()", "", "")

function b738_toggle_right_VOR()
		
	dataref("right_vor_pos", "laminar/B738/EFIS_control/capt/vor2_off_pos", "readonly")
	dataref("right_vor_pfd", "laminar/B738/EFIS_control/capt/vor2_off_pfd", "readonly")
	
	-- 	1 == VOR
	-- 	0 == OFF
	-- -1 == ADF
	
	if (right_vor_pos == 0.0 and right_vor_pfd == 0.0) then 
		command_once("laminar/B738/EFIS_control/capt/vor2_off_dn")
	end
	
	if (right_vor_pos == -1.0 and right_vor_pfd == -1.0) then 
		command_once("laminar/B738/EFIS_control/capt/vor2_off_up")
		command_once("laminar/B738/EFIS_control/capt/vor2_off_up")
	end
	
	if (right_vor_pos == 1.0 and right_vor_pfd == 1.0) then 
		command_once("laminar/B738/EFIS_control/capt/vor2_off_dn") 
	end
	
end
create_command("WeisAIR/b738/EFIS/toggle_right_VOR", "toggle_right_VOR", "b738_toggle_right_VOR()", "", "")


function b738_vor_left_set_VOR()
		
	set("laminar/B738/EFIS_control/capt/vor1_off_pos", 1.0)
	set("laminar/B738/EFIS_control/capt/vor1_off_pfd", 1.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_left_set_VOR", "vor_left_set_VOR", "b738_vor_left_set_VOR()", "", "")

function b738_vor_left_set_OFF()
		
	set("laminar/B738/EFIS_control/capt/vor1_off_pos", 0.0)
	set("laminar/B738/EFIS_control/capt/vor1_off_pfd", 0.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_left_set_OFF", "vor_left_set_OFF", "b738_vor_left_set_OFF()", "", "")

function b738_vor_left_set_ADF()
		
	set("laminar/B738/EFIS_control/capt/vor1_off_pos", -1.0)
	set("laminar/B738/EFIS_control/capt/vor1_off_pfd", -1.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_left_set_ADF", "vor_left_set_ADF", "b738_vor_left_set_ADF()", "", "")

function b738_vor_right_set_VOR()
		
	set("laminar/B738/EFIS_control/capt/vor2_off_pos", 1.0)
	set("laminar/B738/EFIS_control/capt/vor2_off_pfd", 1.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_right_set_VOR", "vor_right_set_VOR", "b738_vor_right_set_VOR()", "", "")

function b738_vor_right_set_OFF()
		
	set("laminar/B738/EFIS_control/capt/vor2_off_pos", 0.0)
	set("laminar/B738/EFIS_control/capt/vor2_off_pfd", 0.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_right_set_OFF", "vor_right_set_OFF", "b738_vor_right_set_OFF()", "", "")

function b738_vor_right_set_ADF()
		
	set("laminar/B738/EFIS_control/capt/vor2_off_pos", -1.0)
	set("laminar/B738/EFIS_control/capt/vor2_off_pfd", -1.0)
	
end
create_command("WeisAIR/b738/EFIS/vor_right_set_ADF", "vor_right_set_ADF", "b738_vor_right_set_ADF()", "", "")

function b738_seatbelt_nosmoke_sign_on()
		
	command_once("laminar/B738/toggle_switch/no_smoking_dn")
	command_once("laminar/B738/toggle_switch/no_smoking_dn")
	command_once("laminar/B738/toggle_switch/seatbelt_sign_dn")
	command_once("laminar/B738/toggle_switch/seatbelt_sign_dn")	
	
end
create_command("WeisAIR/b738/EFIS/seatbelt_nosmoke_sign_on", "seatbelt_nosmoke_sign_on", "b738_seatbelt_nosmoke_sign_on()", "", "")

function b738_seatbelt_nosmoke_sign_off()
		
	command_once("laminar/B738/toggle_switch/no_smoking_up")
	command_once("laminar/B738/toggle_switch/no_smoking_up")
	command_once("laminar/B738/toggle_switch/seatbelt_sign_up")
	command_once("laminar/B738/toggle_switch/seatbelt_sign_up")	
	
end
create_command("WeisAIR/b738/EFIS/seatbelt_nosmoke_sign_off", "seatbelt_nosmoke_sign_off", "b738_seatbelt_nosmoke_sign_off()", "", "")

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
create_command("WeisAIR/b738/elec/gpu_on", "gpu_on", "b738_gpu_on()", "", "")

function b738_gpu_off()
		
	command_once("laminar/B738/toggle_switch/gpu_up")
	command_once("sim/electrical/GPU_off")
	command_once("sim/radios/power_com2_off")
	
end
create_command("WeisAIR/b738/elec/gpu_off", "gpu_off", "b738_gpu_off()", "", "")

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



function b738_activate_apu_generators_if_available()
	
	dataref("apu_bus_available", "laminar/B738/electrical/apu_bus_enable", "readonly")	
	
	if (apu_bus_available == 1.0) then 
	
	command_once("laminar/B738/toggle_switch/apu_gen1_dn")
	command_once("laminar/B738/toggle_switch/apu_gen2_dn")
		
	end
	
end

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
create_command("WeisAIR/b738/LIGHTS/cockpit_lights_max", "b738_cockpit_lights_max", "b738_cockpit_lights_max()", "", "")

function b738_rwto_lights_on()
	
	command_once("laminar/B738/switch/rwy_light_left_on")
	command_once("laminar/B738/switch/rwy_light_right_on")
	
end
create_command("WeisAIR/b738/LIGHTS/rwto_lights_on", "rwto_lights_on", "b738_rwto_lights_on()", "", "")


function b738_rwto_lights_off()
	
	command_once("laminar/B738/switch/rwy_light_left_off")
	command_once("laminar/B738/switch/rwy_light_right_off")
	
end
create_command("WeisAIR/b738/LIGHTS/rwto_lights_off", "rwto_lights_off", "b738_rwto_lights_off()", "", "")

function b738_pos_lights_toggle()

	dataref("pos_lights_position", "laminar/B738/toggle_switch/position_light_pos", "readonly")
		
	if (pos_lights_position == 0.0) then
		command_once("laminar/B738/toggle_switch/position_light_steady") 
	elseif (pos_lights_position == -1.0) then
		command_once("laminar/B738/toggle_switch/position_light_strobe")
	elseif (pos_lights_position == 1.0) then
		command_once("laminar/B738/toggle_switch/position_light_off")
	end

end
create_command("WeisAIR/b738/LIGHTS/b738_pos_lights_toggle", "b738_pos_lights_toggle", "b738_pos_lights_toggle()", "", "")

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

create_command("WeisAIR/b738/autopilot/ap_prst_start", "", "command_begin(\"laminar/B738/push_button/ap_light_pilot\")", "", "")
create_command("WeisAIR/b738/autopilot/ap_prst_end", "", "command_end(\"laminar/B738/push_button/ap_light_pilot\")", "", "")
create_command("WeisAIR/b738/autopilot/at_prst_start", "", "command_begin(\"laminar/B738/push_button/at_light_pilot\")", "", "")
create_command("WeisAIR/b738/autopilot/at_prst_end", "", "command_end(\"laminar/B738/push_button/at_light_pilot\")", "", "")
create_command("WeisAIR/b738/autopilot/fmc_prst_start", "", "command_begin(\"laminar/B738/push_button/fms_light_pilot\")", "", "")
create_command("WeisAIR/b738/autopilot/fmc_prst_end", "", "command_end(\"laminar/B738/push_button/fms_light_pilot\")", "", "")

create_command("WeisAIR/b738/autopilot/ap_prst_press", "", "command_begin(\"laminar/B738/push_button/ap_light_pilot\")", "", "")
create_command("WeisAIR/b738/autopilot/at_prst_press", "", "command_begin(\"laminar/B738/push_button/at_light_pilot\")", "", "")
create_command("WeisAIR/b738/autopilot/fmc_prst_press", "", "command_begin(\"laminar/B738/push_button/fms_light_pilot\")", "", "")


function b738_toggle_irs_left()
		
		
	dataref("irs_left_state", "laminar/B738/toggle_switch/irs_left", readonly)
	
	current_state = irs_left_state
	new_state = current_state + 1.0
	
	if (new_state <= 3.0) then	command_once("laminar/B738/toggle_switch/irs_L_right") end
	if (new_state > 3.0) then	
	
		command_once("laminar/B738/toggle_switch/irs_L_left") 
		command_once("laminar/B738/toggle_switch/irs_L_left") 
		command_once("laminar/B738/toggle_switch/irs_L_left") 
	end
	
end
create_command("WeisAIR/b738/irs/b738_toggle_irs_left", "b738_toggle_irs_left", "b738_toggle_irs_left()", "", "")

function b738_toggle_irs_right()
		
		
	dataref("irs_right_state", "laminar/B738/toggle_switch/irs_right", readonly)
	
	current_state = irs_right_state
	new_state = current_state + 1.0
	
	if (new_state <= 3.0) then	command_once("laminar/B738/toggle_switch/irs_R_right") end
	if (new_state > 3.0) then	
	
		command_once("laminar/B738/toggle_switch/irs_R_left") 
		command_once("laminar/B738/toggle_switch/irs_R_left") 
		command_once("laminar/B738/toggle_switch/irs_R_left") 
	end
	
end
create_command("WeisAIR/b738/irs/b738_toggle_irs_right", "b738_toggle_irs_right", "b738_toggle_irs_right()", "", "")

function b738_toggle_left_pack_modes()
		
		
	dataref("left_pack_mode", "laminar/B738/air/l_pack_pos", writable)
	
	current_state = left_pack_mode
	new_state = current_state + 1.0
	
	if (new_state == 3.0) then set("laminar/B738/air/l_pack_pos", 0.0) else command_once("laminar/B738/toggle_switch/l_pack_dn") end	
	
end
create_command("WeisAIR/b738/pressure/b738_toggle_left_pack_modes", "b738_toggle_left_pack_modes", "b738_toggle_left_pack_modes()", "", "")

function b738_toggle_right_pack_modes()
		
		
	dataref("right_pack_mode", "laminar/B738/air/r_pack_pos", writable)
	
	current_state = right_pack_mode
	new_state = current_state + 1.0
	
	if (new_state == 3.0) then set("laminar/B738/air/r_pack_pos", 0.0) else command_once("laminar/B738/toggle_switch/r_pack_dn") end	
	
end
create_command("WeisAIR/b738/pressure/b738_toggle_right_pack_modes", "b738_toggle_right_pack_modes", "b738_toggle_right_pack_modes()", "", "")


function b738_toggle_isol_valve_modes()
		
		
	dataref("isol_valve_mode", "laminar/B738/air/isolation_valve_pos", writable)
	
	current_state = isol_valve_mode
	new_state = current_state + 1.0
	
	if (new_state == 3.0) then set("laminar/B738/air/isolation_valve_pos", 0.0) else command_once("laminar/B738/toggle_switch/iso_valve_dn") end	
	
end
create_command("WeisAIR/b738/pressure/b738_toggle_isol_valve_modes", "b738_toggle_isol_valve_modes", "b738_toggle_isol_valve_modes()", "", "")

function b738_toggle_air_valve_modes()
		
		
	dataref("air_valve_mode", "laminar/B738/toggle_switch/air_valve_ctrl", writable)
	
	current_state = air_valve_mode
	new_state = current_state + 1.0
	
	if (new_state == 3.0) then set("laminar/B738/toggle_switch/air_valve_ctrl", 0.0) else command_once("laminar/B738/toggle_switch/air_valve_ctrl_right") end	
	
end
create_command("WeisAIR/b738/pressure/b738_toggle_air_valve_modes", "b738_toggle_air_valve_modes", "b738_toggle_air_valve_modes()", "", "")


function b738_begin_manual_valve_close()
		
	command_begin("laminar/B738/toggle_switch/air_valve_manual_left")	
	
end
create_command("WeisAIR/b738/pressure/b738_begin_manual_valve_close", "b738_begin_manual_valve_close", "b738_begin_manual_valve_close()", "", "")

function b738_end_manual_valve_close()
		
	command_end("laminar/B738/toggle_switch/air_valve_manual_left")	
	
end
create_command("WeisAIR/b738/pressure/b738_end_manual_valve_close", "b738_end_manual_valve_close", "b738_end_manual_valve_close()", "", "")

function b738_begin_manual_valve_open()
		
	command_begin("laminar/B738/toggle_switch/air_valve_manual_right")	
	
end
create_command("WeisAIR/b738/pressure/b738_begin_manual_valve_open", "b738_begin_manual_valve_open", "b738_begin_manual_valve_open()", "", "")

function b738_end_manual_valve_open()
		
	command_end("laminar/B738/toggle_switch/air_valve_manual_right")	
	
end
create_command("WeisAIR/b738/pressure/b738_end_manual_valve_open", "b738_end_manual_valve_open", "b738_end_manual_valve_open()", "", "")

function b738_toggle_emer_exit_lights()
		
		
	dataref("emer_exit_lights_status", "laminar/B738/toggle_switch/emer_exit_lights", readonly)
	
	current_state = emer_exit_lights_status
	new_state = current_state + 1.0
	
	if (new_state == 3.0) then 
		command_once("laminar/B738/toggle_switch/emer_exit_lights_up")
		command_once("laminar/B738/toggle_switch/emer_exit_lights_up")
	
	else command_once("laminar/B738/toggle_switch/emer_exit_lights_dn") end	
	
end
create_command("WeisAIR/b738/lights/b738_toggle_emer_exit_lights", "b738_toggle_emer_exit_lights", "b738_toggle_emer_exit_lights()", "", "")

function b738_align_and_nav_left_irs()
		
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_right")
	command_once("laminar/B738/toggle_switch/irs_L_right")
	
end
create_command("WeisAIR/b738/irs/b738_align_and_nav_left_irs", "b738_align_and_nav_left_irs", "b738_align_and_nav_left_irs()", "", "")

function b738_align_and_nav_right_irs()
		
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_right")
	command_once("laminar/B738/toggle_switch/irs_R_right")
	
end
create_command("WeisAIR/b738/irs/b738_align_and_nav_right_irs", "b738_align_and_nav_right_irs", "b738_align_and_nav_right_irs()", "", "")

function b738_left_irs_off()
		
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_left")
	command_once("laminar/B738/toggle_switch/irs_L_left")
	
end
create_command("WeisAIR/b738/irs/b738_left_irs_off", "b738_left_irs_off", "b738_left_irs_off()", "", "")

function b738_right_irs_off()
		
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	command_once("laminar/B738/toggle_switch/irs_R_left")
	
end
create_command("WeisAIR/b738/irs/b738_right_irs_off", "b738_right_irs_off", "b738_right_irs_off()", "", "")

--do_sometimes("b738_activate_apu_generators_if_available()")
--sim/instruments/timer_start_stop