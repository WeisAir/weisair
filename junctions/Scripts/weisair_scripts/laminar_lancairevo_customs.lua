function eng_starter_push()
		
	command_begin("sim/ignition/engage_starter_1")	
	
end
create_command("WeisAIR/lancairevo/energy/eng_starter_push", "eng_starter_push", "eng_starter_push()", "", "")

function eng_starter_release()
		
	command_end("sim/ignition/engage_starter_1")	
	
end
create_command("WeisAIR/lancairevo/energy/eng_starter_release", "eng_starter_release", "eng_starter_release()", "", "")

function cabin_lights_on()
	set_array("sim/cockpit2/switches/generic_lights_switch",0, 0.5)
	set_array("sim/cockpit2/switches/instrument_brightness_ratio",0, 0.5)
end
create_command("WeisAIR/lancairevo/lights/cabin_lights_on", "cabin_lights_on", "cabin_lights_on()", "", "")

function cabin_lights_off()
	set_array("sim/cockpit2/switches/generic_lights_switch",0, 0.0)
	set_array("sim/cockpit2/switches/instrument_brightness_ratio",0, 0.5)
end
create_command("WeisAIR/lancairevo/lights/cabin_lights_off", "cabin_lights_off", "cabin_lights_off()", "", "")
