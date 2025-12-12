-- =====================================================================================
--  External MCP Autopilot dedicated to Boeing SSG B748 for X-Plane 11
-- =====================================================================================


----------------------------------------
--			AUTHORING SECTION
----------------------------------------

-- Values to be updated by Authors

 local AM_Main_Release = "AM3.5"		-- Current minimum AM release
 local Z2DXPMCP = "1.1.5"				-- Current MCP release
 local Date_Release = "09/20/2019"		-- Last MCP release date

 
--=============================================================================
--=============================================================================

-- Don't change these values
-- or at least,
-- only for personal usage

 local Title = "Z2DXPMCP"
 local InitialRelease_Date="11/02/2018"
 local InitialAuthor = "enjxp_SimPassion" -- "enjxp" on x-plane.org forum and "SimPassion" on Sim Innovations forum (same person)

----------------------------------------
--			RELEASE SECTION
----------------------------------------

local ZiboProject_Builders = "Zibo/AeroSimDevGroup/Fay/Twkster/Audiobirdxp/DrGluck/Flightdeck2sim/Folko"

local Z2DXPMCP_ScriptAuthors = "enjxp_SimPassion/	/	/	/	/	"

--======================================================================================
--								SCRIPT START
--======================================================================================

mcp_background_image = img_add_fullscreen("background.png")

--====================================================================================
--					INIT SECTION	CONSTANTS & VARIABLES
--====================================================================================

up_detperpulse_str = user_prop_add_enum("DETENT PER PULSE TYPE", "TYPE_1_DETENT_PER_PULSE,TYPE_2_DETENT_PER_PULSE,TYPE_4_DETENT_PER_PULSE", "TYPE_1_DETENT_PER_PULSE", "You can choose one of these three choices")
detperpulse_str = user_prop_get(up_detperpulse_str)

up_accel_num = user_prop_add_integer("Acceleration", 1, 10, 1, "(Optional) The multiplier is the maximum number of callbacks of one dial tick when this dial is being rotated at maximum speed.")
accel_num = user_prop_get(up_accel_num)

up_debounce_ms = user_prop_add_integer("Debounce time", 1, 200, 4, "(Optional) Select different debounce time in milliseconds. Default is 4 ms.")
debounce_ms = user_prop_get(up_debounce_ms)

local gbl_power				= 1
local gbl_overspeed_blink	= false
local gbl_ap_airspeed		= false
local gbl_light				= 0
local gbl_vvi_dial_show		= 0
local gbl_test_state		= 0
local gbl_speed_leds_show	= 0
local gbl_speed_mode		= 0
local gbl_mcp_capt_crs		= ""
local gbl_mcp_speed			= ""
local gbl_mcp_hdg			= ""
local gbl_mcp_alt			= ""
local gbl_mcp_vvi			= ""
local gbl_mcp_fo_crs		= ""
local str_speed_status		= ""
local tleds_line			= 58
local mcp_L1 				= 32
local mcp_L2 				= 129
local mcp_L3 				= 226
local mcp_L4 				= 50
local mcp_L5 				= 141
local mcp_C1 				= 252
local mcp_C2 				= 338
local mcp_C3 				= 603
local mcp_C4 				= 730
local mcp_C5 				= 861
local mcp_C6 				= 1039
local mcp_C7 				= 1141
local mcp_C8 				= 1481
local mcp_C9 				= 1585
local pos_sw_AT				= 0
local pos_sw_fda_MA			= 0
local pos_sw_fdb_MA			= 0
local pos_sw_n1				= 0
local pos_sw_spd			= 0
local pos_sw_vnav			= 0
local pos_sw_lvlchg			= 0
local pos_sw_hdgsel			= 0
local pos_sw_lnav			= 0
local pos_sw_vorloc			= 0
local pos_sw_app			= 0
local pos_sw_althld			= 0
local pos_sw_vs				= 0
local pos_sw_vsarm			= 0
local pos_sw_cmda			= 0
local pos_sw_cmdb			= 0
local pos_sw_cmdc			= 0
local pos_sw_cwsb			= 0
local vvi_shift				= 0
local dial_acc				= 1

local txt_style1			= "font:digital-7-mono.ttf; size:39px; color: white; halign: right;"
local txt_style2			= "font:roboto_regular.ttf; size:20px; color: white; halign: center;"
local txt_style3			= "font:roboto_regular.ttf; size:20px; color: #00FF00; halign: center;"

