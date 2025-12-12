-- ============================================================================================================
-- 				External SIXPACK Panel dedicated to Boeing B737-800X ZiboMod for X-Plane
-- ============================================================================================================
--						Hardware Ready using Arduino board for Cockpitbuilders

----------------------------------------
--			AUTHORING SECTION
----------------------------------------

-- Values to be updated by Authors

	local AM_Main_Release = "AM3.7"			-- Minimal AM release requirement
	local Z_2D_XP_SIXPACK = "1.0.2"		-- Current SIXPACK release
	local Date_Release = "04/03/2023"		-- Current SIXPACK release date
 
--=============================================================================
--=============================================================================

-- Don't change these following values
-- or at least,
-- only for personal usage

	local Title = "Z_2D_XP_SIXPACK"
	local InitialRelease_Date="05/24/2021"
	local InitialAuthor = "enjxp_SimPassion" -- "enjxp" on x-plane.org forum and "SimPassion" on Sim Innovations forum (same person)

--=============================================================================
--=============================================================================

----------------------------------------
--			RELEASE SECTION
----------------------------------------

local ZiboProject_Builders = "Zibo/AeroSimDevGroup/Fay/Twkster/Audiobirdxp/DrGluck/Flightdeck2sim/Folko/JBrik/Unsafe05/MugZ/737ngworld/m.philippi"

local Z_2D_XP_SIXPACK_ScriptAuthors = "	enjxp_SimPassion/	/	/	/	/	"

-- Register here each of the successive revisions with comments

-- TODO : Add hardware brightness handling via ADC input and DAIL input for both LEDs displays and Key Lighting

--	Author						Date			Release		Comments
--	enjxp_SimPassion			04/03/2023		1.0.2		Fixed brightness handling
--	enjxp_SimPassion			02/10/2023		1.0.1		Fixed bitmap filename to lowercase
--	enjxp_SimPassion			05/24/2021		1.0.0		Initial release

--=============================================================================
------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
--  Initial release based on initial graphic design by AudioBirdXP and Zibo in ZiboMod 3.31d,
--	thanks to AudioBirdXP agreement for publishing
---------------------------------------------------------------------------------------------------------------------------------------------

--  Note that this panel only mimics the 737 SIXPACK by sending inputs
--  and displaying the 737 outputs.

--	Default size = 429 x 174

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
--		as all objects are displayed with a layer order : the first objects appears behind and the last objects appears in front following the order in which they're been wrote in the script

--========================================================================================================================================================================================================


--======================================================================================
--								SCRIPT START
--======================================================================================

----------------------------------------
--			PRE INIT
----------------------------------------

local info_shown_bln = false

	up_info_shown_bln = user_prop_add_boolean("DISPLAY CHECK INFOS", false, "Display Release infos")
	info_shown_bln = user_prop_get(up_info_shown_bln)

	up_side_str = user_prop_add_enum("CAPT or FO Side", "CAPT,FO", "CAPT", "Choose CAPT or FO Side and restart AM Instrument")
	side_str = user_prop_get(up_side_str)

color_black			= "#000000;"
color_grey			= "#414141;"
color_amber			= "#f9b01e;"
color_yellow		= "yellow;"

font_SZ0			= "size:17px; halign:center; font:arimo_bold.ttf; color:"
font_SZ1			= "size:22px; halign:center; font:Inconsolata-Bold_sml.ttf; color:"
font_SZ2			= "size:31px; halign:center; font:Inconsolata-Bold.ttf; color:"

style_00_amber		= font_SZ0 .. color_amber
style_00_yellow		= font_SZ0 .. color_yellow .. " halign: center;"
style_00_grey1		= font_SZ0 .. color_grey
style_22_grey1		= font_SZ1 .. color_grey
style_31_grey1		= font_SZ2 .. color_grey

local gbl_power		= 0
local str_side		= "CAPT"
local testrt		= 0

img_bg				= img_add_fullscreen("Sixpack_Panel_BG.png")

function pr_test(bright_test)
	if bright_test == -1 then
		testrt = 0.75
	else
		testrt = 1
	end
end

xpl_dataref_subscribe("laminar/B738/toggle_switch/bright_test","FLOAT",
						pr_test)

