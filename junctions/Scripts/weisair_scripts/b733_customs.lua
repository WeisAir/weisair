---------DATAREFS

dataref("alt_act", "sim/cockpit/autopilot/altitude", "writable")	--mcp_altitude
dataref("transponderVal", "ixeg/733/xpdr/xpdr_mode_act", "writable") --XPRD MODE
dataref("fire_test", "ixeg/733/firewarning/fire_ovht_test_act", "writable") --fire test
dataref("autobrakes_mode", "ixeg/733/hydraulics/hyd_auto_brake_act", "writable") -- autobrakes mode
dataref("flt_alt_250", "ixeg/733/pressurization/cabin_auto_flt_alt_kft_act", "writable") -- pressure flight altitude
dataref("land_alt_500", "ixeg/733/pressurization/cabin_auto_land_alt_kft_act","writable") -- pressure land altitude (500er step!!!)
dataref("pilot_dh", "ixeg/733/ehsi/dh_pt_act","writable") -- pilot side decision hide
dataref("batt_state", "ixeg/733/electrical/elec_batt_on_act", "writable") -- batt state
dataref("gpu_state", "ixeg/733/electrical/elec_grd_pwr_on_act", "writable") -- gpu switch state
--dataref("apu_state", "ixeg/733/apu/apu_start_switch_act","writable") -- apu switch state
--dataref("ign_switch_pos", "ixeg/733/engine/ign_select_act", "writable") -- ignition switch position
dataref("fuel_lever_eng1", "ixeg/733/fuel/fuel_start_lever1_act", "readonly") -- fuel lever position eng 1
dataref("fuel_lever_eng2", "ixeg/733/fuel/fuel_start_lever2_act", "readonly") -- fuel lever position eng 2
dataref("starter_pos_eng1", "ixeg/733/engine/eng1_start_act","readonly") -- eng 1 starter position
dataref("starter_pos_eng2", "ixeg/733/engine/eng2_start_act","readonly") -- eng 2 starter position
dataref("irs_left_state", "ixeg/733/irs/irs_left_mode_act", "writable") -- left irs mode 
dataref("irs_right_state", "ixeg/733/irs/irs_right_mode_act", "writable") -- right irs mode
dataref("left_pack_mode", "ixeg/733/bleedair/bleedair_lpack_act", "writable")  -- left packs mode
dataref("right_pack_mode", "ixeg/733/bleedair/bleedair_rpack_act", "writable")  -- right packs mode
dataref("iso_valve_mode", "ixeg/733/bleedair/bleedair_isovalve_act", "writable")  -- iso valve mode
dataref("man_cabin_pressure_toggle", "ixeg/733/pressurization/cabin_manual_act", "writable")  -- toggle between open and close
dataref("cabin_pressure_mode", "ixeg/733/pressurization/cabin_mode_act", "writable")  -- cabin pressure mode



--------CUSTOM COMMANDS

function activate_toga()

	set("ixeg/733/MCP/mcp_toga_act", 1.0)

end
create_command("WeisAIR/b733/activate_toga", "activate_toga", "activate_toga()", "", "")

function toggle_fire_test()

	if(fire_test == 0.0) then set("ixeg/733/firewarning/fire_ovht_test_act", 1.0)
		else set("ixeg/733/firewarning/fire_ovht_test_act", 0.0)
	end
end
create_command("WeisAIR/b733/toggle_fire_test", "toggle_fire_test", "toggle_fire_test()", "", "")

function inc_pilot_dh()

	new_val = pilot_dh + 1.0

	if(new_val < 1000.0) then set("ixeg/733/ehsi/dh_pt_act", new_val)	end
end
create_command("WeisAIR/b733/ehsi/inc_pilot_dh", "inc_pilot_dh", "inc_pilot_dh()", "", "")

function dec_pilot_dh()

	new_val = pilot_dh - 1.0

	if(new_val > -21.0) then set("ixeg/733/ehsi/dh_pt_act", new_val)	end
end
create_command("WeisAIR/b733/ehsi/dec_pilot_dh", "dec_pilot_dh", "dec_pilot_dh()", "", "")

function fire_test_start()

	set("ixeg/733/firewarning/fire_ovht_test_act", 1.0)
end
function fire_test_end()

	set("ixeg/733/firewarning/fire_ovht_test_act", 0.0)
end
create_command("WeisAIR/b733/fire_test", "fire_test", "fire_test_start()", "", "fire_test_end()")

function ovhd_annun_test_start()

	set("ixeg/733/caution/caution_lights_test", 1.0)
end
create_command("WeisAIR/b733/ovhd_annun_test_start", "ovhd_annun_test_start", "ovhd_annun_test_start()", "", "")

function ovhd_annun_test_end()

	set("ixeg/733/caution/caution_lights_test", 0.0)
end
create_command("WeisAIR/b733/ovhd_annun_test_end", "ovhd_annun_test_end", "ovhd_annun_test_end()", "", "")


function b733_cockpit_inc_background_light()
		
	dataref("panel_brightness_background", "ixeg/733/lighting/light_main_background", "writable")
	set("ixeg/733/lighting/light_main_background", panel_brightness_background + 0.005)
	
end
create_command("WeisAIR/b733/LIGHTS/b733_cockpit_inc_background_light", "b733_cockpit_inc_background_light", "b733_cockpit_inc_background_light()", "", "")

function b733_cockpit_dec_background_light()		
		
	dataref("panel_brightness_background", "ixeg/733/lighting/light_main_background", "writable")
	set("ixeg/733/lighting/light_main_background", panel_brightness_background - 0.005)
	
end
create_command("WeisAIR/b733/LIGHTS/b733_cockpit_dec_background_light", "b733_cockpit_dec_background_light", "b733_cockpit_dec_background_light()", "", "")