--====================================================================================
--									FUNCTIONS
--====================================================================================

--==================================
--		MCP SWITCHES FUNCTIONS
--==================================

function press_n1(position)	-- N1 button function
	xpl_command("SSG/UFMC/AP_N1_Button")
end

function n1_chg(position)
	switch_set_state(switch_n1, position)
	pos_sw_n1 = position
end

function press_speed(position)	-- SPEED button function
	xpl_command("SSG/UFMC/AP_SPD_Button")
end

function mcpspd_chg(position)
	switch_set_state(switch_speed, position)
	pos_sw_spd = position
end

function press_vnav(position)	-- VNAV button function
	xpl_command("SSG/UFMC/AP_VNAV_Button")
end

function vnav_chg(position)
	switch_set_state(switch_vnav, position)
	if position == 0 then
		pos_sw_vnav = 0
	else
		txt_set ( txt_leds_warn_spd, "")
		pos_sw_vnav = 1
	end
end

function press_lvl_chg(position)	-- LVL CHG button function
	xpl_command("SSG/UFMC/AP_LVLCHG_Button")
end

function lvlchg_chg(position)
	switch_set_state(switch_lvl_chg, position)
	pos_sw_lvlchg = position
end

function press_hdg_sel(position)	-- HDG SEL button function
	xpl_command("SSG/UFMC/AP_HDG_Button")
end

function hdgsel_chg(position)
	switch_set_state(switch_hdg_sel, position)
	pos_sw_hdgsel = position
end

function press_lnav(position)	-- LNAV button function
	xpl_command("SSG/UFMC/AP_LNAV_Button")
end

function lnav_chg(position)
	switch_set_state(switch_lnav, position)
	pos_sw_lnav = position
end

function press_vor_loc(position)	-- VOR LOC button function
	xpl_command("SSG/UFMC/AP_VORLOC_Button")
end

function vorloc_chg(position)
	switch_set_state(switch_vor_loc, position)
	pos_sw_vorloc = position
end

function press_app(position)	-- APP button function
	xpl_command("SSG/UFMC/AP_APP_Button")
end

function app_chg(position)
	switch_set_state(switch_app, position)
	pos_sw_app = position
end

function press_alt_hold(position)	-- ALT HLD button function
	xpl_command("SSG/UFMC/AP_ALTHOLD_Button")
end

function alt_hold_chg(position)
	if (position == 1.0) then position_set = 1 end
	if (position == 0.0) then position_set = 0 end
	switch_set_state(switch_alt_hold, position_set)
	pos_sw_althld = position_set
end

function press_vs(position)	-- V/S button functions  ARMED and SELECTED
	xpl_command("SSG/UFMC/AP_VS_Button")
end

function vs_chg(position)
	switch_set_state(switch_vs, position)
	if position == 0 then
		pos_sw_vs = 0
	else
		pos_sw_vs = 1
	end
end

function press_cmda(position)	-- CMD A button function
	xpl_command("SSG/UFMC/AP_CMDA_Button")
end

function cmda_chg(position)
	switch_set_state(switch_cmda, position)
	pos_sw_cmda = position
end

function press_cmdb(position)	-- CMD B button function
	xpl_command("SSG/UFMC/AP_CMDB_Button")
end

function cmdb_chg(position)
	switch_set_state(switch_cmdb, position)
	pos_sw_cmdb = position
end

function press_cmdc(position)	-- CWS A button function
	xpl_command("SSG/UFMC/AP_CMDC_Button")
end

function cwsa_pos(position)
	pos_sw_cmdc_pos = position
end

function cwsa_chg(position)
	switch_set_state(switch_cmdc, position)
	pos_sw_cmdc = position
end

--==================================
--		  LEDS FUNCTIONS
--==================================

function img_AT_led_chg(position)	-- A/T ARM Switch/LED FUNCTION
	if position == 0.0 then
		switch_set_state(switch_ath, 0 )
	elseif position== 1.0 then 
		switch_set_state(switch_ath, 1 )
	end
	pos_sw_AT = position
end

function FA_MA_A_chg(position)	-- FDA MASTER LED FUNCTION
	if position == 0.0 then pos_sw_fda_MA = 0 end
	if position == 1.0 then pos_sw_fda_MA = 1 end
end

function FA_MA_B_chg(position)	-- FDB MASTER LED FUNCTION
	if position == 0.0 then pos_sw_fdb_MA = 0 end
	if position == 1.0 then pos_sw_fdb_MA = 1 end
