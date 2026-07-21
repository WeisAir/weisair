function cockpit_panel_lights_on()
	
	dataref("panel_lights_state", "laminar/b58/panel_light_toggle/switch_pos", "readonly")
	dataref("flood_lights_state", "laminar/b58/flood_light_toggle/switch_pos", "readonly")
	
	if (panel_lights_state == 1.0) then command_once("laminar/b58/lighting/panel_light_switch") end
	if (flood_lights_state == 1.0) then command_once("laminar/b58/lighting/flood_light_switch") end
	
	command_once("laminar/b58/lighting/flood_light_switch")
	command_once("laminar/b58/lighting/panel_light_switch")
	
end
create_command("WeisAIR/b58/lights/cockpit_panel_lights_on", "cockpit_panel_lights_on", "cockpit_panel_lights_on()", "", "")

function cockpit_panel_lights_off()
	
	dataref("panel_lights_state", "laminar/b58/panel_light_toggle/switch_pos", "readonly")
	dataref("flood_lights_state", "laminar/b58/flood_light_toggle/switch_pos", "readonly")
	
	if (panel_lights_state == 0.0) then command_once("laminar/b58/lighting/panel_light_switch") end
	if (flood_lights_state == 0.0) then command_once("laminar/b58/lighting/flood_light_switch") end
	
	command_once("laminar/b58/lighting/flood_light_switch")
	command_once("laminar/b58/lighting/panel_light_switch")
	
end
create_command("WeisAIR/b58/lights/cockpit_panel_lights_off", "cockpit_panel_lights_off", "cockpit_panel_lights_off()", "", "")