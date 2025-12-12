-- =====================================================================================
--		External MCP Autopilot dedicated to Boeing B737-800X ZiboMod for X-Plane 11
-- =====================================================================================
--	Hardware Ready using Arduino board for Cockpit builders
--	62	PINS for I/O
---------------------
--	3	OUTPUTS	: by Single or Daisychained - MAX7219 Displays LEDs (Maxi 4 Daisychained)
--	12	INPUTS	: Dials
--	5	INPUTS	: Bank Switch
--	8	INPUTS	: FDA/AT/DISENGAGE/FDB Switches
--	17	INPUTS	: Push Buttons
--	17	OUTPUTS	: LEDs

----------------------------------------
--			AUTHORING SECTION
----------------------------------------

-- Values to be updated by Authors

 local AM_Main_Release = "AM4.1"		-- Minimal AM release requirement
 local Z_2D_XP_MCP = "1.2.7"			-- Current MCP release
 local Date_Release = "05/22/2023"		-- Last MCP release date
 local ZiboModminRelease = "3.56 EA 6.3"	-- Minimum ZiboMod Release required
 
--=============================================================================
--=============================================================================

-- Don't change these following values
-- or at least,
-- only for personal usage

 local Title = "Z_2D_XP_MCP"
 local InitialRelease_Date="11/02/2018"
 local InitialAuthor = "enjxp_SimPassion" -- "enjxp" on x-plane.org forum and "SimPassion" on Sim Innovations forum (same person)

--=============================================================================
--=============================================================================

--	TODO :

--			Add User Property for syncing AM Instrument LEDs displays brightness to HW ADC Input
--			Fix dark vs bright panel rendering
--			Fix panel bright vs leds light (dataref)
--			Add customizable MAX7219 handling
--			Check digit_8/over_spd and digit_A/under_spd datarefs
--				"laminar/B738/mcp/digit_8"		"laminar/B738/mcp/digit_A"
--				"laminar/B738/mcp/over_spd"		"laminar/B738/mcp/under_spd"
--			Green button light min Voltage to switch OFF from Standby Power
-- 						sim/cockpit2/electrical/battery_voltage_indicated_volts

----------------------------------------
--			RELEASE SECTION
----------------------------------------

local ZiboProject_Builders = "Zibo/AeroSimDevGroup/Fay/Twkster/Audiobirdxp/DrGluck/Flightdeck2sim/Folko"

local Z_2D_XP_MCP_ScriptAuthors = "enjxp_SimPassion/	/	/	/	/	"

-- Register here each of the successive revisions with comments

--	Author						Date			Release		Comments

--	enjxp_SimPassion			05/22/2023		1.2.7		Fixed ias/mach LEDs digits not properly displayed when C/O pressed
--	enjxp_SimPassion			05/16/2023					Updated vvi dataref due to changes starting from 3.56 6.n
--	enjxp_SimPassion			05/27/2022		1.2.6		Updated datarefs acordingly to new Electrical Scheme from 3_53_Full
--	enjxp_SimPassion			02/12/2022		1.2.5		Fixed max count on daisy chained MAX7219 modules : lowered from 4 to 3 as 3 is enough to handle all LEDs digits in MCP
--															Also fixed bitmaps lowercase naming issue with Android or unix like devices
--	enjxp_SimPassion			01/06/2022		1.2.4		Reworking logic to anticipate better MAX7219 hardware and LEDs display handling
--															MAX7219 eventually handled properly : testing done using 4 x MAX7219 daisy chained modules
--	enjxp_SimPassion			12/10/2021		1.2.3		Fixed test not running properly due to dataref change
--	enjxp_SimPassion			12/10/2021		1.2.2		Fixed an issue where the ambient light is still displayed without power
--	enjxp_SimPassion			12/05/2021		1.2.1		Added HW I/O Count in the header and in instrument information
--															Re-ordering of HW I/O
--															Added Flood handling
--															Removed useless "empty.png" bitmap file
--	enjxp_SimPassion			07/07/2021		1.2.0		Updated MCP LEDs check display
--															Upgraded to a new bright scheme handling
--	enjxp_SimPassion			07/04/2021		1.1.9		Inverted Panel bright behavior
--															Datarefs updated to follow 3_49_10
--															Added "minimum required" ZiboMod Release number in optional info displayed
--															MCP_ALT format fixed to display "000" when equal to 0
--	enjxp_SimPassion			05/10/2021		1.1.8		Cleaning text
--	enjxp_SimPassion			05/09/2021		1.1.7		Handling panel bright using AFDS FLOOD Bright
--	enjxp_SimPassion			05/08/2021		1.1.6		Changed values type from INT to FLOAT type
--															Request_Callback added to handle Loaded previously saved flight
--															Frozen LEDs no more occurs Loaded previously saved flight situation(standard LEDs lights refresh)
--															Fixed A/T switch arming dataref and A/T Led behavior
--															Added Toggle check infos button (Software)
--															Added version number displayed to be able to check version on tablet devices
--															Enhanced brightness handling with gradation
--															Fixed MACH Speed still displayed while in VNAV
--															Fixed Speed/MACH not properly displayed while LEDs Test running (Personal Note: both related reverse issue: one at a time)
--															Fixed VVI still displayed after LEDS Test ended
--															Updated CRS Datarefs for both Pilot and Copilot sides
--															Added Hardware MAX7219 with 7-Segment LEDs digits displays handling
--															Fixed Speed status still displaying while Light Test running
--															Enhanced Buttons Green light design and cutting bglight.png around buttons area
--															Enhanced switches design
--															Added missing external hardware LEDs handling
--															Added turning LEDs lights OFF on closing instrument
--															Reworking brightness handling
--	enjxp_SimPassion			09/19/2019		1.1.5		Suppressed Overspeed and Underspeed blinking on LIGHT TEST
--															Overspeed and Underspeed digits location adjusted
--															Fixed Altitude digits number on LIGHT TEST : changed to 5 digits
--															Moved Mach Speed LEDs location
--															Fixed variables name consistency
--	enjxp_SimPassion			08/08/2019		1.1.4		Adding missing Hardware handling for V/S Wheel
--	enjxp_SimPassion			06/23/2019		1.1.3		Adding Hardware handling from Tony & Keith with my own customizations on User Properties
--	Tony (Sling) & Keith Baxter	06/12/2019					Hardware handling work shared by Keith and Tony
--	enjxp_SimPassion			04/24/2019		1.1.2		Removed dials acceleration, as it's now handled in internal coding in 3D Cockpit
--	enjxp_SimPassion			04/07/2019		1.1.1		Fixed overspeed and underspeed indicators behavior
--															Added dials acceleration
--	enjxp_SimPassion			04/02/2019		1.1.0		Previous fonts removed and new one added for a licensing concern
--	enjxp_SimPassion			02/25/2019		1.0.9		Fixed an issue where the VS wheel was not displayed with missing bitmap
--	enjxp_SimPassion			02/24/2019		1.0.8		Enhanced Scroll wheel handling : now react with touch and mouse with a sliding effect
--	enjxp_SimPassion			02/13/2019		1.0.7		Fixed MCP Brightness handling issue
--															Fixed digits not displayed with BAT switched to ON on start
--															Fixed overspeed and underspeed behavior
--															Reduced min Voltage limit where MCP digits will switch OFF by themselves (from 5V to 3V) trying to follow ZiboMod behavior
--															Added Digits flashing on Display Light Test
--	enjxp_SimPassion			02/04/2019		1.0.6		Fixed VVI wheel not working properly in touch mode (if mouse mode is enabled in AM/AP, mouse wheel will always only work in the same direction in each related up 
--																or down half-size of area, or using left mouse click)
--															Fixed VNAV button issue
--															Fixed V/S button issue
--															Adjusted touch area for bank selector
--															Both F/D light and A/T ARM light enhancement while MAIN PANEL Light is more than 50% (they were previously half masked)
--															Added "A" IAS indicator and under speed management
--	enjxp_SimPassion			12/15/2018		1.0.5		Fixed MCP Speed display issue condition only on "Show IAS"
--	enjxp_SimPassion			12/02/2018		1.0.4		Initial release

