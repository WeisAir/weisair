---------------------------------------------------------------
-- Lights Functions-----------------------------------------------
---------------------------------------------------------------

function b748_cockpit_lights_max()
		
	dataref("panel_brightness_dome", "ssg/LGT/dome_brt", "writable")
	dataref("panel_brightness_dome_sw", "ssg/LGT/dome_sw", "writable")
	dataref("panel_brightness_glareshield", "ssg/LGT/graresheld_brt", "writable")
	dataref("panel_brightness_flood", "ssg/LGT/std_fld_brt", "writable")
	dataref("panel_brightness_stm", "ssg/LGT/stm_sw", "writable")
	dataref("panel_brightness_ovhd","ssg/LGT/Pnl_ovhd_sw", "writable") 
	dataref("panel_brightness_glaresheld_sw","ssg/LGT/glaresheld_sw", "writable")
	dataref("panel_brightness_pnl_sw","ssg/LGT/glaresheld_pnl_sw", "writable")
	dataref("panel_brightness_pnl_up_sw","ssg/LGT/pnl_up_sw", "writable")	
	dataref("panel_brightness_flood_sw","ssg/LGT/cp_fld_sw", "writable")	
	
	set("ssg/LGT/dome_brt",	1.5 )
	set("ssg/LGT/graresheld_brt", 1.5 )
	set("ssg/LGT/std_fld_brt", 1.5)
	set("ssg/LGT/stm_sw", 1.0)
	set("ssg/LGT/Pnl_ovhd_sw", 1.0)
	set("ssg/LGT/glaresheld_sw", 1.0)
	set("ssg/LGT/glaresheld_pnl_sw", 1.0)
	set("ssg/LGT/dome_sw", 1.0)
	set("ssg/LGT/pnl_up_sw", 1.0)	
	set("ssg/LGT/cp_fld_sw", 1.0)	
	
	
	
end
create_command("WeisAIR/b748/LIGHTS/cockpit_lights_max", "b748_cockpit_lights_max", "b748_cockpit_lights_max()", "", "")

function b748_cockpit_lights_off()
		
	dataref("panel_brightness_dome", "ssg/LGT/dome_brt", "writable")
	dataref("panel_brightness_dome_sw", "ssg/LGT/dome_sw", "writable")
	dataref("panel_brightness_glareshield", "ssg/LGT/graresheld_brt", "writable")
	dataref("panel_brightness_flood", "ssg/LGT/std_fld_brt", "writable")
	dataref("panel_brightness_stm", "ssg/LGT/stm_sw", "writable")
	dataref("panel_brightness_ovhd","ssg/LGT/Pnl_ovhd_sw", "writable") 
	dataref("panel_brightness_glaresheld_sw","ssg/LGT/glaresheld_sw", "writable")
	dataref("panel_brightness_pnl_sw","ssg/LGT/glaresheld_pnl_sw", "writable")
	dataref("panel_brightness_pnl_up_sw","ssg/LGT/pnl_up_sw", "writable")
	dataref("panel_brightness_flood_sw","ssg/LGT/cp_fld_sw", "writable")
	
	set("ssg/LGT/dome_brt",	1.34999991 )
	set("ssg/LGT/graresheld_brt", 1.34999991 )
	set("ssg/LGT/std_fld_brt", 1.2)
	set("ssg/LGT/stm_sw", 0.0)
	set("ssg/LGT/Pnl_ovhd_sw", 0.0)
	set("ssg/LGT/glaresheld_sw", 0.0)
	set("ssg/LGT/glaresheld_pnl_sw", 0.0)
	set("ssg/LGT/dome_sw", 0.0)
	set("ssg/LGT/pnl_up_sw", 0.0)
	set("ssg/LGT/cp_fld_sw", 0.0)
	
end
create_command("WeisAIR/b748/LIGHTS/cockpit_lights_off", "b748_cockpit_lights_off", "b748_cockpit_lights_off()", "", "")

---------------------------------------------------------------
-- IRS Functions-----------------------------------------------
---------------------------------------------------------------

function toggle_IRS_Mode_L()
	dataref("irsMode_L", "ssg/Nav/align1_sw", "writable")
	new_mode = irsMode_L + 1
	if (new_mode <4) then set("ssg/Nav/align1_sw", new_mode)
	else set("ssg/Nav/align1_sw", 0)
	end
end
create_command("WeisAIR/b748/irs/toggle_IRS_Mode_L", "toggle_IRS_Mode_L", "toggle_IRS_Mode_L()", "", "")

function toggle_IRS_Mode_R()
	dataref("irsMode_R", "ssg/Nav/align3_sw", "writable")
	new_mode = irsMode_R + 1
	if (new_mode <4) then set("ssg/Nav/align3_sw", new_mode)
	else set("ssg/Nav/align3_sw", 0)
	end
end
create_command("WeisAIR/b748/irs/toggle_IRS_Mode_R", "toggle_IRS_Mode_R", "toggle_IRS_Mode_R()", "", "")

function toggle_IRS_Mode_C()
	dataref("irsMode_C", "ssg/Nav/align2_sw", "writable")
	new_mode = irsMode_C + 1
	if (new_mode <4) then set("ssg/Nav/align2_sw", new_mode)
	else set("ssg/Nav/align2_sw", 0)
	end
end
create_command("WeisAIR/b748/irs/toggle_IRS_Mode_C", "toggle_IRS_Mode_C", "toggle_IRS_Mode_C()", "", "")

---------------------------------------------------------------
-- MCP Functions-----------------------------------------------
---------------------------------------------------------------

function incMcpAltitude()
	dataref("mcp_altitude", "ssg/B748/MCP/mcp_alt_target_act", "writable")
	new_altitude = mcp_altitude + 100
	set("ssg/B748/MCP/mcp_alt_target_act", new_altitude)
end
create_command("WeisAIR/b748/mcp/incMcpAltitude", "incMcpAltitude", "incMcpAltitude()", "", "")

function decMcpAltitude()
	dataref("mcp_altitude", "ssg/B748/MCP/mcp_alt_target_act", "writable")
	new_altitude = mcp_altitude - 100
	set("ssg/B748/MCP/mcp_alt_target_act", new_altitude)
end
create_command("WeisAIR/b748/MCP/decMcpAltitude", "decMcpAltitude", "decMcpAltitude()", "", "")

function incMcpHeading()
	dataref("mcp_heading", "ssg/B748/MCP/mcp_heading_bug_act", "writable")
	new_heading = mcp_heading + 1.0
	set("ssg/B748/MCP/mcp_heading_bug_act", new_heading)
end
create_command("WeisAIR/b748/MultiPanel/incMcpHeading", "incMcpHeading", "incMcpHeading()", "", "")

function decMcpHeading()
	dataref("mcp_heading", "ssg/B748/MCP/mcp_heading_bug_act", "writable")
	new_heading = mcp_heading - 1.0
	set("ssg/B748/MCP/mcp_heading_bug_act", new_heading)
end
create_command("WeisAIR/b748/MultiPanel/decMcpHeading", "decMcpHeading", "decMcpHeading()", "", "")	

function incMcpBankAngle()
	dataref("mcp_bank_angle", "ssg/B748/MCP/mcp_bank_angle_act", "writable")
	new_bank_angle = mcp_bank_angle + 1.0
	if (new_bank_angle >=0 and new_bank_angle <= 5) then set("ssg/B748/MCP/mcp_bank_angle_act", new_bank_angle) end
end
create_command("WeisAIR/b748/MultiPanel/incMcpBankAngle", "incMcpBankAngle", "incMcpBankAngle()", "", "")

