--|-----------------------------------|--
--|--//WeisAIR EFIS Panel Commands//--|--
--|-----------------------------------|--
--MINS Encoder A
function mins_inc()
	dataref("mins", "ssg/AP/minimum_radio_sw", "readable")
	
	mins_current = mins
	mins_new = mins + 1
	
	set("ssg/AP/minimum_radio_sw", mins_new)
	
end
create_command("WeisAIR/b748/EFIS/mins_inc", "mins_inc", "mins_inc()", "", "")

--MINS Encoder B
function mins_dec()
	dataref("mins", "ssg/AP/minimum_radio_sw", "readable")
	
	mins_current = mins
	mins_new = mins - 1
	
	set("ssg/AP/minimum_radio_sw", mins_new)
	
end
create_command("WeisAIR/b748/EFIS/mins_dec", "mins_dec", "mins_dec()", "", "")

--BARO Encoder A
function baro_inc()
	dataref("baro_value", "ssg/PFD/baro_act", "readable")
	
	baro_current_before_inc = baro_value
	baro_new_for_inc = baro_current_before_inc + 1
	
	set("ssg/PFD/baro_act", baro_new_for_inc)
	
end
create_command("WeisAIR/b748/EFIS/baro_inc", "baro_inc", "baro_inc()", "", "")

--BARO Encoder B
function baro_dec()
	dataref("baro_value", "ssg/PFD/baro_act", "readable")
	
	baro_current_before_dec = baro_value
	baro_new_for_dec = baro_current_before_dec - 1
	
	set("ssg/PFD/baro_act", baro_new_for_dec)
	
end
create_command("WeisAIR/b748/EFIS/baro_dec", "baro_dec", "baro_dec()", "", "")

--MINS Encoder Button
	--INOP
	