end

--==================================
--		MCP DATAREAD CALLBACK
--==================================

function flip_fda(position)	-- FD Switch CAPT
	if position == 0 then
		xpl_command("WeisAIR/b748/MCP/toggleCptFD")
	else
		xpl_command("WeisAIR/b748/MCP/toggleCptFD")
	end
end

function fda_switch_chg(position)
	switch_set_state(switch_fda, position)
end

function flip_fdb(position)	-- FD Switch FO
	if position == 0 then
		xpl_command("WeisAIR/b748/MCP/toggleCpltFD")
	else
		xpl_command("WeisAIR/b748/MCP/toggleCpltFD")
	end
end

function fdb_switch_chg(position)
	switch_set_state(switch_fdb, position)
end

function flip_ath(position)	-- AT Arm Switch
	if position == 0 then
		xpl_command("SSG/UFMC/AP_ARM_AT_Switch")
		move(img_disengage,nil,260,nil,nil )
	else
		xpl_command("SSG/UFMC/AP_ARM_AT_Switch")
	end
end

function twist_obs1(direction)	-- CAPT OBS Window and Knob
	if direction == 1 then
		xpl_command("sim/radios/obs_HSI_up")
	elseif direction == -1 then
		xpl_command("sim/radios/obs_HSI_down")
	end
end

function obs1_chg (crs_value)	-- CAPT OBS Value
	gbl_mcp_capt_crs = string.format("%03.0f", crs_value)
	txt_set(txt_leds_obs1,gbl_mcp_capt_crs)
end

function twist_obs2(direction)	-- FO OBS Window and Knob
	if direction == 1 then
		xpl_command("sim/radios/copilot_obs_HSI_up")
	elseif direction == -1 then
		xpl_command("sim/radios/copilot_obs_HSI_down")
	end
end

function obs2_chg (crs_value)	-- FO OBS Value
	gbl_mcp_fo_crs = string.format("%03.0f", crs_value)
	txt_set(txt_leds_obs2,gbl_mcp_fo_crs)
end

function twist_speed(direction)	-- MCP Speed Window and knob
	if direction == 1 then
		xpl_command("sim/autopilot/airspeed_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/airspeed_down")
	end	
end

function mcp_spd_chg(ap_speed, is_mach)	-- SPD Value
	gbl_speed_mode = is_mach
	if is_mach == 1 then
		gbl_mcp_speed = string.format(".%02.0f ", ap_speed * 100)
		txt_set(txt_leds_mch, gbl_mcp_speed)
		txt_set(txt_leds_spd, "")
	else
		gbl_mcp_speed = string.format("%.0f", ap_speed)
		txt_set(txt_leds_spd, gbl_mcp_speed)
		txt_set(txt_leds_mch, "")
	end
end

function twist_bank(direction)	-- Bank Limit knob
	-- if direction == 1 then 
		-- xpl_command("laminar/B738/autopilot/bank_angle_up")
	-- elseif direction == -1 then
		-- xpl_command("laminar/B738/autopilot/bank_angle_dn")
	-- end
end
	
function bank_limit_chg(bank_num)
	-- if bank_num== 0 then
		-- bank_knob_angle= -56
	-- elseif bank_num==1 then
		-- bank_knob_angle= -26
	-- elseif bank_num==2 then
		-- bank_knob_angle= 0
	-- elseif bank_num==3 then
		-- bank_knob_angle= 26
	-- elseif bank_num==4 then
		-- bank_knob_angle= 56
	-- end
	-- img_rotate(img_bank_knob,bank_knob_angle)
end		

function twist_alt(direction)	-- ALT Knob and Text
	if direction == 1 then
		xpl_command("sim/autopilot/altitude_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/altitude_down")
	end
end

function mcp_alt_chg (alt_value)	-- ALT Value
	gbl_mcp_alt = string.format("%.0f", alt_value)
	txt_set(txt_leds_alt,gbl_mcp_alt)
end

function twist_hdg(direction)	-- HDG Knob and Text
	if direction == 1 then 
		xpl_command("sim/autopilot/heading_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/heading_down")
	end
end

function mcp_hdg_chg(mcp_hdg)	-- HDG Value
	gbl_mcp_hdg = string.format("%03.0f", mcp_hdg)
	txt_set(txt_leds_hdg,gbl_mcp_hdg)
end