--=============================================================================
------------------------------------------------------------------------------------------------------------------------------------
--  Boeing 737-800X MCP for ZiboMmod
--		based on Russ Barlow's MCP for the EADT x737
--		based on Boeing 737NG - Autopilot - Mode Control Panel from Joe Venzon
-------------------------------------------------------------------------------------------------------------------------------------------------------
--  New release based on initial graphic design by AudioBirdXP and ZiboMod 3.31d , script reworking started and made by enjxp_SimPassion on 11/02/2018
--	thanks to kind permission of AudioBirdXP for publishing
-------------------------------------------------------------------------------------------------------------------------------------------------------

--  Note that this panel only mimics the 737 MCP by sending inputs
--  and displaying the 737 outputs.

--	Default size = 1920 x 329

------------------------------------------------------------------------------

----------------------------------------
--			INSTALLATION SECTION
----------------------------------------

-- Unzip the file, then copy/paste the inside folder named with a suite of digits and letters, into the "\Users\%username%\Air Manager\instruments\OPEN_DIRECTORY" folder or in the "\Users\%username%\Air Manager BETA\instruments\OPEN_DIRECTORY" folder 

-- This instrument could be send on a remote PC, or on the same PC to Air Player, in order to run in standalone mode
-- it also could be send to Air Player running on Android, iPad, Linux, Windows, Mac or Raspberry Pi with the appropriate licence of Air Player

-- For execution, mandatory requirement is one of the following Sim Innovations product and license : Air Manager on Windows or Air Player on Android / iPad / Raspberry Pi

--========================================================================================================================================================================================================

--		CAVEATS for coding : in this LUA script the order in which appear the statements concerning texts, buttons and images positioning, is of primary importance,
--		as all objects are displayed with a layer order : the first objects appear behind and the last objects appear in front following the order in which they're been wrote in the script

--========================================================================================================================================================================================================


--======================================================================================
--								SCRIPT START
--======================================================================================

mcp_bg_image = img_add_fullscreen("bg.png")

--====================================================================================
--					INIT SECTION	CONSTANTS & VARIABLES
--====================================================================================

up_daisychain_nb = user_prop_add_integer("MAX7219 Daisy Chain modules count", 1, 3, 3, "(Optional) Select your current max daisy chained MAX7219 count. Default is 3.")
daisychain_nb = user_prop_get(up_daisychain_nb)

up_info_shown_bln = user_prop_add_boolean("DISPLAY CHECK INFOS", false, "Display CAPT/FO side and release infos")
info_shown_bln = user_prop_get(up_info_shown_bln)

up_detperpulse_str = user_prop_add_enum("DETENT PER PULSE TYPE", "TYPE_1_DETENT_PER_PULSE,TYPE_2_DETENT_PER_PULSE,TYPE_4_DETENT_PER_PULSE", "TYPE_2_DETENT_PER_PULSE", "You can choose one of these three choices")
detperpulse_str = user_prop_get(up_detperpulse_str)

up_accel_num = user_prop_add_integer("ACCELERATION", 1, 10, 1, "(Optional) The multiplier is the maximum number of callbacks of one dial tick when this dial is being rotated at maximum speed.")
accel_num = user_prop_get(up_accel_num)

up_debounce_ms = user_prop_add_integer("DEBOUNCE TIME", 1, 200, 4, "(Optional) Select different debounce time in milliseconds. Default is 4 ms.")
debounce_ms = user_prop_get(up_debounce_ms)

-- local setdebug				= false
local setdebug				= true

local gbl_power				= 0
local gbl_overspeed_blink	= false
local gbl_ap_airspeed		= false
local gbl_light				= 0
local gbl_bright_rt			= 0
local gbl_vvi_dial_show		= 0
local gbl_test_state		= 0
local gbl_speed_leds_show	= 0

local gbl_speed_mode		= 0
local gbl_mcp_speed_status	= " "
local gbl_mcp_capt_crs		= "0"	-- 3 digits
local gbl_mcp_mach			= "0"	-- 4 digits
local gbl_mcp_speed			= "0"	-- 3 digits
local gbl_mcp_hdg			= "0"	-- 3 digits
local gbl_mcp_alt			= "0"	-- 5 digits
local gbl_mcp_vvi			= "0"	-- 5 digits
local gbl_mcp_fo_crs		= "0"	-- 3 digits

local str_chr_display0		= ""
local str_chr_display1		= ""
local str_chr_display2		= ""
local str_chr_display3		= ""
local gbl_mcp_digits		= ""

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
local at_led_state			= 0.0
local pos_sw_AT				= 0.0
local pos_sw_fda_MA			= 0.0
local pos_sw_fdb_MA			= 0.0
local pos_sw_n1				= 0.0
local pos_sw_spd			= 0.0
local pos_sw_vnav			= 0.0
local pos_sw_lvlchg			= 0.0
local pos_sw_hdgsel			= 0.0
local pos_sw_lnav			= 0.0
local pos_sw_vorloc			= 0.0
local pos_sw_app			= 0.0
local pos_sw_althld			= 0.0
local pos_sw_vs				= 0.0
local pos_sw_vsarm			= 0.0
local pos_sw_cmda			= 0.0
local pos_sw_cmdb			= 0.0
local pos_sw_cwsa			= 0.0
local pos_sw_cwsb			= 0.0
-- local vvi_shift				= 0
local dial_acc				= 1

local txt_style0			= "font:arimo_bold.ttf; size:17px; color: yellow; halign: center;"
local txt_style1			= "font:digital-7-mono.ttf; size:39px; color: white; halign: right;"
local txt_style2			= "font:roboto_regular.ttf; size:20px; color: #666666; halign: center;"
local txt_style3			= "font:roboto_regular.ttf; size:20px; color: #00FF00; halign: center;"

--====================================================================================
--									FUNCTIONS
--====================================================================================

--==================================
--		MCP SWITCHES FUNCTIONS
--==================================

function press_n1(position)	-- N1 button function
	xpl_command("laminar/B738/autopilot/n1_press")
end

function n1_chg(position)
	switch_set_state(switch_n1, position)
	pos_sw_n1 = position
	request_callback(set_panel_states)
end

function press_speed(position)	-- SPEED button function
	xpl_command("laminar/B738/autopilot/speed_press")
end

function mcpspd_chg(position)
	switch_set_state(switch_speed, position)
	pos_sw_spd = position
	request_callback(set_panel_states)	
end

function press_vnav(position)	-- VNAV button function
	xpl_command("laminar/B738/autopilot/vnav_press")
end

function vnav_chg(position)
	switch_set_state(switch_vnav, position)
	if position == 0 then
		pos_sw_vnav = 0
	else
		txt_set(txt_leds_warn_spd, "")
		pos_sw_vnav = 1
	end
	request_callback(set_panel_states)
end

function press_lvl_chg(position)	-- LVL CHG button function
	xpl_command("laminar/B738/autopilot/lvl_chg_press")
end

function lvlchg_chg(position)
	switch_set_state(switch_lvl_chg, position)
	pos_sw_lvlchg = position
	request_callback(set_panel_states)
end

function press_hdg_sel(position)	-- HDG SEL button function
	xpl_command("laminar/B738/autopilot/hdg_sel_press")
end

function hdgsel_chg(position)
	switch_set_state(switch_hdg_sel, position)
	pos_sw_hdgsel = position
	request_callback(set_panel_states)
end

function press_lnav(position)	-- LNAV button function
	xpl_command("laminar/B738/autopilot/lnav_press")
end

function lnav_chg(position)
	switch_set_state(switch_lnav, position)
	pos_sw_lnav = position
	request_callback(set_panel_states)
end

function press_vor_loc(position)	-- VOR LOC button function
	xpl_command("laminar/B738/autopilot/vorloc_press")
end

function vorloc_chg(position)
	switch_set_state(switch_vor_loc, position)
	pos_sw_vorloc = position
	request_callback(set_panel_states)
end

function press_app(position)	-- APP button function
	xpl_command("laminar/B738/autopilot/app_press")
end

function app_chg(position)
	switch_set_state(switch_app, position)
	pos_sw_app = position
	request_callback(set_panel_states)
end

function press_alt_hold(position)	-- ALT HLD button function
	xpl_command("laminar/B738/autopilot/alt_hld_press")
end

function alt_hold_chg(position)
	switch_set_state(switch_alt_hold, position)
	pos_sw_althld = position
	request_callback(set_panel_states)
end

function press_vs(position)	-- V/S button functions  ARMED and SELECTED
	xpl_command("laminar/B738/autopilot/vs_press")
end

