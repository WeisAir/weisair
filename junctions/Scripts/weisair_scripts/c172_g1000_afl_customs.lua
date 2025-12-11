function cockpit_lights_all_increase()

		command_once("C172/cockpit/dim/swCbPanelsInc")
		command_once("C172/cockpit/dim/stbyIndInc")
		command_once("C172/cockpit/dim/pedestalInc")

end
create_command("WeisAIR/afl_c172_g1000/cockpit_lights_all_increase", "cockpit_lights_all_increase", "cockpit_lights_all_increase()", "", "")


function cockpit_lights_all_decrease()

		command_once("C172/cockpit/dim/swCbPanelsDec")
		command_once("C172/cockpit/dim/stbyIndDec")
		command_once("C172/cockpit/dim/pedestalDec")

end
create_command("WeisAIR/afl_c172_g1000/cockpit_lights_all_decrease", "cockpit_lights_all_decrease", "cockpit_lights_all_decrease()", "", "")


function cockpit_lights_all_max()

	set("C172/cockpit/dim/swCbPanels", 1.0)
	set("C172/cockpit/dim/stbyInd", 1.0)
	set("C172/cockpit/dim/pedestal", 1.0)
	
end
create_command("WeisAIR/afl_c172_g1000/cockpit_lights_all_max", "cockpit_lights_all_max", "cockpit_lights_all_max()", "", "")

function cockpit_lights_all_off()

	set("C172/cockpit/dim/swCbPanels", 0.0)
	set("C172/cockpit/dim/stbyInd", 0.0)
	set("C172/cockpit/dim/pedestal", 0.0)
	
end
create_command("WeisAIR/afl_c172_g1000/cockpit_lights_all_off", "cockpit_lights_all_off", "cockpit_lights_all_off()", "", "")


function taxi_light_on()

		set("C172/cockpit/lights/taxiRecogLand", 1.0)

end
create_command("WeisAIR/afl_c172_g1000/taxi_light_on", "taxi_light_on", "taxi_light_on()", "", "")

function taxi_light_off()

		set("C172/cockpit/lights/taxiRecogLand", 0.0)

end
create_command("WeisAIR/afl_c172_g1000/taxi_light_off", "taxi_light_off", "taxi_light_off()", "", "")

function land_light_on()
		
		set("C172/cockpit/lights/taxiRecogLand", 2.0)
end
create_command("WeisAIR/afl_c172_g1000/land_light_on", "land_light_on", "land_light_on()", "", "")

function land_light_off()

		set("C172/cockpit/lights/taxiRecogLand", 0.0)
end
create_command("WeisAIR/afl_c172_g1000/land_light_off", "land_light_off", "land_light_off()", "", "")

function stby_batt_test_start()

		dataref("stby_batt_state", "C172/cockpit/stbyBatt", "writable")
		
		if(stby_batt_state == 0.0) then	command_begin("C172/cockpit/stbyBattDec") end
end
create_command("WeisAIR/afl_c172_g1000/stby_batt_test_start", "stby_batt_test_start", "stby_batt_test_start()", "", "")

function stby_batt_test_stop()

		command_end("C172/cockpit/stbyBattDec")
		command_once("C172/cockpit/stbyBattInc")
	
end
create_command("WeisAIR/afl_c172_g1000/stby_batt_test_stop", "stby_batt_test_stop", "stby_batt_test_stop()", "", "")