function b733_cockpit_lights_max()
		
	dataref("panel_brightness_background", "ixeg/733/lighting/light_main_background", "writable")
	dataref("panel_brightness_panel", "sim/cockpit/electrical/instrument_brightness", "writable")
	dataref("panel_brightness_afds", "ixeg/733/rheostats/light_afds_act", "writable")
	dataref("panel_brightness_pedflood", "ixeg/733/lighting/light_pedflood", "writable")
	dataref("panel_brightness_pedpanel", "ixeg/733/lighting/light_pedpanel", "writable")
	dataref("panel_brightness_main_copilot_side"	,"ixeg/733/lighting/light_main_copilot_side", "writable")		 
	dataref("panel_brightness_main_pilot_side"		,"ixeg/733/lighting/light_main_pilot_side", "writable")			 
	dataref("panel_brightness_breakers"				,"ixeg/733/rheostats/light_breakers_act", "writable")			 
	dataref("panel_brightness_overhead"				,"ixeg/733/rheostats/light_overhead_act", "writable")			 
	dataref("panel_brightness_dome_light"			,"ixeg/733/misc/dome_light_act", "writable")
	dataref("panel_brightness_map_cpt"				,"ixeg/733/rheostats/light_mapbr_cpt_act", "writable")	
	dataref("panel_brightness_map_pt"				,"ixeg/733/rheostats/light_mapbr_pt_act", "writable")
	
	set("ixeg/733/lighting/light_main_background", 0.03370455) -- 0.042866006
	set("sim/cockpit/electrical/instrument_brightness",	1.0 )
	set("ixeg/733/rheostats/light_afds_act",	1.0 )
	set("ixeg/733/lighting/light_pedflood", 0.033941127)
	set("ixeg/733/lighting/light_pedpanel", 0.033941127)
	set("ixeg/733/lighting/light_main_copilot_side", 0.04126876) 	
	set("ixeg/733/lighting/light_main_pilot_side", 0.04126876)		
	set("ixeg/733/rheostats/light_breakers_act", 1.0)		
	set("ixeg/733/rheostats/light_overhead_act", 1.0)		
	set("ixeg/733/misc/dome_light_act", 1.0)				
	set("ixeg/733/rheostats/light_mapbr_cpt_act", 1.0)
	set("ixeg/733/rheostats/light_mapbr_pt_act", 1.0)
	
end
create_command("WeisAIR/b733/LIGHTS/cockpit_lights_max", "b733_cockpit_lights_max", "b733_cockpit_lights_max()", "", "")

function b733_cockpit_lights_off()
		
	dataref("panel_brightness_background", "ixeg/733/lighting/light_main_background", "writable")
	dataref("panel_brightness_panel", "sim/cockpit/electrical/instrument_brightness", "writable")
	dataref("panel_brightness_afds", "ixeg/733/rheostats/light_afds_act", "writable")
	dataref("panel_brightness_pedflood", "ixeg/733/lighting/light_pedflood", "writable")
	dataref("panel_brightness_pedpanel", "ixeg/733/lighting/light_pedpanel", "writable")
	dataref("panel_brightness_main_copilot_side"	,"ixeg/733/lighting/light_main_copilot_side", "writable")		 
	dataref("panel_brightness_main_pilot_side"		,"ixeg/733/lighting/light_main_pilot_side", "writable")			 
	dataref("panel_brightness_breakers"				,"ixeg/733/rheostats/light_breakers_act", "writable")			 
	dataref("panel_brightness_overhead"				,"ixeg/733/rheostats/light_overhead_act", "writable")			 
	dataref("panel_brightness_dome_light"			,"ixeg/733/misc/dome_light_act", "writable")
	dataref("panel_brightness_map_cpt"				,"ixeg/733/rheostats/light_mapbr_cpt_act", "writable")	
	dataref("panel_brightness_map_pt"				,"ixeg/733/rheostats/light_mapbr_pt_act", "writable")
	
	set("ixeg/733/lighting/light_main_background",	0.0 )
	set("sim/cockpit/electrical/instrument_brightness",	0.0 )
	set("ixeg/733/rheostats/light_afds_act",	0.0 )	
	set("ixeg/733/lighting/light_pedflood", 0.0)
	set("ixeg/733/lighting/light_pedpanel", 0.0)
	set("ixeg/733/lighting/light_main_copilot_side", 0.0)	
	set("ixeg/733/lighting/light_main_pilot_side", 0.0)	
	set("ixeg/733/rheostats/light_breakers_act", 0.0)		
	set("ixeg/733/rheostats/light_overhead_act", 0.0)		
	set("ixeg/733/misc/dome_light_act", 0.0)
	set("ixeg/733/rheostats/light_mapbr_cpt_act", 0.0)
	set("ixeg/733/rheostats/light_mapbr_pt_act", 0.0)
end
create_command("WeisAIR/b733/LIGHTS/cockpit_lights_off", "b733_cockpit_lights_off", "b733_cockpit_lights_off()", "", "")

function crs_1_inc()
	dataref("crs1_act", "ixeg/733/MCP/mcp_plt_course_act", "writable")
	
	new_val = crs1_act + 1.0
	if (new_val < 360.0) then set("ixeg/733/MCP/mcp_plt_course_act", new_val) 
		else set("ixeg/733/MCP/mcp_plt_course_act", 360.0-new_val)
	end
	
end
create_command("WeisAIR/b733/mcp/crs_1_inc", "crs_1_inc", "crs_1_inc()", "", "")

function crs_1_dec()
	dataref("crs1_act", "ixeg/733/MCP/mcp_plt_course_act", "writable")
	
	new_val = crs1_act - 1.0
	if (new_val > 0.0) then set("ixeg/733/MCP/mcp_plt_course_act", new_val) 
		else set("ixeg/733/MCP/mcp_plt_course_act", 360.0+new_val)
	end
	
end
create_command("WeisAIR/b733/mcp/crs_1_dec", "crs_1_dec", "crs_1_dec()", "", "")