function vs_chg(position)
	switch_set_state(switch_vs, position)
	if position == 0 then
		pos_sw_vs = 0
	else
		pos_sw_vs = 1
	end
	request_callback(set_panel_states)
end

function press_cmda(position)	-- CMD A button function
	xpl_command("laminar/B738/autopilot/cmd_a_press")
end

function cmda_chg(position)
	switch_set_state(switch_cmda, position)
	pos_sw_cmda = position
	request_callback(set_panel_states)
end

function press_cmdb(position)	-- CMD B button function
	xpl_command("laminar/B738/autopilot/cmd_b_press")
end

function cmdb_chg(position)
	switch_set_state(switch_cmdb, position)
	pos_sw_cmdb = position
	request_callback(set_panel_states)
end

function press_cwsa(position)	-- CWS A button function
	xpl_command("laminar/B738/autopilot/cws_a_press")
end

function cwsa_pos(position)
	pos_sw_cwsa_pos = position
	request_callback(set_panel_states)
end

function cwsa_chg(position)
	switch_set_state(switch_cwsa, position)
	pos_sw_cwsa = position
	request_callback(set_panel_states)
end

function press_cwsb(position)	-- CWS B button function
	xpl_command("laminar/B738/autopilot/cws_b_press")
end

function cwsb_pos(position)
	pos_sw_cwsb_pos = 1
	request_callback(set_panel_states)
end

function cwsb_chg(position)
	switch_set_state(switch_cwsb, position)
	pos_sw_cwsb = position
	request_callback(set_panel_states)
end

--==================================
--		  LEDS FUNCTIONS
--==================================

function img_AT_chg(position)	-- A/T ARM Switch/LED FUNCTION
	if position == 0 then
		switch_set_state(switch_ath, 0 )
	elseif position==1 then 
		switch_set_state(switch_ath, 1 )
	end
	pos_sw_AT = position
	request_callback(set_panel_states)
end

function img_AT_led_state(state)
	at_led_state = state
end

function FA_MA_A_chg(position)	-- FDA MASTER LED FUNCTION
	pos_sw_fda_MA = position
	request_callback(set_panel_states)
end

function FA_MA_B_chg(position)	-- FDB MASTER LED FUNCTION
	pos_sw_fdb_MA = position
	request_callback(set_panel_states)
end

--==================================
--		MCP DATAREAD CALLBACK
--==================================

function flip_fda(position)	-- FD Switch CAPT
	if position == 0 then
		xpl_command("laminar/B738/autopilot/flight_director_toggle")
	else
		xpl_command("laminar/B738/autopilot/flight_director_toggle")
	end
end

function fda_switch_chg(position)
	switch_set_state(switch_fda, position)
end

function flip_fdb(position)	-- FD Switch FO
	if position == 0 then
		xpl_command("laminar/B738/autopilot/flight_director_fo_toggle")
	else
		xpl_command("laminar/B738/autopilot/flight_director_fo_toggle")
	end
end

function fdb_switch_chg(position)
	switch_set_state(switch_fdb, position)
end

function flip_ath(position)	-- AT Arm Switch
	if position == 0 then
		xpl_command("laminar/B738/autopilot/autothrottle_arm_toggle")
		move(img_disengage,nil,260,nil,nil )
	else
		xpl_command("laminar/B738/autopilot/autothrottle_arm_toggle")
	end
end

function twist_obs1(direction)	-- CAPT OBS Window and Knob
	if direction == 1 then
		xpl_command("sim/radios/obs_HSI_up")
	elseif direction == -1 then
		xpl_command("sim/radios/obs_HSI_down")
	end
end

function twist_obs2(direction)	-- FO OBS Window and Knob
	if direction == 1 then
		xpl_command("sim/radios/copilot_obs_HSI_up")
	elseif direction == -1 then
		xpl_command("sim/radios/copilot_obs_HSI_down")
	end
end

function twist_speed(direction)	-- MCP Speed Window and knob
	if direction == 1 then
		xpl_command("sim/autopilot/airspeed_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/airspeed_down")
	end	
end

function twist_bank(direction)	-- Bank Limit knob
	if direction == 1 then 
		xpl_command("laminar/B738/autopilot/bank_angle_up")
	elseif direction == -1 then
		xpl_command("laminar/B738/autopilot/bank_angle_dn")
	end
end
	
function bank_limit_chg(bank_num)
	if bank_num== 0 then
		bank_knob_angle= -56
	elseif bank_num==1 then
		bank_knob_angle= -26
	elseif bank_num==2 then
		bank_knob_angle= 0
	elseif bank_num==3 then
		bank_knob_angle= 26
	elseif bank_num==4 then
		bank_knob_angle= 56
	end
	img_rotate(img_bank_knob,bank_knob_angle)
end		

function twist_alt(direction)	-- ALT Knob and Text
	if direction == 1 then
		xpl_command("sim/autopilot/altitude_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/altitude_down")
	end
end

function twist_hdg(direction)	-- HDG Knob and Text
	if direction == 1 then 
		xpl_command("sim/autopilot/heading_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/heading_down")
	end
end

function twist_vs(direction)	-- MCP Vertical Speed Wheel & Text
	if direction == 1 then 
		xpl_command("sim/autopilot/vertical_speed_up")
	elseif direction == -1 then
		xpl_command("sim/autopilot/vertical_speed_down")
	end
end

function click_mach()	-- MACH ChangeOver (CO) button
	xpl_command("laminar/B738/autopilot/change_over_press")
end

function click_alt()	-- ALT INTV button
	xpl_command("laminar/B738/autopilot/alt_interv")
end

function click_spd()	-- SPEED INTV button
	xpl_command("laminar/B738/autopilot/spd_interv")
end

function click_dis()	-- A/P Disengage Bar
	xpl_command("laminar/B738/autopilot/disconnect_toggle")
end

function APengage_chg(disc_on)
	if disc_on == 0 then
		move(img_disengage,nil,260,nil,nil )
	elseif disc_on == 1 then
		move(img_disengage,nil,285,nil,nil )
	end
end

--==================================
--		MCP TXT_SET GRAPHICS LEDs
--==================================

function obs1_chg (crs_value)	-- CAPT OBS Value
	gbl_mcp_capt_crs = string.format("%03.0f", crs_value)
	txt_set(txt_leds_obs1,gbl_mcp_capt_crs)
	hw_chr_display()		-- Display on HW 7-Segment Displays LEDs
end

function obs2_chg (crs_value)	-- FO OBS Value
	gbl_mcp_fo_crs = string.format("%03.0f", crs_value)
	txt_set(txt_leds_obs2,gbl_mcp_fo_crs)
	hw_chr_display()		-- Display on HW 7-Segment Displays LEDs
end

function mcp_spd_chg(ap_speed, is_mach)	-- SPEED or MACH Value
	-- print("is_mach : "..is_mach)
	gbl_speed_mode = is_mach
	-- gbl_mcp_mach	= string.format("%01.2f", ap_speed / 661.546298)
	gbl_mcp_mach	= string.format("%01.2f", ap_speed)
	-- gbl_mcp_mach	= string.format(" .%02.0f", ap_speed * 100)
	gbl_mcp_speed	= string.format("%.0f", ap_speed)
	-- print(ap_speed)
	if gbl_speed_mode == 1 then		-- MACH mode
		txt_set(txt_leds_mch, gbl_mcp_mach)
		txt_set(txt_leds_spd, "   ")
	else							-- STD Speed mode
		txt_set(txt_leds_mch, "    ")
		txt_set(txt_leds_spd, gbl_mcp_speed)
	end
	hw_chr_display()		-- Display on HW 7-Segment Displays LEDs
end

function mcp_alt_chg (alt_value)	-- ALT Value
	gbl_mcp_alt = string.format("%03.0f", alt_value)	-- MCP_ALT format fixed on 1.1.9 to display "000" when equal to 0
	txt_set(txt_leds_alt,gbl_mcp_alt)
	hw_chr_display()		-- Display on HW 7-Segment Displays LEDs
end

function mcp_hdg_chg(mcp_hdg)	-- HDG Value
	gbl_mcp_hdg = string.format("%03.0f", mcp_hdg)
	txt_set(txt_leds_hdg,gbl_mcp_hdg)
	hw_chr_display()		-- Display on HW 7-Segment Displays LEDs
end