function decMcpBankAngle()
	dataref("mcp_bank_angle", "ssg/B748/MCP/mcp_bank_angle_act", "writable")
	new_bank_angle = mcp_bank_angle - 1.0
	if (new_bank_angle >=0 and new_bank_angle <= 5) then set("ssg/B748/MCP/mcp_bank_angle_act", new_bank_angle) end
end
create_command("WeisAIR/b748/MultiPanel/decMcpBankAngle", "decMcpBankAngle", "decMcpBankAngle()", "", "")	

function hdgSelectPush()
	set("ssg/B748/MCP/mcp_hdg_select_sw", 1)
end
function hdgSelectRelease()
	set("ssg/B748/MCP/mcp_hdg_select_sw", 0)
end
create_command("WeisAIR/b748/MultiPanel/hdgSelectPushButton", "hdgSelectPushButton", "hdgSelectPush()", "", "hdgSelectRelease()")	

function incMcpSpeed()
	dataref("mcp_speed", "ssg/B748/MCP/mcp_ias_mach_act", "writable")
	new_speed = mcp_speed + 1.0
	set("ssg/B748/MCP/mcp_ias_mach_act", new_speed)
end
create_command("WeisAIR/b748/MultiPanel/incMcpSpeed", "incMcpSpeed", "incMcpSpeed()", "", "")

function decMcpSpeed()
	dataref("mcp_speed", "ssg/B748/MCP/mcp_ias_mach_act", "writable")
	new_speed = mcp_speed - 1.0
	set("ssg/B748/MCP/mcp_ias_mach_act", new_speed)
end
create_command("WeisAIR/b748/MultiPanel/decMcpSpeed", "decMcpSpeed", "decMcpSpeed()", "", "")	

function incMcpVertSpeed()
	dataref("mcp_vertSpeed", "ssg/B748/MCP/mcp_vs_target_act", "writable")
	new_vertSpeed = mcp_vertSpeed + 100.0
	set("ssg/B748/MCP/mcp_vs_target_act", new_vertSpeed)
end
create_command("WeisAIR/b748/MultiPanel/incMcpVertSpeed", "incMcpVertSpeed", "incMcpVertSpeed()", "", "")

function decMcpVertSpeed()
	dataref("mcp_vertSpeed", "ssg/B748/MCP/mcp_vs_target_act", "writable")
	new_vertSpeed = mcp_vertSpeed - 100.0
	set("ssg/B748/MCP/mcp_vs_target_act", new_vertSpeed)
end
create_command("WeisAIR/b748/MultiPanel/decMcpVertSpeed", "decMcpVertSpeed", "decMcpVertSpeed()", "", "")	

function toggleBothFDs()
	command_once("SSG/UFMC/FD_Pilot_SW")
	command_once("SSG/UFMC/FD_Copilot_SW")
	
end
create_command("WeisAIR/b748/MCP/toggleBothFDs", "toggleBothFDs", "toggleBothFDs()", "", "")


function seatBelt_sign_on()
	
	dataref("seat_belt_sign_state", "ssg/PASS/passenger_signal_sw", "writable")
	
	if(seat_belt_sign_state == 0) then set("ssg/PASS/passenger_signal_sw", 2) end
		
end
create_command("WeisAIR/b748/seatBelt_sign_on", "seatBelt_sign_on", "seatBelt_sign_on()", "", "")

function seatBelt_sign_off()
	
	dataref("seat_belt_sign_state", "ssg/PASS/passenger_signal_sw", "writable")
	
	if(seat_belt_sign_state == 2) then set("ssg/PASS/passenger_signal_sw", 0) end
	
end
create_command("WeisAIR/b748/seatBelt_sign_off", "seatBelt_sign_off", "seatBelt_sign_off()", "", "")

function taxi_rwto_lights_on()
	
	dataref("rwto_left_state", "ssg/LGT/lgt_rwyL_sw","writable")
	dataref("rwto_right_state", "ssg/LGT/lgt_rwyR_sw","writable")
	dataref("taxi_state","ssg/LGT/lgt_taxi_sw","writable")
	
	if(rwto_left_state == 0 or rwto_right_state == 0 or taxi_state == 0) then
		set("ssg/LGT/lgt_rwyL_sw", 1)
		set("ssg/LGT/lgt_rwyR_sw", 1)
		set("ssg/LGT/lgt_taxi_sw", 1)
	end
	
end
create_command("WeisAIR/b748/lights/taxi_rwto_lights_on", "taxi_rwto_lights_on", "taxi_rwto_lights_on()", "", "")

function taxi_rwto_lights_off()
	
	dataref("rwto_left_state", "ssg/LGT/lgt_rwyL_sw","writable")
	dataref("rwto_right_state", "ssg/LGT/lgt_rwyR_sw","writable")
	dataref("taxi_state","ssg/LGT/lgt_taxi_sw","writable")
	
	if(rwto_left_state == 1 or rwto_right_state == 1 or taxi_state == 1) then
		set("ssg/LGT/lgt_rwyL_sw", 0)
		set("ssg/LGT/lgt_rwyR_sw", 0)
		set("ssg/LGT/lgt_taxi_sw", 0)
	end
	
end
create_command("WeisAIR/b748/lights/taxi_rwto_lights_off", "taxi_rwto_lights_off", "taxi_rwto_lights_off()", "", "")

function taxi_rwto_lights_toggle()
	
	dataref("rwto_left_state", "ssg/LGT/lgt_rwyL_sw","writable")
	dataref("rwto_right_state", "ssg/LGT/lgt_rwyR_sw","writable")
	dataref("taxi_state","ssg/LGT/lgt_taxi_sw","writable")
	
	if(rwto_left_state == 1 or rwto_right_state == 1 or taxi_state == 1) then
		set("ssg/LGT/lgt_rwyL_sw", 0)
		set("ssg/LGT/lgt_rwyR_sw", 0)
		set("ssg/LGT/lgt_taxi_sw", 0)
	else
		set("ssg/LGT/lgt_rwyL_sw", 1)
		set("ssg/LGT/lgt_rwyR_sw", 1)
		set("ssg/LGT/lgt_taxi_sw", 1)
	end
	
end
create_command("WeisAIR/b748/lights/taxi_rwto_lights_toggle", "taxi_rwto_lights_toggle", "taxi_rwto_lights_toggle()", "", "")

function taxi_lights_toggle()
	
	dataref("taxi_state","ssg/LGT/lgt_taxi_sw","writable")
	
	if(taxi_state == 1) then
		set("ssg/LGT/lgt_taxi_sw", 0)
	else
		set("ssg/LGT/lgt_taxi_sw", 1)
	end
	
end
create_command("WeisAIR/b748/lights/taxi_lights_toggle", "taxi_lights_toggle", "taxi_lights_toggle()", "", "")

function rwto_lights_toggle()
	
	dataref("rwto_left_state", "ssg/LGT/lgt_rwyL_sw","writable")
	dataref("rwto_right_state", "ssg/LGT/lgt_rwyR_sw","writable")

	if(rwto_left_state == 1 or rwto_right_state == 1) then
		set("ssg/LGT/lgt_rwyL_sw", 0)
		set("ssg/LGT/lgt_rwyR_sw", 0)
	else
		set("ssg/LGT/lgt_rwyL_sw", 1)
		set("ssg/LGT/lgt_rwyR_sw", 1)
	end
	
end
create_command("WeisAIR/b748/lights/rwto_lights_toggle", "rwto_lights_toggle", "rwto_lights_toggle()", "", "")