function twist_vs(direction)	-- MCP Vertical Speed Wheel & Text
	if direction == 1 then 
		xpl_command("sim/autopilot/vertical_speed_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/vertical_speed_down")
	end
end

function mcp_vvi_chg(mcp_vvi)	-- VVI value
	mcp_vvi = math.floor(mcp_vvi)
	vvi_shift = vvi_shift + 1
	if vvi_shift > 1 then
		vvi_shift = 0
	end
	if mcp_vvi == 0 then
		txt_set(txt_leds_vvi,"")
	else
		if mcp_vvi < 0  then
			str_sig = "-"
		else
			str_sig = "+"
		end
		mcp_vvi = math.abs(mcp_vvi)
		gbl_mcp_vvi = str_sig..string.format("%4d",mcp_vvi)
		txt_set(txt_leds_vvi,"  "..gbl_mcp_vvi)
	end
end

function click_mach()	-- MACH ChangeOver (CO) button
	xpl_command("sim/autopilot/knots_mach_toggle")
end

function click_alt()	-- ALT INTV button
	xpl_command("SSG/UFMC/AP_Altitude_Intervention_Button")
end

function click_spd()	-- SPEED INTV button
	xpl_command("SSG/UFMC/AP_SPD_Intervention_Button")
end

function click_dis()	-- A/P Disengage Bar
	xpl_command("SSG/UFMC/AP_discon_Button")
end

function APengage_chg(disc_on)
	if disc_on == 0 then
		move(img_disengage,nil,260,nil,nil )
	elseif disc_on == 1 then
		move(img_disengage,nil,285,nil,nil )
	end
end

function set_power_xpl(bus_volts,avionics_on)
	if  bus_volts == nil or avionics_on == nil then
		visible(img_MCP_OFF,true)
		return
	end

	gbl_power = fif((bus_volts[1] > 3 or bus_volts[2] > 3 or bus_volts[3] > 3) or avionics_on, 1, 0)
	if gbl_power == 0 then
		visible(lbl_lights_grp,false)
		visible(digits_leds_grp,false)
		visible(txt_leds_vvi,false)
		visible(txt_leds_spd,false)
		visible(txt_leds_mch,false)
		visible(img_MCP_LIGHT,false)
	else
		visible(digits_leds_grp,true)
		if gbl_light == 1 then
			visible(lbl_lights_grp,true)
			visible(img_MCP_LIGHT,true)
		else
			visible(lbl_lights_grp,false)
			visible(img_MCP_LIGHT,false)
		end
		if vvi_dial_show == 1 then
			gbl_vvi_dial_show = 1
			visible(txt_leds_vvi,true)
		elseif vvi_dial_show == 1 and gbl_test_state == 0 then
			gbl_vvi_dial_show = 0
			visible(txt_leds_vvi,false)
		end
		gbl_speed_leds_show = spd_leds_show
		if spd_leds_show == 0 then
			visible(txt_leds_spd,false)
			visible(txt_leds_mch,false)
		else
			visible(txt_leds_spd,true)
			visible(txt_leds_mch,true)
		end
	end
end



-- NULL FUNCTION FOR DEFAULT DIALS CALLBACK

function dial_nothing(pos,dir)
end

-- NULL FUNCTION FOR DEFAULT BUTTONS CALLBACK

function btn_nothing()
end

-- TOOLS FUNCTIONS

function prtdbg(label,param)
	print("DBG | "..label..": ["..param.."]")
end

function str_lftextract(str,nb)
	return str:sub(1,nb)
end

--====================================================================================
--								OBJECTS ADDING
--====================================================================================