function crs_2_inc()
	dataref("crs2_act", "ixeg/733/MCP/mcp_cplt_course_act", "writable")
	
	new_val = crs2_act + 1.0
	if (new_val < 360.0) then set("ixeg/733/MCP/mcp_cplt_course_act", new_val) 
		else set("ixeg/733/MCP/mcp_cplt_course_act", 360.0-new_val)
	end
	
end
create_command("WeisAIR/b733/mcp/crs_2_inc", "crs_2_inc", "crs_2_inc()", "", "")

function crs_2_dec()
	dataref("crs2_act", "ixeg/733/MCP/mcp_cplt_course_act", "writable")
	
	new_val = crs2_act - 1.0
	if (new_val > 0.0) then set("ixeg/733/MCP/mcp_cplt_course_act", new_val) 
		else set("ixeg/733/MCP/mcp_cplt_course_act", 360.0+new_val)
	end
	
end
create_command("WeisAIR/b733/mcp/crs_2_dec", "crs_2_dec", "crs_2_dec()", "", "")

	

function toggle_autobrake()

	new_val = autobrakes_mode + 1.0
	if (new_val < 5.0) then set("ixeg/733/hydraulics/hyd_auto_brake_act", new_val) 
		else set("ixeg/733/hydraulics/hyd_auto_brake_act", -1.0)
	end
	
end
create_command("WeisAIR/b733/misc/toggle_autobrake", "toggle_autobrake", "toggle_autobrake()", "", "")


function alt_inc_1000()
	--dataref("alt_act_1000_inc", "sim/cockpit/autopilot/altitude", "writable")
	--new_val = alt_act_1000_inc + 1000.0

	new_val = alt_act + 1000.0
	set("sim/cockpit/autopilot/altitude", new_val) 
end
create_command("WeisAIR/b733/mcp/alt_inc_1000", "alt_inc_1000", "alt_inc_1000()", "", "")

function alt_inc_100()
	--dataref("alt_act_100_inc", "sim/cockpit/autopilot/altitude", "writable")
	--new_val = alt_act_100_inc + 100.0
	
	new_val = alt_act + 100.0
	set("sim/cockpit/autopilot/altitude", new_val) 
end
create_command("WeisAIR/b733/mcp/alt_inc_100", "alt_inc_100", "alt_inc_100()", "", "")

function alt_dec_1000()
	--dataref("alt_act_1000_dec", "sim/cockpit/autopilot/altitude", "writable")
	--new_val = alt_act_1000_dec - 1000.0

	new_val = alt_act - 1000.0
	if (new_val > 0) then set("sim/cockpit/autopilot/altitude", new_val) end
end
create_command("WeisAIR/b733/mcp/alt_dec_1000", "alt_dec_1000", "alt_dec_1000()", "", "")

function alt_dec_100()
	--dataref("alt_act_100_dec", "sim/cockpit/autopilot/altitude", "writable")
	--new_val = alt_act_100_dec - 100.0

	new_val = alt_act - 100.0
	if (new_val > 0) then set("sim/cockpit/autopilot/altitude", new_val) end
end
create_command("WeisAIR/b733/mcp/alt_dec_100", "alt_dec_100", "alt_dec_100()", "", "")


function inc_flt_alt()
	new_val = flt_alt_250 + 0.25
	set("ixeg/733/pressurization/cabin_auto_flt_alt_kft_act", new_val) 
end
create_command("WeisAIR/b733/pressure/inc_flt_alt", "inc_flt_alt", "inc_flt_alt()", "", "")

function dec_flt_alt()
	new_val = flt_alt_250 - 0.25
	set("ixeg/733/pressurization/cabin_auto_flt_alt_kft_act", new_val) 
end
create_command("WeisAIR/b733/pressure/dec_flt_alt", "dec_flt_alt", "dec_flt_alt()", "", "")

function inc_land_alt()
	new_val = land_alt_500 + 0.5
	if (new_val <14.0) then	set("ixeg/733/pressurization/cabin_auto_land_alt_kft_act", new_val) end 
end
create_command("WeisAIR/b733/pressure/inc_land_alt", "inc_land_alt", "inc_land_alt()", "", "")

function dec_land_alt()
	new_val = land_alt_500 - 0.5
	if (new_val >-1.5)	then set("ixeg/733/pressurization/cabin_auto_land_alt_kft_act", new_val) end 
end
create_command("WeisAIR/b733/pressure/dec_land_alt", "dec_land_alt", "dec_land_alt()", "", "")

function range_inc()
	dataref("range", "ixeg/733/ehsi/ehsi_range_pt_act", "writable")
	
	range_current = range
	range_new = range + 1.0
	
	if (range_new >= 0.0 and range_new <= 5.0) then set("ixeg/733/ehsi/ehsi_range_pt_act", range_new) end
	
end
create_command("WeisAIR/b733/EHSI/range_inc", "range_inc", "range_inc()", "", "")

function range_dec()
	dataref("range", "ixeg/733/ehsi/ehsi_range_pt_act", "writable")
	
	range_current = range
	range_new = range - 1.0
	
	if (range_new >= 0.0 and range_new <= 5.0) then set("ixeg/733/ehsi/ehsi_range_pt_act", range_new) end
	
end
create_command("WeisAIR/b733/EHSI/range_dec", "range_dec", "range_dec()", "", "")


function map_mode_inc()
	dataref("map_mode", "ixeg/733/ehsi/ehsi_mode_pt_act", "writable")
	
	map_mode_current = map_mode
	map_mode_new = map_mode + 1.0
	
	if (map_mode_new >= 0.0 and map_mode_new <= 4.0) then set("ixeg/733/ehsi/ehsi_mode_pt_act", map_mode_new) end
	
end
create_command("WeisAIR/b733/EHSI/map_mode_inc", "map_mode_inc", "map_mode_inc()", "", "")

