function a330_strobe_lights_toggle()
	
	dataref("strobe_lights_state", "laminar/a333/switches/strobe_pos", "readonly")
	
	if (strobe_lights_state < 2.0) then command_once("laminar/A333/toggle_switch/strobe_pos_up")
	else 
			command_once("laminar/A333/toggle_switch/strobe_pos_dn")
			command_once("laminar/A333/toggle_switch/strobe_pos_dn")
	end
end
create_command("WeisAIR/a330/lights/a330_strobe_lights_toggle", "a330_strobe_lights_toggle", "a330_strobe_lights_toggle()", "", "")

function a330_taxi_lights_toggle()
	
	dataref("taxi_lights_state", "sim/cockpit2/switches/landing_lights_switch", "writable",1)
	
	current_taxi_light_state = taxi_lights_state
	new_taxi_light_state = taxi_lights_state + 0.5

	if (new_taxi_light_state < 1.5) then set_array("sim/cockpit2/switches/landing_lights_switch",1, new_taxi_light_state)
	else 
			set_array("sim/cockpit2/switches/landing_lights_switch",1, 0.0)
	end
end
create_command("WeisAIR/a330/lights/a330_taxi_lights_toggle", "a330_taxi_lights_toggle", "a330_taxi_lights_toggle()", "", "")

function a330_navlogo_lights_toggle()
	
	dataref("navlogo_lights_state", "laminar/a333/switches/nav_pos", "readonly")
	
	if (navlogo_lights_state < 2.0) then command_once("laminar/A333/toggle_switch/nav_light_pos_up")
	else 
			command_once("laminar/A333/toggle_switch/nav_light_pos_dn")
			command_once("laminar/A333/toggle_switch/nav_light_pos_dn")
	end
end
create_command("WeisAIR/a330/lights/a330_navlogo_lights_toggle", "a330_navlogo_lights_toggle", "a330_navlogo_lights_toggle()", "", "")
