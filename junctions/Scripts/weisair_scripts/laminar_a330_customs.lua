function a330_strobe_lights_toggle()
	
	dataref("strobe_lights_state", "laminar/a333/switches/strobe_pos", "readonly")
	
	if (strobe_lights_state < 2.0) then command_once("laminar/A333/toggle_switch/strobe_pos_up")
	else 
			command_once("laminar/A333/toggle_switch/strobe_pos_dn")
			command_once("laminar/A333/toggle_switch/strobe_pos_dn")
	end
end
create_command("WeisAIR/a330/lights/a330_strobe_lights_toggle", "a330_strobe_lights_toggle", "a330_strobe_lights_toggle()", "", "")