function mcp_vvi_chg(mcp_vvi)	-- VVI value
	mcp_vvi = math.floor(mcp_vvi)
	str_sig = " "
	
	if mcp_vvi == 0 then
		txt_set(txt_leds_vvi,"     ")
		gbl_mcp_vvi = str_sig..string.format("%4d",mcp_vvi)
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
	hw_chr_display()		-- Display on HW 7-Segment Displays LEDs
end

function set_panel_states(status,is_overspd,is_underspd)
	if (is_overspd == 1) and (gbl_test_state ~= 2) then
		gbl_mcp_speed_status = "8"
	elseif (is_underspd == 1) and (gbl_test_state ~= 2) then
		gbl_mcp_speed_status = "A"
	elseif gbl_test_state == 1 then
		gbl_mcp_speed_status = " "
	end

	if status == 0 then
		gbl_mcp_speed_status = " "
	end
	txt_set(txt_leds_warn_spd, gbl_mcp_speed_status)
	-- visible(txt_leds_warn_spd,(is_overspd == 1 or is_underspd == 1) and gbl_speed_leds_show ~= 0 and gbl_power == 1 and gbl_test_state == 1)
	visible(txt_leds_warn_spd,(is_overspd == 1 or is_underspd == 1) and gbl_speed_leds_show ~= 0 and gbl_power == 1 and gbl_test_state ~= 1)
	
	visible(img_AT_led,			at_led_state	== 1 and gbl_power == 1)
	visible(img_fda_MA,			pos_sw_fda_MA	== 1 and gbl_power == 1)
	visible(img_fdb_MA,			pos_sw_fdb_MA	== 1 and gbl_power == 1)
	visible(img_switch_n1,			pos_sw_n1		== 1 and gbl_power == 1)
	visible(img_switch_speed,		pos_sw_spd		== 1 and gbl_power == 1)
	visible(img_switch_vnav,		pos_sw_vnav		== 1 and gbl_power == 1)
	visible(img_switch_lvl_chg,	pos_sw_lvlchg	== 1 and gbl_power == 1)
	visible(img_switch_hdg_sel,	pos_sw_hdgsel	== 1 and gbl_power == 1)
	visible(img_switch_lnav,		pos_sw_lnav		== 1 and gbl_power == 1)
	visible(img_switch_vor_loc,	pos_sw_vorloc	== 1 and gbl_power == 1)
	visible(img_switch_app,		pos_sw_app		== 1 and gbl_power == 1)
	visible(img_switch_alt_hold,	pos_sw_althld	== 1 and gbl_power == 1)
	visible(img_switch_vs,			pos_sw_vs		== 1 and gbl_power == 1)
	visible(img_switch_cmda,		pos_sw_cmda		== 1 and gbl_power == 1)
	visible(img_switch_cmdb,		pos_sw_cmdb		== 1 and gbl_power == 1)
	visible(img_switch_cwsa,		pos_sw_cwsa		== 1 and gbl_power == 1)
	visible(img_switch_cwsb,		pos_sw_cwsb		== 1 and gbl_power == 1)
	
	opacity(img_AT_led,		(at_led_state * gbl_bright_rt + 0.3)*at_led_state)
	opacity(img_fda_MA,		(pos_sw_fda_MA * gbl_bright_rt + 0.3)*pos_sw_fda_MA)
	opacity(img_fdb_MA,		(pos_sw_fdb_MA * gbl_bright_rt + 0.3)*pos_sw_fdb_MA)
	opacity(img_switch_n1,		(pos_sw_n1		* gbl_bright_rt + 0.3)*pos_sw_n1)
	opacity(img_switch_speed,	(pos_sw_spd		* gbl_bright_rt + 0.3)*pos_sw_spd)
	opacity(img_switch_vnav,	(pos_sw_vnav	* gbl_bright_rt + 0.3)*pos_sw_vnav)
	opacity(img_switch_lvl_chg, (pos_sw_lvlchg	* gbl_bright_rt + 0.3)*pos_sw_lvlchg)
	opacity(img_switch_hdg_sel, (pos_sw_hdgsel	* gbl_bright_rt + 0.3)*pos_sw_hdgsel)
	opacity(img_switch_lnav,	(pos_sw_lnav	* gbl_bright_rt + 0.3)*pos_sw_lnav)
	opacity(img_switch_vor_loc, (pos_sw_vorloc	* gbl_bright_rt + 0.3)*pos_sw_vorloc)
	opacity(img_switch_app,	(pos_sw_app		* gbl_bright_rt + 0.3)*pos_sw_app)
	opacity(img_switch_alt_hold,(pos_sw_althld * gbl_bright_rt + 0.3)*pos_sw_althld)
	opacity(img_switch_vs,		(pos_sw_vs		* gbl_bright_rt + 0.3)*pos_sw_vs)
	opacity(img_switch_cmda,	(pos_sw_cmda	* gbl_bright_rt + 0.3)*pos_sw_cmda)
	opacity(img_switch_cmdb,	(pos_sw_cmdb	* gbl_bright_rt + 0.3)*pos_sw_cmdb)
	opacity(img_switch_cwsa,	(pos_sw_cwsa	* gbl_bright_rt + 0.3)*pos_sw_cwsa)
	opacity(img_switch_cwsb,	(pos_sw_cwsb	* gbl_bright_rt + 0.3)*pos_sw_cwsb)

	visible(img_MCP_AMB,gbl_power == 1)
	visible(img_MCP_Flood,gbl_power == 1)

	hw_led_set(hw_led_atarm,	(at_led_state	* gbl_bright_rt + 0.1)*at_led_state)
	hw_led_set(hw_led_fda,		(pos_sw_fda_MA	* gbl_bright_rt + 0.1)*pos_sw_fda_MA)
	hw_led_set(hw_led_fdb,		(pos_sw_fdb_MA	* gbl_bright_rt + 0.1)*pos_sw_fdb_MA)
	hw_led_set(hw_led_n1,		(pos_sw_n1		* gbl_bright_rt + 0.1)*pos_sw_n1)
	hw_led_set(hw_led_speed,	(pos_sw_spd		* gbl_bright_rt + 0.1)*pos_sw_spd)
	hw_led_set(hw_led_vnav,	(pos_sw_vnav	* gbl_bright_rt + 0.1)*pos_sw_vnav)
	hw_led_set(hw_led_lvlchg,	(pos_sw_lvlchg	* gbl_bright_rt + 0.1)*pos_sw_lvlchg)
	hw_led_set(hw_led_hdgsel,	(pos_sw_hdgsel	* gbl_bright_rt + 0.1)*pos_sw_hdgsel)
	hw_led_set(hw_led_lnav,	(pos_sw_lnav	* gbl_bright_rt + 0.1)*pos_sw_lnav)
	hw_led_set(hw_led_vorloc,	(pos_sw_vorloc	* gbl_bright_rt + 0.1)*pos_sw_vorloc)
	hw_led_set(hw_led_app,		(pos_sw_app		* gbl_bright_rt + 0.1)*pos_sw_app)
	hw_led_set(hw_led_althld,	(pos_sw_althld	* gbl_bright_rt + 0.1)*pos_sw_althld)
	hw_led_set(hw_led_vs,		(pos_sw_vs		* gbl_bright_rt + 0.1)*pos_sw_vs)
	hw_led_set(hw_led_cmda,	(pos_sw_cmda	* gbl_bright_rt + 0.1)*pos_sw_cmda)
	hw_led_set(hw_led_cmdb,	(pos_sw_cmdb	* gbl_bright_rt + 0.1)*pos_sw_cmdb)
	hw_led_set(hw_led_cwsa,	(pos_sw_cwsa	* gbl_bright_rt + 0.1)*pos_sw_cwsa)
	hw_led_set(hw_led_cwsb,	(pos_sw_cwsb	* gbl_bright_rt + 0.1)*pos_sw_cwsb)

	hw_chr_display()		-- Display on HW 7-Segment Displays LEDs
end

