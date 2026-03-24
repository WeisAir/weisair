function deice_max_push()
	command_begin("laminar/sr22/anti_ice_tks_max")
end
create_command("WeisAIR/sr22/deice_max_push", "deice_max_push", "deice_max_push()", "", "")

function deice_max_release()
	command_end("laminar/sr22/anti_ice_tks_max")
end
create_command("WeisAIR/sr22/deice_max_release", "deice_max_release", "deice_max_release()", "", "")


function cockpit_lights_max()
	
	set_array("sim/cockpit2/switches/generic_lights_switch",6,1.0)	
	set_array("sim/cockpit2/switches/instrument_brightness_ratio",0,1.0)	
end
create_command("WeisAIR/sr22/lights/cockpit_lights_max", "cockpit_lights_max", "cockpit_lights_max()", "", "")

function cockpit_lights_off()
	
	set_array("sim/cockpit2/switches/generic_lights_switch",6,0.0)	
	set_array("sim/cockpit2/switches/instrument_brightness_ratio",0,0.0)	
end
create_command("WeisAIR/sr22/lights/cockpit_lights_off", "cockpit_lights_off", "cockpit_lights_off()", "", "")

