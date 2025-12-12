-- =====================================================================================
-- 		External CAPT EFIS dedicated to Boeing B737-800X ZiboMod for X-Plane 11
-- =====================================================================================

--modified to match color of Zibo panel by Russ Barlow
----------------------------------------
--			AUTHORING SECTION
----------------------------------------

-- Values to be updated by Authors

 local AM_Main_Release = "AM3.5"		-- Current AM release
 local Z2DXPEFIS = "1.0.6"				-- Current EFIS release
 local Date_Release = "04/02/2019"		-- Current EFIS release date

 
--=============================================================================
--=============================================================================

-- Don't change these values
-- or at least,
-- only for personal usage

 local Title = "Z2DXPEFIS CAPT SIDE"
 local InitialRelease_Date="11/08/2018"
 local InitialAuthor = "enjxp_SimPassion" -- "enjxp" on x-plane.org forum and "SimPassion" on Sim Innovations forum (same person)

----------------------------------------
--			RELEASE SECTION
----------------------------------------

local ZiboProject_Builders = "Zibo/AeroSimDevGroup/Fay/Twkster/Audiobirdxp/DrGluck/Flightdeck2sim/Folko"

local Z2DXPEFIS_ScriptAuthors = "	enjxp_SimPassion/	/	/	/	/	"

-- Register here each of the successive revisions with comments

--	Author						Date			Release		Comments
--	enjxp_SimPassion			12/06/2018		1.0.4		Initial release
--	enjxp_SimPassion			02/04/2019		1.0.5		fixed touch area
--	enjxp_SimPassion			04/02/2019		1.0.6		Previous fonts removed and new one added for a licensing concern

--=============================================================================
------------------------------------------------------------------------------------------------------------------------------------
--  Boeing 737-800X EFIS for ZiboMmod
--		based on Russ Barlow's EFIS for the EADT x737
---------------------------------------------------------------------------------------------------------------------------------------------
--  New release based on initial graphic design by AudioBirdXP and ZiboMod 3.31d , script reworking made by enjxp_SimPassion on 11/08/2018
--	thanks to AudioBirdXP agreement for publishing
---------------------------------------------------------------------------------------------------------------------------------------------

--  Note that this panel only mimics the 737 EFIS by sending inputs
--  and displaying the 737 outputs.

--	Default size = 598 x 329

------------------------------------------------------------------------------

----------------------------------------
--			INSTALLATION SECTION
----------------------------------------

-- Unzip the file, then copy/paste the inside folder named with a suite of digits and letters, into the "\Users\%username%\Air Manager\instruments\OPEN_DIRECTORY" folder or in the "\Users\%username%\Air Manager BETA\instruments\OPEN_DIRECTORY" folder 

-- This instrument could be send on a remote PC, or on the same PC to Air Player, in order to run in standalone mode : waiting for an Air Player 3.5 Release
-- it also could be send to Air Player running on Android, iPad, Linux, Windows, Mac or Raspberry Pi with the appropriate licence of Air Player

-- For execution, mandatory requirement is : Air Manager v3.5 on Windows, from Sim Innovations (for the moment run on Air Manager 3.5 Beta until final release of v3.5)

--========================================================================================================================================================================================================

--		CAVEATS for coding : in this LUA script the order in which appear the statements concerning texts, buttons and images positioning, is of primary importance,
--		as all objects are displayed with a layer order : the first objects appear behind and the last objects appear in front following the order in which they're been wrote in the script

--========================================================================================================================================================================================================


--======================================================================================
--								SCRIPT START
--======================================================================================

switch_vor1_pos	= 2
switch_vor2_pos	= 2
min_mode		= 0
ctr_dial_angle	= 0
min_baro		= 0
baro_dial_angle	= 0
tfc_is_on		= 1
wxr_is_on		= 0
wpt_is_on		= 0
terr_is_on		= 0
arpt_is_on		= 0
sync_memo		= 0
gbl_power		= false
local gbl_light	= false

local txt_style1			= "font:Arimo-Bold.ttf; size:17px; color: white; halign: center;"
local txt_style2			= "font:Arimo-Bold.ttf; size:17px; color: #D3A56C; halign: center;"
local txt_style3			= "font:Arimo-Bold.ttf; size:20px; color: white; halign: center;"
local txt_style4			= "font:Arimo-Bold.ttf; size:20px; color: #D3A56C; halign: center;"