--BARO Encoder Button
function baro_STD_push()
		
	dataref("button_state_STD", "ssg/PFD/baro_standard_sw_p", "readable")
	
	button_state_current = button_state_STD
	button_state_new = -1
	
	if(button_state_current == 0) then button_state_new = 1 end
	if(button_state_current == 1) then button_state_new = 0 end
	
	set("ssg/PFD/baro_standard_sw_p", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/baro_STD_push", "baro_STD_push", "baro_STD_push()", "", "")

--Switch 1 RADIO
function mins_set_radio()
		
	set("ssg/PFD/dh_mode_sw", 1)
	
end
create_command("WeisAIR/b748/EFIS/mins_set_radio", "mins_set_radio", "mins_set_radio()", "", "")

--Switch 1 BARO
function mins_set_baro()
		
	set("ssg/PFD/dh_mode_sw", 0)
	
end
create_command("WeisAIR/b748/EFIS/mins_set_baro", "mins_set_baro", "mins_set_baro()", "", "")

--Switch 2 IN
function baro_set_in()
		
	set("ssg/PFD/baro_type_sw", 0)
	
end
create_command("WeisAIR/b748/EFIS/baro_set_in", "baro_set_in", "baro_set_in()", "", "")

--Switch 2 HPA
function baro_set_hpa()
		
	set("ssg/PFD/baro_type_sw", 1)
	
end
create_command("WeisAIR/b748/EFIS/baro_set_hpa", "baro_set_hpa", "baro_set_hpa()", "", "")

--Switch 3 VOR 1
function vor_left_set_VOR()
		
	set("ssg/B748/MCP/ap_vor_adf1", 1.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_left_set_VOR", "vor_left_set_VOR", "vor_left_set_VOR()", "", "")

--Switch 3 ADF 1
function vor_left_set_ADF()
		
	set("ssg/B748/MCP/ap_vor_adf1", -1.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_left_set_ADF", "vor_left_set_ADF", "vor_left_set_ADF()", "", "")

--Switch 4 VOR 2
function vor_right_set_VOR()
		
	set("ssg/B748/MCP/ap_vor_adf2", 1.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_right_set_VOR", "vor_right_set_VOR", "vor_right_set_VOR()", "", "")
	
--Switch 4 ADF 2
function vor_right_set_ADF()
		
	set("ssg/B748/MCP/ap_vor_adf2", -1.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_right_set_ADF", "vor_right_set_ADF", "vor_right_set_ADF()", "", "")
	
--MAP MODE PREV
function mode_dec()
	
	dataref("map_mode", "ssg/B748/ND/mode_pilot", "writable")
	
	mode_current = map_mode
	mode_new = mode_current - 1.0

	if (mode_new <=3.0 and mode_new >=0.0) 
		then set("ssg/B748/ND/mode_pilot", mode_new)
	end
end
create_command("WeisAIR/b748/EFIS/mode_dec", "mode_dec", "mode_dec()", "", "")

--MAP MODE CTR
function CTR_push()
		
	set("ssg/B748/ND/CRT_pilot", 1.0)
	
end
create_command("WeisAIR/b748/EFIS/CTR_push", "CTR_push", "CTR_push()", "", "")

--MAP MODE NEXT
function mode_inc()
	
	dataref("map_mode", "ssg/B748/ND/mode_pilot", "writable")
	
	mode_current = map_mode
	mode_new = mode_current + 1.0

	if (mode_new <=3.0 and mode_new >=0.0) 
		then set("ssg/B748/ND/mode_pilot", mode_new)
	end
end
create_command("WeisAIR/b748/EFIS/mode_inc", "mode_inc", "mode_inc()", "", "")

--MAP RANGE DEC
function range_dec()
	dataref("range", "ssg/B748/ND/range_pilot", "writable")
	
	range_current = range
	range_new = range - 1.0
	
	if (range_new >= -3.0 and range_new <= 7.0) then set("ssg/B748/ND/range_pilot", range_new) end
	
end
create_command("WeisAIR/b748/EFIS/range_dec", "range_dec", "range_dec()", "", "")

--MAP RANGE TFC
function TFC_push()
			
	dataref("button_state_TFC", "ssg/B748/ND/show_TCAS_pilot", "readable")
	
	button_state_current = button_state_TFC
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_TCAS_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/TFC_push", "TFC_push", "TFC_push()", "", "")

--MAP RANGE INC
function range_inc()
	dataref("range", "ssg/B748/ND/range_pilot", "writable")
	
	range_current = range
	range_new = range + 1.0
	
	if (range_new >= -3.0 and range_new <= 7.0) then set("ssg/B748/ND/range_pilot", range_new) end
	
end
create_command("WeisAIR/b748/EFIS/range_inc", "range_inc", "range_inc()", "", "")

--BTN WXR
function WXR_push_cpt()
	dataref("button_state_WXR", "ssg/B748/ND/show_wheather_pilot", "writable")
	
	button_state_current = button_state_WXR
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_wheather_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/WXR_push_cpt", "WXR_push_cpt", "WXR_push_cpt()", "", "")

--BTN STA
function STA_push_cpt()
	dataref("button_state_STA", "ssg/B748/ND/show_VOR_pilot", "writable")
	
	button_state_current = button_state_STA
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_VOR_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/STA_push_cpt", "STA_push_cpt", "STA_push_cpt()", "", "")

--BTN WPT
function WPT_push_cpt()
	dataref("button_state_WPT", "ssg/B748/ND/show_waypoint_pilot", "writable")
	
	button_state_current = button_state_WPT
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_waypoint_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/WPT_push_cpt", "WPT_push_cpt", "WPT_push_cpt()", "", "")

--BTN APRT
function ARPT_push_cpt()
	dataref("button_state_ARPT", "ssg/B748/ND/show_airport_pilot", "writable")
	
	button_state_current = button_state_ARPT
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_airport_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/ARPT_push_cpt", "ARPT_push_cpt", "ARPT_push_cpt()", "", "")

--BTN DATA
function DATA_push_cpt()
	dataref("button_state_DATA", "ssg/B748/ND/show_NDB_pilot", "writable")
	
	button_state_current = button_state_DATA
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_NDB_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/DATA_push_cpt", "DATA_push_cpt", "DATA_push_cpt()", "", "")

--BTN POS
function POS_push_cpt()
	dataref("button_state_POS", "ssg/B748/ND/show_POS_pilot", "writable")
	
	button_state_current = button_state_POS
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_POS_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/POS_push_cpt", "POS_push_cpt", "POS_push_cpt()", "", "")

--BTN TERR
function TERR_push_cpt()
	dataref("button_state_TERR", "ssg/B748/ND/show_Terr_pilot", "writable")
	
	button_state_current = button_state_TERR
	button_state_new = -1.0
	
	if(button_state_current == 0.0) then button_state_new = 1.0 end
	if(button_state_current == 1.0) then button_state_new = 0.0 end
	
	set("ssg/B748/ND/show_Terr_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/TERR_push_cpt", "TERR_push_cpt", "TERR_push_cpt()", "", "")

--BTN FPV
function FPV_push()
	
	dataref("button_state_FPV", "SSG/B748/PFD/fpv_sw_pilot", "readable")
	
	button_state_current = button_state_FPV
	button_state_new = -1
	
	if(button_state_current == 0) then button_state_new = 1 end
	if(button_state_current == 1) then button_state_new = 0 end
	
	set("SSG/B748/PFD/fpv_sw_pilot", button_state_new)
end
create_command("WeisAIR/b748/EFIS/FPV_push", "FPV_push", "FPV_push()", "", "")

--BTN MTRS

function MTRS_push()
		
	dataref("button_state_MRTS", "ssg/PFD/meters_sw_pilot", "readable")
	
	button_state_current = button_state_MRTS
	button_state_new = -1
	
	if(button_state_current == 0) then button_state_new = 1 end
	if(button_state_current == 1) then button_state_new = 0 end
	
	set("ssg/PFD/meters_sw_pilot", button_state_new)
	
end
create_command("WeisAIR/b748/EFIS/MTRS_push", "MTRS_push", "MTRS_push()", "", "")
	

--|-----------------------------------|--
--|--//WeisAIR GEAR Panel Commands//--|--
--|-----------------------------------|--
--GEAR POS 1
--GEAR POS 2
--GEAR POS 3
--|-----------------------------------|--
--|--//WeisAIR Multipanel Commands//--|--
--|-----------------------------------|--

--Multipanel Switch 1 ON (FD)
function b748_fdir_both_on()

	dataref("fdir_position_pilot", "ssg/B748/MCP/mcp_plt_fd_act", "writable")
	dataref("fdir_position_copilot", "ssg/B748/MCP/mcp_cplt_fd_act", "writable")
	
	if (fdir_position_pilot == 0.0 and fdir_position_copilot == 0.0) then 

		command_once("SSG/UFMC/FD_Pilot_SW")
		command_once("SSG/UFMC/FD_Copilot_SW")
		
	end
	
end
create_command("WeisAIR/b748/Multipanel/fdir_both_on", "fdir_both_on", "b748_fdir_both_on()", "", "")	
	
--Multipanel Switch 1 OFF (FD)
function b748_fdir_both_off()

	dataref("fdir_position_pilot", "ssg/B748/MCP/mcp_plt_fd_act", "writable")
	dataref("fdir_position_copilot", "ssg/B748/MCP/mcp_cplt_fd_act", "writable")	
	
	if (fdir_position_pilot == 1.0 and fdir_position_copilot == 1.0) then 

		command_once("SSG/UFMC/FD_Pilot_SW")
		command_once("SSG/UFMC/FD_Copilot_SW")
		
	end
	
end
create_command("WeisAIR/b748/Multipanel/fdir_both_off", "fdir_both_off", "b748_fdir_both_off()", "", "")	

--Multipanel Switch 2 ON (ATHR)
--Multipanel Switch 2 OFF (ATHR)
	
--|--------------------------------------------------------|--
--|--//WeisAIR Multipanal Commands for Airmanager Panel//--|--
--|--------------------------------------------------------|--

function incMcpAltitude()
	dataref("mcp_altitude", "ssg/B748/MCP/mcp_alt_target_act", "writable")
	new_altitude = mcp_altitude + 100.0
	set("ssg/B748/MCP/mcp_alt_target_act", new_altitude)
end
create_command("WeisAIR/b748/MultiPanel/incMcpAltitude", "incMcpAltitude", "incMcpAltitude()", "", "")

function decMcpAltitude()
	dataref("mcp_altitude", "ssg/B748/MCP/mcp_alt_target_act", "writable")
	new_altitude = mcp_altitude - 100.0
	set("ssg/B748/MCP/mcp_alt_target_act", new_altitude)
end
create_command("WeisAIR/b748/MultiPanel/decMcpAltitude", "decMcpAltitude", "decMcpAltitude()", "", "")	

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

function transponderIdent()
		
	set("sim/cockpit/radios/transponder_mode", 3) 
	
end
create_command("WeisAIR/b748/radios/transponderIdent", "transponderIdent", "transponderIdent()", "", "")

function press_master_caution()

	set("ssg/EICAS/master_pushl_sw", 1)
end
function release_master_caution()

	set("ssg/EICAS/master_pushl_sw", 0)
end
create_command("WeisAIR/b748/clear_master_caution", "clear_master_caution", "press_master_caution()", "", "release_master_caution()")

function AP_SPEED_SPEEDINT_toggle()

	--TODO: how to simulate a "long" press?
	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("SSG/UFMC/AP_SPD_Intervention_Button")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("SSG/UFMC/AP_SPD_Button")
	
	end

end
create_command("WeisAIR/b748/AP_SPEED_SPEEDINT_toggle", "AP_SPEED_SPEEDINT_toggle", "AP_SPEED_SPEEDINT_toggle()", "", "")

function AP_SPEED_SPEEDINT_toggle()

	--TODO: how to simulate a "long" press?
	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("SSG/UFMC/AP_SPD_Intervention_Button")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("SSG/UFMC/AP_SPD_Button")
	
	end

end
create_command("WeisAIR/b748/AP_SPEED_SPEEDINT_toggle", "AP_SPEED_SPEEDINT_toggle", "AP_SPEED_SPEEDINT_toggle()", "", "")

function mcp_speed()

	--TODO: how to simulate a "long" press?
	dataref("fn_activated","bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if (fn_activated == 0) then command_once("SSG/UFMC/AP_SPD_Button") end
	if (fn_activated == 1) then command_once("SSG/UFMC/AP_SPD_Intervention_Button") end

end
create_command("WeisAIR/b748/mcp/mcp_speed", "mcp_speed", "mcp_speed()", "", "")

function mcp_altitude()

	--TODO: how to simulate a "long" press?
	dataref("fn_activated","bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if (fn_activated == 0) then command_once("SSG/UFMC/AP_ALTHOLD_Button") end
	if (fn_activated == 1) then command_once("SSG/UFMC/AP_Altitude_Intervention_Button") end

end
create_command("WeisAIR/b748/mcp/mcp_altitude", "mcp_altitude", "mcp_altitude()", "", "")
	

--|-------------------------------------|--
--|--//WeisAIR Lights panel Commands//--|--
--|-------------------------------------|--
--Landing Light ON
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
create_command("WeisAIR/b748/LIGHTS/land_lights_on", "land_lights_on", "land_lights_on()", "", "")

--Landing Light OFF
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
create_command("WeisAIR/b748/LIGHTS/land_lights_off", "land_lights_off", "land_lights_off()", "", "")
--RWTO Light ON
function rwto_lights_on()
	
	dataref("rwto_left_state", "ssg/LGT/lgt_rwyL_sw","writable")
	dataref("rwto_right_state", "ssg/LGT/lgt_rwyR_sw","writable")
	
	if(rwto_left_state == 0 or rwto_right_state == 0) then
		set("ssg/LGT/lgt_rwyL_sw", 1)
		set("ssg/LGT/lgt_rwyR_sw", 1)
	end
	
end
create_command("WeisAIR/b748/LIGHTS/rwto_lights_on", "rwto_lights_on", "rwto_lights_on()", "", "")

--RWTO Light OFF
function rwto_lights_off()
	
	dataref("rwto_left_state", "ssg/LGT/lgt_rwyL_sw","writable")
	dataref("rwto_right_state", "ssg/LGT/lgt_rwyR_sw","writable")
	
	if(rwto_left_state == 1 or rwto_right_state == 1) then
		set("ssg/LGT/lgt_rwyL_sw", 0)
		set("ssg/LGT/lgt_rwyR_sw", 0)
	end
	
end
create_command("WeisAIR/b748/LIGHTS/taxi_rwto_lights_off", "taxi_rwto_lights_off", "taxi_rwto_lights_off()", "", "")

--TAXI Light ON
function taxi_lights_on()
	
	dataref("taxi_state","ssg/LGT/lgt_taxi_sw","writable")
	
	if(taxi_state == 0) then
		set("ssg/LGT/lgt_taxi_sw", 1)
	end
	
end
create_command("WeisAIR/b748/LIGHTS/taxi_lights_on", "taxi_lights_on", "taxi_lights_on()", "", "")

--TAXI Light OFF
function taxi_lights_off()
	
	dataref("taxi_state","ssg/LGT/lgt_taxi_sw","writable")
	
	if(taxi_state == 1) then
		set("ssg/LGT/lgt_taxi_sw", 0)
	end
	
end
create_command("WeisAIR/b748/LIGHTS/taxi_lights_off", "taxi_lights_off", "taxi_lights_off()", "", "")

--LOGO Light ON
--LOGO Light OFF
--STROBE Light ON
--STROBE Light OFF
--BEACON Light ON
--BEACON Light OFF
--WING Light ON
--WING Light OFF
--WHEEL WELL Light ON
--WHEEL WELL Light OFF
--COCKPIT Light ON
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

--COCKPIT Light OFF
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
--|-----------------------------------|--
--|--//WeisAIR MFD Commands//---------|--
--|-----------------------------------|--
--Generic Lower Button 1
--Generic Lower Button 2
function nextEICASleftINDB()
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	
	if(EICASleftINBDstate<11) then 
		nextState = EICASleftINBDstate + 1
		set("ssg/EICAS/inbrdL_sw", nextState)
	end
end
create_command("WeisAIR/b748/MFDPanel/nextEICASleftINDB", "nextEICASleftINDB", "nextEICASleftINDB()", "", "")

--Generic Lower Button 3
function prevEICASleftINDB()
	dataref("EICASleftINBDstate", "ssg/EICAS/inbrdL_sw", "writable")
	
	if(EICASleftINBDstate>=0) then 
		prevState = EICASleftINBDstate - 1
		set("ssg/EICAS/inbrdL_sw", prevState)
	end
end
create_command("WeisAIR/b748/MFDPanel/prevEICASleftINDB", "prevEICASleftINDB", "prevEICASleftINDB()", "", "")

--Generic Lower Button 4
--Generic Lower Button 5
--Generic Lower Button 6
--Generic Lower Button 7
--Generic Lower Button 8
--Generic Lower Button 9
--Generic Lower Button 10
--Generic Lower Button 11
--Generic Lower Button 12
--Generic Right Button 13
--Generic Right Button 14
--Generic Right Button 15
--Generic Right Button 16
--Generic Right Button 17
--Generic Right Button 18

--GA Outer Enc ++
function checklistUp()
		
	dataref("checklistVal", "SSG/B748/CHKL/chkl_r_sw", "writable")
	
	checklistVal_current = checklistVal
	checklistVal_new = checklistVal_current + 1
	
	if (checklistVal_new >= -1 and checklistVal_new <= 9) then 
		set("SSG/B748/CHKL/chkl_r_sw", checklistVal_new)		
	end	
	
end
create_command("WeisAIR/b748/MFDPanel/checklistUp", "checklistUp", "checklistUp()", "", "")

--GA Outer Enc --
function checklistDn()
		
	dataref("checklistVal", "SSG/B748/CHKL/chkl_r_sw", "writable")
	
	checklistVal_current = checklistVal
	checklistVal_new = checklistVal_current - 1
	
	if (checklistVal_new >= -1 and checklistVal_new <= 9) then 
		set("SSG/B748/CHKL/chkl_r_sw", checklistVal_new)		
	end	
	
end
create_command("WeisAIR/b748/MFDPanel/checklistDn", "checklistDn", "checklistDn()", "", "")

--GA Inner Enc ++
--GA Inner Enc --

--GA Outer Button
function checklistOkButton()

	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 1)
	set("SSG/B748/CHKL/chkl_ok_r_sw", 0)	
end
create_command("WeisAIR/b748/MFDPanel/checklistOkButton", "checklistOkButton", "checklistOkButton()", "", "")

--GA Inner Button
--|-----------------------------------|--
--|--//WeisAIR Systems Commands//-----|--
--|-----------------------------------|--
--FUEL PUMP ON
--FUEL PUMP OFF
--ANTI ICE ON
--ANTI ICE OFF
--PITOT HEAT ON
--PITOT HEAT OFF
--YAW DAMPER ON
--YAW DAMPER OFF
--XPDR MODE ++
function transponderUp()
		
	dataref("transponderVal", "sim/cockpit/radios/transponder_mode", "writable")
	
	transponder_current = transponderVal
	transponder_new = transponder_current + 1
	
	if (transponder_new >= 1 and transponder_new <= 2) then 
		set("sim/cockpit/radios/transponder_mode", transponder_new) 
		set("sim/cockpit2/radios/actuators/transponder_mode", transponder_new) 		
	end	
	
end
create_command("WeisAIR/b748/Systems/transponderUp", "transponderUp", "transponderUp()", "", "")

--XPDR MODE --
function transponderDn()
		
	dataref("transponderVal", "sim/cockpit/radios/transponder_mode", "writable")
	
	
	transponder_current = transponderVal
	transponder_new = transponder_current - 1
	
	if (transponder_new >= 1 and transponder_new <= 2) then 
		set("sim/cockpit/radios/transponder_mode", transponder_new) 
		set("sim/cockpit2/radios/actuators/transponder_mode", transponder_new) 
	end	
	
end
create_command("WeisAIR/b748/Systems/transponderDn", "transponderDn", "transponderDn()", "", "")

--IRS ALIGN ON
--IRS ALIGN OFF
--|------------------------------------|--
--|--//WeisAIR Lower Panel Commands//--|--
--|------------------------------------|--
--Switch Park Brk ON
--Switch Park Brk OFF
--Switch Cabin Sign ON
function seatBelt_sign_on()
	
	dataref("seat_belt_sign_state", "ssg/PASS/passenger_signal_sw", "writable")
	
	if(seat_belt_sign_state == 0) then set("ssg/PASS/passenger_signal_sw", 2) end
		
end
create_command("WeisAIR/b748/OtherFunctionality/seatBelt_sign_on", "seatBelt_sign_on", "seatBelt_sign_on()", "", "")

--Switch Cabin Sign OFF
function seatBelt_sign_off()
	
	dataref("seat_belt_sign_state", "ssg/PASS/passenger_signal_sw", "writable")
	
	if(seat_belt_sign_state == 2) then set("ssg/PASS/passenger_signal_sw", 0) end
	
end
create_command("WeisAIR/b748/OtherFunctionality/seatBelt_sign_off", "seatBelt_sign_off", "seatBelt_sign_off()", "", "")


--Toggle LIGHTS Test
--Toggle FIRE WARN Test
--|-------------------------------------|--
--|--//WeisAIR Energy Panel Commands//--|--
--|-------------------------------------|--
--BAT ON
--BAT OFF
--GPU ON
--GPU OFF
--APU TOGGLE GEN
--APU TOGGLE STARTER
--ENG 1 TOGGLE GEN
--ENG 1 TOGGLE STARTER
--ENG 2 TOGGLE GEN
--ENG 2 TOGGLE STARTER
--ENG 3 TOGGLE GEN
--ENG 3 TOGGLE STARTER
--ENG 4 TOGGLE GEN
--ENG 4 TOGGLE STARTER
--|-----------------------------------|--
--|--//WeisAIR Yoke Commands//--------|--
--|-----------------------------------|--
--left button top
	--> SSG/UFMC/AP_discon_Button
--left button back
	--> pushToTalk
--left Hatswitch Up
--left Hatswitch Dn
--left Hatswitch Left
--left Hatswitch Right
--left trim A
--left trim B
--right white button
--right red button
function TOGA_ATHR_ARM_toggle()

	-- simulate "long" press
	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("SSG/UFMC/TOGA_Button")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("SSG/UFMC/AP_ARM_AT_Switch")
	
	end

end
create_command("WeisAIR/b748/TOGA_ATHR_ARM_toggle", "TOGA_ATHR_ARM_toggle", "TOGA_ATHR_ARM_toggle()", "", "")
--right trim A
--right trim B
--MASTER ALT
--MASTER BAT
--BUS 1
--BUS 2
--Light BCN
--Light LAND
--Light TAXI
--Light NAV
--Light Strobe
--IGN OFF
--IGN R
--IGN L
--IGN BOTH
--IGN START
	
	
--|-----------------------------------|--
--|--//WeisAIR Throttle Commands//----|--
--|-----------------------------------|--
--T1.1
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
create_command("WeisAIR/b748/OtherFunctionality/wipers_inc", "wipers_inc", "wipers_inc()", "", "")

--T1.2
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
create_command("WeisAIR/b748/OtherFunctionality/wipers_dec", "wipers_dec", "wipers_dec()", "", "")

--T1.3
function toggle_eng1_fuel_control()
		
	dataref("fuel_control_eng1", "ssg/ENG/eng1_cutoff_sw", "readable")
		
	fuel_control_eng1_tmp = fuel_control_eng1
	
	if (fuel_control_eng1_tmp == 0) then set("ssg/ENG/eng1_cutoff_sw", 1) end
	if (fuel_control_eng1_tmp == 1) then set("ssg/ENG/eng1_cutoff_sw", 0) end
		
	
end
create_command("WeisAIR/b748/OtherFunctionality/toggle_eng1_fuel_control", "toggle_eng1_fuel_control", "toggle_eng1_fuel_control()", "", "")

--T1.4
function toggle_eng3_fuel_control()
		
	dataref("fuel_control_eng3", "ssg/ENG/eng3_cutoff_sw", "readable")
		
	fuel_control_eng3_tmp = fuel_control_eng3
	
	if (fuel_control_eng3_tmp == 0) then set("ssg/ENG/eng3_cutoff_sw", 1) end
	if (fuel_control_eng3_tmp == 1) then set("ssg/ENG/eng3_cutoff_sw", 0) end
		
	
end
create_command("WeisAIR/b748/OtherFunctionality/toggle_eng3_fuel_control", "toggle_eng3_fuel_control", "toggle_eng3_fuel_control()", "", "")

--T1.5
function toggle_eng2_fuel_control()
		
	dataref("fuel_control_eng2", "ssg/ENG/eng2_cutoff_sw", "readable")
		
	fuel_control_eng2_tmp = fuel_control_eng2
	
	if (fuel_control_eng2_tmp == 0) then set("ssg/ENG/eng2_cutoff_sw", 1) end
	if (fuel_control_eng2_tmp == 1) then set("ssg/ENG/eng2_cutoff_sw", 0) end
		
	
end
create_command("WeisAIR/b748/OtherFunctionality/toggle_eng2_fuel_control", "toggle_eng2_fuel_control", "toggle_eng2_fuel_control()", "", "")

--T1.6
function toggle_eng4_fuel_control()
		
	dataref("fuel_control_eng4", "ssg/ENG/eng4_cutoff_sw", "readable")
		
	fuel_control_eng4_tmp = fuel_control_eng4
	
	if (fuel_control_eng4_tmp == 0) then set("ssg/ENG/eng4_cutoff_sw", 1) end
	if (fuel_control_eng4_tmp == 1) then set("ssg/ENG/eng4_cutoff_sw", 0) end
		
	
end
create_command("WeisAIR/b748/OtherFunctionality/toggle_eng4_fuel_control", "toggle_eng4_fuel_control", "toggle_eng4_fuel_control()", "", "")

--T2.1
--T2.2
--T2.3
--T2.4
--T2.5
--T2.6

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--|-----------------------------------|--
--|--//Too good to throw it away//----|--
--|-----------------------------------|--

function toggleBothFDs()
	command_once("SSG/UFMC/FD_Pilot_SW")
	command_once("SSG/UFMC/FD_Copilot_SW")
	
end
create_command("WeisAIR/b748/MCP/toggleBothFDs", "toggleBothFDs", "toggleBothFDs()", "", "")
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

function vor_left_set_OFF()
		
	set("ssg/B748/MCP/ap_vor_adf1", 0.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_left_set_OFF", "vor_left_set_OFF", "vor_left_set_OFF()", "", "")

function vor_right_set_OFF()
		
	set("ssg/B748/MCP/ap_vor_adf2", 0.0)
	
end
create_command("WeisAIR/b748/EFIS/vor_right_set_OFF", "vor_right_set_OFF", "vor_right_set_OFF()", "", "")

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