function land_lights_on()

	dataref("land_light_inL_state","ssg/LGT/lgt_inL_sw","writable")
	dataref("land_light_inR_state","ssg/LGT/lgt_inR_sw","writable")
	dataref("land_light_outL_state","ssg/LGT/lgt_outL_sw","writable")
	dataref("land_light_outR_state","ssg/LGT/lgt_outR_sw","writable")
	
	if(land_light_inL_state == 0 or land_light_inR_state == 0 or land_light_outL_state == 0 or land_light_outR_state == 0 ) then
		set("ssg/LGT/lgt_inL_sw", 1)
		set("ssg/LGT/lgt_inR_sw", 1)
		set("ssg/LGT/lgt_outL_sw", 1)
		set("ssg/LGT/lgt_outR_sw", 1)	
	end

end
create_command("WeisAIR/b748/lights/land_lights_on", "land_lights_on", "land_lights_on()", "", "")

function land_lights_off()

	dataref("land_light_inL_state","ssg/LGT/lgt_inL_sw","writable")
	dataref("land_light_inR_state","ssg/LGT/lgt_inR_sw","writable")
	dataref("land_light_outL_state","ssg/LGT/lgt_outL_sw","writable")
	dataref("land_light_outR_state","ssg/LGT/lgt_outR_sw","writable")
	
	if(land_light_inL_state == 1 or land_light_inR_state == 1 or land_light_outL_state == 1 or land_light_outR_state == 1 ) then
		set("ssg/LGT/lgt_inL_sw", 0)
		set("ssg/LGT/lgt_inR_sw", 0)
		set("ssg/LGT/lgt_outL_sw", 0)
		set("ssg/LGT/lgt_outR_sw", 0)	
	end

end
create_command("WeisAIR/b748/lights/land_lights_off", "land_lights_off", "land_lights_off()", "", "")

function land_lights_toggle()

	dataref("land_light_inL_state","ssg/LGT/lgt_inL_sw","writable")
	dataref("land_light_inR_state","ssg/LGT/lgt_inR_sw","writable")
	dataref("land_light_outL_state","ssg/LGT/lgt_outL_sw","writable")
	dataref("land_light_outR_state","ssg/LGT/lgt_outR_sw","writable")
	
	if(land_light_inL_state == 1 or land_light_inR_state == 1 or land_light_outL_state == 1 or land_light_outR_state == 1 ) then
		set("ssg/LGT/lgt_inL_sw", 0)
		set("ssg/LGT/lgt_inR_sw", 0)
		set("ssg/LGT/lgt_outL_sw", 0)
		set("ssg/LGT/lgt_outR_sw", 0)
	else 
		set("ssg/LGT/lgt_inL_sw", 1)
		set("ssg/LGT/lgt_inR_sw", 1)
		set("ssg/LGT/lgt_outL_sw", 1)
		set("ssg/LGT/lgt_outR_sw", 1)
	end

end
create_command("WeisAIR/b748/lights/land_lights_toggle", "land_lights_toggle", "land_lights_toggle()", "", "")

function beacon_lights_on()

	dataref("beacon_light_state","ssg/LGT/lgt_bcn_sw","writable")
	
	if(beacon_light_state == 0 or beacon_light_state == -1) then
		set("ssg/LGT/lgt_bcn_sw", 1)
	end

end
create_command("WeisAIR/b748/lights/beacon_lights_on", "beacon_lights_on", "beacon_lights_on()", "", "")

function beacon_lights_off()

	dataref("beacon_light_state","ssg/LGT/lgt_bcn_sw","writable")
	
	if(beacon_light_state == 1 or beacon_light_state == -1) then
		set("ssg/LGT/lgt_bcn_sw", 0)
	end

end
create_command("WeisAIR/b748/lights/beacon_lights_off", "beacon_lights_off", "beacon_lights_off()", "", "")

function beacon_lights_toogle()

	dataref("beacon_light_state","ssg/LGT/lgt_bcn_sw","writable")
	
	if(beacon_light_state == -1) then set("ssg/LGT/lgt_bcn_sw", 0)
		else if (beacon_light_state == 0) then set("ssg/LGT/lgt_bcn_sw", 1)
			else set("ssg/LGT/lgt_bcn_sw", -1)
		end
	end
end
create_command("WeisAIR/b748/lights/beacon_lights_toogle", "beacon_lights_toogle", "beacon_lights_toogle()", "", "")

function nav_lights_on()

	dataref("nav_light_state","ssg/LGT/lgt_nav_sw","writable")
	
	if(nav_light_state == 0) then
		set("ssg/LGT/lgt_nav_sw", 1)
	end

end
create_command("WeisAIR/b748/lights/nav_lights_on", "nav_lights_on", "nav_lights_on()", "", "")

function nav_lights_off()

	dataref("nav_light_state","ssg/LGT/lgt_nav_sw","writable")
	
	if(nav_light_state == 1) then
		set("ssg/LGT/lgt_nav_sw", 0)
	end

end
create_command("WeisAIR/b748/lights/nav_lights_off", "nav_lights_off", "nav_lights_off()", "", "")

function nav_lights_toggle()

	dataref("nav_light_state","ssg/LGT/lgt_nav_sw","writable")
	
	if(nav_light_state == 1) then
		set("ssg/LGT/lgt_nav_sw", 0)
	else
		set("ssg/LGT/lgt_nav_sw", 1)
	end

end
create_command("WeisAIR/b748/lights/nav_lights_toggle", "nav_lights_toggle", "nav_lights_toggle()", "", "")


function logo_lights_toggle()

	dataref("logo_light_state","ssg/LGT/lgt_logo_sw","writable")
	
	if(logo_light_state == 1) then
		set("ssg/LGT/lgt_logo_sw", 0)
	else
		set("ssg/LGT/lgt_logo_sw", 1)
	end

end
create_command("WeisAIR/b748/lights/logo_lights_toggle", "logo_lights_toggle", "logo_lights_toggle()", "", "")

function wing_lights_toggle()

	dataref("wing_light_state","ssg/LGT/lgt_wing_sw","writable")
	
	if(wing_light_state == 1) then
		set("ssg/LGT/lgt_wing_sw", 0)
	else
		set("ssg/LGT/lgt_wing_sw", 1)
	end

end
create_command("WeisAIR/b748/lights/wing_lights_toggle", "wing_lights_toggle", "wing_lights_toggle()", "", "")

function strobe_lights_on()

	dataref("strobe_light_state","ssg/LGT/lgt_stb_sw","writable")
	
	if(strobe_light_state == 0) then
		set("ssg/LGT/lgt_stb_sw", 1)
	end

end
create_command("WeisAIR/b748/lights/strobe_lights_on", "strobe_lights_on", "strobe_lights_on()", "", "")

function strobe_lights_off()

	dataref("strobe_light_state","ssg/LGT/lgt_stb_sw","writable")
	
	if(strobe_light_state == 1) then
		set("ssg/LGT/lgt_stb_sw", 0)
	end

end
create_command("WeisAIR/b748/lights/strobe_lights_off", "strobe_lights_off", "strobe_lights_off()", "", "")

function strobe_lights_toogle()

	dataref("strobe_light_state","ssg/LGT/lgt_stb_sw","writable")
	
	if(strobe_light_state == 1) then
		set("ssg/LGT/lgt_stb_sw", 0)
	else
		set("ssg/LGT/lgt_stb_sw", 1)
	end

end
create_command("WeisAIR/b748/lights/strobe_lights_toogle", "strobe_lights_toogle", "strobe_lights_toogle()", "", "")