efis_bkgnd	= img_add_fullscreen("EFIS_bknd_img.png")

img_EFIS_LIGHT	= img_add_fullscreen("EFIS_lights_img.png")
visible(img_EFIS_LIGHT,false)

lt_base		= img_add("efis_knob_bg.png"	, 72, 50,100,100)
rt_base		= img_add("efis_knob_bg.png"	,427, 50,100,100)
lt_ctr		= img_add("efis_knob.png"		, 89, 67, 66, 66)
lt_btn		= img_add("efis_btn.png"		, 97, 75, 50, 50)
rt_ctr		= img_add("efis_knob.png"		,444, 67, 66, 66)
rt_btn		= img_add("efis_btn.png"		,452, 75, 50, 50)

mode_base	= img_add("efis_knob_bg.png"	,185,167, 80, 80)
mode_btn	= img_add("efis_btn.png"		,193,175, 64, 64)

rng_base	= img_add("efis_knob_bg.png"	,332,167, 80 ,80)
rng_btn		= img_add("efis_btn.png"		,340,175, 64, 64)

img_rotate(lt_base		, -35)
img_rotate(rt_base		, -35)
img_rotate(mode_base	,  20)
img_rotate(rng_base	, -30)

function vor1_scroll(dir)	-- EFIS VOR/ADF SEL SWITCH 1
	if dir == 1 then
			xpl_command("laminar/B738/EFIS_control/capt/vor1_off_dn")
	elseif dir == -1  then
			xpl_command("laminar/B738/EFIS_control/capt/vor1_off_up")
	end
end

function set_vor1(vor_state)
	switch_set_state(switch_vor1 , vor_state+1 )
	switch_vor1_pos = vor_state
end

function vor2_scroll(dir)	-- EFIS VOR/ADF SEL SWITCH 2

	if dir == 1 then
			xpl_command("laminar/B738/EFIS_control/capt/vor2_off_dn")
	elseif dir ==-1 then
			xpl_command("laminar/B738/EFIS_control/capt/vor2_off_up")
        end
end

function set_vor2(vor_state)
	switch_set_state(switch_vor2, vor_state+1 )
	switch_vor2_pos = vor_state
end

function mins_select(direction)	-- MINS Knob & RST button
	if sync_memo == 0 or sync_memo == 1 then
		if direction== 1 then
			xpl_command("laminar/B738/EFIS_control/cpt/minimums_dn")
		elseif direction== -1 then
			xpl_command("laminar/B738/EFIS_control/cpt/minimums_up")
		end
	elseif sync_memo == 2 then
		if direction== 1 then
			xpl_command("laminar/B738/EFIS_control/fo/minimums_dn")
		elseif direction== -1 then
			xpl_command("laminar/B738/EFIS_control/fo/minimums_up")
		end
	end
end

function set_min_mode(cpt_mode,fo_mode,sync_mode)
	if sync_mode == 0 or sync_mode == 1 then  -- Sync OFF or Sync FO to CPT
		min_mode = cpt_mode
	elseif sync_mode == 2 then  -- Sync CPT to FO
		min_mode = fo_mode
	end
	if min_mode == 0 then
		img_rotate(lt_base, -33)
	elseif min_mode == 1 then
		img_rotate(lt_base, 36)
	end
	sync_memo = sync_mode
end

function mins_set(direction)	-- CTR knob
	ctr_dial_angle=ctr_dial_angle +  15*direction
	img_rotate(lt_ctr, ctr_dial_angle)
	if sync_memo == 0 or sync_memo == 1 then
		if direction== 1 then
			xpl_command("laminar/B738/pfd/dh_pilot_up")
		else
			xpl_command("laminar/B738/pfd/dh_pilot_dn")
		end
	elseif sync_memo == 2 then
		if direction== 1 then
			xpl_command("laminar/B738/pfd/dh_copilot_up")
		else
			xpl_command("laminar/B738/pfd/dh_copilot_dn")
		end
	end
end