function map_mode_dec()
	dataref("map_mode", "ixeg/733/ehsi/ehsi_mode_pt_act", "writable")
	
	map_mode_current = map_mode
	map_mode_new = map_mode - 1.0
	
	if (map_mode_new >= 0.0 and map_mode_new <= 4.0) then set("ixeg/733/ehsi/ehsi_mode_pt_act", map_mode_new) end
	
end
create_command("WeisAIR/b733/EHSI/map_mode_dec", "map_mode_dec", "map_mode_dec()", "", "")


function b733_wipersUp()
	dataref("wipers_pos", "ixeg/733/wiper/wiper_speed_act", "writable")
	
	if (wipers_pos < 2.0) then set("ixeg/733/wiper/wiper_speed_act", wipers_pos + 1.0) end
	

end
create_command("WeisAIR/b733/overhead/wipersUp", "wipersUp", "b733_wipersUp()", "", "")

function b733_wipersDn()
	dataref("wipers_pos", "ixeg/733/wiper/wiper_speed_act", "writable")
	
	if (wipers_pos >= 0.0) then set("ixeg/733/wiper/wiper_speed_act", wipers_pos - 1.0) end
	

end
create_command("WeisAIR/b733/overhead/wipersDn", "wipersDn", "b733_wipersDn()", "", "")


function b733_land_lights_on()
	
		set("ixeg/733/lighting/r_outboard_ll_act",1.0)
		set("ixeg/733/lighting/r_inboard_ll_act",1.0)
		set("ixeg/733/lighting/l_inboard_ll_act",1.0)
		set("ixeg/733/lighting/l_outboard_ll_act",1.0)
	
end
create_command("WeisAIR/b733/lights/land_lights_on", "land_lights_on", "b733_land_lights_on()", "", "")


function b733_land_lights_off()
		
		set("ixeg/733/lighting/r_outboard_ll_act",0.0)
		set("ixeg/733/lighting/r_inboard_ll_act",0.0)
		set("ixeg/733/lighting/l_inboard_ll_act",0.0)
		set("ixeg/733/lighting/l_outboard_ll_act",0.0)
	
end
create_command("WeisAIR/b733/lights/land_lights_off", "land_lights_off", "b733_land_lights_off()", "", "")

function b733_land_lights_toggle()
		
	dataref("ll_ro", "ixeg/733/lighting/r_outboard_ll_act","writable")
	dataref("ll_ri", "ixeg/733/lighting/r_inboard_ll_act","writable")  
	dataref("ll_li", "ixeg/733/lighting/l_inboard_ll_act","writable")  
	dataref("ll_lo", "ixeg/733/lighting/l_outboard_ll_act","writable")  

	if (ll_ro == 2.0) then set("ixeg/733/lighting/r_outboard_ll_act",0.0) else set("ixeg/733/lighting/r_outboard_ll_act",2.0) end
	if (ll_ri == 2.0) then set("ixeg/733/lighting/r_inboard_ll_act",0.0) else set("ixeg/733/lighting/r_inboard_ll_act",2.0) end
	if (ll_li == 2.0) then set("ixeg/733/lighting/l_inboard_ll_act",0.0) else set("ixeg/733/lighting/l_inboard_ll_act",2.0) end
	if (ll_lo == 2.0) then set("ixeg/733/lighting/l_outboard_ll_act",0.0) else set("ixeg/733/lighting/l_outboard_ll_act",2.0) end
	
end
create_command("WeisAIR/b733/lights/b733_land_lights_toggle", "b733_land_lights_toggle", "b733_land_lights_toggle()", "", "")

function rwto_lights_off()
	
		set("ixeg/733/lighting/l_rwy_turnoff_act",0.0)
		set("ixeg/733/lighting/r_rwy_turnoff_act",0.0)

end
create_command("WeisAIR/b733/lights/rwto_lights_off", "rwto_lights_off", "rwto_lights_off()", "", "")

function rwto_lights_on()
	
		set("ixeg/733/lighting/l_rwy_turnoff_act",1.0)
		set("ixeg/733/lighting/r_rwy_turnoff_act",1.0)

end
create_command("WeisAIR/b733/lights/rwto_lights_on", "rwto_lights_on", "rwto_lights_on()", "", "")

function pos_lights_toggle()
	
		dataref("pos_light_state", "ixeg/733/lighting/position_lt_act", "writable")
		
		new_val = pos_light_state + 1.0

		if (new_val < 2.0) then set("ixeg/733/lighting/position_lt_act",new_val)
		else set("ixeg/733/lighting/position_lt_act",-1.0)
		end

end
create_command("WeisAIR/b733/lights/pos_lights_toggle", "pos_lights_toggle", "pos_lights_toggle()", "", "")

function fire_warn_push()
	
	set("ixeg/733/firewarning/fire_bell_co_pt_act",1.0)
	
end
create_command("WeisAIR/b733/mcp/fire_warn_push", "fire_warn_push", "b733_fire_warn_push()", "", "")

function fire_warn_release()
	
	set("ixeg/733/firewarning/fire_bell_co_pt_act",0.0)
	
end
create_command("WeisAIR/b733/mcp/fire_warn_release", "fire_warn_release", "fire_warn_release()", "", "")

function master_caution_push()
	
	set("ixeg/733/caution/caution_reset_act",1.0)
	
end
create_command("WeisAIR/b733/mcp/master_caution_push", "master_caution_push", "master_caution_push()", "", "")

function master_caution_release()
	
	set("ixeg/733/caution/caution_reset_act",0.0)
	
end
create_command("WeisAIR/b733/mcp/master_caution_release", "master_caution_release", "master_caution_release()", "", "")

function sixpack_pilot_recall_push()
	
	set("ixeg/733/caution/caution_recall_act",1.0)
	
end
create_command("WeisAIR/b733/mcp/sixpack_pilot_recall_push", "sixpack_pilot_recall_push", "sixpack_pilot_recall_push()", "", "")