function chocks_toogle()

	dataref("chocks_state","SSG/B748/chocks_sw","writable")
	
	if(chocks_state == 1) then
		set("SSG/B748/chocks_sw", 0)
	else
		set("SSG/B748/chocks_sw", 1)
	end

end
create_command("WeisAIR/b748/equip/chocks_toogle", "chocks_toogle", "chocks_toogle()", "", "")
--TODO: find / customize CHOCKS icon for streambeck -> is currently under 737/icons and from other author

function toggleCptFD()
	
	dataref("mcp_plt_fd_act", "ssg/B748/MCP/mcp_plt_fd_act", "writable")
			
	if (mcp_plt_fd_act == 0.0) then new_fd_mode = 1.0 end
	if (mcp_plt_fd_act == 1.0) then new_fd_mode = 0.0 end
	
	set("ssg/B748/MCP/mcp_plt_fd_act", new_fd_mode)
end
create_command("WeisAIR/b748/MCP/toggleCptFD", "toggleCptFD", "toggleCptFD()", "", "")

function toggleCpltFD()
	
	dataref("mcp_cplt_fd_act", "ssg/B748/MCP/mcp_cplt_fd_act", "writable")
			
	if (mcp_cplt_fd_act == 0.0) then new_fd_mode = 1.0 end
	if (mcp_cplt_fd_act == 1.0) then new_fd_mode = 0.0 end
	
	set("ssg/B748/MCP/mcp_cplt_fd_act", new_fd_mode)
end
create_command("WeisAIR/b748/MCP/toggleCpltFD", "toggleCpltFD", "toggleCpltFD()", "", "")

---------------------------------------------------------------
-- EICAS Functions---------------------------------------------
---------------------------------------------------------------


function nextEICASleftINDB()
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	
	if(EICASleftINBDstate<11) then 
		nextState = EICASleftINBDstate + 1
		set("ssg/EICAS/inbrdL_sw", nextState)
	end
end
create_command("WeisAIR/b748/EICAS/nextEICASleftINDB", "nextEICASleftINDB", "nextEICASleftINDB()", "", "")

function prevEICASleftINDB()
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	
	if(EICASleftINBDstate>=0) then 
		prevState = EICASleftINBDstate - 1
		set("ssg/EICAS/inbrdL_sw", prevState)
	end
end
create_command("WeisAIR/b748/EICAS/prevEICASleftINDB", "prevEICASleftINDB", "prevEICASleftINDB()", "", "")

function press_l_inbd_button()

	set("ssg/EICAS/inbrdL_bt_sw", 1)
end
function release_l_inbd_button()

	set("ssg/EICAS/inbrdL_bt_sw", 0)
end
create_command("WeisAIR/b748/EICAS/push_l_inbd_button", "push_l_inbd_button", "press_l_inbd_button()", "", "release_l_inbd_button()")

function press_rcl_cncl_button()

	set("ssg/EICAS/reset_bt_sw", 1)
end
function release_rcl_cncl_button()

	set("ssg/EICAS/reset_bt_sw", 0)
end
create_command("WeisAIR/b748/EICAS/eicas_rcl_cncl_push", "eicas_rcl_cncl_push", "press_rcl_cncl_button()", "", "release_rcl_cncl_button()")

function eicas_eng_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=1) then set("ssg/EICAS/inbrdL_sw", 1)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_eng_push", "eicas_eng_push", "eicas_eng_push()", "", "")

function eicas_stat_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=2) then set("ssg/EICAS/inbrdL_sw", 2)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_stat_push", "eicas_stat_push", "eicas_stat_push()", "", "")

function eicas_elec_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=3) then set("ssg/EICAS/inbrdL_sw", 3)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_elec_push", "eicas_elec_push", "eicas_elec_push()", "", "")

function eicas_fuel_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=4) then set("ssg/EICAS/inbrdL_sw", 4)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_fuel_push", "eicas_fuel_push", "eicas_fuel_push()", "", "")

function eicas_ecs_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=5) then set("ssg/EICAS/inbrdL_sw", 5)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_ecs_push", "eicas_ecs_push", "eicas_ecs_push()", "", "")

function eicas_fctl_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=6) then set("ssg/EICAS/inbrdL_sw", 6)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_fctl_push", "eicas_fctl_push", "eicas_fctl_push()", "", "")

function eicas_hyd_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=8) then set("ssg/EICAS/inbrdL_sw", 8)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_hyd_push", "eicas_hyd_push", "eicas_hyd_push()", "", "")

function eicas_drs_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=9) then set("ssg/EICAS/inbrdL_sw", 9)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_drs_push", "eicas_drs_push", "eicas_drs_push()", "", "")

function eicas_gear_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=10) then set("ssg/EICAS/inbrdL_sw", 10)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_gear_push", "eicas_gear_push", "eicas_gear_push()", "", "")

function eicas_info_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=14) then set("ssg/EICAS/inbrdL_sw", 14)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_info_push", "eicas_info_push", "eicas_info_push()", "", "")

function eicas_chkl_push()
	
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	if(EICASleftINBDstate~=7) then set("ssg/EICAS/inbrdL_sw", 7)
		else set("ssg/EICAS/inbrdL_sw", 0)
	end
end
create_command("WeisAIR/b748/EICAS/eicas_chkl_push", "eicas_chkl_push", "eicas_chkl_push()", "", "")

function eicas_nav_push()
	
	set("ssg/EICAS/inbrdL_sw", 0)
	
end
create_command("WeisAIR/b748/EICAS/eicas_nav_push", "eicas_nav_push", "eicas_nav_push()", "", "")

function checklist_dial_up()
	
	dataref("checklist_cursor_pos", "SSG/B748/CHKL/chkl_l_sw", "writable")
	
	new_cursor_pos = checklist_cursor_pos + 1

	if (checklist_cursor_pos < 10) then set("SSG/B748/CHKL/chkl_l_sw", new_cursor_pos)
		else set("SSG/B748/CHKL/chkl_l_sw", 0)
	end

end
create_command("WeisAIR/b748/EICAS/checklist_dial_up", "checklist_dial_up", "checklist_dial_up()", "", "")

function checklist_dial_down()
	
	dataref("checklist_cursor_pos", "SSG/B748/CHKL/chkl_l_sw", "writable")
	
	new_cursor_pos = checklist_cursor_pos - 1

	if (checklist_cursor_pos >= 0) then set("SSG/B748/CHKL/chkl_l_sw", new_cursor_pos)
		else set("SSG/B748/CHKL/chkl_l_sw", 9)
	end

end
create_command("WeisAIR/b748/EICAS/checklist_dial_down", "checklist_dial_down", "checklist_dial_down()", "", "")

function press_checklist_dial_button()

	set("SSG/B748/CHKL/chkl_ok_l_sw", 1)
end
function release_checklist_dial_button()

	set("SSG/B748/CHKL/chkl_ok_l_sw", 0)
end
create_command("WeisAIR/b748/EICAS/checklist_dial_button_push", "checklist_dial_button_push", "press_checklist_dial_button()", "", "release_checklist_dial_button()")

---------------------------------------------------------------
-- EFIS Functions----------------------------------------------
---------------------------------------------------------------
	
function WXR_push_cpt()
	dataref("button_state_WXR", "ssg/B748/ND/show_wheather_pilot", "writable")
	
	button_state_current = button_state_WXR
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_wheather_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/WXR_push_cpt", "WXR_push_cpt", "WXR_push_cpt()", "", "")
	
function STA_push_cpt()
	dataref("button_state_STA", "ssg/B748/ND/show_VOR_pilot", "writable")
	
	button_state_current = button_state_STA
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_VOR_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/STA_push_cpt", "STA_push_cpt", "STA_push_cpt()", "", "")