function press_rst()
	if sync_memo == 0 or sync_memo == 1 then
		xpl_command("laminar/B738/EFIS_control/capt/push_button/rst_press")
		xpl_dataref_write("laminar/B738/EFIS_control/capt/push_button/std","INT",1)
	elseif sync_memo == 2 then
		xpl_command("laminar/B738/EFIS_control/fo/push_button/rst_press")
		xpl_dataref_write("laminar/B738/EFIS_control/fo/push_button/std","INT",1)
	end
end

function press_select(direction)	--  BARO Knobs & STD button
	if direction== 1 then
		xpl_command("laminar/B738/EFIS_control/capt/baro_in_hpa_up")
	elseif direction== -1 then
		xpl_command("laminar/B738/EFIS_control/capt/baro_in_hpa_dn")
	end
end

function set_hpa(hpa_val)
	if hpa_val == 0 then
		img_rotate(rt_base, -35)
	elseif hpa_val == 1 then
		img_rotate(rt_base, 35)
	end
end

function baro_set(direction)
	baro_dial_angle=baro_dial_angle + 36*direction
	img_rotate(rt_ctr, baro_dial_angle)

	if direction== 1 then
		xpl_command("laminar/B738/pilot/barometer_up")
	elseif direction== -1 then
		xpl_command("laminar/B738/pilot/barometer_down")
	end
end

function press_std()
	xpl_command("laminar/B738/EFIS_control/capt/push_button/std_press")
	xpl_dataref_write("laminar/B738/EFIS_control/capt/push_button/rst","INT",1)
end

function mode_spin(direction)	-- ND MODE KNOB
	if direction== 1 then
		xpl_command("laminar/B738/EFIS_control/capt/map_mode_up")
	elseif direction== -1 then
		xpl_command("laminar/B738/EFIS_control/capt/map_mode_dn")
	end
end

function set_mode(position)
	if position==0 then
		img_rotate(mode_base, -46)
	elseif position==1 then
		img_rotate(mode_base, -20)
	elseif position==2 then
		img_rotate(mode_base, 20)
	elseif position==3 then
		img_rotate(mode_base, 50)
	end
end

function press_ctr()	-- CTR button
	xpl_command("laminar/B738/EFIS_control/capt/push_button/ctr_press")
end

function set_rng(rng_val)	-- ND RANGE KNOB
	rng_ang = rng_val * 30  - 90
	img_rotate(rng_base, rng_ang)
end

function rng_spin(direction)
	if direction==  1 then
		xpl_command("laminar/B738/EFIS_control/capt/map_range_up")
	elseif direction== -1 then
		xpl_command("laminar/B738/EFIS_control/capt/map_range_dn")
	end
end

function press_tfc(sw_state)	-- TFC button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/tfc_press")
end

function press_wxr(sw_state)	-- WXR button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/wxr_press")
end

function wxr_chg(position)
	wxr_is_on=position
	switch_set_state(switch_wxr, position)
end

function press_sta(sw_state)	-- STA button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/sta_press")
end

function sta_chg(position)
	switch_set_state(switch_sta, position)
end

function press_wpt(sw_state)	-- WPT button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/wpt_press")
end

function wpt_chg(position)
	wpt_is_on=position
	switch_set_state(switch_wpt, position)
end

function press_arpt(sw_state)	-- ARPT button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/arpt_press")
end

function arpt_chg(position)
	arpt_is_on=position
	switch_set_state(switch_arpt, position)
end

function press_data(sw_state)	-- DATA button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/data_press")
end

function data_chg(position)
	switch_set_state(switch_data, position)
end

function press_pos(sw_state)	-- POS button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/pos_press")
end

function pos_chg(position)
	switch_set_state(switch_pos, position)
end

function press_terr(sw_state)	-- TERR button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/terr_press")
end

function press_fpv()	-- FPV button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/fpv_press")
end

function press_mtr()	-- MTR button
	xpl_command ("laminar/B738/EFIS_control/capt/push_button/mtrs_press")
end

