dataref("bat_switch", "les/dc3/elecSys/controls/battery_sw", "writable") 
dataref("left_magneto", "les/dc3/elecSys/controls/Lmagneto_sw", "writable") 
dataref("right_magneto", "les/dc3/elecSys/controls/Rmagneto_sw", "writable") 
dataref("xpdr_mode", "les/dc3/radios/xpndr_kb", "writable") 
dataref("fire_ext_selector","les/dc3/fuelSys/fire_eng_select_switch_mnp","writable")
dataref("left_eng_fuel_selector","les/dc3/fuelSys/lFuelSelector_kb","writable")
dataref("right_eng_fuel_selector","les/dc3/fuelSys/rFuelSelector_kb","writable")
dataref("park_brake","les/dc3/gear/brakes/parking_brake","writable")
---------------------

function land_lights_on()
	
	dataref("ll_l", "les/dc3/elecSys/lighting/L_ldgLit", "writable")
	dataref("ll_r", "les/dc3/elecSys/lighting/R_ldgLit", "writable")
	
	set("les/dc3/elecSys/lighting/L_ldgLit",1)
	set("les/dc3/elecSys/lighting/R_ldgLit",1)

end
create_command("WeisAIR/dc3/lights/land_lights_on", "land_lights_on", "land_lights_on()", "", "")


function land_lights_off()
	
	dataref("ll_l", "les/dc3/elecSys/lighting/L_ldgLit", "writable")
	dataref("ll_r", "les/dc3/elecSys/lighting/R_ldgLit", "writable")
	
	set("les/dc3/elecSys/lighting/L_ldgLit",0)
	set("les/dc3/elecSys/lighting/R_ldgLit",0)
		
	--end
	
end
create_command("WeisAIR/dc3/lights/land_lights_off", "land_lights_off", "land_lights_off()", "", "")

function battery_switch_toggle()
	
	new_val = bat_switch + 1

	if (new_val < 3) then set("les/dc3/elecSys/controls/battery_sw",new_val)
	else set("les/dc3/elecSys/controls/battery_sw",0)
	end

end
create_command("WeisAIR/dc3/elec/battery_switch_toggle", "battery_switch_toggle", "battery_switch_toggle()", "", "")

function magneto_left_toggle()
	
	new_val = left_magneto + 1

	if (new_val < 4) then set("les/dc3/elecSys/controls/Lmagneto_sw",new_val)
	else set("les/dc3/elecSys/controls/Lmagneto_sw",0)
	end

end
create_command("WeisAIR/dc3/elec/magneto_left_toggle", "magneto_left_toggle", "magneto_left_toggle()", "", "")

function magneto_right_toggle()
	
	new_val = right_magneto + 1

	if (new_val < 4) then set("les/dc3/elecSys/controls/Rmagneto_sw",new_val)
	else set("les/dc3/elecSys/controls/Rmagneto_sw",0)
	end

end
create_command("WeisAIR/dc3/elec/magneto_right_toggle", "magneto_right_toggle", "magneto_right_toggle()", "", "")

function start_priming_eng1()
	
	command_begin("sim/fuel/engine_1_primer")
end
create_command("WeisAIR/dc3/eng/start_priming_eng1", "start_priming_eng1", "start_priming_eng1()", "", "")

function stop_priming_eng1()
	
	command_end("sim/fuel/engine_1_primer")
end
create_command("WeisAIR/dc3/eng/stop_priming_eng1", "stop_priming_eng1", "stop_priming_eng1()", "", "")

function start_priming_eng2()
	
	command_begin("sim/fuel/engine_2_primer")
end
create_command("WeisAIR/dc3/eng/start_priming_eng2", "start_priming_eng2", "start_priming_eng2()", "", "")

function stop_priming_eng2()
	
	command_end("sim/fuel/engine_2_primer")
end
create_command("WeisAIR/dc3/eng/stop_priming_eng2", "stop_priming_eng2", "stop_priming_eng2()", "", "")

function fire_test_start()
	
	set("les/dc3/elecSys/ann/fireTestPressed",1)
end
create_command("WeisAIR/dc3/eng/fire_test_start", "fire_test_start", "fire_test_start()", "", "")

function fire_test_stop()
	
	set("les/dc3/elecSys/ann/fireTestPressed",0)
end
create_command("WeisAIR/dc3/eng/fire_test_stop", "fire_test_stop", "fire_test_stop()", "", "")

function xpdr_mode_dec()
	
	new_val = xpdr_mode - 1
	if (new_val > -1) then set("les/dc3/radios/xpndr_kb",new_val) end
	
end
create_command("WeisAIR/dc3/xpdr/xpdr_mode_dec", "xpdr_mode_dec", "xpdr_mode_dec()", "", "")

function xpdr_mode_inc()
	
	new_val = xpdr_mode + 1
	if (new_val < 4) then set("les/dc3/radios/xpndr_kb",new_val) end
	
end
create_command("WeisAIR/dc3/xpdr/xpdr_mode_inc", "xpdr_mode_inc", "xpdr_mode_inc()", "", "")

function toggle_fire_ext_selector()
	
	new_val = fire_ext_selector + 1
	if (new_val < 2) then set("les/dc3/fuelSys/fire_eng_select_switch_mnp",new_val) 
	else set("les/dc3/fuelSys/fire_eng_select_switch_mnp",-1)
	end
	
end
create_command("WeisAIR/dc3/fire/toggle_fire_ext_selector", "toggle_fire_ext_selector", "toggle_fire_ext_selector()", "", "")

function toggle_left_engine_fuel_selector()
	
	new_val = left_eng_fuel_selector + 1
	if (new_val < 5) then set("les/dc3/fuelSys/lFuelSelector_kb",new_val) 
	else set("les/dc3/fuelSys/lFuelSelector_kb",0)
	end
	
end
create_command("WeisAIR/dc3/fuel/toggle_left_engine_fuel_selector", "toggle_left_engine_fuel_selector", "toggle_left_engine_fuel_selector()", "", "")

function toggle_right_engine_fuel_selector()
	
	new_val = right_eng_fuel_selector + 1
	if (new_val < 5) then set("les/dc3/fuelSys/rFuelSelector_kb",new_val) 
	else set("les/dc3/fuelSys/rFuelSelector_kb",0)
	end
	
end
create_command("WeisAIR/dc3/fuel/toggle_right_engine_fuel_selector", "toggle_right_engine_fuel_selector", "toggle_right_engine_fuel_selector()", "", "")

function toggle_park_brake()
	
	if(park_brake == 0.0) then set("les/dc3/gear/brakes/parking_brake",1.0) 
	else set("les/dc3/gear/brakes/parking_brake",0.0) 
	end
	
end
create_command("WeisAIR/dc3/misc/toggle_park_brake", "toggle_park_brake", "toggle_park_brake()", "", "")