img_fda_MA				= img_add("master_light.png"		,  195,135, 34, 34)visible(img_fda_MA,false)
img_fdb_MA				= img_add("master_light.png"		, 1683,135, 34, 34)visible(img_fdb_MA,false)
swoff_n1_switch			= img_add("off_btn.png" ,mcp_C1,mcp_L3, 70, 70)
swoff_speed_switch		= img_add("off_btn.png" ,mcp_C2,mcp_L3, 70, 70)
swoff_vnav_switch		= img_add("off_btn.png" ,mcp_C3,mcp_L1, 70, 70)
swoff_lvl_chg__switch	= img_add("off_btn.png" ,mcp_C3,mcp_L3, 70, 70)
swoff_hdg_sel_switch	= img_add("off_btn.png" ,mcp_C4,mcp_L3, 70, 70)
swoff_lnav_switch		= img_add("off_btn.png" ,mcp_C5,mcp_L1, 70, 70)
swoff_vor_loc_switch	= img_add("off_btn.png" ,mcp_C5,mcp_L2, 70, 70)
swoff_app_switch		= img_add("off_btn.png" ,mcp_C5,mcp_L3, 70, 70)
swoff_alt_hold_switch	= img_add("off_btn.png" ,mcp_C6,mcp_L3, 70, 70)
swoff_vs_switch			= img_add("off_btn.png" ,mcp_C7,mcp_L3, 70, 70)
swoff_cmda_switch		= img_add("off_btn.png" ,mcp_C8,mcp_L4, 70, 70)
swoff_cmdb_switch		= img_add("off_btn.png" ,mcp_C9,mcp_L4, 70, 70)
swoff_cmdc_switch		= img_add("off_btn.png" ,mcp_C8,mcp_L5, 70, 70)
--swoff_cwsb_switch		= img_add("off_btn.png" ,mcp_C9,mcp_L5, 70, 70)

img_AT_led				= img_add("autothrt_light.png"	,  262, 56, 40, 14)visible(img_AT_led,false)

img_MCP_EMPTY			= img_add_fullscreen("backgroundEmpty.png")visible(img_MCP_EMPTY,true)

img_screw1				= img_add("Screw1.png",  32, 32,32,30)
img_screw2				= img_add("Screw2.png",1856, 32,32,30)
img_screw3				= img_add("Screw3.png",  32,265,32,30)
img_screw4				= img_add("Screw4.png",1856,265,32,30)

img_MCP_LIGHT			= img_add_fullscreen("backgroundLight.png")visible(img_MCP_LIGHT,false)

--====================================================================================
--								SWITCHES - DIALS
--====================================================================================

switch_fda				= switch_add	("FDAOFF.png" , "FDAON.png"			, 185,220, 60, 60,flip_fda)
switch_fdb				= switch_add	("FDBOFF.png" , "FDBON.png"			,1675,220, 60, 60,flip_fdb)
switch_ath				= switch_add	("autothrtoff.png","autothrton.png"	, 249, 77, 80, 80,flip_ath)
scrollwheel_id			= scrollwheel_add_ver("segment.png", 1365, 152, 32, 120, 32, 20, twist_vs)
swh_mask_id				= img_add("swh_mask.png", 1365, 152, 32, 120)
visible(swh_mask_id,true)

dial_co_obs				= dial_add		("mcpcrs_knob.png"					, 100,127, 72, 72,dial_acc,twist_obs1)
dial_fo_obs				= dial_add		("mcpcrs_knob.png"					,1741,127, 72, 72,dial_acc,twist_obs2)
dial_speed				= dial_add		("mcp_knob.png"						, 469,160, 72, 72,dial_acc,twist_speed)
dial_bank				= dial_add		("empty.png"						, 716,116,100,100,twist_bank)
img_bank_knob			= img_add		("mcpbk_knob.png"					, 719,119, 95, 95)
dial_alt				= dial_add		("mcp_knob.png"						,1037,129, 72, 72,dial_acc,twist_alt)
dial_hdg				= dial_add		("mcp_knob.png"						, 737,137, 58, 58,dial_acc,twist_hdg)

img_disengage			= img_add		("mcp_disengage.png"				,1488,260,160, 40)
btn_altintv				= button_add	("intv_btn.png","intv_btn.png"		,1145,147, 40, 40,click_alt)
btn_mach				= button_add	("intv_btn.png","intv_btn.png"		, 400,147, 40, 40,click_mach)
btn_spdintv				= button_add	("intv_btn.png","intv_btn.png"		, 572,147, 40, 40,click_spd)
btn_AP_Dis_toggle		= button_add	("empty.png", "empty.png"			,1480,240,160, 78,click_dis)