function sixpack_pilot_recall_release()
	
	set("ixeg/733/caution/caution_recall_act",0.0)
	
end
create_command("WeisAIR/b733/mcp/sixpack_pilot_recall_release", "sixpack_pilot_recall_release", "sixpack_pilot_recall_release()", "", "")


function sixpack_copilot_recall_push()
	
	set("ixeg/733/caution/caution_recall_cpt_act",1.0)
	
end
create_command("WeisAIR/b733/mcp/sixpack_copilot_recall_push", "sixpack_copilot_recall_push", "sixpack_copilot_recall_push()", "", "")

function sixpack_copilot_recall_release()
	
	set("ixeg/733/caution/caution_recall_cpt_act",0.0)
	
end
create_command("WeisAIR/b733/mcp/sixpack_copilot_recall_release", "sixpack_copilot_recall_release", "sixpack_copilot_recall_release()", "", "")

function ap_prst_push()
	set("ixeg/733/caution/caution_ap_rst_act",1.0)
end
create_command("WeisAIR/b733/mcp/ap_prst_push", "ap_prst_push", "ap_prst_push()", "", "")

function ap_prst_release()
	set("ixeg/733/caution/caution_ap_rst_act",0.0)
	
end
create_command("WeisAIR/b733/mcp/ap_prst_release", "ap_prst_release", "ap_prst_release()", "", "")

function at_prst_push()
		
	set("ixeg/733/caution/caution_at_rst_act",1.0)
	
end
create_command("WeisAIR/b733/mcp/at_prst_push", "at_prst_push", "at_prst_push()", "", "")

function at_prst_release()
	
	set("ixeg/733/caution/caution_at_rst_act",0.0)
	
end
create_command("WeisAIR/b733/mcp/at_prst_release", "at_prst_release", "at_prst_release()", "", "")

function fmc_prst_push()
		
	set("ixeg/733/caution/caution_fmc_rst_act",1.0)
	
end
create_command("WeisAIR/b733/mcp/fmc_prst_push", "fmc_prst_push", "fmc_prst_push()", "", "")

function fmc_prst_release()
	
	set("ixeg/733/caution/caution_fmc_rst_act",0.0)
	
end
create_command("WeisAIR/b733/mcp/fmc_prst_release", "fmc_prst_release", "fmc_prst_release()", "", "")

function below_gs_push()
	
	set("ixeg/733/misc/egpws_gs_act",1.0)
	
end
create_command("WeisAIR/b733/mcp/below_gs_push", "below_gs_push", "below_gs_push()", "", "")

function below_gs_release()
	
	set("ixeg/733/misc/egpws_gs_act",0.0)
	
end
create_command("WeisAIR/b733/mcp/below_gs_release", "below_gs_release", "below_gs_release()", "", "")

function b733_flight_directors_on()
	dataref("wipers_pos", "ixeg/733/wiper/wiper_speed_act", "writable")
	
	dataref("fd_cpt_state", "ixeg/733/MCP/mcp_plt_fd_act", "writable")
	dataref("fd_fo_state", "ixeg/733/MCP/mcp_cplt_fd_act", "writable")
	
	if (fd_cpt_state < 1.0 or fd_fo_state < 1.0) then 
		
		set("ixeg/733/MCP/mcp_plt_fd_act",1.0)
		set("ixeg/733/MCP/mcp_cplt_fd_act",1.0)
		
	end
	
end
create_command("WeisAIR/b733/mcp/flight_directors_on", "flight_directors_on", "flight_directors_on()", "", "")


function b733_flight_directors_off()
	dataref("wipers_pos", "ixeg/733/wiper/wiper_speed_act", "writable")
	
	dataref("fd_cpt_state", "ixeg/733/MCP/mcp_plt_fd_act", "writable")
	dataref("fd_fo_state", "ixeg/733/MCP/mcp_cplt_fd_act", "writable")
	
	if (fd_cpt_state > 0.0 or fd_fo_state > 0.0) then 
		
		set("ixeg/733/MCP/mcp_plt_fd_act",0.0)
		set("ixeg/733/MCP/mcp_cplt_fd_act",0.0)
		
	end
	
end
create_command("WeisAIR/b733/mcp/flight_directors_off", "flight_directors_off", "b733_flight_directors_off()", "", "")

function b733_flight_directors_toggle()
	dataref("wipers_pos", "ixeg/733/wiper/wiper_speed_act", "writable")
	
	dataref("fd_cpt_state", "ixeg/733/MCP/mcp_plt_fd_act", "writable")
	dataref("fd_fo_state", "ixeg/733/MCP/mcp_cplt_fd_act", "writable")
	
	if (fd_cpt_state > 0.0 or fd_fo_state > 0.0) then 
		
		set("ixeg/733/MCP/mcp_plt_fd_act",0.0)
		set("ixeg/733/MCP/mcp_cplt_fd_act",0.0)
		
	else
		
		set("ixeg/733/MCP/mcp_plt_fd_act",1.0)
		set("ixeg/733/MCP/mcp_cplt_fd_act",1.0)
		
	end
	
	
end
create_command("WeisAIR/b733/mcp/flight_directors_toggle", "flight_directors_toggle", "b733_flight_directors_toggle()", "", "")

function b733_auto_throttle_on()
	dataref("athr_state", "ixeg/733/MCP/mcp_at_arm_act", "writable")
	if (athr_state < 1.0) then 	set("ixeg/733/MCP/mcp_at_arm_act",1.0)	end
	
end
create_command("WeisAIR/b733/mcp/auto_throttle_on", "auto_throttle_on", "b733_auto_throttle_on()", "", "")


function b733_auto_throttle_off()
	dataref("athr_state", "ixeg/733/MCP/mcp_at_arm_act", "writable")
	if (athr_state > 0.0) then 	set("ixeg/733/MCP/mcp_at_arm_act",0.0)	end
