function toggle_brg1()
	
	dataref("brg1_mode", "XCrafts/ERJ/BRG1", "writable")
	
	if brg1_mode < 3 then set("XCrafts/ERJ/BRG1",brg1_mode + 1)
	else set("XCrafts/ERJ/BRG1",1) end

end
create_command("WeisAIR/e170/dcp/toggle_brg1", "toggle_brg1", "toggle_brg1()", "", "")

function toggle_brg2()
	
	dataref("brg2_mode", "XCrafts/ERJ/brg2", "writable")
	
	if brg2_mode < 3 then set("XCrafts/ERJ/brg2",brg2_mode + 1)
	else set("XCrafts/ERJ/brg2",1) end

end
create_command("WeisAIR/e170/dcp/toggle_brg2", "toggle_brg2", "toggle_brg2()", "", "")

function toggle_autobrake()
	
	dataref("autobrake_mode", "sim/cockpit/switches/auto_brake_settings", "writable")
	
	new_ab_mode = autobrake_mode + 1
	if new_ab_mode == 6 then set("sim/cockpit/switches/auto_brake_settings",0)
		else if new_ab_mode ~=2 then set("sim/cockpit/switches/auto_brake_settings",new_ab_mode)
			else set("sim/cockpit/switches/auto_brake_settings",3)
		end
	end

end
create_command("WeisAIR/e170/misc/toggle_autobrake", "toggle_autobrake", "toggle_autobrake()", "", "")

function toggle_ac_bus_ties_switch()
	
	dataref("ac_bus_ties_state", "XCrafts/electrical/ac_bus_tie_switch", "writable")
	
	new_bt_state = ac_bus_ties_state + 1
	if new_bt_state <3 then set("XCrafts/electrical/ac_bus_tie_switch",new_bt_state)
		else set("XCrafts/electrical/ac_bus_tie_switch",0)
	end

end
create_command("WeisAIR/e170/energy/toggle_ac_bus_ties_switch", "toggle_ac_bus_ties_switch", "toggle_ac_bus_ties_switch()", "", "")

function toggle_emer_exit_lights()
	
	dataref("emer_exit_lights_state", "XCrafts/light/emerg_switch", "writable")
	
	new_emer_exit_lights_state = emer_exit_lights_state + 1
	if new_emer_exit_lights_state <3 then set("XCrafts/light/emerg_switch",new_emer_exit_lights_state)
		else set("XCrafts/light/emerg_switch",0)
	end

end
create_command("WeisAIR/e170/lights/toggle_emer_exit_lights", "toggle_emer_exit_lights", "toggle_emer_exit_lights()", "", "")



function pass_signes_on()	
	
	set("sim/cockpit/switches/fasten_seat_belts",2)
	set("sim/cockpit/switches/no_smoking",2)

end
create_command("WeisAIR/e170/misc/pass_signes_on", "pass_signes_on", "pass_signes_on()", "", "")

function pass_signes_off()	
	
	set("sim/cockpit/switches/fasten_seat_belts",0)
	set("sim/cockpit/switches/no_smoking",0)

end
create_command("WeisAIR/e170/misc/pass_signes_off", "pass_signes_off", "pass_signes_off()", "", "")




function map_range_dec()
	
	dataref("map_range", "sim/cockpit/switches/EFIS_map_range_selector", "writable")
	
	inc_map_range = map_range + 1
	if inc_map_range <7 then set("sim/cockpit/switches/EFIS_map_range_selector",inc_map_range)	end

end
create_command("WeisAIR/e170/map/map_range_dec", "map_range_dec", "map_range_dec()", "", "")

function map_range_inc()
	
	dataref("map_range", "sim/cockpit/switches/EFIS_map_range_selector", "writable")
	
	dec_map_range = map_range - 1
	if dec_map_range >=0 then set("sim/cockpit/switches/EFIS_map_range_selector",dec_map_range)	end

end
create_command("WeisAIR/e170/map/map_range_inc", "map_range_inc", "map_range_inc()", "", "")



function minimums_set_RA()	
	
	set("XCrafts/ERJ/RA_BARO_Mins",0)
end
create_command("WeisAIR/e170/dcp/minimums_set_RA", "minimums_set_RA", "minimums_set_RA()", "", "")

function minimums_set_BARO()	
	
	set("XCrafts/ERJ/RA_BARO_Mins",1)
end
create_command("WeisAIR/e170/dcp/minimums_set_BARO", "minimums_set_BARO", "minimums_set_BARO()", "", "")

function minimums_inc()	
	
	dataref("mins_value_baro", "XCrafts/ERJ/baro_altimeter_minimums", "writable")
	--dataref("mins_value_radio", "sim/cockpit/misc/radio_altimeter_minimum", "writable")
	dataref("mins_mode", "XCrafts/ERJ/RA_BARO_Mins", "writable")

	if mins_mode == 0 then command_once("sim/instruments/dh_ref_up") end
	if mins_mode == 1 then set("XCrafts/ERJ/baro_altimeter_minimums",mins_value_baro + 10) end