img_switch_n1			= img_add("sel_btn.png"	,mcp_C1,mcp_L3, 70, 70)
img_switch_speed		= img_add("sel_btn.png"	,mcp_C2,mcp_L3, 70, 70)
img_switch_vnav			= img_add("sel_btn.png"	,mcp_C3,mcp_L1, 70, 70)
img_switch_lvl_chg		= img_add("sel_btn.png"	,mcp_C3,mcp_L3, 70, 70)
img_switch_hdg_sel		= img_add("sel_btn.png"	,mcp_C4,mcp_L3, 70, 70)
img_switch_lnav			= img_add("sel_btn.png"	,mcp_C5,mcp_L1, 70, 70)
img_switch_vor_loc		= img_add("sel_btn.png"	,mcp_C5,mcp_L2, 70, 70)
img_switch_app			= img_add("sel_btn.png"	,mcp_C5,mcp_L3, 70, 70)
img_switch_alt_hold 	= img_add("sel_btn.png"	,mcp_C6,mcp_L3, 70, 70)
img_switch_vs			= img_add("sel_btn.png"	,mcp_C7,mcp_L3, 70, 70)
img_switch_cmda			= img_add("sel_btn.png"	,mcp_C8,mcp_L4, 70, 70)
img_switch_cmdb			= img_add("sel_btn.png"	,mcp_C9,mcp_L4, 70, 70)
img_switch_cmdc			= img_add("sel_btn.png"	,mcp_C8,mcp_L5, 70, 70)

switch_n1				= switch_add("empty.png" ,nil,mcp_C1,mcp_L3, 70, 70,press_n1)
switch_speed			= switch_add("empty.png" ,nil,mcp_C2,mcp_L3, 70, 70,press_speed)
switch_vnav				= switch_add("empty.png" ,nil,mcp_C3,mcp_L1, 70, 70,press_vnav)
switch_lvl_chg			= switch_add("empty.png" ,nil,mcp_C3,mcp_L3, 70, 70,press_lvl_chg)
switch_hdg_sel			= switch_add("empty.png" ,nil,mcp_C4,mcp_L3, 70, 70,press_hdg_sel)
switch_lnav				= switch_add("empty.png" ,nil,mcp_C5,mcp_L1, 70, 70,press_lnav)
switch_vor_loc			= switch_add("empty.png" ,nil,mcp_C5,mcp_L2, 70, 70,press_vor_loc)
switch_app				= switch_add("empty.png" ,nil,mcp_C5,mcp_L3, 70, 70,press_app)
switch_alt_hold 		= switch_add("empty.png" ,nil,mcp_C6,mcp_L3, 70, 70,press_alt_hold)
switch_vs				= switch_add("empty.png" ,nil,mcp_C7,mcp_L3, 70, 70,press_vs)
switch_cmda				= switch_add("empty.png" ,nil,mcp_C8,mcp_L4, 70, 70,press_cmda)
switch_cmdb				= switch_add("empty.png" ,nil,mcp_C9,mcp_L4, 70, 70,press_cmdb)
switch_cmdc				= switch_add("empty.png" ,nil,mcp_C8,mcp_L5, 70, 70,press_cmdc)

txt_lbl_n1				= txt_add("THR"			,txt_style2,mcp_C1-3,mcp_L3+5,80,30)
txt_lbl_speed			= txt_add("SPEED"		,txt_style2,mcp_C2-3,mcp_L3+5,80,30)
txt_lbl_vnav			= txt_add("VNAV"		,txt_style2,mcp_C3-3,mcp_L1+5,80,30)
txt_lbl_lvlchg			= txt_add("LVL CHG"	,txt_style2,mcp_C3-3,mcp_L3+5,80,30)
txt_lbl_hdg				= txt_add("HDG HLD"	,txt_style2,mcp_C4-3,mcp_L3+5,80,30)
txt_lbl_lnav			= txt_add("LNAV"		,txt_style2,mcp_C5-3,mcp_L1+5,80,30)
txt_lbl_vorloc			= txt_add("VOR LOC"	,txt_style2,mcp_C5-3,mcp_L2+5,80,30)
txt_lbl_app				= txt_add("APP"		,txt_style2,mcp_C5-3,mcp_L3+5,80,30)
txt_lbl_alt				= txt_add("ALT HLD"	,txt_style2,mcp_C6-3,mcp_L3+5,80,30)
txt_lbl_vs				= txt_add("V/S"		,txt_style2,mcp_C7-3,mcp_L3+5,80,30)
txt_lbl_cmda			= txt_add("CMD-A"		,txt_style2,mcp_C8-3,mcp_L4+5,80,30)
txt_lbl_cmdb			= txt_add("CMD-B"		,txt_style2,mcp_C9-3,mcp_L4+5,80,30)
txt_lbl_cmdc			= txt_add("CMD-C"		,txt_style2,mcp_C8-3,mcp_L5+5,80,30)
	
