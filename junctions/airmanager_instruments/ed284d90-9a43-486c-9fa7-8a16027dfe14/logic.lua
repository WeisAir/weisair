
-- ============================================================================================================
-- 		External CLOCK dedicated to Boeing B737-800X ZiboMod for X-Plane 11
-- ============================================================================================================
--						Hardware Ready using Arduino board for Cockpitbuilders

----------------------------------------
--			AUTHORING SECTION
----------------------------------------

-- Values to be updated by Authors

	local AM_Main_Release = "AM3.7"				-- Minimal AM release requirement
	local Z_2D_XP_CLOCK = "1.0.2"				-- Current CLOCK release
	local Date_Release = "04/03/2023"			-- Current CLOCK release date
 
--=============================================================================
--=============================================================================

-- Don't change these following values
-- or at least,
-- only for personal usage

	local Title = "Z_2D_XP_CLOCK"
	local InitialRelease_Date="03/03/2023"
	local InitialAuthor = "enjxp_SimPassion" -- "enjxp" on x-plane.org forum and "SimPassion" on Sim Innovations forum (same person)

--=============================================================================
--=============================================================================

----------------------------------------
--			RELEASE SECTION
----------------------------------------

local ZiboProject_Builders = "Zibo/AeroSimDevGroup/Fay/Twkster/Audiobirdxp/DrGluck/Flightdeck2sim/Folko/JBrik/Unsafe05/MugZ/737ngworld/m.philippi"

local Z_2D_XP_FLAPS_Autobrake_ScriptAuthors = "	enjxp_SimPassion/	/	/	/	/	"

-- Register here each of the successive revisions with comments

-- TODO : Add hardware brightness handling via ADC input and DIAL input for both LEDs displays and Key Lighting

--	Author						Date			Release		Comments
--	enjxp_SimPassion			04/03/2023		1.0.2		Fixed brightness handling
--	enjxp_SimPassion			03/03/2023		1.0.1		Fixed objects still displayed after retrurning from Test phase
--															Fixed comments not related to this instrument
--	enjxp_SimPassion			03/02/2023		1.0.0		Adding features and fixing behaviors
--															Hardware handling added
--															Initial release

--=============================================================================
------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
--  Initial release based on initial graphic design by AudioBirdXP and Zibo in ZiboMod 3.31d,
--	thanks to AudioBirdXP agreement for publishing
---------------------------------------------------------------------------------------------------------------------------------------------

--  Note that this panel only mimics the 737 CLOCK by sending inputs
--  and displaying the 737 outputs.

--	Default size = 439 x 439

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

up_info_shown_bln = user_prop_add_boolean("DISPLAY CHECK INFOS", false, "Display CAPT/FO side and release infos")
info_shown_bln = user_prop_get(up_info_shown_bln)

up_side_str = user_prop_add_enum("CAPT or FO Side", "CAPT,FO", "CAPT", "Choose CAPT or FO Side and restart AM Instrument")
side_str = user_prop_get(up_side_str)

local gbl_power	= 0
local bg_lvl	= 0.5
local str_side	= ""
local str_side1	= ""
local str_side2	= ""

local style_00_yellow	= "font:arimo_bold.ttf; size:17px; color: yellow; halign: center;"
local style_01_white	= "font:dseg7classic-bold.ttf; size:42px; color: white; halign: center;"
local style_02_white	= "font:arimo_bold.ttf; size:23px; color: white; halign: left;"