function display_lights_test(test_state)
	if  test_state == nil then
		return
	end
	gbl_test_state = test_state[3]
	request_callback(pr_set_power)
	if gbl_test_state == 0 then
		if gbl_vvi_dial_show == 0 then
			visible(txt_leds_vvi,false)
		end
		if gbl_speed_mode == 0 then												-- TO BE CHECKED !!!!!!!!!!!!!!!!!!!!!!!!!!!
			txt_set(txt_leds_warn_spd,gbl_mcp_speed_status)
		else
			txt_set(txt_leds_warn_spd," ")
		end
		txt_set(txt_leds_obs1,gbl_mcp_capt_crs)
		if gbl_speed_mode == 1 then		-- MACH mode
			txt_set(txt_leds_mch, gbl_mcp_mach)
			txt_set(txt_leds_spd, "   ")
		else							-- STD Speed mode
			txt_set(txt_leds_mch, "    ")
			txt_set(txt_leds_spd, gbl_mcp_speed)
		end
		txt_set(txt_leds_hdg,gbl_mcp_hdg)
		txt_set(txt_leds_alt,gbl_mcp_alt)
		txt_set(txt_leds_vvi,gbl_mcp_vvi)
		txt_set(txt_leds_obs2,gbl_mcp_fo_crs)
	elseif gbl_test_state == 1 then
		if gbl_power == 1 then
			visible(txt_leds_vvi,true)
			txt_set(txt_leds_obs1,"888")
			txt_set(txt_leds_warn_spd," ")
			txt_set(txt_leds_mch,"    ")
			txt_set(txt_leds_spd,"88.88")
			txt_set(txt_leds_hdg,"888")
			txt_set(txt_leds_alt,"88880")
			txt_set(txt_leds_vvi,"+8880")
			txt_set(txt_leds_obs2,"888")
		end
	elseif gbl_test_state == 2 then
		txt_set(txt_leds_obs1,"   ")
		txt_set(txt_leds_warn_spd," ")
		txt_set(txt_leds_spd,"   ")
		txt_set(txt_leds_mch,"    ")
		txt_set(txt_leds_hdg,"   ")
		txt_set(txt_leds_alt,"     ")
		txt_set(txt_leds_vvi,"     ")
		txt_set(txt_leds_obs2,"   ")
	end
end

-- FORMATING reference :
-------------------------

--	https://siminnovations.com/forums/viewtopic.php?p=23687#p23687

-- Left justified text can be done by adding the '-' sign.

-- Code: Select all

-- str = string.format("%-4.1f%4.1f", value_1, value_2)

-- string.format uses printf internally. Quite a powerfull tool once you get the hang of it.

-- More info here:
-- http://www.cplusplus.com/reference/cstdio/printf/


-- Corjan 


--==================================================
--		SET Hardware 7-Segment Displays LEDs
--==================================================

function hw_chr_display()	--	MAX7219 mode from AM internal handling is able to displays these digits : "AbcdEFHLP0123456789 .-_"

	--					CRS1	MACH	SPD/ALERT	IAS		HEADING		ALTITUDE	VERT/SPEED		CRS2
	--					  3		  4		  (1*)		 3		   3			5			5			  3		:	 (*SPD/ALERT is common digit) | gbl_mcp_digits:len() = 26 chars
	--	START	=		1		4		8			9		12			15		 	20				25
	--	END		=		3		7		8			11		14		 	19			24	 			27

-- SAMPLE
-----------
	--	OVERSPEED		043		.42		   8		271		  258		  23000		   +1400		043
	--	UNDERSPEED		043		.42		   A		271		  258		  23000		   +1400		043


	-- prtdbg("I:",gbl_mcp_capt_crs)
	-- prtdbg("I:",gbl_mcp_mach)
	-- prtdbg("I:",gbl_mcp_speed_status)
	-- prtdbg("I:",gbl_mcp_speed)
	-- prtdbg("I:",gbl_mcp_hdg)
	-- prtdbg("I:",gbl_mcp_alt)
	-- prtdbg("I:",gbl_mcp_vvi,"dbg06",true)
	-- prtdbg("I:",gbl_mcp_fo_crs)

	c_1 = tonumber(gbl_mcp_capt_crs)
	c_2 = tonumber(gbl_mcp_mach)
	c_3 = string.byte(gbl_mcp_speed_status)
	c_4 = tonumber(gbl_mcp_speed)
	c_5 = tonumber(gbl_mcp_hdg)
	c_6 = tonumber(gbl_mcp_alt)
	c_7 = gbl_mcp_vvi
	c_8 = tonumber(gbl_mcp_fo_crs)

	gbl_mcp_digits = string.format("%03d%01.2f%c%03d%03d%5d%s%03d",
									c_1,
									c_2,
									c_3,
									c_4,
									c_5,
									c_6,
									c_7,
									c_8
									)
	-- gbl_mcp_digits = gbl_mcp_capt_crs..gbl_mcp_mach..gbl_mcp_speed_status..gbl_mcp_speed..gbl_mcp_hdg..gbl_mcp_alt..gbl_mcp_vvi..gbl_mcp_fo_crs

	-- prtdbg("DISP ALL LEDs: ",string.format("%2d",gbl_mcp_digits:len()).."["..gbl_mcp_digits.."]","dbg01",true)

	hw_chr_display0()
	hw_chr_display1()
	hw_chr_display2()
	-- hw_chr_display3()
	-- hw_chr_display4()

	-- prtdbg("DISP LEDs #0: ",str_chr_display0,"dbg02",true)
	-- prtdbg("DISP LEDs #1: ",str_chr_display1,"dbg03",true)
	-- prtdbg("DISP LEDs #2: ",str_chr_display2,"dbg04",true)
	-- prtdbg("DISP LEDs #3: ",str_chr_display3,"dbg05",true)