txt_lbl_light_n1		= txt_add("THR"			,txt_style3,mcp_C1-3,mcp_L3+5,80,30)
txt_lbl_light_speed		= txt_add("SPEED"		,txt_style3,mcp_C2-3,mcp_L3+5,80,30)
txt_lbl_light_vnav		= txt_add("VNAV"		,txt_style3,mcp_C3-3,mcp_L1+5,80,30)
txt_lbl_light_lvlchg	= txt_add("LVL CHG"	,txt_style3,mcp_C3-3,mcp_L3+5,80,30)
txt_lbl_light_hdg		= txt_add("HDG HLD"	,txt_style3,mcp_C4-3,mcp_L3+5,80,30)
txt_lbl_light_lnav		= txt_add("LNAV"		,txt_style3,mcp_C5-3,mcp_L1+5,80,30)
txt_lbl_light_vorloc	= txt_add("VOR LOC"	,txt_style3,mcp_C5-3,mcp_L2+5,80,30)
txt_lbl_light_app		= txt_add("APP"		,txt_style3,mcp_C5-3,mcp_L3+5,80,30)
txt_lbl_light_alt		= txt_add("ALT HLD"	,txt_style3,mcp_C6-3,mcp_L3+5,80,30)
txt_lbl_light_vs		= txt_add("V/S"		,txt_style3,mcp_C7-3,mcp_L3+5,80,30)
txt_lbl_light_cmda		= txt_add("CMD-A"		,txt_style3,mcp_C8-3,mcp_L4+5,80,30)
txt_lbl_light_cmdb		= txt_add("CMD-B"		,txt_style3,mcp_C9-3,mcp_L4+5,80,30)
txt_lbl_light_cmdc		= txt_add("CMD-C"		,txt_style3,mcp_C8-3,mcp_L5+5,80,30)

txt_leds_obs1			= txt_add(""			,txt_style1,   95, tleds_line,  94, 61)
txt_leds_mch			= txt_add(""			,txt_style1,  334, tleds_line, 150, 61)
txt_leds_warn_spd		= txt_add(""			,txt_style1,  371, tleds_line,  94, 61)
txt_leds_spd			= txt_add(""			,txt_style1,  375, tleds_line, 150, 61)
txt_leds_hdg			= txt_add(""			,txt_style1,  703, tleds_line,  94, 61)
txt_leds_alt			= txt_add(""			,txt_style1,  985, tleds_line, 148, 61)

txt_leds_vvi			= txt_add(""			,txt_style1, 1250, tleds_line, 148, 61)
txt_leds_obs2			= txt_add(""			,txt_style1, 1693, tleds_line,  94, 61)

mcp_switch_grp		= group_add(img_switch_n1,
								img_switch_speed,
								img_switch_vnav,
								img_switch_lvl_chg,
								img_switch_hdg_sel,
								img_switch_lnav,
								img_switch_vor_loc,
								img_switch_app,
								img_switch_alt_hold,
								img_switch_vs,
								img_switch_cmda,
								img_switch_cmdb,
								img_switch_cmdc
								)visible(mcp_switch_grp,false)

digits_leds_grp		= group_add(txt_leds_obs1,
								txt_leds_spd,
								txt_leds_hdg,
								txt_leds_alt,
								txt_leds_obs2)visible(digits_leds_grp,false)

visible(txt_leds_warn_spd,false)

lbl_lights_grp		= group_add(txt_lbl_light_n1,
								txt_lbl_light_speed,
								txt_lbl_light_vnav,
								txt_lbl_light_lvlchg,
								txt_lbl_light_hdg,
								txt_lbl_light_lnav,
								txt_lbl_light_vorloc,
								txt_lbl_light_app,
								txt_lbl_light_alt,
								txt_lbl_light_vs,
								txt_lbl_light_cmda,
								txt_lbl_light_cmdb,
								txt_lbl_light_cmdc
								)visible(lbl_lights_grp,false)

visible(img_MCP_LIGHT,false)

--====================================================================================
--								DATAREFS SUBSCRIBE
--====================================================================================