img_background			= img_add_fullscreen("clock_bg.png")
img_screws				= img_add_fullscreen("screws.png")
img_bg_brt				= img_add_fullscreen("clock_bright.png")opacity(img_bg_brt,1)
img_bg_grd				= img_add_fullscreen("clock_grad.png")
img_run					= img_add_fullscreen("run.png")visible(img_run,false)
img_hld					= img_add_fullscreen("hld.png")visible(img_hld,false)
img_utc					= img_add_fullscreen("utc.png")visible(img_utc,false)
img_man					= img_add_fullscreen("man.png")visible(img_man,false)
img_time				= img_add_fullscreen("time.png")visible(img_time,false)
img_date				= img_add_fullscreen("date.png")visible(img_date,false)
img_et					= img_add_fullscreen("et.png")visible(img_et,false)
img_chr					= img_add_fullscreen("chr.png")visible(img_chr,false)
img_tst					= img_add_fullscreen("test.png")visible(img_tst,false)
img_ndl					= img_add_fullscreen("clock_needle.png")visible(img_ndl,false)
img_bg_lit				= img_add_fullscreen("clock_lights.png")opacity(img_bg_lit,0.1)
lbl_dm					= "DAY      MO"
lbl_yr					= "                  YR"
txt_time_date			= txt_add("00:00",style_01_white,	148, 167, 150, 55)
txt_lbl					= txt_add("",style_02_white,		158, 208, 150, 23)
txt_chr					= txt_add("",style_01_white,	148, 231, 150, 55)

--====================================================================================
--									FUNCTIONS
--====================================================================================

-- Commands

function chr_p()
	xpl_command("laminar/B738/push_button/chrono_cycle_"..str_side2)
end
function dt_p()
	xpl_command("laminar/B738/push_button/chrono_disp_mode_"..str_side2)
end
function et_p()
	xpl_command("laminar/B738/push_button/chrono_"..str_side2.."_et_mode")
end
function rst_p()
	xpl_command("laminar/B738/push_button/et_reset_"..str_side2)
end
function dec_p()
	xpl_command("laminar/B738/push_button/chrono_bright_minus_"..str_side1)
end
function inc_p()
	xpl_command("laminar/B738/push_button/chrono_bright_plus_"..str_side1)
end

-- btnlit	= "btn_lit.png"
btnlit	= nil
btnsz	= 40

btnchr	= button_add(btnlit,nil,  38,  36, btnsz, btnsz, chr_p)
btndt	= button_add(btnlit,nil, 336,  22, btnsz, btnsz, dt_p)
btnet	= button_add(btnlit,nil,  20, 337, btnsz, btnsz, et_p)
btnrst	= button_add(btnlit,nil,  63, 379, btnsz, btnsz, rst_p)
btndec	= button_add(btnlit,nil, 339, 381, btnsz, btnsz, dec_p)
btninc	= button_add(btnlit,nil, 380, 340, btnsz, btnsz, inc_p)

hw_btnchr	= hw_button_add("CHR", chr_p)
hw_btndt	= hw_button_add("TIME/DATE", dt_p)
hw_btnet	= hw_button_add("ET", et_p)
hw_btnrst	= hw_button_add("RST", rst_p)
hw_btndec	= hw_button_add("DEC", dec_p)
hw_btninc	= hw_button_add("INC", inc_p)

function set_panel_bright(brightness)
	bright = brightness[tonumber(spunit)]
	if gbl_power == 1 then
		visible(img_bg_lit,true)
		opacity(img_bg_lit,bright)
	else
		visible(img_bg_lit,false)
	end
end

function set_power_xpl(bus_volts,avionics_on)	-- Power Handling Based on sample instrument "Boeing 737NG - Comm Nav Stack" from Sim Innovations
	if  bus_volts == nil or avionics_on == nil then
		return
	end
	gbl_power = fif((bus_volts[1] > 10) or (bus_volts[2] > 10), 1, 0)
	if gbl_power == 0 then
		visible(img_bg_lit,false)
	else
		visible(img_bg_lit,true)
	end
end

-- CLOCK SIDE handling

int_lbl_capt_loc	= 0
int_lbl_fo_loc		= 399

lbl_ver_clock		= txt_add(Title.." - "..Z_2D_XP_CLOCK,	style_00_yellow, 120, 215, 200, 20)
lbl_capt_clock		= txt_add("CAPT", style_00_yellow,	int_lbl_capt_loc,	215, 40, 20)
lbl_fo_clock		= txt_add("FO", style_00_yellow,	int_lbl_fo_loc,		215, 40, 20)