function press_six()
	xpl_command("laminar/B738/push_button/"..str_side2.."_six_pack", 1)
	xpl_dataref_write("laminar/B738/push_button/"..str_side2.."_six_pack", "FLOAT", 1)
end
function release_six()
	xpl_command("laminar/B738/push_button/"..str_side2.."_six_pack", 0)
	xpl_dataref_write("laminar/B738/push_button/"..str_side2.."_six_pack", "FLOAT", 0)
end

function press_six_capt()
	xpl_command("laminar/B738/push_button/capt_six_pack", 1)
	xpl_dataref_write("laminar/B738/push_button/capt_six_pack", "FLOAT", 1)
end
function release_six_capt()
	xpl_command("laminar/B738/push_button/capt_six_pack", 0)
	xpl_dataref_write("laminar/B738/push_button/capt_six_pack", "FLOAT", 0)
end

function press_six_fo()
	xpl_command("laminar/B738/push_button/fo_six_pack", 1)
	xpl_dataref_write("laminar/B738/push_button/fo_six_pack", "FLOAT", 1)
end
function release_six_fo()
	xpl_command("laminar/B738/push_button/fo_six_pack", 0)
	xpl_dataref_write("laminar/B738/push_button/fo_six_pack", "FLOAT", 0)
end

function reset_fire_warn_pressed()
	xpl_command("laminar/B738/push_button/fire_bell_light"..spunit,1)
end

function reset_fire_warn_release()
	xpl_command("laminar/B738/push_button/fire_bell_light"..spunit,0)
end

function click_MC()
	xpl_command("laminar/B738/push_button/master_caution"..spunit,1)
	xpl_dataref_write("laminar/B738/push_button/master_caution_accept"..spunit, "FLOAT", 1)
end

function release_MC()
	xpl_command("laminar/B738/push_button/master_caution"..spunit,0)
	xpl_dataref_write("laminar/B738/push_button/master_caution_accept"..spunit, "FLOAT", 0)
end

img_annun_LIGHT_pilot	= img_add_fullscreen("sixpack_panel_lit_bg_pilot.png")
an_bg_capt				= img_add("an_bg_capt.png",					210,  42, 200, 90)
capt_fire_warn_dark		= img_add("fire_warn_dark.png",				 18,  48,  78, 76)
capt_MC_dark			= img_add("mc_dark.png",					108,  48,  78, 76)
txt_drk_flt_cont		= txt_add("FLT CONT", style_00_grey1,		210,  50, 100, 30)
txt_drk_irs				= txt_add("IRS", style_00_grey1, 			210,  79, 100, 30)
txt_drk_fuel			= txt_add("FUEL", style_00_grey1,			210, 109, 100, 30)
txt_drk_elec			= txt_add("ELEC", style_00_grey1,			310,  50, 100, 30)
txt_drk_apu				= txt_add("APU", style_00_grey1,			310,  79, 100, 30)
txt_drk_ovht_det		= txt_add("OVHT/DET", style_00_grey1,		310, 109, 100, 30)

capt_an_fire_warn_state	= img_add("fire_warn.png",					 18,  48,  78, 76)
capt_an_MC_state		= img_add("mc_lit.png",						108,  48,  78, 76)
txt_flt_cont			= txt_add("FLT CONT", style_00_amber,		210,  50, 100, 30)
txt_irs					= txt_add("IRS", style_00_amber,			210,  79, 100, 30)
txt_fuel				= txt_add("FUEL", style_00_amber,			210, 109, 100, 30)
txt_elec				= txt_add("ELEC", style_00_amber,			310,  50, 100, 30)
txt_apu					= txt_add("APU", style_00_amber,			310,  79, 100, 30)
txt_ovht_det			= txt_add("OVHT/DET", style_00_amber,		310, 109, 100, 30)

btn_six_pack_capt		= button_add(nil,nil,						210,  42, 178, 88, press_six, release_six)
btn_fire_warn_capt		= button_add(nil,nil,						 18,  48,  78, 76, reset_fire_warn_pressed, reset_fire_warn_release)
btn_MC_capt				= button_add(nil,nil,						108,  48,  78, 76, click_MC, release_MC)