end
create_command("WeisAIR/b733/mcp/auto_throttle_off", "auto_throttle_off", "b733_auto_throttle_off()", "", "")


--ToDo: switch needs to jump back
--ToDo: GND connection through IXEG menue not realiably reflected to detect whether GPU is connected or not
function b733_gpu_on()

	set("ixeg/733/electrical/elec_grd_pwr_on_act",1.0)
	
end
create_command("WeisAIR/b733/elec/gpu_on", "gpu_on", "b733_gpu_on()", "", "")

function b733_gpu_off()

	set("ixeg/733/electrical/elec_grd_pwr_on_act",-1.0)
	
end
create_command("WeisAIR/b733/elec/gpu_off", "gpu_off", "b733_gpu_off()", "", "")

function toggle_apu()

	if (apu_state == -1.0) then set("ixeg/733/apu/apu_start_switch_act",-0.0)
	else set("ixeg/733/apu/apu_start_switch_act",-1.0)
	end
	
end
create_command("WeisAIR/b733/elec/toggle_apu", "toggle_apu", "toggle_apu()", "", "")

function toggle_ign_switch()

	if (ign_switch_pos == -1.0) 
		then set("ixeg/733/engine/ign_select_act",0.0) 
			elseif (ign_switch_pos == 0.0) 
				then set("ixeg/733/engine/ign_select_act",1.0)
	else set("ixeg/733/engine/ign_select_act",-1.0)
	end
	
end
create_command("WeisAIR/b733/eng/toggle_ign_switch", "toggle_ign_switch", "toggle_ign_switch()", "", "")

function eng1_fuel_lever_idle()

	set("ixeg/733/fuel/fuel_start_lever1_act",1.0)
	
end
create_command("WeisAIR/b733/eng/eng1_fuel_lever_idle", "eng1_fuel_lever_idle", "eng1_fuel_lever_idle()", "", "")

function eng1_fuel_lever_cutoff()

	set("ixeg/733/fuel/fuel_start_lever1_act",0.0)
	
end
create_command("WeisAIR/b733/eng/eng1_fuel_lever_idle", "eng1_fuel_lever_idle", "eng1_fuel_lever_idle()", "", "")

function eng2_fuel_lever_idle()

	set("ixeg/733/fuel/fuel_start_lever2_act",1.0)
	
end
create_command("WeisAIR/b733/eng/eng2_fuel_lever_idle", "eng2_fuel_lever_idle", "eng2_fuel_lever_idle()", "", "")

function eng2_fuel_lever_cutoff()

	set("ixeg/733/fuel/fuel_start_lever2_act",0.0)
	
end
create_command("WeisAIR/b733/eng/eng2_fuel_lever_cutoff", "eng2_fuel_lever_cutoff", "eng2_fuel_lever_cutoff()", "", "")

function eng1_fuel_lever_toogle()

	if(fuel_lever_eng1 == 0.0) then command_once("ixeg/733/engines/left_fuel_lever_to_idle")
	else command_once("ixeg/733/engines/left_fuel_lever_to_cutoff")
	end
	
end
create_command("WeisAIR/b733/eng/eng1_fuel_lever_toogle", "eng1_fuel_lever_toogle", "eng1_fuel_lever_toogle()", "", "")


--todo: toggle back to 0.0 does apparently not work
function eng2_fuel_lever_toogle()

	if(fuel_lever_eng2 == 0.0) then command_once("ixeg/733/engines/right_fuel_lever_to_idle")
	else command_once("ixeg/733/engines/right_fuel_lever_to_cutoff")
	end
	
end
create_command("WeisAIR/b733/eng/eng2_fuel_lever_toogle", "eng2_fuel_lever_toogle", "eng2_fuel_lever_toogle()", "", "")


function inc_eng1_starter_pos()
	
	if(starter_pos_eng1 == -1.0) then command_once("ixeg/733/overhead/left_engine_startswitch_to_OFF")
	elseif (starter_pos_eng1 == 0.0) then command_once("ixeg/733/overhead/left_engine_startswitch_to_CONT")
	elseif (starter_pos_eng1 == 1.0) then command_once("ixeg/733/overhead/left_engine_startswitch_to_FLT")
	else command_once("ixeg/733/overhead/left_engine_startswitch_to_FLT")
	end
	
end
create_command("WeisAIR/b733/eng/inc_eng1_starter_pos", "inc_eng1_starter_pos", "inc_eng1_starter_pos()", "", "")

function inc_eng2_starter_pos()

	if(starter_pos_eng2 == -1.0) then command_once("ixeg/733/overhead/right_engine_startswitch_to_OFF")
	elseif (starter_pos_eng2 == 0.0) then command_once("ixeg/733/overhead/right_engine_startswitch_to_CONT")
	elseif (starter_pos_eng2 == 1.0) then command_once("ixeg/733/overhead/right_engine_startswitch_to_FLT")
	else command_once("ixeg/733/overhead/right_engine_startswitch_to_FLT")
	end
	
end
create_command("WeisAIR/b733/eng/inc_eng2_starter_pos", "inc_eng2_starter_pos", "inc_eng2_starter_pos()", "", "")


function dec_eng1_starter_pos()

	if(starter_pos_eng1 == 2.0) then command_once("ixeg/733/overhead/left_engine_startswitch_to_CONT")
	elseif (starter_pos_eng1 == 1.0) then command_once("ixeg/733/overhead/left_engine_startswitch_to_OFF")
	elseif (starter_pos_eng1 == 0.0) then command_once("ixeg/733/overhead/left_engine_startswitch_to_GRD")
	else command_once("ixeg/733/overhead/left_engine_startswitch_to_GRD")
	end
	
end
create_command("WeisAIR/b733/eng/dec_eng1_starter_pos", "dec_eng1_starter_pos", "dec_eng1_starter_pos()", "", "")