function set_panel_light(brightness)
	if brightness[1] >= 0.5 then
		gbl_light = true
		if gbl_power == true then
			visible(img_EFIS_LIGHT,true)
			txt_style(lbl_wxr,txt_style2)
			txt_style(lbl_arpt,txt_style2)
			txt_style(lbl_sta,txt_style2)
			txt_style(lbl_wpt,txt_style2)
			txt_style(lbl_data,txt_style2)
			txt_style(lbl_pos,txt_style2)
			txt_style(lbl_terr,txt_style2)
			txt_style(lbl_rst,txt_style2)
			txt_style(lbl_std,txt_style2)
			txt_style(lbl_ctr,txt_style4)
			txt_style(lbl_tfc,txt_style4)
		end
	else
		gbl_light = false
		visible(img_EFIS_LIGHT,false)
		txt_style(lbl_wxr,txt_style1)
		txt_style(lbl_arpt,txt_style1)
		txt_style(lbl_sta,txt_style1)
		txt_style(lbl_wpt,txt_style1)
		txt_style(lbl_data,txt_style1)
		txt_style(lbl_pos,txt_style1)
		txt_style(lbl_terr,txt_style1)
		txt_style(lbl_rst,txt_style1)
		txt_style(lbl_std,txt_style1)
		txt_style(lbl_ctr,txt_style3)
		txt_style(lbl_tfc,txt_style3)
	end
end

function set_power_xpl(bus_volts,avionics_on)

	if  bus_volts == nil or avionics_on == nil then
		return
	end

	gbl_power = fif((bus_volts[1] > 10 or bus_volts[2] > 10) and avionics_on, true, false)

	if gbl_power == true and gbl_light == true then
		visible(img_EFIS_LIGHT,true)
	end
end

xpl_dataref_subscribe("laminar/B738/EFIS_control/capt/vor1_off_pos","INT"		,set_vor1)
xpl_dataref_subscribe("laminar/B738/EFIS_control/capt/vor2_off_pos","INT"		,set_vor2)
xpl_dataref_subscribe("laminar/B738/EFIS_control/capt/baro_in_hpa","INT"		,set_hpa)
xpl_dataref_subscribe("laminar/B738/EFIS_control/capt/map_mode_pos","FLOAT"	,set_mode)
xpl_dataref_subscribe("laminar/B738/EFIS/capt/map_range","INT"				,set_rng)
xpl_dataref_subscribe("laminar/B738/EFIS_control/capt/push_button/wxr","INT"	,wxr_chg)
xpl_dataref_subscribe("laminar/B738/EFIS_control/capt/push_button/sta","INT"	,sta_chg)
xpl_dataref_subscribe("sim/cockpit2/EFIS/EFIS_fix_on","INT"					,wpt_chg)
xpl_dataref_subscribe("sim/cockpit2/EFIS/EFIS_airport_on","INT"				,arpt_chg)
xpl_dataref_subscribe("laminar/B738/EFIS_control/capt/push_button/data","INT"	,data_chg)
xpl_dataref_subscribe("laminar/B738/EFIS_control/capt/push_button/pos","INT"	,pos_chg)
xpl_dataref_subscribe("laminar/B738/EFIS_control/cpt/minimums","INT",
						"laminar/B738/EFIS_control/fo/minimums","INT",
						"laminar/B738/effects/sync_pilot","INT"					,set_min_mode)
xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts","FLOAT[4]",
						"sim/cockpit/electrical/avionics_on","INT"				,set_power_xpl)
xpl_dataref_subscribe("laminar/B738/electric/panel_brightness","FLOAT[4]"		,set_panel_light)

xpl_command("laminar/B738/EFIS_control/capt/baro_in_hpa_up",0)
xpl_command("laminar/B738/EFIS_control/capt/baro_in_hpa_dn",0)

dial_mins_bg	= dial_add		("empty.png",															 72, 50,100,100	,mins_select)
dial_mins_in_bg	= dial_add		("empty.png",															 89, 67, 66, 66	, 10, mins_set)
dial_baro_bg	= dial_add		("empty.png",															427, 50,100,100	,press_select)
dial_baro_in_bg	= dial_add		("empty.png",															444, 67, 66, 66	, 5, baro_set)

rst_btn			= button_add	("empty.png", "empty.png",												101, 79, 42, 42	,press_rst)
std_btn			= button_add	("empty.png", "empty.png",												456, 79, 42, 42	,press_std)

dial_mode		= dial_add		("empty.png",															180,162, 90, 90	,mode_spin)
dial_range		= dial_add		("empty.png",															327,162, 90, 90	,rng_spin)

btn_ctr			= button_add	("empty.png", "empty.png",												207,190, 30, 30	,press_ctr)
btn_tfc			= button_add	("empty.png", "empty.png",												355,190, 30, 30	,press_tfc)