grp_capt_side1 = group_add(btn_six_pack_capt,
							btn_fire_warn_capt,
							btn_MC_capt,
							img_annun_LIGHT_pilot,
							an_bg_capt,
							capt_fire_warn_dark,
							capt_MC_dark,
							txt_drk_flt_cont,
							txt_drk_irs,
							txt_drk_fuel,
							txt_drk_elec,
							txt_drk_apu,
							txt_drk_ovht_det)visible(grp_capt_side1,false)
grp_capt_side2 = group_add(capt_an_fire_warn_state,
							capt_an_MC_state,
							txt_flt_cont,
							txt_irs,
							txt_fuel,
							txt_elec,
							txt_apu,
							txt_ovht_det,
							txt_drk_flt_cont,
							txt_drk_irs,
							txt_drk_fuel,
							txt_drk_elec,
							txt_drk_apu,
							txt_drk_ovht_det)visible(grp_capt_side2,false)

img_annun_LIGHT_fo		= img_add_fullscreen("sixpack_panel_lit_bg_fo.png")
an_bg_fo				= img_add("an_bg_fo.png",					 18,  42, 200, 90)
fo_fire_warn_dark		= img_add("fire_warn_dark.png",				332,  50,  78, 76)
fo_MC_dark				= img_add("mc_dark.png",					242,  50,  78, 76)
txt_drk_anti_ice		= txt_add("ANTI-ICE", style_00_grey1,		 18,  50, 100, 30)
txt_drk_hyd				= txt_add("HYD", style_00_grey1,			 18,  79, 100, 30)
txt_drk_doors			= txt_add("DOORS", style_00_grey1,			 18, 109, 100, 30)
txt_drk_eng				= txt_add("ENG", style_00_grey1,			118,  50, 100, 30)
txt_drk_overhead		= txt_add("OVERHEAD", style_00_grey1,		118,  79, 100, 30)
txt_drk_air_cond		= txt_add("AIR COND", style_00_grey1,		118, 109, 100, 30)

fo_an_fire_warn_state	= img_add("fire_warn.png",					332,  50,  78, 76)
fo_an_MC_state			= img_add("mc_lit.png",						242,  50,  78, 76)
txt_anti_ice			= txt_add("ANTI-ICE", style_00_amber,		 18,  50, 100, 30)
txt_hyd					= txt_add("HYD", style_00_amber,			 18,  79, 100, 30)
txt_doors				= txt_add("DOORS", style_00_amber,			 18, 109, 100, 30)
txt_eng					= txt_add("ENG", style_00_amber,			118,  50, 100, 30)
txt_overhead			= txt_add("OVERHEAD", style_00_amber,		118,  79, 100, 30)
txt_air_cond			= txt_add("AIR COND", style_00_amber,		118, 109, 100, 30)

btn_six_pack_fo			= button_add(nil,nil,						 18,  42, 200, 90, press_six, release_six)
btn_fire_warn_fo		= button_add(nil,nil,						332,  48,  78, 76, reset_fire_warn_pressed, reset_fire_warn_release)
btn_MC_fo				= button_add(nil,nil,						232,  48,  78, 76, click_MC, release_MC)

grp_fo_side1 = group_add(btn_six_pack_fo,
							btn_fire_warn_fo,
							btn_MC_fo,
							img_annun_LIGHT_fo,
							an_bg_fo,
							fo_fire_warn_dark,
							fo_MC_dark,
							txt_drk_flt_cont,
							txt_drk_irs,
							txt_drk_fuel,
							txt_drk_elec,
							txt_drk_apu,
							txt_drk_ovht_det)visible(grp_fo_side1,false)
grp_fo_side2 = group_add(fo_an_fire_warn_state,
							fo_an_MC_state,
							txt_anti_ice,
							txt_hyd,
							txt_doors,
							txt_eng,
							txt_overhead,
							txt_air_cond,
							txt_drk_anti_ice,
							txt_drk_hyd,
							txt_drk_doors,
							txt_drk_eng,
							txt_drk_overhead,
							txt_drk_air_cond)visible(grp_fo_side2,false)

