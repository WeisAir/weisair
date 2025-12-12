-- =====================================================================================
-- 		External CAPT EFIS dedicated to Boeing SSG 747-800 for X-Plane 11
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
			xpl_command("WeisAIR/b748/EFIS/vor_left_set_ADF")
	elseif dir == -1  then
			xpl_command("WeisAIR/b748/EFIS/vor_left_set_VOR")
	end
end

function set_vor1(vor_state)
	switch_set_state(switch_vor1 , vor_state+1.0 )
	switch_vor1_pos = vor_state
end

function vor2_scroll(dir)	-- EFIS VOR/ADF SEL SWITCH 2

	if dir == 1 then
			xpl_command("WeisAIR/b748/EFIS/vor_right_set_ADF")
	elseif dir ==-1 then
			xpl_command("WeisAIR/b748/EFIS/vor_right_set_VOR")
        end
end

function set_vor2(vor_state)
	switch_set_state(switch_vor2, vor_state+1.0 )
	switch_vor2_pos = vor_state
end

function mins_select(direction)	-- MINS Knob & RST button
	if sync_memo == 0 or sync_memo == 1 then
		if direction== 1 then
			xpl_command("WeisAIR/b748/EFIS/mins_dec")
		elseif direction== -1 then
			xpl_command("WeisAIR/b748/EFIS/mins_inc")
		end
	elseif sync_memo == 2 then
		if direction== 1 then
			xpl_command("WeisAIR/b748/EFIS/mins_dec")
		elseif direction== -1 then
			xpl_command("WeisAIR/b748/EFIS/mins_inc")
		end
	end
end

function set_min_mode(cpt_mode)
	min_mode = cpt_mode
	if min_mode == 0 then
		img_rotate(lt_base, -33)
	elseif min_mode == 1 then
		img_rotate(lt_base, 36)
	end
end

function mins_set(direction)	-- CTR knob					??????????????????????
	ctr_dial_angle=ctr_dial_angle +  15*direction
	img_rotate(lt_ctr, ctr_dial_angle)
	if sync_memo == 0 or sync_memo == 1 then
		if direction== 1 then
			xpl_command("WeisAIR/b748/EFIS/mins_set_baro")
		else
			xpl_command("WeisAIR/b748/EFIS/mins_set_radio")
		end
	elseif sync_memo == 2 then
		if direction== 1 then
			xpl_command("WeisAIR/b748/EFIS/mins_set_baro")
		else
			xpl_command("WeisAIR/b748/EFIS/mins_set_radio")
		end
	end
end

function press_rst()
	if sync_memo == 0 or sync_memo == 1 then
		--xpl_command("laminar/B738/EFIS_control/capt/push_button/rst_press")
		--xpl_dataref_write("laminar/B738/EFIS_control/capt/push_button/std","INT",1)
	elseif sync_memo == 2 then
		--xpl_command("laminar/B738/EFIS_control/fo/push_button/rst_press")
		--xpl_dataref_write("laminar/B738/EFIS_control/fo/push_button/std","INT",1)
	end
end

function press_select(direction)	--  BARO Knobs & STD button
	if direction== 1 then
		xpl_command("WeisAIR/b748/EFIS/baro_set_hpa")
	elseif direction== -1 then
		xpl_command("WeisAIR/b748/EFIS/baro_set_in")
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
		xpl_command("WeisAIR/b748/EFIS/baro_inc")
	elseif direction== -1 then
		xpl_command("WeisAIR/b748/EFIS/baro_dec")
	end
end

function press_std()
	xpl_command("WeisAIR/b748/EFIS/baro_STD_push")
end

function mode_spin(direction)	-- ND MODE KNOB
	if direction== 1 then
		xpl_command("WeisAIR/b748/EFIS/mode_inc")
	elseif direction== -1 then
		xpl_command("WeisAIR/b748/EFIS/mode_dec")
	end
end

function set_mode(position)
	if position==0.0 then
		img_rotate(mode_base, -46)
	elseif position==1.0 then
		img_rotate(mode_base, -20)
	elseif position==2.0 then
		img_rotate(mode_base, 20)
	elseif position==3.0 then
		img_rotate(mode_base, 50)
	end
end