btn_fpv			= button_add	("efis_btn.png", "empty.png",											218, 43, 50, 50	,press_fpv)
btn_mtr			= button_add	("efis_btn.png", "empty.png",											329, 43, 50, 50	,press_mtr)

switch_vor1		= switch_add	("switch_vor1_adf.png", "switch_vor1_ctr.png","switch_vor1_vor.png" ,	 38,165, 50, 50	, nil)
switch_vor2		= switch_add	("switch_vor2_adf.png", "switch_vor2_ctr.png","switch_vor2_vor.png",	508,165, 50, 50	 , nil )
scroll_vor1 = scrollwheel_add_ver( nil, 38,165, 50, 50, 38, 30, vor1_scroll)
scroll_vor2 = scrollwheel_add_ver( nil, 508,165, 50, 50, 38, 30, vor2_scroll)
switch_wxr		= switch_add	("efis_btn_layer.png", "efis_btn_layer.png",							 50,249, 55, 50	,press_wxr)
switch_sta		= switch_add	("efis_btn_layer.png", "efis_btn_layer.png",							123,249, 55, 50	,press_sta)
switch_wpt		= switch_add	("efis_btn_layer.png", "efis_btn_layer.png",							196,249, 55, 50	,press_wpt)
switch_arpt		= switch_add	("efis_btn_layer.png", "efis_btn_layer.png",							269,249, 55, 50	,press_arpt)
switch_data		= switch_add	("efis_btn_layer.png", "efis_btn_layer.png",							344,249, 55, 50	,press_data)
switch_pos		= switch_add	("efis_btn_layer.png", "efis_btn_layer.png",							417,249, 55, 50	,press_pos)
switch_terr		= switch_add	("efis_btn_layer.png", "efis_btn_layer.png",							491,249, 55, 50	,press_terr)

lbl_wxr			= txt_add	("WXR",		txt_style1,													 50,265, 55, 20	)
lbl_sta			= txt_add	("STA",		txt_style1,													123,265, 55, 20	)
lbl_wpt			= txt_add	("WPT",		txt_style1,													196,265, 55, 20	)
lbl_arpt		= txt_add	("ARPT",	txt_style1,													269,265, 55, 20	)
lbl_data		= txt_add	("DATA",	txt_style1,													344,265, 55, 20	)
lbl_pos			= txt_add	("POS",		txt_style1,													417,265, 55, 20	)
lbl_terr		= txt_add	("TERR",	txt_style1,													491,265, 55, 20	)

lbl_rst			= txt_add	("RST",		txt_style1,													 95, 93, 55, 20	)
lbl_std			= txt_add	("STD",		txt_style1,													450, 93, 55, 20	)
lbl_ctr			= txt_add	("CTR",		txt_style3,													197,197, 55, 23	)
lbl_tfc			= txt_add	("TFC",		txt_style3,													345,197, 55, 23	)