function dec_eng2_starter_pos()

	if(starter_pos_eng2 == 2.0) then command_once("ixeg/733/overhead/right_engine_startswitch_to_CONT")
	elseif (starter_pos_eng2 == 1.0) then command_once("ixeg/733/overhead/right_engine_startswitch_to_OFF")
	elseif (starter_pos_eng2 == 0.0) then command_once("ixeg/733/overhead/right_engine_startswitch_to_GRD")
	else command_once("ixeg/733/overhead/right_engine_startswitch_to_GRD")
	end	
end
create_command("WeisAIR/b733/eng/dec_eng2_starter_pos", "dec_eng2_starter_pos", "dec_eng2_starter_pos()", "", "")

function apu_gens_on_press()

	set("ixeg/733/electrical/elec_apu_gen1_onoff_act",1.0)
	set("ixeg/733/electrical/elec_apu_gen2_onoff_act",1.0)
	
end
function apu_gens_on_release()

	set("ixeg/733/electrical/elec_apu_gen1_onoff_act",0.0)
	set("ixeg/733/electrical/elec_apu_gen2_onoff_act",0.0)
	
end
create_command("WeisAIR/b733/elec/apu_gens_on", "apu_gens_on", "apu_gens_on_press()", "", "apu_gens_on_release()")

function apu_gens_off_press()

	set("ixeg/733/electrical/elec_apu_gen1_onoff_act",-1.0)
	set("ixeg/733/electrical/elec_apu_gen2_onoff_act",-1.0)
	
end
function apu_gens_off_release()

	set("ixeg/733/electrical/elec_apu_gen1_onoff_act",0.0)
	set("ixeg/733/electrical/elec_apu_gen2_onoff_act",0.0)
	
end
create_command("WeisAIR/b733/elec/apu_gens_off", "apu_gens_off", "apu_gens_off_press()", "", "apu_gens_off_release()")

function eng1_gen_on_press()

	set("ixeg/733/electrical/elec_gen1_onoff_act",1.0)
	
end
function eng1_gen_on_release()

	set("ixeg/733/electrical/elec_gen1_onoff_act",0.0)
	
end
create_command("WeisAIR/b733/elec/eng1_gen_on", "eng1_gen_on", "eng1_gen_on_press()", "", "eng1_gen_on_release()")

function eng1_gen_off_press()

	set("ixeg/733/electrical/elec_gen1_onoff_act",-1.0)
	
end
function eng1_gen_off_release()

	set("ixeg/733/electrical/elec_gen1_onoff_act",0.0)
	
end
create_command("WeisAIR/b733/elec/eng1_gen_off", "eng1_gen_off", "eng1_gen_off_press()", "", "eng1_gen_off_release()")


function start_apu()

	set("ixeg/733/apu/apu_start_switch_act",1.0)
	
end
create_command("WeisAIR/b733/elec/start_apu", "start_apu", "start_apu()", "", "")


--ToDo: guard does not move
function b733_battery_on()
	if (batt_state == 0.0) then	
		set("ixeg/733/electrical/elec_batt_on_act",1.0)	
		set("ixeg/733/electrical/batt_pwr_guard",0.0)
	end
end
create_command("WeisAIR/b733/elec/battery_on", "battery_on", "b733_battery_on()", "", "")


function b733_battery_off()
	if (batt_state == 1.0) then	
		set("ixeg/733/electrical/elec_batt_on_act",0.0)	
		set("ixeg/733/electrical/batt_pwr_guard",1.0)
	end
end
create_command("WeisAIR/b733/elec/battery_off", "battery_off", "b733_battery_off()", "", "")

--ToDo: check states, no smoking switch does not move
function b733_cabin_signs_on()
	dataref("cab_signs_state_1", "ixeg/733/misc/smoking_act", "writable")
	dataref("cab_signs_state_2", "ixeg/733/misc/seatbelt_act", "writable")
	if (cab_signs_state_1 == 0.0) then	set("ixeg/733/misc/smoking_act",2.0)	end
	if (cab_signs_state_2 == 0.0) then	set("ixeg/733/misc/seatbelt_act",2.0)	end
end
create_command("WeisAIR/b733/overhead/cabin_signs_on", "cabin_signs_on", "b733_cabin_signs_on()", "", "")

function b733_cabin_signs_off()
	dataref("cab_signs_state_1", "ixeg/733/misc/smoking_act", "writable")
	dataref("cab_signs_state_2", "ixeg/733/misc/seatbelt_act", "writable")
	if (cab_signs_state_1 == 2.0) then	set("ixeg/733/misc/smoking_act",0.0)	end
	if (cab_signs_state_2 == 2.0) then	set("ixeg/733/misc/seatbelt_act",0.0)	end
end
create_command("WeisAIR/b733/overhead/cabin_signs_off", "cabin_signs_off", "b733_cabin_signs_off()", "", "")


function b733_irs_align()
	if (irs_left_state == 0.0) then	set("ixeg/733/irs/irs_left_mode_act",2.0)	end
	if (irs_right_state == 0.0) then set("ixeg/733/irs/irs_right_mode_act",2.0)	end
end
create_command("WeisAIR/b733/overhead/irs_align", "irs_align", "b733_irs_align()", "", "")

function b733_irs_off()
	if (irs_left_state == 2.0) then	set("ixeg/733/irs/irs_left_mode_act",0.0)	end
	if (irs_right_state == 2.0) then set("ixeg/733/irs/irs_right_mode_act",0.0)	end
end
create_command("WeisAIR/b733/overhead/irs_off", "irs_off", "b733_irs_off()", "", "")

function b733_toggle_irs_left()

	new_state = irs_left_state + 1.0
	
	if (new_state <= 3.0) then	set("ixeg/733/irs/irs_left_mode_act",new_state) 
	else set("ixeg/733/irs/irs_left_mode_act",0.0) 
	end
	