function annun_state_status(FLT_CON_state,			-- param #01
							IRS_state,				-- param #02
							FUEL_state,				-- param #03
							ELEC_state,				-- param #04
							APU_state,				-- param #05
							OVHT_DET_state,			-- param #06
							ANTI_ICE_state,			-- param #07
							HYD_state,				-- param #08
							DOORS_state,			-- param #09
							ENG_state,				-- param #10
							OVERHEAD_state,			-- param #11
							AIR_COND_state,			-- param #12
							fire_warn_state,		-- param #13
							fire_warn_state2,		-- param #14
							MC_state)				-- param #15

	side_disc_state = ap_disc_state
	side_disc_state = at_disc_state

	if str_side == "CAPT" then
		opacity(txt_flt_cont,		fif(FLT_CON_state ~= 0,1,0) * testrt)
		opacity(txt_irs,			fif(IRS_state ~= 0,1,0) * testrt)
		opacity(txt_fuel,			fif(FUEL_state ~= 0,1,0) * testrt)
		opacity(txt_elec,			fif(ELEC_state ~= 0,1,0) * testrt)
		opacity(txt_apu,			fif(APU_state ~= 0,1,0) * testrt)
		opacity(txt_ovht_det,		fif(OVHT_DET_state ~= 0,1,0) * testrt)
		visible(txt_flt_cont,		(FLT_CON_state > 0) and (gbl_power == 1))
		visible(txt_irs,			(IRS_state > 0) and (gbl_power == 1))
		visible(txt_fuel,			(FUEL_state > 0) and (gbl_power == 1))
		visible(txt_elec,			(ELEC_state > 0) and (gbl_power == 1))
		visible(txt_apu,			(APU_state > 0) and (gbl_power == 1))
		visible(txt_ovht_det,		(OVHT_DET_state > 0) and (gbl_power == 1))
		visible(capt_an_fire_warn_state,(fire_warn_state > 0) and (gbl_power == 1))
		visible(capt_an_MC_state,		(MC_state > 0) and (gbl_power == 1))
	elseif str_side == "FO" then
		opacity(txt_anti_ice,		fif(ANTI_ICE_state ~= 0,1,0) * testrt)
		opacity(txt_hyd,			fif(HYD_state ~= 0,1,0) * testrt)
		opacity(txt_doors,			fif(DOORS_state ~= 0,1,0) * testrt)
		opacity(txt_eng,			fif(ENG_state ~= 0,1,0) * testrt)
		opacity(txt_overhead,		fif(OVERHEAD_state ~= 0,1,0) * testrt)
		opacity(txt_air_cond,		fif(AIR_COND_state ~= 0,1,0) * testrt)
		visible(txt_anti_ice,		(ANTI_ICE_state > 0) and (gbl_power == 1))
		visible(txt_hyd,			(HYD_state > 0) and (gbl_power == 1))
		visible(txt_doors,			(DOORS_state > 0) and (gbl_power == 1))
		visible(txt_eng,			(ENG_state > 0) and (gbl_power == 1))
		visible(txt_overhead,		(OVERHEAD_state > 0) and (gbl_power == 1))
		visible(txt_air_cond,		(AIR_COND_state > 0) and (gbl_power == 1))
		visible(fo_an_fire_warn_state,(fire_warn_state2 > 0) and (gbl_power == 1))
		visible(fo_an_MC_state,		(MC_state > 0) and (gbl_power == 1))
	end
end

function set_panel_bright(brightness)
	bright = brightness[10]
	if gbl_power == 1 then
		if str_side == "CAPT" then
			visible(img_annun_LIGHT_fo,false)
			visible(img_annun_LIGHT_pilot,true)
			opacity(img_annun_LIGHT_pilot,1-bright)
		elseif str_side == "FO" then
			visible(img_annun_LIGHT_pilot,false)
			visible(img_annun_LIGHT_fo,true)
			opacity(img_annun_LIGHT_fo,1-bright)
		end
	end
end

function set_power_xpl(bus_volts,avionics_on)	-- Power Handling Based on sample instrument "Boeing 737NG - Comm Nav Stack" from Sim Innovations
	if  bus_volts == nil or avionics_on == nil then
		return
	end
	gbl_power = fif((bus_volts[1] > 10) or (bus_volts[2] > 10), 1, 0)
	if gbl_power == 0 then
		visible(img_annun_LIGHT_pilot,false)
		visible(img_annun_LIGHT_fo,false)
	else
		if str_side == "CAPT" then
			visible(img_annun_LIGHT_pilot,true)
			visible(img_annun_LIGHT_fo,false)
		elseif str_side == "FO" then
			visible(img_annun_LIGHT_pilot,false)
			visible(img_annun_LIGHT_fo,true)
		end
	end