function compute_display_infos()
	visible(lbl_ver_clock,info_shown_bln)
	visible(lbl_capt_clock,info_shown_bln and str_side == "CAPT")
	visible(lbl_fo_clock,info_shown_bln and str_side == "FO")
end

function compute_check_infos()
	info_shown_bln = not(info_shown_bln)
	compute_display_infos()
end

function switch_capt_side()
	str_side			= "CAPT"
	str_side1			= "cpt"
	str_side2			= "capt"
	spunit				= "1"
	compute_display_infos()
	request_callback(set_panel_bright)
	request_callback(clock_update)
end

function switch_fo_side()
	str_side			= "FO"
	str_side1			= "fo"
	str_side2			= "fo"
	spunit				= "2"
	compute_display_infos()
	request_callback(set_panel_bright)
	request_callback(clock_update)
end

if side_str == "CAPT" then
	switch_capt_side()
elseif side_str == "FO" then
	switch_fo_side()
end

btn_lbl_ver		= button_add(nil,nil, 120, 209, 200, 20,compute_check_infos)
btn_capt_side	= button_add(nil,nil,	int_lbl_capt_loc,209, 40, 20,switch_capt_side)
btn_fo_side		= button_add(nil,nil,	int_lbl_fo_loc,209, 40, 20,switch_fo_side)

-- Datarefs