function WPT_push_cpt()
	dataref("button_state_WPT", "ssg/B748/ND/show_waypoint_pilot", "writable")
	
	button_state_current = button_state_WPT
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_waypoint_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/WPT_push_cpt", "WPT_push_cpt", "WPT_push_cpt()", "", "")

function ARPT_push_cpt()
	dataref("button_state_ARPT", "ssg/B748/ND/show_airport_pilot", "writable")
	
	button_state_current = button_state_ARPT
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_airport_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/ARPT_push_cpt", "ARPT_push_cpt", "ARPT_push_cpt()", "", "")

function DATA_push_cpt()
	dataref("button_state_DATA", "ssg/B748/ND/show_NDB_pilot", "writable")
	
	button_state_current = button_state_DATA
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_NDB_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/DATA_push_cpt", "DATA_push_cpt", "DATA_push_cpt()", "", "")

function POS_push_cpt()
	dataref("button_state_POS", "ssg/B748/ND/show_POS_pilot", "writable")
	
	button_state_current = button_state_POS
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_POS_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/POS_push_cpt", "POS_push_cpt", "POS_push_cpt()", "", "")

function TERR_push_cpt()
	dataref("button_state_TERR", "ssg/B748/ND/show_Terr_pilot", "writable")
	
	button_state_current = button_state_TERR
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_Terr_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/TERR_push_cpt", "TERR_push_cpt", "TERR_push_cpt()", "", "")

function baro_inc()
	dataref("baro_value", "ssg/PFD/baro_act", "readable")
	
	baro_current_before_inc = baro_value
	baro_new_for_inc = baro_current_before_inc + 1
	
	set("ssg/PFD/baro_act", baro_new_for_inc)
	
end
create_command("WeisAIR/b748/EFIS/baro_inc", "baro_inc", "baro_inc()", "", "")

function baro_dec()
	dataref("baro_value", "ssg/PFD/baro_act", "readable")
	
	baro_current_before_dec = baro_value
	baro_new_for_dec = baro_current_before_dec - 1
	
	set("ssg/PFD/baro_act", baro_new_for_dec)
	
end
create_command("WeisAIR/b748/EFIS/baro_dec", "baro_dec", "baro_dec()", "", "")


function baro_set_hpa()
		
	set("ssg/PFD/baro_type_sw", 1)
	
end
create_command("WeisAIR/b748/EFIS/baro_set_hpa", "baro_set_hpa", "baro_set_hpa()", "", "")

function baro_set_in()
		
	set("ssg/PFD/baro_type_sw", 0)
	
end
create_command("WeisAIR/b748/EFIS/baro_set_in", "baro_set_in", "baro_set_in()", "", "")

function mins_set_radio()
		
	set("ssg/PFD/dh_mode_sw", 1)
	
end
create_command("WeisAIR/b748/EFIS/mins_set_radio", "mins_set_radio", "mins_set_radio()", "", "")

function mins_set_baro()
		
	set("ssg/PFD/dh_mode_sw", 0)
	
end
create_command("WeisAIR/b748/EFIS/mins_set_baro", "mins_set_baro", "mins_set_baro()", "", "")