end

-- SIXPACK SIDE handling

int_lbl_capt_loc	= 5
int_lbl_fo_loc		= 369

lbl_ver_sixpack		= txt_add(Title.." - "..Z_2D_XP_SIXPACK, style_00_yellow, 				 115, 	150, 200, 20)
lbl_capt_sixpack	= txt_add("CAPT", style_00_yellow,							int_lbl_capt_loc,	150,  55, 20)
lbl_fo_sixpack		= txt_add("FO", style_00_yellow,							  int_lbl_fo_loc,	150,  55, 20)

function compute_display_infos()
	visible(lbl_ver_sixpack,info_shown_bln)
	visible(lbl_capt_sixpack,info_shown_bln and str_side == "CAPT")
	visible(lbl_fo_sixpack,info_shown_bln and str_side == "FO")
end

function compute_check_infos()
	info_shown_bln = not(info_shown_bln)
	compute_display_infos()
end

function switch_capt_side()
	str_side			= "CAPT"
	str_side2			= "capt"
	spunit				= "1"
	visible(grp_fo_side1,false)
	visible(grp_fo_side2,false)
	visible(grp_capt_side1,true)
	visible(grp_capt_side2,true)
	compute_display_infos()
	request_callback(set_panel_bright)
	request_callback(annun_state_status)
end

function switch_fo_side()
	str_side			= "FO"
	str_side2			= "fo"
	spunit				= "2"
	visible(grp_capt_side1,false)
	visible(grp_capt_side2,false)
	visible(grp_fo_side1,true)
	visible(grp_fo_side2,true)
	compute_display_infos()
	request_callback(set_panel_bright)
	request_callback(annun_state_status)
end

if side_str == "CAPT" then
	switch_capt_side()
elseif side_str == "FO" then
	switch_fo_side()
end

compute_display_infos()

btn_lbl_ver		= button_add(nil,nil, 115, 150, 200, 20,compute_check_infos)
btn_capt_side	= button_add(nil,nil,	int_lbl_capt_loc,150, 55, 20,switch_capt_side)
btn_fo_side		= button_add(nil,nil,	int_lbl_fo_loc,150, 55, 20,switch_fo_side)

xpl_dataref_subscribe("laminar/B738/annunciator/six_pack_flt_cont", "FLOAT",			-- param #01
						"laminar/B738/annunciator/six_pack_irs", "FLOAT",				-- param #02
						"laminar/B738/annunciator/six_pack_fuel", "FLOAT",				-- param #03
						"laminar/B738/annunciator/six_pack_elec", "FLOAT",				-- param #04
						"laminar/B738/annunciator/six_pack_apu", "FLOAT",				-- param #05
						"laminar/B738/annunciator/six_pack_fire", "FLOAT",				-- param #06
						"laminar/B738/annunciator/six_pack_ice", "FLOAT",				-- param #07
						"laminar/B738/annunciator/six_pack_hyd", "FLOAT",				-- param #08
						"laminar/B738/annunciator/six_pack_doors", "FLOAT",				-- param #09
						"laminar/B738/annunciator/six_pack_eng", "FLOAT",				-- param #10
						"laminar/B738/annunciator/six_pack_overhead", "FLOAT",			-- param #11
						"laminar/B738/annunciator/six_pack_air_cond", "FLOAT",			-- param #12
						"laminar/B738/annunciator/fire_bell_annun", "FLOAT",			-- param #13
						"laminar/B738/annunciator/fire_bell_annun2", "FLOAT",			-- param #14
						"laminar/B738/annunciator/master_caution_light", "FLOAT",		-- param #15
						annun_state_status)

xpl_dataref_subscribe("sim/flightmodel2/lights/generic_lights_brightness_ratio","FLOAT[128]",
						set_panel_bright) --> set panel bright / value[10] -- dome light dim==0.4 bright==1

-- xpl_dataref_subscribe("laminar/B738/toggle_switch/cockpit_dome_pos", "FLOAT",
--							set_panel_bright) -- dome light 1=dim -1=bright

xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts" ,"FLOAT[4]",
						"sim/cockpit/electrical/avionics_on", "INT",
						set_power_xpl)

request_callback(set_power_xpl)
request_callback(set_panel_bright)
request_callback(annun_state_status)