--	print("DISP#1: "..string.format("%2d",str_chr_display0:len()).."["..str_chr_display0.."]   ".."DISP#2: "..string.format("%2d",str_chr_display1:len()).."["..str_chr_display1.."]")

	-- [ id | #module if chained (starting from 0) | #line starting from 0 (if more than one line available on module) | Value to be displayed ]
	hw_chr_display_set_text(dsply_chr_mcp, 0, 0, str_chr_display0)
	hw_chr_display_set_text(dsply_chr_mcp, 1, 0, str_chr_display1)
	hw_chr_display_set_text(dsply_chr_mcp, 2, 0, str_chr_display2)
	-- hw_chr_display_set_text(dsply_chr_mcp, 3, 0, str_chr_display3)
	-- hw_chr_display_set_text(dsply_chr_mcp, 4, 0, str_chr_display4)
end

function hw_chr_display0()		-- CRS A & SPD
	str_chr_display0 = gbl_mcp_digits:sub(1,3)		-- 3 leds digits
	-- SPEED or MACH
	if gbl_speed_mode == 1 then
		-- 6 digits		-- 4 chars --> 3 leds digits			= 3 leds digits + 3 previous leds digits	= 6 leds digits
		str_chr_display0 = str_chr_display0..gbl_mcp_digits:sub(4,7)
	else
		-- 6 didgits	-- 2 blanks + 1 digit + 2 leds digits	= 5 leds digits + 3 previous leds digits	= 8 leds digits
		str_chr_display0 = str_chr_display0.." "..gbl_mcp_digits:sub(8,11)
	end
end

function hw_chr_display1()		-- HDG & ALT
	str_chr_display1 = gbl_mcp_digits:sub(12,19)		-- 8 leds digits
end

function hw_chr_display2()		-- VSI & CRS B
	str_chr_display2 = gbl_mcp_digits:sub(20,27)		-- 8 leds digits
end

-- function hw_chr_display3()		-- CRS B
	-- str_chr_display3 = gbl_mcp_digits:sub(25,27)		-- 8 leds digits
-- end

-- function hw_chr_display4()		-- SPD (Testing purpose)
	-- str_chr_display4 = gbl_mcp_digits:sub(4,11)		-- 8 leds digits
-- end

--==================================================
--		GENERAL MCP FUNCTIONS
--==================================================

function set_panel_light(brightness)
	if brightness == nil then
		return
	end
	bright = brightness[1]
	gbl_bright_rt = bright
	opacity(lbl_lights_grp,bright)
	opacity(digits_leds_grp,bright+0.3)
	opacity(img_MCP_LIGHT,bright)
	if bright >= 0.5 then
		gbl_light = 1
		-- visible(lbl_lights_grp,true)
	else
		gbl_light = 0
		-- visible(lbl_lights_grp,false)
	end
end

function set_panel_bright(brightness)
	bright = brightness[8]
	opacity(img_MCP_DRK,1-bright-0.2)
	opacity(img_MCP_AMB,bright/10)
	opacity(img_MCP_Flood,bright)
end

	-- Power Handling based on sample instrument "Boeing 737NG - Comm Nav Stack" from Sim Innovations
function pr_set_power(bus_volts,avionics_on,vvi_dial_show,spd_leds_show)
	if bus_volts == nil or avionics_on == nil then
		visible(img_MCP_OFF,true)
		return
	end

	gbl_power = fif((bus_volts[1] > 3 or bus_volts[2] > 3 or bus_volts[3] > 3) and avionics_on, 1, 0)
	if gbl_power == 0 then
		visible(lbl_lights_grp,false)
		visible(digits_leds_grp,false)
		visible(txt_leds_vvi,false)
		visible(txt_leds_spd,false)
		visible(txt_leds_mch,false)
		visible(img_MCP_LIGHT,false)
	else
		visible(img_MCP_LIGHT,true)
		visible(digits_leds_grp,true)
		visible(lbl_lights_grp,true)
		if vvi_dial_show == 1 or gbl_test_state == 1 then
			gbl_vvi_dial_show = 1
			visible(txt_leds_vvi,true)
		else
			gbl_vvi_dial_show = 0
			visible(txt_leds_vvi,false)
		end
		gbl_speed_leds_show = spd_leds_show
		-- print("gbl_speed_mode : "..gbl_speed_mode)
		if (spd_leds_show == 1) or (gbl_test_state == 1) then
			-- visible(txt_leds_spd,gbl_speed_mode == 0)
			-- visible(txt_leds_mch,gbl_speed_mode == 1)
			visible(txt_leds_spd,true)
			visible(txt_leds_mch,true)
		else
			visible(txt_leds_spd,false)
			visible(txt_leds_mch,false)
		end
	end
end

--====================================================================================
--								MISCELLANEOUS FUNCTIONS
--====================================================================================

-- NULL FUNCTION FOR DEFAULT DIALS CALLBACK

function dial_nothing(pos,dir)
end

-- NULL FUNCTION FOR DEFAULT BUTTONS CALLBACK

function btn_nothing()
end

-- TOOLS FUNCTIONS

function prtdbg(label,param,dbgstep,dbgprt)
	-- print("dbg: "..dbgstep)
	if setdebug and dbgprt then
		print(label..": ["..param.."] ".."<"..dbgstep..">")	-- Don't comment out this line, it will not be used, depending on setdebug parameter which has been set to 'false' by default
	end
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
swoff_cwsa_switch		= img_add("off_btn.png" ,mcp_C8,mcp_L5, 70, 70)
swoff_cwsb_switch		= img_add("off_btn.png" ,mcp_C9,mcp_L5, 70, 70)

img_AT_led				= img_add("autothrt_light.png"	,  262, 56, 40, 14)visible(img_AT_led,false)

img_MCP_EMPTY			= img_add_fullscreen("bgempty.png")visible(img_MCP_EMPTY,true)

img_MCP_DRK				= img_add_fullscreen("bgdark.png")visible(img_MCP_DRK,true)
img_MCP_LIGHT			= img_add_fullscreen("bglight.png")visible(img_MCP_LIGHT,true)
img_MCP_NML				= img_add_fullscreen("bg_nml.png")visible(img_MCP_NML,true)

img_screw1				= img_add("screw1.png",  32, 32,32,30)
img_screw2				= img_add("screw2.png",1856, 32,32,30)
img_screw3				= img_add("screw3.png",  32,265,32,30)
img_screw4				= img_add("screw4.png",1856,265,32,30)

--====================================================================================
--								SWITCHES - DIALS
--====================================================================================

switch_fda				= switch_add	("fdaoff.png" , "fdaon.png"			, 185,220, 60, 60,flip_fda)
switch_fdb				= switch_add	("fdboff.png" , "fdbon.png"			,1675,220, 60, 60,flip_fdb)
switch_ath				= switch_add	("autothrtoff.png","autothrton.png"	, 249, 77, 80, 80,flip_ath)
scrollwheel_id			= scrollwheel_add_ver("segment.png", 1365, 152, 32, 120, 32, 20, twist_vs)
swh_mask_id				= img_add("swh_mask.png", 1365, 152, 32, 120)
visible(swh_mask_id,true)

dial_co_obs				= dial_add		("mcpcrs_knob.png"					, 100,127, 72, 72,dial_acc,twist_obs1)
dial_fo_obs				= dial_add		("mcpcrs_knob.png"					,1741,127, 72, 72,dial_acc,twist_obs2)
dial_speed				= dial_add		("mcp_knob.png"						, 469,160, 72, 72,dial_acc,twist_speed)
dial_bank				= dial_add		(nil						, 716,116,100,100,twist_bank)
img_bank_knob			= img_add		("mcpbk_knob.png"					, 719,119, 95, 95)
dial_alt				= dial_add		("mcp_knob.png"						,1037,129, 72, 72,dial_acc,twist_alt)
dial_hdg				= dial_add		("mcp_knob.png"						, 737,137, 58, 58,dial_acc,twist_hdg)

img_disengage			= img_add		("mcp_disengage.png"				,1488,260,160, 40)
btn_AP_Dis_toggle		= button_add	(nil, nil			,1480,240,160, 78,click_dis)
btn_mach				= button_add	("intv_btn.png","intv_btn.png"		, 400,147, 40, 40,click_mach)
btn_altintv				= button_add	("intv_btn.png","intv_btn.png"		,1145,147, 40, 40,click_alt)
btn_spdintv				= button_add	("intv_btn.png","intv_btn.png"		, 572,147, 40, 40,click_spd)

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
img_switch_cwsa			= img_add("sel_btn.png"	,mcp_C8,mcp_L5, 70, 70)
img_switch_cwsb			= img_add("sel_btn.png"	,mcp_C9,mcp_L5, 70, 70)

switch_n1				= switch_add(nil ,nil,mcp_C1,mcp_L3, 70, 70,press_n1)
switch_speed			= switch_add(nil ,nil,mcp_C2,mcp_L3, 70, 70,press_speed)
switch_vnav				= switch_add(nil ,nil,mcp_C3,mcp_L1, 70, 70,press_vnav)
switch_lvl_chg			= switch_add(nil ,nil,mcp_C3,mcp_L3, 70, 70,press_lvl_chg)
switch_hdg_sel			= switch_add(nil ,nil,mcp_C4,mcp_L3, 70, 70,press_hdg_sel)
switch_lnav				= switch_add(nil ,nil,mcp_C5,mcp_L1, 70, 70,press_lnav)
switch_vor_loc			= switch_add(nil ,nil,mcp_C5,mcp_L2, 70, 70,press_vor_loc)
switch_app				= switch_add(nil ,nil,mcp_C5,mcp_L3, 70, 70,press_app)
switch_alt_hold 		= switch_add(nil ,nil,mcp_C6,mcp_L3, 70, 70,press_alt_hold)
switch_vs				= switch_add(nil ,nil,mcp_C7,mcp_L3, 70, 70,press_vs)
switch_cmda				= switch_add(nil ,nil,mcp_C8,mcp_L4, 70, 70,press_cmda)
switch_cmdb				= switch_add(nil ,nil,mcp_C9,mcp_L4, 70, 70,press_cmdb)
switch_cwsa				= switch_add(nil ,nil,mcp_C8,mcp_L5, 70, 70,press_cwsa)
switch_cwsb				= switch_add(nil ,nil,mcp_C9,mcp_L5, 70, 70,press_cwsb)

txt_lbl_n1				= txt_add("N1"			,txt_style2,mcp_C1-3,mcp_L3+5,80,30)
txt_lbl_speed			= txt_add("SPEED"		,txt_style2,mcp_C2-3,mcp_L3+5,80,30)
txt_lbl_vnav			= txt_add("VNAV"		,txt_style2,mcp_C3-3,mcp_L1+5,80,30)
txt_lbl_lvlchg			= txt_add("LVL CHG"	,txt_style2,mcp_C3-3,mcp_L3+5,80,30)
txt_lbl_hdg				= txt_add("HDG SEL"	,txt_style2,mcp_C4-3,mcp_L3+5,80,30)
txt_lbl_lnav			= txt_add("LNAV"		,txt_style2,mcp_C5-3,mcp_L1+5,80,30)
txt_lbl_vorloc			= txt_add("VOR LOC"	,txt_style2,mcp_C5-3,mcp_L2+5,80,30)
txt_lbl_app				= txt_add("APP"		,txt_style2,mcp_C5-3,mcp_L3+5,80,30)
txt_lbl_alt				= txt_add("ALT HLD"	,txt_style2,mcp_C6-3,mcp_L3+5,80,30)
txt_lbl_vs				= txt_add("V/S"		,txt_style2,mcp_C7-3,mcp_L3+5,80,30)
txt_lbl_cmda			= txt_add("CMD"		,txt_style2,mcp_C8-3,mcp_L4+5,80,30)
txt_lbl_cmdb			= txt_add("CMD"		,txt_style2,mcp_C9-3,mcp_L4+5,80,30)
txt_lbl_cwsa			= txt_add("CWS"		,txt_style2,mcp_C8-3,mcp_L5+5,80,30)
txt_lbl_cwsb			= txt_add("CWS"		,txt_style2,mcp_C9-3,mcp_L5+5,80,30)
	
txt_lbl_light_n1		= txt_add("N1"			,txt_style3,mcp_C1-3,mcp_L3+5,80,30)
txt_lbl_light_speed		= txt_add("SPEED"		,txt_style3,mcp_C2-3,mcp_L3+5,80,30)
txt_lbl_light_vnav		= txt_add("VNAV"		,txt_style3,mcp_C3-3,mcp_L1+5,80,30)
txt_lbl_light_lvlchg	= txt_add("LVL CHG"	,txt_style3,mcp_C3-3,mcp_L3+5,80,30)
txt_lbl_light_hdg		= txt_add("HDG SEL"	,txt_style3,mcp_C4-3,mcp_L3+5,80,30)
txt_lbl_light_lnav		= txt_add("LNAV"		,txt_style3,mcp_C5-3,mcp_L1+5,80,30)
txt_lbl_light_vorloc	= txt_add("VOR LOC"	,txt_style3,mcp_C5-3,mcp_L2+5,80,30)
txt_lbl_light_app		= txt_add("APP"		,txt_style3,mcp_C5-3,mcp_L3+5,80,30)
txt_lbl_light_alt		= txt_add("ALT HLD"	,txt_style3,mcp_C6-3,mcp_L3+5,80,30)
txt_lbl_light_vs		= txt_add("V/S"		,txt_style3,mcp_C7-3,mcp_L3+5,80,30)
txt_lbl_light_cmda		= txt_add("CMD"		,txt_style3,mcp_C8-3,mcp_L4+5,80,30)
txt_lbl_light_cmdb		= txt_add("CMD"		,txt_style3,mcp_C9-3,mcp_L4+5,80,30)
txt_lbl_light_cwsa		= txt_add("CWS"		,txt_style3,mcp_C8-3,mcp_L5+5,80,30)
txt_lbl_light_cwsb		= txt_add("CWS"		,txt_style3,mcp_C9-3,mcp_L5+5,80,30)

txt_leds_obs1			= txt_add(""			,txt_style1,   95, tleds_line,  94, 61)
txt_leds_mch			= txt_add(""			,txt_style1,  316, tleds_line, 150, 61)
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
								img_switch_cwsa,
								img_switch_cwsb)visible(mcp_switch_grp,false)