function baro_STD_push()
		
	dataref("button_state_STD", "ssg/PFD/baro_standard_sw_p", "readable")
	
	button_state_current = button_state_STD
	button_state_new = -1
	
	if(button_state_current == 0) then button_state_new = 1 end
	if(button_state_current == 1) then button_state_new = 0 end
	
	set("ssg/PFD/baro_standard_sw_p", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/baro_STD_push", "baro_STD_push", "baro_STD_push()", "", "")

function MTRS_push()
		
	dataref("button_state_MRTS", "ssg/PFD/meters_sw_pilot", "readable")
	
	button_state_current = button_state_MRTS
	button_state_new = -1
	
	if(button_state_current == 0) then button_state_new = 1 end
	if(button_state_current == 1) then button_state_new = 0 end
	
	set("ssg/PFD/meters_sw_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/MTRS_push", "MTRS_push", "MTRS_push()", "", "")

function FPV_push()
	
	dataref("button_state_FPV", "SSG/B748/PFD/fpv_sw_pilot", "readable")
	
	button_state_current = button_state_FPV
	button_state_new = -1
	
	if(button_state_current == 0) then button_state_new = 1 end
	if(button_state_current == 1) then button_state_new = 0 end
	
	set("SSG/B748/PFD/fpv_sw_pilot", button_state_new)
end
create_command("WeisAIR/b748/EFIS/FPV_push", "FPV_push", "FPV_push()", "", "")

function TFC_push()
			
	dataref("button_state_TFC", "ssg/B748/ND/show_TCAS_pilot", "readable")
	
	button_state_current = button_state_TFC
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_TCAS_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/TFC_push", "TFC_push", "TFC_push()", "", "")

function CTR_push()
		
	set("ssg/B748/ND/CRT_pilot", 1.0)
	
end
create_command("WeisAIR/b748/EFIS/CTR_push", "CTR_push", "CTR_push()", "", "")

function mode_APP()
		
	set("ssg/B748/ND/mode_pilot", 0.0)
	
end
create_command("WeisAIR/b748/EFIS/mode_APP", "mode_APP", "mode_APP()", "", "")

function mode_VOR()
		
	set("ssg/B748/ND/mode_pilot", 1.0)
	
end
create_command("WeisAIR/b748/EFIS/mode_VOR", "mode_VOR", "mode_VOR()", "", "")

function mode_MAP()
		
	set("ssg/B748/ND/mode_pilot", 2.0)
	
end
create_command("WeisAIR/b748/EFIS/mode_MAP", "mode_MAP", "mode_MAP()", "", "")

function mode_PLN()
		
	set("ssg/B748/ND/mode_pilot", 3.0)
	
end
create_command("WeisAIR/b748/EFIS/mode_PLN", "mode_PLN", "mode_PLN()", "", "")

function mode_inc()
	
	dataref("map_mode", "ssg/B748/ND/mode_pilot", "writable")
	
	mode_current = map_mode
	mode_new = mode_current + 1.0

	if (mode_new <=3.0 and mode_new >=0.0) 
		then set("ssg/B748/ND/mode_pilot", mode_new)
	end
end
create_command("WeisAIR/b748/EFIS/mode_inc", "mode_inc", "mode_inc()", "", "")

function mode_dec()
	
	dataref("map_mode", "ssg/B748/ND/mode_pilot", "writable")
	
	mode_current = map_mode
	mode_new = mode_current - 1.0

	if (mode_new <=3.0 and mode_new >=0.0) 
		then set("ssg/B748/ND/mode_pilot", mode_new)
	end
end
create_command("WeisAIR/b748/EFIS/mode_dec", "mode_dec", "mode_dec()", "", "")

function mode_toggle()
	
	dataref("map_mode", "ssg/B748/ND/mode_pilot", "writable")
	
	mode_current = map_mode
	mode_new = mode_current + 1.0

	if (mode_new <=3.0)
		then set("ssg/B748/ND/mode_pilot", mode_new)
		else set("ssg/B748/ND/mode_pilot", 0.0)
	end
end
create_command("WeisAIR/b748/EFIS/mode_toggle", "mode_toggle", "mode_toggle()", "", "")


function mins_inc()
	dataref("mins", "ssg/AP/minimum_radio_sw", "readable")
	
	mins_current = mins
	mins_new = mins + 1
	
	set("ssg/AP/minimum_radio_sw", mins_new)
	
end
create_command("WeisAIR/b748/EFIS/mins_inc", "mins_inc", "mins_inc()", "", "")

function mins_dec()
	dataref("mins", "ssg/AP/minimum_radio_sw", "readable")
	
	mins_current = mins
	mins_new = mins - 1
	
	set("ssg/AP/minimum_radio_sw", mins_new)
	
end
create_command("WeisAIR/b748/EFIS/mins_dec", "mins_dec", "mins_dec()", "", "")

function range_inc()
	dataref("range", "ssg/B748/ND/range_pilot", "writable")
	
	range_current = range
	range_new = range + 1.0
	
	if (range_new >= -3.0 and range_new <= 7.0) then set("ssg/B748/ND/range_pilot", range_new) end
	
end
create_command("WeisAIR/b748/EFIS/range_inc", "range_inc", "range_inc()", "", "")

function range_dec()
	dataref("range", "ssg/B748/ND/range_pilot", "writable")
	
	range_current = range
	range_new = range - 1.0
	
	if (range_new >= -3.0 and range_new <= 7.0) then set("ssg/B748/ND/range_pilot", range_new) end
	
end
create_command("WeisAIR/b748/EFIS/range_dec", "range_dec", "range_dec()", "", "")


function range_toggle()
	
	dataref("range", "ssg/B748/ND/range_pilot", "writable")
	
	range_current = range
	range_new = range + 1.0
	
	if (range_new <= 7.0) then set("ssg/B748/ND/range_pilot", range_new) 
	else set("ssg/B748/ND/range_pilot", -3.0) 
	end

end
create_command("WeisAIR/b748/EFIS/range_toggle", "range_toggle", "range_toggle()", "", "")

function range_set_M3()

	set("ssg/B748/ND/range_pilot", -3.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_M3", "range_set_M3", "range_set_M3()", "", "")

function range_set_M2()

	set("ssg/B748/ND/range_pilot", -2.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_M2", "range_set_M2", "range_set_M2()", "", "")

function range_set_M1()

	set("ssg/B748/ND/range_pilot", -1.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_M1", "range_set_M1", "range_set_M1()", "", "")

function range_set_P0()

	set("ssg/B748/ND/range_pilot", 0.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_P0", "range_set_P0", "range_set_P0()", "", "")

function range_set_P1()

	set("ssg/B748/ND/range_pilot", 1.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_P1", "range_set_P1", "range_set_P1()", "", "")

function range_set_P2()

	set("ssg/B748/ND/range_pilot", 2.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_P2", "range_set_P2", "range_set_P2()", "", "")

function range_set_P3()

	set("ssg/B748/ND/range_pilot", 3.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_P3", "range_set_P3", "range_set_P3()", "", "")

function range_set_P4()

	set("ssg/B748/ND/range_pilot", 4.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_P4", "range_set_P4", "range_set_P4()", "", "")

function range_set_P5()

	set("ssg/B748/ND/range_pilot", 5.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_P5", "range_set_P5", "range_set_P5()", "", "")

function range_set_P6()

	set("ssg/B748/ND/range_pilot", 6.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_P6", "range_set_P6", "range_set_P6()", "", "")

function range_set_P7()

	set("ssg/B748/ND/range_pilot", 7.0) 
	
end
create_command("WeisAIR/b748/EFIS/range_set_P7", "range_set_P7", "range_set_P7()", "", "")

function vor_left_set_VOR()
		
	set("ssg/B748/MCP/ap_vor_adf1", 1.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_left_set_VOR", "vor_left_set_VOR", "vor_left_set_VOR()", "", "")

function vor_left_set_OFF()
		
	set("ssg/B748/MCP/ap_vor_adf1", 0.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_left_set_OFF", "vor_left_set_OFF", "vor_left_set_OFF()", "", "")

function vor_left_set_ADF()
		
	set("ssg/B748/MCP/ap_vor_adf1", -1.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_left_set_ADF", "vor_left_set_ADF", "vor_left_set_ADF()", "", "")


function b748_toggle_left_VOR()
		
	dataref("left_vor_pos", "ssg/B748/MCP/ap_vor_adf1", "writable")
	
	-- 	1 == VOR
	-- 	0 == OFF
	-- -1 == ADF
	
	if (left_vor_pos == 0.0) then set("ssg/B748/MCP/ap_vor_adf1", -1.0)
		else if (left_vor_pos == -1.0) then set("ssg/B748/MCP/ap_vor_adf1", 1.0)
			else set("ssg/B748/MCP/ap_vor_adf1", 0.0)
		end
	end
	
end
create_command("WeisAIR/b748/EFIS/toggle_left_VOR", "toggle_left_VOR", "b748_toggle_left_VOR()", "", "")

function b748_toggle_right_vor()
		
	dataref("right_vor_pos", "ssg/B748/MCP/ap_vor_adf2", "writable")
	
	-- 	1 == VOR
	-- 	0 == OFF
	-- -1 == ADF
	
	if (right_vor_pos == 0.0) then set("ssg/B748/MCP/ap_vor_adf2", -1.0)
		else if (right_vor_pos == -1.0) then set("ssg/B748/MCP/ap_vor_adf2", 1.0)
			else set("ssg/B748/MCP/ap_vor_adf2", 0.0)
		end
	end
end
create_command("WeisAIR/b748/EFIS/toggle_right_vor", "toggle_right_vor", "b748_toggle_right_vor()", "", "")

function vor_right_set_VOR()
		
	set("ssg/B748/MCP/ap_vor_adf2", 1.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_right_set_VOR", "vor_right_set_VOR", "vor_right_set_VOR()", "", "")

function vor_right_set_OFF()
		
	set("ssg/B748/MCP/ap_vor_adf2", 0.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_right_set_OFF", "vor_right_set_OFF", "vor_right_set_OFF()", "", "")

function vor_right_set_ADF()
		
	set("ssg/B748/MCP/ap_vor_adf2", -1.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_right_set_ADF", "vor_right_set_ADF", "vor_right_set_ADF()", "", "")

function wipers_dec()
		
	dataref("rangeWiperL", "ssg/ICE/ice_washerL_sw", "writable")
	dataref("rangeWiperR", "ssg/ICE/ice_washerR_sw", "writable")
	
	if (rangeWiperL ~= rangeWiperR) then set ("ssg/ICE/ice_washerL_sw",rangeWiperR) end
	
	range_current = rangeWiperR
	range_new = range_current - 1
	
	if (range_new >= 0 and range_new <= 3) then 
		set("ssg/ICE/ice_washerL_sw", range_new) 
		set("ssg/ICE/ice_washerR_sw", range_new) 
	end	
	
end
create_command("WeisAIR/b748/EFIS/wipers_dec", "wipers_dec", "wipers_dec()", "", "")

function wipers_inc()
		
	dataref("rangeWiperL", "ssg/ICE/ice_washerL_sw", "writable")
	dataref("rangeWiperR", "ssg/ICE/ice_washerR_sw", "writable")
	
	if (rangeWiperL ~= rangeWiperR) then set ("ssg/ICE/ice_washerL_sw",rangeWiperR) end
	
	range_current = rangeWiperR
	range_new = range_current + 1
	
	if (range_new >= 0 and range_new <= 3) then 
		set("ssg/ICE/ice_washerL_sw", range_new) 
		set("ssg/ICE/ice_washerR_sw", range_new) 
	end	
	
end
create_command("WeisAIR/b748/EFIS/wipers_inc", "wipers_inc", "wipers_inc()", "", "")

function transponderUp()
		
	dataref("transponderVal", "ssg/Radio/transp_mode_sw", "writable")
	
	transponder_new = transponderVal + 1
	
	if (transponder_new < 4) then 
		set("ssg/Radio/transp_mode_sw", transponder_new) 
	end	
	
end
create_command("WeisAIR/b748/radios/transponderUp", "transponderUp", "transponderUp()", "", "")

function transponderDn()
		
	dataref("transponderVal", "ssg/Radio/transp_mode_sw", "writable")
	
	transponder_new = transponderVal - 1
	
	if (transponder_new > -1) then 
		set("ssg/Radio/transp_mode_sw", transponder_new) 
	end	
	
end
create_command("WeisAIR/b748/radios/transponderDn", "transponderDn", "transponderDn()", "", "")

function transponderIdent()
		
	set("sim/cockpit/radios/transponder_mode", 4) 
	
end
create_command("WeisAIR/b748/radios/transponderIdent", "transponderIdent", "transponderIdent()", "", "")


-- Transponder Stuff
--  ssg/Radio/transp_Key_0 bis ssg/Radio/transp_Key_7 haben Wert 0 0der 1 (push / release) 
--  ssg/Radio/transp_Key_clr muss vor der Eingabe gedrückt werden um neuen Code eingeben zu können - auch hier 0 (push) und 1 (release)
--  ssg/Radio/transp_mode_sw -> XPDR modes: 0 = STBY, 1 = XPNDR, 2 = TA, 3 = TA/RA
--  ssg/Radio/transp_id_sw -> ident switch - auch hier 0 (push) und 1 (release)
--  sim/cockpit/radios/transponder_code hält den eingegebenen Code nach dem alle 4 digits belegt wurden. Sobald die letzte digit belegt wurde wird der code gespeichert
--  approach:
--		1. sich den Code temporär zusammenbauen mit Encoder, stelle für Stelle
--      2. clr-key
--      3. den erstellten werk schreiben nach sim/cockpit/radios/transponder_code
--       


function toggle_hyd_pump_1()
		
	dataref("hyd_pump_1_mode", "ssg/HYD/hyd_pump1_swb", "readable")
		
	next_mode = hyd_pump_1_mode + 1

	if (next_mode >= -1 and next_mode < 3) then set("ssg/HYD/hyd_pump1_swb", next_mode)
		else set("ssg/HYD/hyd_pump1_swb", -1)
	end			
end
create_command("WeisAIR/b748/hyd/toggle_hyd_pump_1", "toggle_hyd_pump_1", "toggle_hyd_pump_1()", "", "")

function toggle_hyd_pump_2()
		
	dataref("hyd_pump_2_mode", "ssg/HYD/hyd_pump2_swb", "readable")
		
	next_mode = hyd_pump_2_mode + 1

	if (next_mode >= 0 and next_mode < 3) then set("ssg/HYD/hyd_pump2_swb", next_mode)
		else set("ssg/HYD/hyd_pump2_swb", 0)
	end			
end
create_command("WeisAIR/b748/hyd/toggle_hyd_pump_2", "toggle_hyd_pump_2", "toggle_hyd_pump_2()", "", "")

function toggle_hyd_pump_3()
		
	dataref("hyd_pump_3_mode", "ssg/HYD/hyd_pump3_swb", "readable")
		
	next_mode = hyd_pump_3_mode + 1

	if (next_mode >= 0 and next_mode < 3) then set("ssg/HYD/hyd_pump3_swb", next_mode)
		else set("ssg/HYD/hyd_pump3_swb", 0)
	end			
end
create_command("WeisAIR/b748/hyd/toggle_hyd_pump_3", "toggle_hyd_pump_3", "toggle_hyd_pump_3()", "", "")

function toggle_hyd_pump_4()
		
	dataref("hyd_pump_4_mode", "ssg/HYD/hyd_pump4_swb", "readable")
		
	next_mode = hyd_pump_4_mode + 1

	if (next_mode >= -1 and next_mode < 3) then set("ssg/HYD/hyd_pump4_swb", next_mode)
		else set("ssg/HYD/hyd_pump4_swb", -1)
	end			
end
create_command("WeisAIR/b748/hyd/toggle_hyd_pump_4", "toggle_hyd_pump_4", "toggle_hyd_pump_4()", "", "")

function toggle_deice_eng_1()
		
	dataref("deice_mode_eng1", "ssg/ICE/ice_eng1_sw", "readable")
		
	next_mode = deice_mode_eng1 + 1

	if (next_mode >= 0 and next_mode < 3) then set("ssg/ICE/ice_eng1_sw", next_mode)
		else set("ssg/ICE/ice_eng1_sw", 0)
	end			
end
create_command("WeisAIR/b748/deice/toggle_deice_eng_1", "toggle_deice_eng_1", "toggle_deice_eng_1()", "", "")

function toggle_deice_eng_2()
		
	dataref("deice_mode_eng2", "ssg/ICE/ice_eng2_sw", "readable")
		
	next_mode = deice_mode_eng2 + 1

	if (next_mode >= 0 and next_mode < 3) then set("ssg/ICE/ice_eng2_sw", next_mode)
		else set("ssg/ICE/ice_eng2_sw", 0)
	end			
end
create_command("WeisAIR/b748/deice/toggle_deice_eng_2", "toggle_deice_eng_2", "toggle_deice_eng_2()", "", "")

function toggle_deice_eng_3()
		
	dataref("deice_mode_eng3", "ssg/ICE/ice_eng3_sw", "readable")
		
	next_mode = deice_mode_eng3 + 1

	if (next_mode >= 0 and next_mode < 3) then set("ssg/ICE/ice_eng3_sw", next_mode)
		else set("ssg/ICE/ice_eng3_sw", 0)
	end			
end
create_command("WeisAIR/b748/deice/toggle_deice_eng_3", "toggle_deice_eng_3", "toggle_deice_eng_3()", "", "")

function toggle_deice_eng_4()
		
	dataref("deice_mode_eng4", "ssg/ICE/ice_eng4_sw", "readable")
		
	next_mode = deice_mode_eng4 + 1

	if (next_mode >= 0 and next_mode < 3) then set("ssg/ICE/ice_eng4_sw", next_mode)
		else set("ssg/ICE/ice_eng4_sw", 0)
	end			
end
create_command("WeisAIR/b748/deice/toggle_deice_eng_4", "toggle_deice_eng_4", "toggle_deice_eng_4()", "", "")

function toggle_deice_wing()
		
	dataref("deice_mode_wing", "ssg/ICE/ice_wing_sw", "readable")
		
	next_mode = deice_mode_wing + 1

	if (next_mode >= 0 and next_mode < 3) then set("ssg/ICE/ice_wing_sw", next_mode)
		else set("ssg/ICE/ice_wing_sw", 0)
	end			
end
create_command("WeisAIR/b748/deice/toggle_deice_wing", "toggle_deice_wing", "toggle_deice_wing()", "", "")

function toggle_altn_vent()
		
	dataref("altn_vent_mode", "ssg/B748/altn_vent_valve_sw", "readable")
		
	next_mode = altn_vent_mode + 1

	if (next_mode >= -1 and next_mode <= 1) then set("ssg/B748/altn_vent_valve_sw", next_mode)
		else set("ssg/B748/altn_vent_valve_sw", -1)
	end			
end
create_command("WeisAIR/b748/pressure/toggle_altn_vent", "toggle_altn_vent", "toggle_altn_vent()", "", "")

function toggle_auto_select()
		
	dataref("auto_select_mode", "ssg/ECS/auto_ecs_sel", "readable")
		
	next_mode = auto_select_mode + 1

	if (next_mode >= 0 and next_mode <= 2) then set("ssg/ECS/auto_ecs_sel", next_mode)
		else set("ssg/ECS/auto_ecs_sel", 0)
	end			
end
create_command("WeisAIR/b748/ecs/toggle_auto_select", "toggle_auto_select", "toggle_auto_select()", "", "")


function toggle_autobrakes()
		
	dataref("autobrakes_mode", "ssg/GEAR/autobrake_sel", "readable")
		
	next_mode = autobrakes_mode + 1

	if (next_mode >= 0 and next_mode <= 6) then set("ssg/GEAR/autobrake_sel", next_mode)
		else set("ssg/GEAR/autobrake_sel", 0)
	end			
end
create_command("WeisAIR/b748/gear/toggle_autobrakes", "toggle_autobrakes", "toggle_autobrakes()", "", "")

function toggle_stby_power()
	
	dataref("current_stby_pwr", "ssg/Elec/bat2_sw", "writable")
	
	new_stby_pwr = current_stby_pwr + 1

	if (new_stby_pwr < 3) then set("ssg/Elec/bat2_sw", new_stby_pwr)
		else set("ssg/Elec/bat2_sw", 0)
	end

end
create_command("WeisAIR/b748/eng/toggle_stby_power", "toggle_stby_power", "toggle_stby_power()", "", "")

function toggle_eng1_fuel_control()
		
	dataref("fuel_control_eng1", "ssg/ENG/eng1_cutoff_sw", "readable")
		
	fuel_control_eng1_tmp = fuel_control_eng1
	
	if (fuel_control_eng1_tmp == 0) then set("ssg/ENG/eng1_cutoff_sw", 1) end
	if (fuel_control_eng1_tmp == 1) then set("ssg/ENG/eng1_cutoff_sw", 0) end
		
	
end
create_command("WeisAIR/b748/eng/toggle_eng1_fuel_control", "toggle_eng1_fuel_control", "toggle_eng1_fuel_control()", "", "")

function toggle_eng2_fuel_control()
		
	dataref("fuel_control_eng2", "ssg/ENG/eng2_cutoff_sw", "readable")
		
	fuel_control_eng2_tmp = fuel_control_eng2
	
	if (fuel_control_eng2_tmp == 0) then set("ssg/ENG/eng2_cutoff_sw", 1) end
	if (fuel_control_eng2_tmp == 1) then set("ssg/ENG/eng2_cutoff_sw", 0) end
		
	
end
create_command("WeisAIR/b748/eng/toggle_eng2_fuel_control", "toggle_eng2_fuel_control", "toggle_eng2_fuel_control()", "", "")

function toggle_eng3_fuel_control()
		
	dataref("fuel_control_eng3", "ssg/ENG/eng3_cutoff_sw", "readable")
		
	fuel_control_eng3_tmp = fuel_control_eng3
	
	if (fuel_control_eng3_tmp == 0) then set("ssg/ENG/eng3_cutoff_sw", 1) end
	if (fuel_control_eng3_tmp == 1) then set("ssg/ENG/eng3_cutoff_sw", 0) end
		
	
end
create_command("WeisAIR/b748/eng/toggle_eng3_fuel_control", "toggle_eng3_fuel_control", "toggle_eng3_fuel_control()", "", "")

function toggle_eng4_fuel_control()
		
	dataref("fuel_control_eng4", "ssg/ENG/eng4_cutoff_sw", "readable")
		
	fuel_control_eng4_tmp = fuel_control_eng4
	
	if (fuel_control_eng4_tmp == 0) then set("ssg/ENG/eng4_cutoff_sw", 1) end
	if (fuel_control_eng4_tmp == 1) then set("ssg/ENG/eng4_cutoff_sw", 0) end
		
	
end
create_command("WeisAIR/b748/eng/toggle_eng4_fuel_control", "toggle_eng4_fuel_control", "toggle_eng4_fuel_control()", "", "")

function apu1_start()

	set("ssg/Elec/APU1_sw", 2)
end
create_command("WeisAIR/b748/eng/apu1_start", "apu1_start", "apu1_start()", "", "")

function mcp_speed()

	dataref("fn_activated","bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if (fn_activated == 0) then command_once("SSG/UFMC/AP_SPD_Button") end
	if (fn_activated == 1) then command_once("SSG/UFMC/AP_SPD_Intervention_Button") end

end
create_command("WeisAIR/b748/mcp/mcp_speed", "mcp_speed", "mcp_speed()", "", "")

function mcp_altitude()

	dataref("fn_activated","bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if (fn_activated == 0) then command_once("SSG/UFMC/AP_ALTHOLD_Button") end
	if (fn_activated == 1) then command_once("SSG/UFMC/AP_Altitude_Intervention_Button") end

end
create_command("WeisAIR/b748/mcp/mcp_altitude", "mcp_altitude", "mcp_altitude()", "", "")

function checklistUp()
		
	dataref("checklistVal", "SSG/B748/CHKL/chkl_r_sw", "writable")
	
	checklistVal_current = checklistVal
	checklistVal_new = checklistVal_current + 1
	
	if (checklistVal_new >= -1 and checklistVal_new <= 9) then 
		set("SSG/B748/CHKL/chkl_r_sw", checklistVal_new)		
	end	
	
end
create_command("WeisAIR/b748/chkl/checklistUp", "checklistUp", "checklistUp()", "", "")

function checklistDn()
		
	dataref("checklistVal", "SSG/B748/CHKL/chkl_r_sw", "writable")
	
	checklistVal_current = checklistVal
	checklistVal_new = checklistVal_current - 1
	
	if (checklistVal_new >= -1 and checklistVal_new <= 9) then 
		set("SSG/B748/CHKL/chkl_r_sw", checklistVal_new)		
	end	
	
end
create_command("WeisAIR/b748/chkl/checklistDn", "checklistDn", "checklistDn()", "", "")

function checklistOkButton()

	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 0)	
end
create_command("WeisAIR/b748/chkl/checklistOkButton", "checklistOkButton", "checklistOkButton()", "", "")


function TOGA_ATHR_ARM_toggle()


	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("SSG/UFMC/TOGA_Button")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("SSG/UFMC/AP_ARM_AT_Switch")
	
	end

end
create_command("WeisAIR/b748/TOGA_ATHR_ARM_toggle", "TOGA_ATHR_ARM_toggle", "TOGA_ATHR_ARM_toggle()", "", "")

function AP_SPEED_SPEEDINT_toggle()


	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("SSG/UFMC/AP_SPD_Intervention_Button")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("SSG/UFMC/AP_SPD_Button")
	
	end

end
create_command("WeisAIR/b748/AP_SPEED_SPEEDINT_toggle", "AP_SPEED_SPEEDINT_toggle", "AP_SPEED_SPEEDINT_toggle()", "", "")


function press_master_caution()

	set("ssg/EICAS/master_pushl_sw", 1)
end
function release_master_caution()

	set("ssg/EICAS/master_pushl_sw", 0)
end
create_command("WeisAIR/b748/clear_master_caution", "clear_master_caution", "press_master_caution()", "", "release_master_caution()")

function fire_test_start()

	set("ssg/Fire/fire_test_sw", 1)
end
function fire_test_end()

	set("ssg/Fire/fire_test_sw", 0)
end
create_command("WeisAIR/b748/fire_test", "fire_test", "fire_test_start()", "", "fire_test_end()")

function annun_test_start()

	set("ssg/Elec/ovhd__lt_dimm_sw", 1)
end
function annun_test_end()

	set("ssg/Elec/ovhd__lt_dimm_sw", 0)
end
create_command("WeisAIR/b748/ovhd_annun_test", "ovhd_annun_test", "annun_test_start()", "", "annun_test_end()")


