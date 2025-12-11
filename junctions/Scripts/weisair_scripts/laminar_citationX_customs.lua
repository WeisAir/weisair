function citX_taxi_lights_on()
	
	dataref("taxi_lights_state", "laminar/CitX/lights/taxi", "readonly")
	
	if (taxi_lights_state==0.0) then command_once("laminar/CitX/lights/cmd_taxi_toggle")
	end
end
create_command("WeisAIR/citX/lights/citX_taxi_lights_on", "citX_taxi_lights_on", "citX_taxi_lights_on()", "", "")

function citX_taxi_lights_off()
	
	dataref("taxi_lights_state", "laminar/CitX/lights/taxi", "readonly")
	
	if (taxi_lights_state==1.0) then command_once("laminar/CitX/lights/cmd_taxi_toggle")
	end
end
create_command("WeisAIR/citX/lights/citX_taxi_lights_off", "citX_taxi_lights_off", "citX_taxi_lights_off()", "", "")


function citX_land_lights_on()
	
	dataref("land_lights_left_state", "laminar/CitX/lights/landing_left", "readonly")
	dataref("land_lights_right_state", "laminar/CitX/lights/landing_right", "readonly")
	
	if (land_lights_left_state==0.0 and land_lights_right_state==0.0) then 
		command_once("laminar/CitX/lights/cmd_landing_left_toggle")
		command_once("laminar/CitX/lights/cmd_landing_right_toggle")
	end
end
create_command("WeisAIR/citX/lights/citX_land_lights_on", "citX_land_lights_on", "citX_land_lights_on()", "", "")

function citX_land_lights_off()
	
	dataref("land_lights_left_state", "laminar/CitX/lights/landing_left", "readonly")
	dataref("land_lights_right_state", "laminar/CitX/lights/landing_right", "readonly")
	
	if (land_lights_left_state==1.0 and land_lights_right_state==1.0) then 
		command_once("laminar/CitX/lights/cmd_landing_left_toggle")
		command_once("laminar/CitX/lights/cmd_landing_right_toggle")
	end
end
create_command("WeisAIR/citX/lights/citX_land_lights_off", "citX_land_lights_off", "citX_land_lights_off()", "", "")

function citX_energy_avionics_on()
	
	dataref("avionics_state", "laminar/CitX/electrical/avionics", "readonly")
		
	if (avionics_state==0.0) then 
		command_once("laminar/CitX/electrical/cmd_avionics_toggle")
	end
end
create_command("WeisAIR/citX/energy/citX_energy_avionics_on", "citX_energy_avionics_on", "citX_energy_avionics_on()", "", "")

function citX_energy_avionics_off()
	
	dataref("avionics_state", "laminar/CitX/electrical/avionics", "readonly")
		
	if (avionics_state==1.0) then 
		command_once("laminar/CitX/electrical/cmd_avionics_toggle")
	end
end
create_command("WeisAIR/citX/energy/citX_energy_avionics_off", "citX_energy_avionics_off", "citX_energy_avionics_off()", "", "")

function citX_energy_avionics_eicas_on()
	
	dataref("avionics_eicas_state", "laminar/CitX/electrical/avionics_eicas", "readonly")
		
	if (avionics_eicas_state==0.0) then 
		command_once("laminar/CitX/electrical/cmd_avionics_eicas_toggle")
	end
end
create_command("WeisAIR/citX/energy/citX_energy_avionics_eicas_on", "citX_energy_avionics_eicas_on", "citX_energy_avionics_eicas_on()", "", "")

function citX_energy_avionics_eicas_off()
	
	dataref("avionics_eicas_state", "laminar/CitX/electrical/avionics_eicas", "readonly")
		
	if (avionics_eicas_state==1.0) then 
		command_once("laminar/CitX/electrical/cmd_avionics_eicas_toggle")
	end
end
create_command("WeisAIR/citX/energy/citX_energy_avionics_eicas_off", "citX_energy_avionics_eicas_off", "citX_energy_avionics_eicas_off()", "", "")