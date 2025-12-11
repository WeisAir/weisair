function toggleParkBrakeAndNWSteering()
	dataref("nose_wheel_steering_handle", "les/sf34a/acft/gear/anm/nose_wheel_steering_switch", "readonly")
	--> pushed in = 0.0 = released 
	--> pushed out = 1.0 = blocked
	
	dataref("park_brake_handle", "les/sf34a/acft/gear/mnp/parking_brake_handle", "readonly")
	if (nose_wheel_steering_handle ~= park_brake_handle) then
		command_once("les/sf34a/acft/gear/mnp/nose_wheel_steering_switch")
		command_once("sim/flight_controls/brakes_toggle_max")
	end
end
create_command("WeisAIR/s340a/toggleParkBrakeAndNWSteering", "toggleParkBrakeAndNWSteering", "toggleParkBrakeAndNWSteering()", "", "")

function bothWipersUP()

		command_once("les/sf34a/acft/rain/mnp/wiper_knob_up_L")
		command_once("les/sf34a/acft/rain/mnp/wiper_knob_up_R")

end
create_command("WeisAIR/s340a/bothWipersUP", "bothWipersUP", "bothWipersUP()", "", "")

function bothWipersDOWN()

		command_once("les/sf34a/acft/rain/mnp/wiper_knob_dn_L")
		command_once("les/sf34a/acft/rain/mnp/wiper_knob_dn_R")

end
create_command("WeisAIR/s340a/bothWipersDOWN", "bothWipersDOWN", "bothWipersDOWN()", "", "")


function setSectorMode0()

	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	
--	set("les/sf34a/acft/avio/anm/dcp_compass_mode_knob_pilot", 0.0) 	

end
create_command("WeisAIR/s340a/setSectorMode0", "setSectorMode0", "setSectorMode0()", "", "")

function setSectorMode1()

	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")


--	set("les/sf34a/acft/avio/anm/dcp_compass_mode_knob_pilot", 1.0) 	

end
create_command("WeisAIR/s340a/setSectorMode1", "setSectorMode1", "setSectorMode1()", "", "")

function setSectorMode2()

	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")

--	set("les/sf34a/acft/avio/anm/dcp_compass_mode_knob_pilot", 2.0) 	

end
create_command("WeisAIR/s340a/setSectorMode2", "setSectorMode2", "setSectorMode2()", "", "")

function setSectorMode3()

	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")

--	set("les/sf34a/acft/avio/anm/dcp_compass_mode_knob_pilot", 3.0) 	

end
create_command("WeisAIR/s340a/setSectorMode3", "setSectorMode3", "setSectorMode3()", "", "")

function setSectorMode4()

	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")

--	set("les/sf34a/acft/avio/anm/dcp_compass_mode_knob_pilot", 4.0) 	

end
create_command("WeisAIR/s340a/setSectorMode4", "setSectorMode4", "setSectorMode4()", "", "")

function setSectorMode5()

	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	
--	set("les/sf34a/acft/avio/anm/dcp_compass_mode_knob_pilot", 5.0) 	

end
create_command("WeisAIR/s340a/setSectorMode5", "setSectorMode5", "setSectorMode5()", "", "")

function setSectorMode6()

	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")

--	set("les/sf34a/acft/avio/anm/dcp_compass_mode_knob_pilot", 6.0) 	

end
create_command("WeisAIR/s340a/setSectorMode6", "setSectorMode6", "setSectorMode6()", "", "")

function setSectorMode7()

	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_dn_pilot")
		
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")
	command_once("les/sf34a/acft/avio/mnp/dcp_compass_mode_knob_up_pilot")

--	set("les/sf34a/acft/avio/anm/dcp_compass_mode_knob_pilot", 7.0) 	

end
create_command("WeisAIR/s340a/setSectorMode7", "setSectorMode7", "setSectorMode7()", "", "")

function toggle_ctot()

	command_once("les/sf34a/acft/engn/mnp/ctot_switch_L")
	command_once("les/sf34a/acft/engn/mnp/ctot_switch_R")

end
create_command("WeisAIR/s340a/toggle_ctot", "toggle_ctot", "toggle_ctot()", "", "")

function ap_engage_start()

	command_begin("les/sf34a/acft/aplt/mnp/autopilot_engage_switch")

end
create_command("WeisAIR/s340a/ap_engage_start", "ap_engage_start", "ap_engage_start()", "", "")

function ap_engage_stop()

	command_end("les/sf34a/acft/aplt/mnp/autopilot_engage_switch")

end
create_command("WeisAIR/s340a/ap_engage_stop", "ap_engage_stop", "ap_engage_stop()", "", "")

function yd_engage_start()

	command_begin("les/sf34a/acft/aplt/mnp/yaw_damper_engage_switch")

end
create_command("WeisAIR/s340a/yd_engage_start", "yd_engage_start", "yd_engage_start()", "", "")

function yd_engage_stop()

	command_end("les/sf34a/acft/aplt/mnp/yaw_damper_engage_switch")

end
create_command("WeisAIR/s340a/yd_engage_stop", "yd_engage_stop", "yd_engage_stop()", "", "")

function cockpit_lights_max()

	dataref("dome_lights", "les/sf34a/acft/ltng/anm/int_dome_switch", "readonly")
	if(dome_lights == 0.0) then command_once("les/sf34a/acft/ltng/mnp/int_dome_switch") end

end
create_command("WeisAIR/s340a/lights/cockpit_lights_max", "cockpit_lights_max", "cockpit_lights_max()", "", "")

function cockpit_lights_off()

	dataref("dome_lights", "les/sf34a/acft/ltng/anm/int_dome_switch", "readonly")
	if(dome_lights == 1.0) then command_once("les/sf34a/acft/ltng/mnp/int_dome_switch") end

end
create_command("WeisAIR/s340a/lights/cockpit_lights_off", "cockpit_lights_off", "cockpit_lights_off()", "", "")

function passengers_signs_on()

	dataref("seat_belt_sign", "LES/saab/annun/seat_belt", "readonly")
	dataref("no_smoking_sign", "LES/saab/annun/no_smoking", "readonly")

	if(seat_belt_sign == 0.0) then command_once("les/sf34a/acft/comm/mnp/seat_belt_sign_switch")  end
	if(no_smoking_sign == 0.0 ) then command_once("les/sf34a/acft/comm/mnp/no_smoking_sign_switch")	end


end
create_command("WeisAIR/s340a/passengers_signs_on", "passengers_signs_on", "passengers_signs_on()", "", "")

function passengers_signs_off()

	dataref("seat_belt_sign", "LES/saab/annun/seat_belt", "readonly")
	dataref("no_smoking_sign", "LES/saab/annun/no_smoking", "readonly")

	if(seat_belt_sign > 0.0) then command_once("les/sf34a/acft/comm/mnp/seat_belt_sign_switch")  end
	if(no_smoking_sign > 0.0 ) then command_once("les/sf34a/acft/comm/mnp/no_smoking_sign_switch")	end


end
create_command("WeisAIR/s340a/passengers_signs_off", "passengers_signs_off", "passengers_signs_off()", "", "")