end
create_command("WeisAIR/b733/irs/toggle_irs_left", "b733_toggle_irs_left", "b733_toggle_irs_left()", "", "")

function b733_toggle_irs_right()
		
	new_state = irs_right_state + 1.0
	
	if (new_state <= 3.0) then	set("ixeg/733/irs/irs_right_mode_act",new_state) 
	else set("ixeg/733/irs/irs_right_mode_act",0.0) 
	end
	
end
create_command("WeisAIR/b733/irs/toggle_irs_right", "b733_toggle_irs_right", "b733_toggle_irs_right()", "", "")

function wxr_tilt_up()
	dataref("wxr_tilt", "ixeg/733/wxr/wxr_tilt_act", "writable")

	new_val = wxr_tilt + 0.1
	if (new_val < 15.1) then	set("ixeg/733/wxr/wxr_tilt_act",new_val) end

end
create_command("WeisAIR/ehsi/wxr_tilt_up", "wxr_tilt_up", "wxr_tilt_up()", "", "")

function wxr_tilt_dn()
	dataref("wxr_tilt", "ixeg/733/wxr/wxr_tilt_act", "writable")

	new_val = wxr_tilt - 0.1
	if (new_val > -15.1) then set("ixeg/733/wxr/wxr_tilt_act",new_val) end

end
create_command("WeisAIR/ehsi/wxr_tilt_dn", "wxr_tilt_dn", "wxr_tilt_dn()", "", "")

function wxr_map_on()

	set("ixeg/733/wxr/wxr_onoff_act",1.0)
	set("ixeg/733/wxr/wxr_disp_terrain_act",1.0)

end
create_command("WeisAIR/ehsi/wxr_map_on", "wxr_map_on", "wxr_map_on()", "", "")

function wxr_map_off()

	set("ixeg/733/wxr/wxr_onoff_act",0.0)
	set("ixeg/733/wxr/wxr_disp_terrain_act",0.0)

end
create_command("WeisAIR/ehsi/wxr_map_off", "wxr_map_off", "wxr_map_off()", "", "")

function wxr_map_toggle()
	dataref("wxr_onoff", "ixeg/733/wxr/wxr_onoff_act", "writable")
	dataref("wxr_terr_map", "ixeg/733/wxr/wxr_disp_terrain_act","writable")
	
	if (wxr_onoff == 0.0) then set("ixeg/733/wxr/wxr_onoff_act",1.0)
	else set("ixeg/733/wxr/wxr_onoff_act",0.0)
	end

	if (wxr_terr_map == 0.0) then set("ixeg/733/wxr/wxr_disp_terrain_act",1.0)
	else set("ixeg/733/wxr/wxr_disp_terrain_act",0.0)
	end

end
create_command("WeisAIR/ehsi/wxr_map_toggle", "wxr_map_toggle", "wxr_map_toggle()", "", "")

function transponderUp()	
	
	transponder_new = transponderVal + 1
	
	if (transponder_new < 5) then 
		set("ixeg/733/xpdr/xpdr_mode_act", transponder_new) 
	end	
	
end
create_command("WeisAIR/b733/radios/transponderUp", "transponderUp", "transponderUp()", "", "")

function transponderDn()
	
	transponder_new = transponderVal - 1
	
	if (transponder_new > -1) then 
		set("ixeg/733/xpdr/xpdr_mode_act", transponder_new) 
	end	
	
end
create_command("WeisAIR/b733/radios/transponderDn", "transponderDn", "transponderDn()", "", "")

function toggle_left_pack_modes()

	new_state = left_pack_mode + 1.0	
	if (new_state < 3.0) then set("ixeg/733/bleedair/bleedair_lpack_act", new_state) 
	else set("ixeg/733/bleedair/bleedair_lpack_act", 0.0)
	end	
	
end
create_command("WeisAIR/b733/pressure/toggle_left_pack_modes", "toggle_left_pack_modes", "toggle_left_pack_modes()", "", "")

function toggle_right_pack_modes()
		
	new_state = right_pack_mode + 1.0	
	if (new_state < 3.0) then set("ixeg/733/bleedair/bleedair_rpack_act", new_state) 
	else set("ixeg/733/bleedair/bleedair_rpack_act", 0.0)
	end	
	
end
create_command("WeisAIR/b733/pressure/toggle_right_pack_modes", "toggle_right_pack_modes", "toggle_right_pack_modes()", "", "")


function toggle_isol_valve_modes()
		
	new_state = iso_valve_mode + 1.0	
	if (new_state < 3.0) then set("ixeg/733/bleedair/bleedair_isovalve_act", new_state) 
	else set("ixeg/733/bleedair/bleedair_isovalve_act", 0.0)
	end	
	
	
end
create_command("WeisAIR/b733/pressure/toggle_isol_valve_modes", "toggle_isol_valve_modes", "toggle_isol_valve_modes()", "", "")


function toggle_man_cabin_pressure_valve()
		
	new_state = man_cabin_pressure_toggle + 1.0	
	if (new_state < 2.0) then set("ixeg/733/pressurization/cabin_manual_act", new_state) 
	else set("ixeg/733/pressurization/cabin_manual_act", -1.0)
	end	
		
end
create_command("WeisAIR/b733/pressure/toggle_man_cabin_pressure_valve", "toggle_man_cabin_pressure_valve", "toggle_man_cabin_pressure_valve()", "", "")

function toggle_cabin_pressure_mode()
		
	new_state = cabin_pressure_mode + 1.0	
	if (new_state < 5.0) then set("ixeg/733/pressurization/cabin_mode_act", new_state) 
	else set("ixeg/733/pressurization/cabin_mode_act", 0.0)
	end	
		
end
create_command("WeisAIR/b733/pressure/toggle_cabin_pressure_mode", "toggle_cabin_pressure_mode", "toggle_cabin_pressure_mode()", "", "")