function clock_update(cpt_pwr,
						fo_pwr,
						chr_dis_cpt,
						clk_dis_cpt,
						clk_dsh_cpt,
						chr_cpt,
						chr_min_cpt,
						chr_mod_cpt,
						chr_sec_cpt,
						rot_cpt,
						et_cpt,
						et_hrs_cpt,
						et_min_cpt,
						et_mod_cpt,
						et_sec_cpt,
						rst_cpt,
						tim_cpt,
						chr_dis_fo,
						clk_dis_fo,
						clk_dsh_fo,
						chr_fo,
						chr_min_fo,
						chr_mod_fo,
						chr_sec_fo,
						rot_fo,
						et_fo,
						et_hrs_fo,
						et_min_fo,
						et_mod_fo,
						et_sec_fo,
						rst_fo,
						tim_fo,
						bg_brt,
						time,
						day,
						month,
						clk_typ,
						z_hour,
						z_min,
						l_hour,
						l_min,
						year,
						dmy_cpt,
						dmy_fo,
						dspl_light_test
						)

	light_test = dspl_light_test[2]

	if str_side == "CAPT" then
		brt = bg_brt[22]
	elseif str_side == "FO" then
		brt = bg_brt[23]
	end

	if light_test ~= 0 then
		if light_test == 1 then
			visible(img_tst,true)
			visible(img_utc,true)
			visible(img_man,true)
			txt_set(txt_time_date,string.format("%02d:%02d",88,88))
			visible(img_time,true)
			visible(img_date,false)
			visible(img_ndl,false)
			txt_set(txt_lbl,"DAY    MOYR")
			txt_set(txt_chr,string.format("%02d:%02d",88,88))
			visible(img_et,true)
			visible(img_chr,true)
			visible(img_run,true)
			visible(img_hld,true)
		else
			visible(img_tst,false)
			visible(img_utc,false)
			visible(img_man,false)
			txt_set(txt_time_date,"")
			visible(img_time,false)
			visible(img_date,false)
			visible(img_ndl,false)
			txt_set(txt_lbl,"")
			txt_set(txt_chr,"")
			visible(img_et,false)
			visible(img_chr,false)
			visible(img_run,false)
			visible(img_hld,false)
		end
	else
		visible(img_tst,false)
		visible(img_et,false)
		visible(img_chr,false)
		visible(img_run,false)
		visible(img_hld,false)
		if (str_side == "CAPT" and cpt_pwr == 1) or (str_side == "FO" and fo_pwr == 1) then
			visible(img_bg_brt,true)
			visible(img_bg_grd,true)
			visible(img_bg_lit,true)
			visible(img_ndl,true)
			visible(img_time,true)
			visible(img_date,true)
			visible(txt_time_date,true)
			opacity(img_bg_brt,brt)
		elseif (str_side == "CAPT" and cpt_pwr == 0) or (str_side == "FO" and fo_pwr == 0) then
			visible(img_bg_brt,false)
			visible(img_bg_grd,false)
			visible(img_bg_lit,false)
			visible(img_ndl,false)
			visible(img_time,false)
			visible(img_date,false)
			visible(txt_time_date,false)
			opacity(img_bg_brt,0)
		end

		if str_side == "CAPT" then
			rotate(img_ndl,rot_cpt * 6+0.5)
			if clk_dis_cpt == 1 then	-- clock_display_mode_capt
				visible(img_utc,true)
				visible(img_man,false)
				txt_set(txt_time_date,string.format("%02d:%02d",z_hour,z_min))
				visible(img_time,true)
				visible(img_date,false)
				txt_set(txt_lbl,"")
			elseif clk_dis_cpt == 3 then	-- clock_display_mode_capt
				visible(img_utc,false)
				visible(img_man,true)
				txt_set(txt_time_date,string.format("%02d:%02d",l_hour,l_min))
				visible(img_time,true)
				visible(img_date,false)
				txt_set(txt_lbl,"")
			elseif clk_dis_cpt == 2 or clk_dis_cpt == 4 then	-- clock_display_mode_capt
				if clk_dis_cpt == 2 then
					visible(img_utc,true)
					visible(img_man,false)
				elseif clk_dis_cpt == 4 then
					visible(img_utc,false)
					visible(img_man,true)
				end
				if dmy_cpt == 1 or dmy_cpt == 3 then
					txt_set(txt_time_date,"")
					txt_set(txt_lbl,"")
				elseif dmy_cpt == 0 then
					txt_set(txt_time_date,string.format("%02d %02d",day,month))
					txt_set(txt_lbl,lbl_dm)
				elseif dmy_cpt == 2 then
					txt_set(txt_time_date,string.format("   %02d",year))
					txt_set(txt_lbl,lbl_yr)
				end
				visible(img_time,false)
				visible(img_date,true)
			end
			if chr_dis_cpt == 0 then	-- chrono_display_mode_capt
				visible(img_chr,true)
				if et_mod_cpt == 1 then		-- captain et_mode
					visible(img_run,true)
					visible(img_hld,false)
				elseif et_mod_cpt == 0 then		-- captain et_mode
					visible(img_run,false)
					visible(img_hld,true)
				elseif et_mod_cpt == -1 then		-- captain et_mode
					visible(img_run,false)
					visible(img_hld,false)
					visible(img_et,false)
				end
				if chr_mod_cpt == 1 then	-- captain chrono_mode
					txt_set(txt_chr,string.format("%02d:%02d",chr_min_cpt,math.floor(chr_sec_cpt)))
					visible(img_et,false)
				elseif chr_mod_cpt == 0 then	-- captain chrono_mode
					visible(img_et,false)
				elseif chr_mod_cpt == -1 then	-- captain chrono_mode
					visible(img_chr,false)
					visible(img_et,true)
				end
			elseif chr_dis_cpt == 1 then	-- chrono_display_mode_capt
				txt_set(txt_chr,"")
				visible(img_chr,false)
				visible(img_et,true)
				if et_mod_cpt == 1 then		-- captain et_mode
					txt_set(txt_chr,string.format("%02d:%02d",et_hrs_cpt,et_min_cpt))
					visible(img_run,true)
					visible(img_hld,false)
				elseif et_mod_cpt == 0 then		-- captain et_mode
					txt_set(txt_chr,string.format("%02d:%02d",et_hrs_cpt,et_min_cpt))
					visible(img_run,false)
					visible(img_hld,true)
				elseif et_mod_cpt == -1 then		-- captain et_mode
					txt_set(txt_chr,"")
					visible(img_run,false)
					visible(img_hld,false)
					visible(img_et,false)
				end
			elseif chr_dis_cpt == 2 then	-- chrono_display_mode_capt
				txt_set(txt_chr,"")
				visible(img_chr,false)
				visible(img_et,false)
			end
		elseif str_side == "FO" then
			rotate(img_ndl,rot_fo * 6+0.5)
			if clk_dis_fo == 1 then	-- clock_display_mode_fo
				visible(img_utc,true)
				visible(img_man,false)
				txt_set(txt_time_date,string.format("%02d:%02d",z_hour,z_min))
				visible(img_time,true)
				visible(img_date,false)
				txt_set(txt_lbl,"")
			elseif clk_dis_fo == 3 then	-- clock_display_mode_fo
				visible(img_utc,false)
				visible(img_man,true)
				txt_set(txt_time_date,string.format("%02d:%02d",l_hour,l_min))
				visible(img_time,true)
				visible(img_date,false)
				txt_set(txt_lbl,"")
			elseif clk_dis_fo == 2 or clk_dis_fo == 4 then	-- clock_display_mode_fo
				if clk_dis_fo == 2 then
					visible(img_utc,true)
					visible(img_man,false)
				elseif clk_dis_fo == 4 then
					visible(img_utc,false)
					visible(img_man,true)
				end
				if dmy_fo == 1 or dmy_fo == 3 then
					txt_set(txt_time_date,"")
					txt_set(txt_lbl,"")
				elseif dmy_fo == 0 then
					txt_set(txt_time_date,string.format("%02d %02d",day,month))
					txt_set(txt_lbl,lbl_dm)
				elseif dmy_fo == 2 then
					txt_set(txt_time_date,string.format("   %02d",year))
					txt_set(txt_lbl,lbl_yr)
				end
				visible(img_time,false)
				visible(img_date,true)
			end
			if chr_dis_fo == 0 then	-- chrono_display_mode_fo
				visible(img_chr,true)
				if et_mod_fo == 1 then		-- fo et_mode
					visible(img_run,true)
					visible(img_hld,false)
				elseif et_mod_fo == 0 then		-- fo et_mode
					visible(img_run,false)
					visible(img_hld,true)
				elseif et_mod_fo == -1 then		-- fo et_mode
					visible(img_run,false)
					visible(img_hld,false)
					visible(img_et,false)
				end
				if chr_mod_fo == 1 then	-- fo chrono_mode
					txt_set(txt_chr,string.format("%02d:%02d",chr_min_fo,math.floor(chr_sec_fo)))
					visible(img_et,false)
				elseif chr_mod_fo == 0 then	-- fo chrono_mode
					visible(img_et,false)
				elseif chr_mod_fo == -1 then	-- fo chrono_mode
					visible(img_chr,false)
					visible(img_et,true)
				end
			elseif chr_dis_fo == 1 then	-- chrono_display_mode_fo
				txt_set(txt_chr,"")
				visible(img_chr,false)
				visible(img_et,true)
				if et_mod_fo == 1 then		-- fo et_mode
					txt_set(txt_chr,string.format("%02d:%02d",et_hrs_fo,et_min_fo))
					visible(img_run,true)
					visible(img_hld,false)
				elseif et_mod_fo == 0 then		-- fo et_mode
					txt_set(txt_chr,string.format("%02d:%02d",et_hrs_fo,et_min_fo))
					visible(img_run,false)
					visible(img_hld,true)
				elseif et_mod_fo == -1 then		-- fo et_mode
					txt_set(txt_chr,"")
					visible(img_run,false)
					visible(img_hld,false)
					visible(img_et,false)
				end
			elseif chr_dis_fo == 2 then	-- chrono_display_mode_fo
				txt_set(txt_chr,"")
				visible(img_chr,false)
				visible(img_et,false)
			end
		end
	end