-- DATAREFS
-- --------
-- laminar/B738/EFIS/baro_box_copilot_show
-- laminar/B738/EFIS/baro_box_pilot_show
-- laminar/B738/EFIS/baro_sel_copilot_show
-- laminar/B738/EFIS/baro_sel_in_hg_copilot
-- laminar/B738/EFIS/baro_sel_in_hg_pilot
-- laminar/B738/EFIS/baro_sel_pilot_show
-- laminar/B738/EFIS/baro_set_std_copilot
-- laminar/B738/EFIS/baro_set_std_pilot
-- laminar/B738/EFIS/baro_std_box_copilot_show
-- laminar/B738/EFIS/baro_std_box_pilot_show
-- laminar/B738/EFIS/capt/data_status
-- laminar/B738/EFIS/capt/map_range
-- laminar/B738/EFIS/EFIS_airport_on
-- laminar/B738/EFIS/EFIS_fix_on
-- laminar/B738/EFIS/EFIS_vor_on
-- laminar/B738/EFIS/EFIS_wx_on
-- laminar/B738/EFIS/fo/data_status
-- laminar/B738/EFIS/fo/EFIS_airport_on
-- laminar/B738/EFIS/fo/EFIS_fix_on
-- laminar/B738/EFIS/fo/EFIS_vor_on
-- laminar/B738/EFIS/fo/EFIS_wx_on
-- laminar/B738/EFIS/fo/map_range
-- laminar/B738/EFIS/green_arc
-- laminar/B738/EFIS/green_arc_fo
-- laminar/B738/EFIS/green_arc_fo_show
-- laminar/B738/EFIS/green_arc_show
-- laminar/B738/EFIS/ta_only_show
-- laminar/B738/EFIS/ta_only_show_fo
-- laminar/B738/EFIS/tcas_ai_show
-- laminar/B738/EFIS/tcas_ai_show_fo
-- laminar/B738/EFIS/tcas_fail_show
-- laminar/B738/EFIS/tcas_fail_show_fo
-- laminar/B738/EFIS/tcas_off_show
-- laminar/B738/EFIS/tcas_off_show_fo
-- laminar/B738/EFIS/tcas_on
-- laminar/B738/EFIS/tcas_on_fo
-- laminar/B738/EFIS/tcas_show
-- laminar/B738/EFIS/tcas_show_fo
-- laminar/B738/EFIS/tcas_test_show
-- laminar/B738/EFIS/tcas_test_show_fo
-- laminar/B738/EFIS/tfc_show
-- laminar/B738/EFIS/tfc_show_fo
-- laminar/B738/EFIS_control/capt/baro_in_hpa
-- laminar/B738/EFIS_control/capt/baro_in_hpa_pfd
-- laminar/B738/EFIS_control/capt/exp_map
-- laminar/B738/EFIS_control/capt/map_mode_pos
-- laminar/B738/EFIS_control/capt/minimums_dh
-- laminar/B738/EFIS_control/capt/minimums_dh_pfd
-- laminar/B738/EFIS_control/capt/push_button/arpt
-- laminar/B738/EFIS_control/capt/push_button/ctr
-- laminar/B738/EFIS_control/capt/push_button/data
-- laminar/B738/EFIS_control/capt/push_button/fpv
-- laminar/B738/EFIS_control/capt/push_button/mtrs
-- laminar/B738/EFIS_control/capt/push_button/pos
-- laminar/B738/EFIS_control/capt/push_button/rst
-- laminar/B738/EFIS_control/capt/push_button/sta
-- laminar/B738/EFIS_control/capt/push_button/std
-- laminar/B738/EFIS_control/capt/push_button/terr
-- laminar/B738/EFIS_control/capt/push_button/tfc
-- laminar/B738/EFIS_control/capt/push_button/wpt
-- laminar/B738/EFIS_control/capt/push_button/wxr
-- laminar/B738/EFIS_control/capt/rings
-- laminar/B738/EFIS_control/capt/terr_on
-- laminar/B738/EFIS_control/capt/vor1_off_pfd
-- laminar/B738/EFIS_control/capt/vor1_off_pos
-- laminar/B738/EFIS_control/capt/vor2_off_pfd
-- laminar/B738/EFIS_control/capt/vor2_off_pos
-- laminar/B738/EFIS_control/capt/vsd_map
-- laminar/B738/EFIS_control/cpt/minimums
-- laminar/B738/EFIS_control/cpt/minimums_pfd
-- laminar/B738/EFIS_control/fo/baro_in_hpa
-- laminar/B738/EFIS_control/fo/baro_in_hpa_fo
-- laminar/B738/EFIS_control/fo/exp_map
-- laminar/B738/EFIS_control/fo/map_mode_pos
-- laminar/B738/EFIS_control/fo/minimums
-- laminar/B738/EFIS_control/fo/minimums_dh
-- laminar/B738/EFIS_control/fo/minimums_dh_pfd
-- laminar/B738/EFIS_control/fo/minimums_pfd
-- laminar/B738/EFIS_control/fo/push_button/arpt
-- laminar/B738/EFIS_control/fo/push_button/ctr
-- laminar/B738/EFIS_control/fo/push_button/data
-- laminar/B738/EFIS_control/fo/push_button/fpv
-- laminar/B738/EFIS_control/fo/push_button/mtrs
-- laminar/B738/EFIS_control/fo/push_button/pos
-- laminar/B738/EFIS_control/fo/push_button/rst
-- laminar/B738/EFIS_control/fo/push_button/sta
-- laminar/B738/EFIS_control/fo/push_button/std
-- laminar/B738/EFIS_control/fo/push_button/terr
-- laminar/B738/EFIS_control/fo/push_button/tfc
-- laminar/B738/EFIS_control/fo/push_button/wpt
-- laminar/B738/EFIS_control/fo/push_button/wxr
-- laminar/B738/EFIS_control/fo/rings
-- laminar/B738/EFIS_control/fo/terr_on
-- laminar/B738/EFIS_control/fo/vor1_off_pfd
-- laminar/B738/EFIS_control/fo/vor1_off_pos
-- laminar/B738/EFIS_control/fo/vor2_off_pfd
-- laminar/B738/EFIS_control/fo/vor2_off_pos
-- laminar/B738/EFIS_control/fo/vsd_map