xpl_dataref_subscribe("ssg/B748/MCP/mcp_n1_ann","FLOAT",n1_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_speed_ann","FLOAT",mcpspd_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_vnav_ann","FLOAT",vnav_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_level_change_ann","FLOAT",lvlchg_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_hdg_ann","FLOAT",hdgsel_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_lnav_ann","FLOAT",lnav_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_vor_loc_ann","FLOAT",vorloc_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_app_ann","FLOAT",app_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_alt_hold_ann","FLOAT",alt_hold_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_vs_ann","FLOAT",vs_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_a_comm_ann","FLOAT",cmda_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_b_comm_ann","FLOAT",cmdb_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_c_comm_ann","FLOAT",cwsa_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_c_comm_ann","FLOAT",FA_MA_A_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_c_comm_ann","FLOAT",FA_MA_B_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_plt_fd_act","FLOAT",fda_switch_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_cplt_fd_act","FLOAT",fdb_switch_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_at_arm_act","FLOAT",img_AT_led_chg)
xpl_dataref_subscribe("laminar/radios/pilot/nav_obs","FLOAT",obs1_chg)
xpl_dataref_subscribe("laminar/radios/copilot/nav_obs","FLOAT",obs2_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_alt_target_act","FLOAT",mcp_alt_chg)
xpl_dataref_subscribe(
"sim/cockpit2/autopilot/airspeed_dial_kts_mach","FLOAT",
"sim/cockpit2/autopilot/airspeed_is_mach","INT",
mcp_spd_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_bank_angle_act","FLOAT",bank_limit_chg)
xpl_dataref_subscribe("sim/cockpit/autopilot/heading_mag","FLOAT",mcp_hdg_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_ap_disengage_act","FLOAT",mcp_vvi_chg)
xpl_dataref_subscribe("ssg/B748/MCP/mcp_ap_disengage_act","INT",APengage_chg)
xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts"						,"FLOAT[6]",
					  "sim/cockpit/electrical/avionics_on"						,"INT",set_power_xpl)


--====================================================================================
--								HARDWARE HANDLING
--====================================================================================

-- Dials
hw_dial_crs1		= hw_dial_add("CRS1 Knob",detperpulse_str,accel_num,debounce_ms,twist_obs1)
hw_dial_crs2		= hw_dial_add("CRS2 Knob",detperpulse_str,accel_num,debounce_ms,twist_obs2)
hw_dial_speed		= hw_dial_add("SPEED Knob",detperpulse_str,accel_num,debounce_ms,twist_speed)
hw_dial_hdg			= hw_dial_add("HDG Knob",detperpulse_str,accel_num,debounce_ms,twist_hdg)
hw_dial_alt			= hw_dial_add("ALT Knob",detperpulse_str,accel_num,debounce_ms,twist_alt)
hw_dial_vswheel		= hw_dial_add("V/S Wheel",detperpulse_str,accel_num,debounce_ms,twist_vs)

-- Switches
hw_switch_bank		= hw_switch_add("BANK Switch", 5,
									function(mode_state)
										xpl_dataref_write("laminar/B738/rotary/autopilot/bank_angle", "INT", mode_state)
									end)
if (hw_switch_get_position(hw_switch_bank) ~= nil) then
	xpl_dataref_write("laminar/B738/rotary/autopilot/bank_angle", "INT", hw_switch_get_position(hw_switch_bank))
end

hw_switch_fd1		= hw_switch_add("FD CAPT",2,flip_fda)
hw_switch_fd2		= hw_switch_add("FD FO",2,flip_fdb)
hw_switch_at		= hw_switch_add("A/T",2,flip_ath)
hw_switch_dis		= hw_switch_add("DISENGAGE ",2,click_dis)

-- Buttons
hw_button_co		= hw_button_add("C/O",click_mach)
hw_button_spdintv	= hw_button_add("SPD INTV",click_spd)
hw_button_altintv	= hw_button_add("ALT INTV",click_alt)

hw_button_n1		= hw_button_add("N1",press_n1)
hw_button_spd		= hw_button_add("SPEED",press_speed)
hw_button_vnv		= hw_button_add("VNAV",press_vnav)
hw_button_lnv		= hw_button_add("LNAV",press_lnav)
hw_button_vlc		= hw_button_add("VOR LOC",press_vor_loc)
hw_button_lch		= hw_button_add("LVL CHG",press_lvl_chg)
hw_button_hsl		= hw_button_add("HDG HLD",press_hdg_sel)
hw_button_app		= hw_button_add("APP",press_app)
hw_button_ahd		= hw_button_add("ALT HLD",press_alt_hold)
hw_button_vs		= hw_button_add("V/S",press_vs)
hw_button_cmda		= hw_button_add("CMD-A",press_cmda)
hw_button_cmdb		= hw_button_add("CMD-B",press_cmdb)
hw_button_cmdc		= hw_button_add("CMD-C",press_cmdc)