end
create_command("WeisAIR/e170/dcp/minimums_inc", "minimums_inc", "minimums_inc()", "", "")

function minimums_dec()	
	
	dataref("mins_value_baro", "XCrafts/ERJ/baro_altimeter_minimums", "writable")
	--dataref("mins_value_radio", "sim/cockpit/misc/radio_altimeter_minimum", "writable")
	dataref("mins_mode", "XCrafts/ERJ/RA_BARO_Mins", "writable")

	if mins_mode == 0 then command_once("sim/instruments/dh_ref_down") end
	if mins_mode == 1 then set("XCrafts/ERJ/baro_altimeter_minimums",mins_value_baro - 10) end
end
create_command("WeisAIR/e170/dcp/minimums_dec", "minimums_dec", "minimums_dec()", "", "")


function baro_set_hpa()	
	
	set("sim/physics/metric_press",1)
end
create_command("WeisAIR/e170/dcp/baro_set_hpa", "baro_set_hpa", "baro_set_hpa()", "", "")

function baro_set_inhg()	
	
	set("sim/physics/metric_press",0)
end
create_command("WeisAIR/e170/dcp/baro_set_inhg", "baro_set_inhg", "baro_set_inhg()", "", "")

function hydr_pump_sys1_incr()	
	
	dataref("hydr_sys1_mode", "XCrafts/ERJ/Hydraulics1", "writable")

	if hydr_sys1_mode < 2 then set("XCrafts/ERJ/Hydraulics1",hydr_sys1_mode + 1) end
	
end
create_command("WeisAIR/e170/hydraulics/hydr_pump_sys1_incr", "hydr_pump_sys1_incr", "hydr_pump_sys1_incr()", "", "")

function hydr_pump_sys1_decr()	
	
	dataref("hydr_sys1_mode", "XCrafts/ERJ/Hydraulics1", "writable")

	if hydr_sys1_mode > 0 then set("XCrafts/ERJ/Hydraulics1",hydr_sys1_mode - 1) end
	
end
create_command("WeisAIR/e170/hydraulics/hydr_pump_sys1_decr", "hydr_pump_sys1_decr", "hydr_pump_sys1_decr()", "", "")

function hydr_pump_sys2_incr()	
	
	dataref("hydr_sys2_mode", "XCrafts/ERJ/Hydraulics2", "writable")

	if hydr_sys2_mode < 2 then set("XCrafts/ERJ/Hydraulics2",hydr_sys2_mode + 1) end
	
end
create_command("WeisAIR/e170/hydraulics/hydr_pump_sys2_incr", "hydr_pump_sys2_incr", "hydr_pump_sys2_incr()", "", "")

function hydr_pump_sys2_decr()	
	
	dataref("hydr_sys2_mode", "XCrafts/ERJ/Hydraulics2", "writable")

	if hydr_sys2_mode > 0 then set("XCrafts/ERJ/Hydraulics2",hydr_sys2_mode - 1) end
	
end
create_command("WeisAIR/e170/hydraulics/hydr_pump_sys2_decr", "hydr_pump_sys2_decr", "hydr_pump_sys2_decr()", "", "")

function hydr_pump_sys3_b_incr()	
	
	dataref("hydr_sys3_b_mode", "XCrafts/hydraulic/sys3_elec_pump_b_switch", "writable")

	if hydr_sys3_b_mode < 2 then set("XCrafts/hydraulic/sys3_elec_pump_b_switch",hydr_sys3_b_mode + 1) end
	
end
create_command("WeisAIR/e170/hydraulics/hydr_pump_sys3_b_incr", "hydr_pump_sys3_b_incr", "hydr_pump_sys3_b_incr()", "", "")

function hydr_pump_sys3_b_decr()	
	
	dataref("hydr_sys3_b_mode", "XCrafts/hydraulic/sys3_elec_pump_b_switch", "writable")

	if hydr_sys3_b_mode > 0 then set("XCrafts/hydraulic/sys3_elec_pump_b_switch",hydr_sys3_b_mode - 1) end
	
end
create_command("WeisAIR/e170/hydraulics/hydr_pump_sys3_b_decr", "hydr_pump_sys3_b_decr", "hydr_pump_sys3_b_decr()", "", "")

function hydr_pump_sys3_a_on()	
	
	set("XCrafts/hydraulic/sys3_elec_pump_a_switch",1)
end
create_command("WeisAIR/e170/hydraulics/hydr_pump_sys3_a_on", "hydr_pump_sys3_a_on", "hydr_pump_sys3_a_on()", "", "")

function hydr_pump_sys3_a_off()	
	
	set("XCrafts/hydraulic/sys3_elec_pump_a_switch",0)