digits_leds_grp		= group_add(txt_leds_obs1,
								txt_leds_mch,
								txt_leds_warn_spd,
								txt_leds_spd,
								txt_leds_hdg,
								txt_leds_alt,
								txt_leds_vvi,
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
								txt_lbl_light_cwsa,
								txt_lbl_light_cwsb)visible(lbl_lights_grp,false)

img_MCP_AMB				= img_add_fullscreen("ambient.png")visible(img_MCP_AMB,false)
img_MCP_Flood			= img_add("flood.png",0,0,1920,17)visible(img_MCP_Flood,false)

lbl_ver = txt_add	(Title.." - "..Z_2D_XP_MCP.." - min.req.: "..ZiboModminRelease, txt_style0, 785, 5, 350, 20)
visible(lbl_ver,info_shown_bln)

function pr_check_infos()
	info_shown_bln = not(info_shown_bln)
	visible(lbl_ver,info_shown_bln)
end
btn_lbl_ver = button_add(nil,nil, 773, 5, 350, 20, pr_check_infos)

-- visible(img_MCP_LIGHT,false)

--====================================================================================
--								DATAREFS SUBSCRIBE
--====================================================================================

xpl_dataref_subscribe("laminar/B738/autopilot/n1_status1"					,"FLOAT",			n1_chg)	-- updated with 3_49_10
xpl_dataref_subscribe("laminar/B738/autopilot/speed_status1"				,"FLOAT",			mcpspd_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/vnav_status1"					,"FLOAT",			vnav_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/lvl_chg_status"				,"FLOAT",			lvlchg_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/hdg_sel_status"				,"FLOAT",			hdgsel_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/lnav_status"					,"FLOAT",			lnav_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/vorloc_status"				,"FLOAT",			vorloc_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/app_status"					,"FLOAT",			app_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/alt_hld_status"				,"FLOAT",			alt_hold_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/vs_status"					,"FLOAT",			vs_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/cmd_a_status"					,"FLOAT",			cmda_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/cmd_b_status"					,"FLOAT",			cmdb_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/cws_a_status"					,"FLOAT",			cwsa_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/cws_b_status"					,"FLOAT",			cwsb_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/master_capt_status"			,"FLOAT",			FA_MA_A_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/master_fo_status"				,"FLOAT",			FA_MA_B_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/flight_director_pos"			,"FLOAT",			fda_switch_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/flight_director_fo_pos"		,"FLOAT",			fdb_switch_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/autothrottle_arm_pos"			,"FLOAT",			img_AT_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/autothrottle_status1"			,"FLOAT",			img_AT_led_state)	-- updated with 3_49_10
xpl_dataref_subscribe("laminar/B738/autopilot/course_pilot"					,"FLOAT",			obs1_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/course_copilot"				,"FLOAT",			obs2_chg)

-- Previous Datarefs
-- xpl_dataref_subscribe("laminar/radios/pilot/nav_obs"							,"FLOAT",		obs1_chg)
-- xpl_dataref_subscribe("laminar/radios/copilot/nav_obs"						,"FLOAT",		obs2_chg)

xpl_dataref_subscribe("laminar/B738/autopilot/mcp_alt_dial"					,"FLOAT",			mcp_alt_chg )
xpl_dataref_subscribe("laminar/B738/autopilot/mcp_speed_dial_kts_mach"		,"FLOAT", 
						"sim/cockpit2/autopilot/airspeed_is_mach"			,"INT", 			mcp_spd_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/bank_angle_pos"				,"FLOAT",			bank_limit_chg)
xpl_dataref_subscribe("laminar/B738/autopilot/mcp_hdg_dial"					,"FLOAT",			mcp_hdg_chg)
-- xpl_dataref_subscribe("laminar/B738/autopilot/ap_vvi_pos"					,"FLOAT",			mcp_vvi_chg)
xpl_dataref_subscribe("sim/cockpit/autopilot/vertical_velocity"					,"FLOAT",			mcp_vvi_chg)	-- Updated due to changes starting from 3.56 6.n
xpl_dataref_subscribe("laminar/B738/autopilot/disconnect_pos"				,"FLOAT",			APengage_chg)

xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts"					,"FLOAT[6]",
					  "sim/cockpit/electrical/avionics_on"					,"INT",
					  "laminar/B738/autopilot/vvi_dial_show"				,"FLOAT",
					  "laminar/B738/autopilot/show_ias"						,"FLOAT",			pr_set_power)

xpl_dataref_subscribe("laminar/B738/electric/panel_brightness"				,"FLOAT[4]",		set_panel_light) --> set LEDs Bright MAIN PANEL BRIGHT / value[1] --(index=1 for read and index=0 for write)



xpl_dataref_subscribe("laminar/B738/electric/generic_brightness","FLOAT[128]",	set_panel_bright) --> set Panel Bright AFDS FLOOD BRIGHT / value[8] --(index=8 for read and index=7 for write)
-- xpl_dataref_subscribe("sim/flightmodel2/lights/generic_lights_brightness_ratio","FLOAT[128]",	set_panel_bright) --> set Panel Bright AFDS FLOOD BRIGHT / value[8] --(index=8 for read and index=7 for write)

xpl_dataref_subscribe("laminar/B738/autopilot/blink"						,"FLOAT",
						"laminar/B738/mcp/over_spd"							,"FLOAT",
						"laminar/B738/mcp/digit_A"							,"FLOAT",
						set_panel_states)
xpl_dataref_subscribe("laminar/B738/dspl_light_test"						,"FLOAT[10]",		display_lights_test)

-- TOGA "laminar/B738/autopilot/left_toga_pos"

--====================================================================================
--								HARDWARE HANDLING
--====================================================================================

-- MAX7219 LEDs displays

--dsply_chr_mcp = hw_chr_display_add("MAX7219", daisychain_nb,"ARDUINO_UNO_A_A0","ARDUINO_UNO_A_A1","ARDUINO_UNO_A_A2")	-- Character display name / Type / Number

--	3	OUTPUTS by Single or Daisychained : MAX7219 Displays LEDs (Maxi 4 Daisychained)

	-- Character display name / Type / Number
dsply_chr_mcp = hw_chr_display_add("MCP MAX7219 LEDs display OUTPUT Channel", "MAX7219", daisychain_nb)

function set_hw_chr_bright(bright)
	hw_chr_display_set_brightness(dsply_chr_mcp, 0, bright)
	hw_chr_display_set_brightness(dsply_chr_mcp, 1, bright)
	hw_chr_display_set_brightness(dsply_chr_mcp, 2, bright)
	-- hw_chr_display_set_brightness(dsply_chr_mcp, 3, bright)
	-- hw_chr_display_set_brightness(dsply_chr_mcp, 4, bright)
end

set_hw_chr_bright(0.1)

hw_max_bright	= hw_adc_input_add("MCP LEDs Brightness", set_hw_chr_bright)

if hw_connected(hw_max_bright) then
	cur_bright		= hw_adc_input_read(hw_max_bright)
	set_hw_chr_bright(cur_bright)
end

--	12	INPUTS : Dials

hw_dial_crs1		= hw_dial_add("CRS1 Knob",detperpulse_str,accel_num,debounce_ms,twist_obs1)
hw_dial_crs2		= hw_dial_add("CRS2 Knob",detperpulse_str,accel_num,debounce_ms,twist_obs2)
hw_dial_speed		= hw_dial_add("SPEED Knob",detperpulse_str,accel_num,debounce_ms,twist_speed)
hw_dial_hdg			= hw_dial_add("HDG Knob",detperpulse_str,accel_num,debounce_ms,twist_hdg)
hw_dial_alt			= hw_dial_add("ALT Knob",detperpulse_str,accel_num,debounce_ms,twist_alt)
hw_dial_vswheel		= hw_dial_add("V/S Wheel",detperpulse_str,accel_num,debounce_ms,twist_vs)

--	5	INPUTS : Bank Switch

hw_switch_bank		= hw_switch_add("BANK Switch", 5,
									function(mode_state)
										xpl_dataref_write("laminar/B738/rotary/autopilot/bank_angle", "INT", mode_state)
									end)
if (hw_switch_get_position(hw_switch_bank) ~= nil) then
	xpl_dataref_write("laminar/B738/rotary/autopilot/bank_angle", "INT", hw_switch_get_position(hw_switch_bank))
end

--	8	INPUTS : FDA/AT/DISENGAGE/FDB Switches

hw_switch_fd1		= hw_switch_add("FD CAPT",2,flip_fda)
hw_switch_at		= hw_switch_add("A/T",2,flip_ath)
hw_switch_dis		= hw_switch_add("DISENGAGE ",2,click_dis)
hw_switch_fd2		= hw_switch_add("FD FO",2,flip_fdb)

--	17	INPUTS : Push Buttons


hw_button_n1		= hw_button_add("N1",press_n1)
hw_button_spd		= hw_button_add("SPEED",press_speed)
hw_button_co		= hw_button_add("C/O",click_mach)
hw_button_spdintv	= hw_button_add("SPD INTV",click_spd)
hw_button_vnv		= hw_button_add("VNAV",press_vnav)
hw_button_lnv		= hw_button_add("LNAV",press_lnav)
hw_button_vlc		= hw_button_add("VOR LOC",press_vor_loc)
hw_button_lch		= hw_button_add("LVL CHG",press_lvl_chg)
hw_button_hsl		= hw_button_add("HDG SEL",press_hdg_sel)
hw_button_app		= hw_button_add("APP",press_app)
hw_button_ahd		= hw_button_add("ALT HLD",press_alt_hold)
hw_button_altintv	= hw_button_add("ALT INTV",click_alt)
hw_button_vs		= hw_button_add("V/S",press_vs)
hw_button_cmda		= hw_button_add("CMDA",press_cmda)
hw_button_cmdb		= hw_button_add("CMDB",press_cmdb)
hw_button_cwsa		= hw_button_add("CWSA",press_cwsa)
hw_button_cwsb		= hw_button_add("CWSB",press_cwsb)

--	17	OUTPUTS : LEDs

hw_led_fda			= hw_led_add("FD A MAST state", 0)
hw_led_atarm		= hw_led_add("AT ARM state", 0)
hw_led_n1			= hw_led_add("N1 state", 0)
hw_led_speed		= hw_led_add("SPEED state", 0)
hw_led_vnav			= hw_led_add("VNAV state", 0)
hw_led_lvlchg		= hw_led_add("LVLCHG state", 0)
hw_led_hdgsel		= hw_led_add("HDGSEL state", 0)
hw_led_lnav			= hw_led_add("LNAV state", 0)
hw_led_vorloc		= hw_led_add("VORLOC state", 0)
hw_led_app			= hw_led_add("APP state", 0)
hw_led_althld		= hw_led_add("ALTHLD state", 0)
hw_led_vs			= hw_led_add("VS state", 0)
hw_led_cmda			= hw_led_add("CMDA state", 0)
hw_led_cmdb			= hw_led_add("CMDB state", 0)
hw_led_cwsa			= hw_led_add("CWSA state", 0)
hw_led_cwsb			= hw_led_add("CWSB state", 0)
hw_led_fdb			= hw_led_add("FD B MAST state", 0)

function event_callback(event)	-- [STARTED / SHOWING / CLOSING / FLIGHT_SIM_CHANGED]
    if event == "CLOSING" then
		hw_led_set(hw_led_fda,0)
		hw_led_set(hw_led_fdb,0)
		hw_led_set(hw_led_atarm,0)
		hw_led_set(hw_led_n1,0)
		hw_led_set(hw_led_speed,0)
		hw_led_set(hw_led_vnav,0)
		hw_led_set(hw_led_lvlchg,0)
		hw_led_set(hw_led_hdgsel,0)
		hw_led_set(hw_led_lnav,0)
		hw_led_set(hw_led_vorloc,0)
		hw_led_set(hw_led_app,0)
		hw_led_set(hw_led_althld,0)
		hw_led_set(hw_led_vs,0)
		hw_led_set(hw_led_cmda,0)
		hw_led_set(hw_led_cmdb,0)
		hw_led_set(hw_led_cwsa,0)
		hw_led_set(hw_led_cwsb,0)
		hw_chr_display_set_text(dsply_chr_mcp, 0, 0, "        ")
		hw_chr_display_set_text(dsply_chr_mcp, 1, 0, "        ")
		hw_chr_display_set_text(dsply_chr_mcp, 2, 0, "        ")
		hw_chr_display_set_text(dsply_chr_mcp, 3, 0, "        ")
		-- hw_chr_display_set_text(dsply_chr_mcp, 4, 0, "        ")
    end
end

event_subscribe(event_callback)

-- request_callback(mcp_vvi_chg)	-- Don't Remove !!!

-- DIGITAL INPUTS (D)
---------------------
-- UNO		: 2-13 = 12				(+6)	= [>>> 18 <<<]
-- MEGA2560	: 2-53 = 51				(+16)	= [>>> 67 <<<]
-- NANO		: 2-13 = 12				(+6)	= [>>> 18 <<<] = with 2 ADC left [>>> 20 <<<]
-- MICRO	: 2-13 = 12				(+6)	= [>>> 18 <<<]
-- LEONARDO : 2-13 = 12				(+6)	= [>>> 18 <<<]
-- HW_PORT	: 5-16 = 12				(+4)	= [>>> 16 <<<]

-- ANALOG INPUTS (A)
--------------------
-- UNO		: 0-5	= 6
-- MEGA2560	: 0-15	= 16
-- NANO		: 0-7	= 8
-- MICRO	: 0-5	= 6
-- LEONARDO : 0-5	= 6
-- HW_PORT	: 1-4	= 4