-- COMMANDS
-- --------
-- laminar/B738/EFIS_control/capt/baro_in_hpa_dn
-- laminar/B738/EFIS_control/capt/baro_in_hpa_up
-- laminar/B738/EFIS_control/capt/map_mode_dn
-- laminar/B738/EFIS_control/capt/map_mode_up
-- laminar/B738/EFIS_control/capt/map_range_dn
-- laminar/B738/EFIS_control/capt/map_range_up
-- laminar/B738/EFIS_control/capt/push_button/arpt_press
-- laminar/B738/EFIS_control/capt/push_button/ctr_press
-- laminar/B738/EFIS_control/capt/push_button/data_press
-- laminar/B738/EFIS_control/capt/push_button/fpv_press
-- laminar/B738/EFIS_control/capt/push_button/mtrs_press
-- laminar/B738/EFIS_control/capt/push_button/pos_press
-- laminar/B738/EFIS_control/capt/push_button/rst_press
-- laminar/B738/EFIS_control/capt/push_button/sta_press
-- laminar/B738/EFIS_control/capt/push_button/std_press
-- laminar/B738/EFIS_control/capt/push_button/terr_press
-- laminar/B738/EFIS_control/capt/push_button/tfc_press
-- laminar/B738/EFIS_control/capt/push_button/wpt_press
-- laminar/B738/EFIS_control/capt/push_button/wxr_press
-- laminar/B738/EFIS_control/capt/vor1_off_dn
-- laminar/B738/EFIS_control/capt/vor1_off_up
-- laminar/B738/EFIS_control/capt/vor2_off_dn
-- laminar/B738/EFIS_control/capt/vor2_off_up
-- laminar/B738/EFIS_control/cpt/minimums_dn
-- laminar/B738/EFIS_control/cpt/minimums_up
-- laminar/B738/EFIS_control/fo/baro_in_hpa_dn
-- laminar/B738/EFIS_control/fo/baro_in_hpa_up
-- laminar/B738/EFIS_control/fo/map_mode_dn
-- laminar/B738/EFIS_control/fo/map_mode_up
-- laminar/B738/EFIS_control/fo/map_range_dn
-- laminar/B738/EFIS_control/fo/map_range_up
-- laminar/B738/EFIS_control/fo/minimums_dn
-- laminar/B738/EFIS_control/fo/minimums_up
-- laminar/B738/EFIS_control/fo/push_button/arpt_press
-- laminar/B738/EFIS_control/fo/push_button/ctr_press
-- laminar/B738/EFIS_control/fo/push_button/data_press
-- laminar/B738/EFIS_control/fo/push_button/fpv_press
-- laminar/B738/EFIS_control/fo/push_button/mtrs_press
-- laminar/B738/EFIS_control/fo/push_button/pos_press
-- laminar/B738/EFIS_control/fo/push_button/rst_press
-- laminar/B738/EFIS_control/fo/push_button/sta_press
-- laminar/B738/EFIS_control/fo/push_button/std_press
-- laminar/B738/EFIS_control/fo/push_button/terr_press
-- laminar/B738/EFIS_control/fo/push_button/tfc_press
-- laminar/B738/EFIS_control/fo/push_button/wpt_press
-- laminar/B738/EFIS_control/fo/push_button/wxr_press
-- laminar/B738/EFIS_control/fo/vor1_off_dn
-- laminar/B738/EFIS_control/fo/vor1_off_up
-- laminar/B738/EFIS_control/fo/vor2_off_dn
-- laminar/B738/EFIS_control/fo/vor2_off_up