end

xpl_dataref_subscribe("laminar/B738/clock/clock_capt_power", "FLOAT",
						"laminar/B738/clock/clock_fo_power", "FLOAT",
						"laminar/B738/clock/chrono_display_mode_capt", "FLOAT",
						"laminar/B738/clock/clock_display_mode_capt", "FLOAT",
						"laminar/B738/clock/clock_dash", "FLOAT",
						"laminar/B738/clock/captain/chr", "FLOAT",
						"laminar/B738/clock/captain/chrono_minutes", "FLOAT",
						"laminar/B738/clock/captain/chrono_mode", "FLOAT",
						"laminar/B738/clock/captain/chrono_seconds", "FLOAT",
						"laminar/B738/clock/captain/chrono_seconds_needle", "FLOAT",
						"laminar/B738/clock/captain/et", "FLOAT",
						"laminar/B738/clock/captain/et_hours", "FLOAT",
						"laminar/B738/clock/captain/et_minutes", "FLOAT",
						"laminar/B738/clock/captain/et_mode", "FLOAT",
						"laminar/B738/clock/captain/et_seconds", "FLOAT",
						"laminar/B738/clock/captain/reset", "FLOAT",
						"laminar/B738/clock/captain/time", "FLOAT",
						"laminar/B738/clock/chrono_display_mode_fo", "FLOAT",
						"laminar/B738/clock/clock_display_mode_fo", "FLOAT",
						"laminar/B738/clock/clock_dash_fo", "FLOAT",
						"laminar/B738/clock/fo/chr", "FLOAT",
						"laminar/B738/clock/fo/chrono_minutes", "FLOAT",
						"laminar/B738/clock/fo/chrono_mode", "FLOAT",
						"laminar/B738/clock/fo/chrono_seconds", "FLOAT",
						"laminar/B738/clock/fo/chrono_seconds_needle", "FLOAT",
						"laminar/B738/clock/fo/et", "FLOAT",
						"laminar/B738/clock/fo/et_hours", "FLOAT",
						"laminar/B738/clock/fo/et_minutes", "FLOAT",
						"laminar/B738/clock/fo/et_mode", "FLOAT",
						"laminar/B738/clock/fo/et_seconds", "FLOAT",
						"laminar/B738/clock/fo/reset", "FLOAT",
						"laminar/B738/clock/fo/time", "FLOAT",
						"sim/cockpit2/electrical/instrument_brightness_ratio_manual", "FLOAT[32]",			--> set gauge backlit / value[22]
						"laminar/B738/tab/page_info_time", "STRING",
						"sim/cockpit2/clock_timer/current_day", "INT",
						"sim/cockpit2/clock_timer/current_month", "INT",
						"laminar/B738/clock_variant", "FLOAT",
						"sim/cockpit2/clock_timer/zulu_time_hours", "INT",
						"sim/cockpit2/clock_timer/zulu_time_minutes", "INT",
						"sim/cockpit2/clock_timer/local_time_hours", "INT",
						"sim/cockpit2/clock_timer/local_time_minutes", "INT",
						"laminar/B738/clock/year", "INT",
						"laminar/B738/clock/clock_display_dmy_capt", "FLOAT",
						"laminar/B738/clock/clock_display_dmy_fo", "FLOAT",
						"laminar/B738/dspl_light_test", "FLOAT[10]",
						clock_update)

xpl_dataref_subscribe("laminar/B738/electric/panel_brightness", "FLOAT[4]",						--> set labels backlit / value[1]
						set_panel_bright)

xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts"							,"FLOAT[4]",
						"sim/cockpit/electrical/avionics_on"						,"INT",			set_power_xpl)

request_callback(set_power_xpl)
compute_display_infos()