function press_ctr()	-- CTR button
	xpl_command("WeisAIR/b748/EFIS/CTR_push")
end

function set_rng(rng_val)	-- ND RANGE KNOB
	rng_ang = rng_val * 30  - 90.0
	img_rotate(rng_base, rng_ang)
end

function rng_spin(direction)
	if direction==  1 then
		xpl_command("WeisAIR/b748/EFIS/range_inc")
	elseif direction== -1 then
		xpl_command("WeisAIR/b748/EFIS/range_dec")
	end
end

function press_tfc(sw_state)	-- TFC button
	xpl_command ("WeisAIR/b748/EFIS/TFC_push")
end

function press_wxr(sw_state)	-- WXR button
	xpl_command ("WeisAIR/b748/EFIS/WXR_push_cpt")
end

function wxr_chg(position)
	wxr_is_on=position
	switch_set_state(switch_wxr, position)
end

function press_sta(sw_state)	-- STA button
	xpl_command ("WeisAIR/b748/EFIS/STA_push_cpt")
end

function sta_chg(position)
	switch_set_state(switch_sta, position)
end

function press_wpt(sw_state)	-- WPT button
	xpl_command ("WeisAIR/b748/EFIS/WPT_push_cpt")
end

function wpt_chg(position)
	wpt_is_on=position
	switch_set_state(switch_wpt, position)
end

function press_arpt(sw_state)	-- ARPT button
	xpl_command ("WeisAIR/b748/EFIS/ARPT_push_cpt")
end

function arpt_chg(position)
	arpt_is_on=position
	switch_set_state(switch_arpt, position)
end

function press_data(sw_state)	-- DATA button
	xpl_command ("WeisAIR/b748/EFIS/DATA_push_cpt")
end

function data_chg(position)
	switch_set_state(switch_data, position)
end

function press_pos(sw_state)	-- POS button
	xpl_command ("WeisAIR/b748/EFIS/POS_push_cpt")
end

function pos_chg(position)
	switch_set_state(switch_pos, position)
end

function press_terr(sw_state)	-- TERR button
	xpl_command ("WeisAIR/b748/EFIS/TERR_push_cpt")
end

function press_fpv()	-- FPV button
	xpl_command ("WeisAIR/b748/EFIS/FPV_push")
end

function press_mtr()	-- MTR button
	xpl_command ("WeisAIR/b748/EFIS/MTRS_push")
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

xpl_dataref_subscribe("ssg/B748/MCP/ap_vor_adf1","FLOAT"		,set_vor1)---
xpl_dataref_subscribe("ssg/B748/MCP/ap_vor_adf2","FLOAT"		,set_vor2)---
xpl_dataref_subscribe("ssg/PFD/baro_type_sw","INT"		,set_hpa)
xpl_dataref_subscribe("ssg/B748/ND/mode_pilot","FLOAT"	,set_mode)
xpl_dataref_subscribe("ssg/B748/ND/range_pilot","FLOAT"				,set_rng)---
xpl_dataref_subscribe("ssg/B748/ND/show_wheather_pilot","FLOAT"	,wxr_chg)--- schnell von 1 auf 0
xpl_dataref_subscribe("ssg/B748/ND/show_VOR_pilot","FLOAT"	,sta_chg)--- schnell von 1 auf 0
xpl_dataref_subscribe("ssg/B748/ND/show_waypoint_pilot","FLOAT"					,wpt_chg)--- schnell von 1 auf 0
xpl_dataref_subscribe("ssg/B748/ND/show_airport_pilot","FLOAT"				,arpt_chg)--- schnell von 1 auf 0
xpl_dataref_subscribe("ssg/B748/ND/show_NDB_pilot","FLOAT"	,data_chg)--- schnell von 1 auf 0
xpl_dataref_subscribe("ssg/B748/ND/show_POS_pilot","FLOAT"	,pos_chg)--- schnell von 1 auf 0
xpl_dataref_subscribe("ssg/PFD/dh_mode_sw","INT", set_min_mode)
xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts","FLOAT[4]",
						"sim/cockpit/electrical/avionics_on","INT"				,set_power_xpl)

xpl_command("WeisAIR/b748/EFIS/baro_set_hpa",0)
xpl_command("WeisAIR/b748/EFIS/baro_set_in",0)

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