end
create_command("WeisAIR/e170/hydraulics/hydr_pump_sys3_a_off", "hydr_pump_sys3_a_off", "hydr_pump_sys3_a_off()", "", "")

function hydr_ptu_incr()	
	
	dataref("hydr_ptu_mode", "XCrafts/hydraulic/PTU_switch", "writable")

	if hydr_ptu_mode < 2 then set("XCrafts/hydraulic/PTU_switch",hydr_ptu_mode + 1) end
	
end
create_command("WeisAIR/e170/hydraulics/hydr_ptu_incr", "hydr_ptu_incr", "hydr_ptu_incr()", "", "")

function hydr_ptu_decr()	
	
	dataref("hydr_ptu_mode", "XCrafts/hydraulic/PTU_switch", "writable")

	if hydr_ptu_mode > 0 then set("XCrafts/hydraulic/PTU_switch",hydr_ptu_mode - 1) end
	
end
create_command("WeisAIR/e170/hydraulics/hydr_ptu_decr", "hydr_ptu_decr", "hydr_ptu_decr()", "", "")


-- function apu_start_push()
-- 	dataref("apu_state", "sim/cockpit2/electrical/APU_starter_switch", "writable")
-- 	if (apu_state == 1) then command_begin("XCrafts/APU_CW") end

-- end
-- function apu_start_release()
-- 	dataref("apu_state", "sim/cockpit2/electrical/APU_starter_switch", "writable")
-- 	if (apu_state == 2) then 
-- 		command_end("XCrafts/APU_CW")
-- 		command_once("XCrafts/APU_CCW")
-- 	end
-- end
-- create_command("WeisAIR/e170/start_apu", "start_apu", "apu_start_push()", "", "apu_start_release()")

function apu_next_state_begin()
	command_begin("XCrafts/APU_CW")
end
create_command("WeisAIR/e170/apu_next_state_begin", "apu_next_state_begin", "apu_next_state_begin()", "", "")

function apu_next_state_end()
	command_end("XCrafts/APU_CW")
end
create_command("WeisAIR/e170/apu_next_state_end", "apu_next_state_end", "apu_next_state_end()", "", "")

function apu_start_push()
	set("sim/cockpit/engine/APU_switch",2)
end
function apu_start_release()
	set("sim/cockpit/engine/APU_switch",1)
end
create_command("WeisAIR/e170/start_apu", "start_apu", "apu_start_push()", "", "apu_start_release()")

function eng1_start_push()
	command_begin("XCrafts/Starter_Eng_1_up_CW")
end
function eng1_start_release()
	command_end("XCrafts/Starter_Eng_1_up_CW")
end
create_command("WeisAIR/e170/start_eng1", "start_eng1", "eng1_start_push()", "", "eng1_start_release()")

function eng1_start_begin()
	command_begin("XCrafts/Starter_Eng_1_up_CW")
end
create_command("WeisAIR/e170/eng1_start_begin", "eng1_start_begin", "eng1_start_begin()", "", "")

function eng1_start_end()
	command_end("XCrafts/Starter_Eng_1_up_CW")
end
create_command("WeisAIR/e170/eng1_start_end", "eng1_start_end", "eng1_start_end()", "", "")

function eng2_start_push()
	command_begin("XCrafts/Starter_Eng_2_up_CW")
end
function eng2_start_release()
	command_end("XCrafts/Starter_Eng_2_up_CW")
end
create_command("WeisAIR/e170/start_eng2", "start_eng2", "eng2_start_push()", "", "eng2_start_release()")

function eng2_start_begin()
	command_begin("XCrafts/Starter_Eng_2_up_CW")
end
create_command("WeisAIR/e170/eng2_start_begin", "eng2_start_begin", "eng2_start_begin()", "", "")

function eng2_start_end()
	command_end("XCrafts/Starter_Eng_2_up_CW")
end
create_command("WeisAIR/e170/eng2_start_end", "eng2_start_end", "eng2_start_end()", "", "")


--XCrafts/ERJ/engine1_starter_knob


-- function bank_push()

-- 	if BANK_value == 0 then
-- 		BANK_value = 1
-- 		xpl_command("sim/autopilot/bank_limit_down","FLOAT")
-- 		xpl_command("sim/autopilot/bank_limit_down","FLOAT")
-- 		xpl_command("sim/autopilot/bank_limit_down","FLOAT")
-- 	else
-- 		BANK_value = 0
-- 		xpl_command("sim/autopilot/bank_limit_up","FLOAT")
-- 		xpl_command("sim/autopilot/bank_limit_up","FLOAT")
-- 		xpl_command("sim/autopilot/bank_limit_up","FLOAT")
-- 	end

-- create_command("WeisAIR/e170/ap/bank_push", "bank_push", "bank_push()", "", "")