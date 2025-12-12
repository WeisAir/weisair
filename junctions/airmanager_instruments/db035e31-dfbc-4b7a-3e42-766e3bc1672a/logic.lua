-- =====================================================================================
--	    External FO CDU FULL dedicated to Boeing B737-800X ZiboMod for X-Plane 11
-- =====================================================================================
------------------------------------------------------------------------------------------------------
--				Darren Lane (ozuser) FO CDU Full for Boeing 737-800X ZIBOmod
------------------------------------------------------------------------------------------------------
--   reworking made by enjxp_SimPassion on 11/01/2018 to fit new text handling starting from AM 3.5
------------------------------------------------------------------------------------------------------

----------------------------------------
--			AUTHORING SECTION
----------------------------------------

-- Values to be updated by Authors

 local AM_Main_Release = "AM3.5"		-- Current AM release
 local Z2DXPCDU = "1.0.6"				-- Current CDU release
 local Date_Release = "02/24/2019"		-- Current CDU release date

 
--=============================================================================
--=============================================================================

-- Don't change these values
-- or at least,
-- only for personal usage

 local Title = "Z2DXP_FO_CDU_Full"
 local InitialRelease_Date="11/18/2017"
 local InitialAuthor = "ozuser_Darren_Lane"

----------------------------------------
--			RELEASE SECTION
----------------------------------------

local ZiboProject_Builders = "Zibo/AeroSimDevGroup/Fay/Twkster/Audiobirdxp/DrGluck/Flightdeck2sim/Folko"

local Z2DXPMCP_ScriptAuthors = "ozuser_Darren_Lane/enjxp_SimPassion/	/	/	/	/	"

-- Register here each of the successive revisions with comments

--	Author						Date			Release		Comments
--	ozuser_Darren_Lane			11/18/2017		1.0.0		Full : initial release
--	ozuser_Darren_Lane			11/27/2017		1.0.1		Full : bugs fixed
--	ozuser_Darren_Lane			11/29/2017		1.0.0		Text only version
--	enjxp_SimPassion			11/29/2017		1.0.2		Full : feature added
--	ozuser_Darren_Lane			12/10/2017		1.0.1		Text only : bugs fixed
--	ozuser_Darren_Lane			12/21/2017		1.0.3		Full : bugs fixed
--	enjxp_SimPassion			11/01/2018		1.0.4		Full : bugs fixed
--	enjxp_SimPassion			01/25/2019		1.0.5		Full : text size issue fixed
--	enjxp_SimPassion			02/24/2019		1.0.6		Info sections reworked

--=============================================================================
------------------------------------------------------------------------------------------------------------------------------------
--  Boeing 737-800X CDU for ZiboMmod
--		based on ozuser_Darren_Lane's CDU for ZiboMod B737-800X
---------------------------------------------------------------------------------------------------------------------------------------------
--  New release based on initial graphic design by ozuser_Darren_Lane, script reworking made by enjxp_SimPassion starting on 11/29/2017
--	thanks to kind permission of ozuser (Darren Lane) for publishing
---------------------------------------------------------------------------------------------------------------------------------------------

--  Note that this panel only mimics the 737 CDU by sending inputs
--  and displaying the 737 outputs.

--	Default size = 623 x 1001

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

img_add_fullscreen("737-800X_cdu.png")

--====================================================================================
--					INIT SECTION	CONSTANTS & VARIABLES
--====================================================================================

--====================================================================================
--									CONSTANTS
--====================================================================================

color_green	= "#6ee970;"
color_grey	= "#e1e1e1;"
color_magenta	= "#ff00ff;"

font_SZ1	= "size:22px; font:Inconsolata-Bold_sml.ttf; color:"
font_SZ2	= "size:32px; font:Inconsolata-Bold.ttf; color:"

style_22_grey1	= font_SZ1 .. color_grey

style_31_green	= font_SZ2 .. color_green
style_31_grey1	= font_SZ2 .. color_grey
style_31_mgnta	= font_SZ2 .. color_magenta

fmcStrLine = string.rep(" ",24)

ColStartA	= 115
ColStartS	= 117

ColScratch = 407

Lig_0A	= 85
Lig_0S	= 93

Lig_1X	= 119
Lig_1A	= 135
Lig_1S	= 142

Lig_2X	= Lig_1X + 48
Lig_2A	= Lig_1A + 48
Lig_2S	= Lig_1S + 48

Lig_3X	= Lig_2X + 48
Lig_3A	= Lig_2A + 48
Lig_3S	= Lig_2S + 48

Lig_4X	= Lig_3X + 48
Lig_4A	= Lig_3A + 48
Lig_4S	= Lig_3S + 48

Lig_5X	= Lig_4X + 48
Lig_5A	= Lig_4A + 48
Lig_5S	= Lig_4S + 48

Lig_6X	= Lig_5X + 48
Lig_6A	= Lig_5A + 48
Lig_6S	= Lig_5S + 48

L_W		= 408
L_HA	= 31
L_HXS	= 22

--====================================================================================
--								TEXT FIELD & VARIABLES
--====================================================================================

txt_0L		= txt_add(fmcStrLine, style_31_grey1, ColStartA,  Lig_0A, L_W, L_HA)
txt_0M		= txt_add(fmcStrLine, style_31_mgnta, ColStartA,  Lig_0A, L_W, L_HA)
txt_0S		= txt_add(fmcStrLine, style_22_grey1, ColStartA,  Lig_0S, L_W, L_HXS)

txt_1X		= txt_add(fmcStrLine, style_22_grey1, ColStartA, Lig_1X, L_W, L_HXS)
txt_1L		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_1A, L_W, L_HA)
txt_1M		= txt_add(fmcStrLine, style_31_mgnta, ColStartA, Lig_1A, L_W, L_HA)
txt_1G		= txt_add(fmcStrLine, style_31_green, ColStartA, Lig_1A, L_W, L_HA)
txt_1I		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_1A, L_W, L_HA)
txt_1S		= txt_add(fmcStrLine, style_22_grey1, ColStartS, Lig_1S, L_W, L_HXS)

txt_2X		= txt_add(fmcStrLine, style_22_grey1, ColStartA, Lig_2X, L_W, L_HXS)
txt_2L		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_2A, L_W, L_HA)
txt_2M		= txt_add(fmcStrLine, style_31_mgnta, ColStartA, Lig_2A, L_W, L_HA)
txt_2G		= txt_add(fmcStrLine, style_31_green, ColStartA, Lig_2A, L_W, L_HA)
txt_2I		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_2A, L_W, L_HA)
txt_2S		= txt_add(fmcStrLine, style_22_grey1, ColStartS, Lig_2S, L_W, L_HXS)

txt_3X		= txt_add(fmcStrLine, style_22_grey1, ColStartA, Lig_3X, L_W, L_HXS)
txt_3L		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_3A, L_W, L_HA)
txt_3M		= txt_add(fmcStrLine, style_31_mgnta, ColStartA, Lig_3A, L_W, L_HA)
txt_3G		= txt_add(fmcStrLine, style_31_green, ColStartA, Lig_3A, L_W, L_HA)
txt_3I		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_3A, L_W, L_HA)
txt_3S		= txt_add(fmcStrLine, style_22_grey1, ColStartS, Lig_3S, L_W, L_HXS)

txt_4X		= txt_add(fmcStrLine, style_22_grey1, ColStartA, Lig_4X, L_W, L_HXS)
txt_4L		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_4A, L_W, L_HA)
txt_4M		= txt_add(fmcStrLine, style_31_mgnta, ColStartA, Lig_4A, L_W, L_HA)
txt_4G		= txt_add(fmcStrLine, style_31_green, ColStartA, Lig_4A, L_W, L_HA)
txt_4I		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_4A, L_W, L_HA)
txt_4S		= txt_add(fmcStrLine, style_22_grey1, ColStartS, Lig_4S, L_W, L_HXS)

txt_5X		= txt_add(fmcStrLine, style_22_grey1, ColStartA, Lig_5X, L_W, L_HXS)
txt_5L		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_5A, L_W, L_HA)
txt_5M		= txt_add(fmcStrLine, style_31_mgnta, ColStartA, Lig_5A, L_W, L_HA)
txt_5G		= txt_add(fmcStrLine, style_31_green, ColStartA, Lig_5A, L_W, L_HA)
txt_5I		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_5A, L_W, L_HA)
txt_5S		= txt_add(fmcStrLine, style_22_grey1, ColStartS, Lig_5S, L_W, L_HXS)

txt_6X		= txt_add(fmcStrLine, style_22_grey1, ColStartA, Lig_6X, L_W, L_HXS)
txt_6L		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_6A, L_W, L_HA)
txt_6M		= txt_add(fmcStrLine, style_31_mgnta, ColStartA, Lig_6A, L_W, L_HA)
txt_6G		= txt_add(fmcStrLine, style_31_green, ColStartA, Lig_6A, L_W, L_HA)
txt_6I		= txt_add(fmcStrLine, style_31_grey1, ColStartA, Lig_6A, L_W, L_HA)
txt_6S		= txt_add(fmcStrLine, style_22_grey1, ColStartS, Lig_6S, L_W, L_HXS)

txt_scratch	= txt_add(fmcStrLine, style_31_grey1, ColStartA, ColScratch, L_W, L_HA)
txt_scratch_I	= txt_add(fmcStrLine, style_31_grey1, ColStartA, ColScratch, L_W, L_HA)

msg_lit_img	= img_add ("msg_lit.png",  571 , 710 , 20 , 152)
exec_lit_img	= img_add ("exec_lit.png", 487 , 555 , 64 ,  17)
visible (msg_lit_img, false)
visible (exec_lit_img, false)

--====================================================================================
--									FUNCTIONS
--====================================================================================

function cdu_lite_status(msg_lit_img_on, exec_lit_img_on)
	visible ( msg_lit_img , msg_lit_img_on == 1 )
	visible ( exec_lit_img , exec_lit_img_on == 1 )
end

--	TEXT LINES

function data_0_L(line_0_L)
	txt_set(txt_0L, line_0_L)
end

function data_0_M(line_0_M)
	txt_set(txt_0M, line_0_M)
end

function data_0_S(line_0_S)
	txt_set(txt_0S, line_0_S)
end

function data_1_G(line_1_G)
	txt_set(txt_1G, line_1_G)
end

function data_1_I(line_1_I)
	txt_set(txt_1I, line_1_I)
end

function data_1_L(line_1_L)
	txt_set(txt_1L, line_1_L)
end

function data_1_M(line_1_M)
	txt_set(txt_1M, line_1_M)
end

function data_1_S(line_1_S)
	txt_set(txt_1S, line_1_S)
end

function data_1_X(line_1_X)
	txt_set(txt_1X, line_1_X)
end

function data_2_G(line_2_G)
	txt_set(txt_2G, line_2_G)
end

function data_2_I(line_2_I)
	txt_set(txt_2I, line_2_I)
end

function data_2_L(line_2_L)
	txt_set(txt_2L, line_2_L)
end

function data_2_M(line_2_M)
	txt_set(txt_2M, line_2_M)
end

function data_2_S(line_2_S)
	txt_set(txt_2S, line_2_S)
end

function data_2_X(line_2_X)
	txt_set(txt_2X, line_2_X)
end

function data_3_G(line_3_G)
	txt_set(txt_3G, line_3_G)
end

function data_3_I(line_3_I)
	txt_set(txt_3I, line_3_I)
end

function data_3_L(line_3_L)
	txt_set(txt_3L, line_3_L)
end

function data_3_M(line_3_M)
	txt_set(txt_3M, line_3_M)
end

function data_3_S(line_3_S)
	txt_set(txt_3S, line_3_S)
end

function data_3_X(line_3_X)
	txt_set(txt_3X, line_3_X)
end

function data_4_X(line_4_X)
	txt_set(txt_4X, line_4_X)
end

function data_4_L(line_4_L)
	txt_set(txt_4L, line_4_L)
end

function data_4_M(line_4_M)
	txt_set(txt_4M, line_4_M)
end

function data_4_G(line_4_G)
	txt_set(txt_4G, line_4_G)
end

function data_4_I(line_4_I)
	txt_set(txt_4I, line_4_I)
end

function data_4_S(line_4_S)
	txt_set(txt_4S, line_4_S)
end

function data_5_G(line_5_G)
	txt_set(txt_5G, line_5_G)
end

function data_5_I(line_5_I)
	txt_set(txt_5I, line_5_I)
end

function data_5_L(line_5_L)
	txt_set(txt_5L, line_5_L)
end

function data_5_M(line_5_M)
	txt_set(txt_5M, line_5_M)
end

function data_5_S(line_5_S)
	txt_set(txt_5S, line_5_S)
end

function data_5_X(line_5_X)
	txt_set(txt_5X, line_5_X)
end

function data_6_G(line_6_G)
	txt_set(txt_6G, line_6_G)
end

function data_6_I(line_6_I)
	txt_set(txt_6I, line_6_I)
end

function data_6_L(line_6_L)
	txt_set(txt_6L, line_6_L)
end

function data_6_M(line_6_M)
	txt_set(txt_6M, line_6_M)
end

function data_6_S(line_6_S)
	txt_set(txt_6S, line_6_S)
end

function data_6_X(line_6_X)
	txt_set(txt_6X, line_6_X)
end

function Line_entry(Line_entry)
	txt_set(txt_scratch, Line_entry)
end

function Line_entry_I(Line_entry_I)
	txt_set(txt_scratch_I, Line_entry_I)
end

-- FMC BUTTONS FUNCTIONS

function tune_BRGHT()
	xpl_command("laminar/B738/push_button/fms_light_fo")
end

function press_INIT()
	xpl_command("laminar/B738/button/fmc2_init_ref")
end

function press_RTE()
	xpl_command("laminar/B738/button/fmc2_rte")
end

function press_CLB()
	xpl_command("laminar/B738/button/fmc2_clb")
end

function press_CRZ()
	xpl_command("laminar/B738/button/fmc2_crz")
end

function press_DES()
	xpl_command("laminar/B738/button/fmc2_des")
end

function press_MENU()
	xpl_command("laminar/B738/button/fmc2_menu")
end

function press_LEGS()
	xpl_command("laminar/B738/button/fmc2_legs")
end

function press_DEPARR()
	xpl_command("laminar/B738/button/fmc2_dep_app")
end

function press_HOLD()
	xpl_command("laminar/B738/button/fmc2_hold")
end

function press_PROG()
	xpl_command("laminar/B738/button/fmc2_prog")
end

function press_N1()
	xpl_command("laminar/B738/button/fmc2_n1_lim")
end

function press_FIX()
	xpl_command("laminar/B738/button/fmc2_fix")
end

function press_PREV()
	xpl_command("laminar/B738/button/fmc2_prev_page")
end

function press_NEXT()
	xpl_command("laminar/B738/button/fmc2_next_page")
end

function press_EXEC()
	xpl_command("laminar/B738/button/fmc2_exec")
end

-- ALPHA

function press_A()
	xpl_command("laminar/B738/button/fmc2_A")
end

function press_B()
	xpl_command("laminar/B738/button/fmc2_B")
end

function press_C()
	xpl_command("laminar/B738/button/fmc2_C")
end

function press_D()
	xpl_command("laminar/B738/button/fmc2_D")
end

function press_E()
	xpl_command("laminar/B738/button/fmc2_E")
end

function press_F()
	xpl_command("laminar/B738/button/fmc2_F")
end

function press_G()
	xpl_command("laminar/B738/button/fmc2_G")
end

function press_H()
	xpl_command("laminar/B738/button/fmc2_H")
end

function press_I()
	xpl_command("laminar/B738/button/fmc2_I")
end

function press_J()
	xpl_command("laminar/B738/button/fmc2_J")
end

function press_K()
	xpl_command("laminar/B738/button/fmc2_K")
end

function press_L()
	xpl_command("laminar/B738/button/fmc2_L")
end

function press_M()
	xpl_command("laminar/B738/button/fmc2_M")
end

function press_N()
	xpl_command("laminar/B738/button/fmc2_N")
end

function press_O()
	xpl_command("laminar/B738/button/fmc2_O")
end

function press_P()
	xpl_command("laminar/B738/button/fmc2_P")
end

function press_Q()
	xpl_command("laminar/B738/button/fmc2_Q")
end

function press_R()
	xpl_command("laminar/B738/button/fmc2_R")
end

function press_S()
	xpl_command("laminar/B738/button/fmc2_S")
end

function press_T()
	xpl_command("laminar/B738/button/fmc2_T")
end

function press_U()
	xpl_command("laminar/B738/button/fmc2_U")
end

function press_V()
	xpl_command("laminar/B738/button/fmc2_V")
end

function press_W()
	xpl_command("laminar/B738/button/fmc2_W")
end

function press_X()
	xpl_command("laminar/B738/button/fmc2_X")
end

function press_Y()
	xpl_command("laminar/B738/button/fmc2_Y")
end

function press_Z()
	xpl_command("laminar/B738/button/fmc2_Z")
end

function press_SPACE()
	xpl_command("laminar/B738/button/fmc2_SP")
end

function press_DEL()
	xpl_command("laminar/B738/button/fmc2_del")
end

function press_SLASH()
	xpl_command("laminar/B738/button/fmc2_slash")
end

function press_CLR()
	xpl_command("laminar/B738/button/fmc2_clr")
end

-- NUMERIC

function press_ONE()
	xpl_command("laminar/B738/button/fmc2_1")
end

function press_TWO()
	xpl_command("laminar/B738/button/fmc2_2")
end

function press_THREE()
	xpl_command("laminar/B738/button/fmc2_3")
end

function press_FOUR()
	xpl_command("laminar/B738/button/fmc2_4")
end

function press_FIVE()
	xpl_command("laminar/B738/button/fmc2_5")
end

function press_SIX()
	xpl_command("laminar/B738/button/fmc2_6")
end

function press_SEVEN()
	xpl_command("laminar/B738/button/fmc2_7")
end

function press_EIGHT()
	xpl_command("laminar/B738/button/fmc2_8")
end

function press_NINE()
	xpl_command("laminar/B738/button/fmc2_9")
end

function press_PERIOD()
	xpl_command("laminar/B738/button/fmc2_period")
end

function press_ZERO()
	xpl_command("laminar/B738/button/fmc2_0")
end

function press_MINUS()
	xpl_command("laminar/B738/button/fmc2_minus")
end

-- LSK#L

function press_LSK1L()
	xpl_command("laminar/B738/button/fmc2_1L")
end

function press_LSK2L()
	xpl_command("laminar/B738/button/fmc2_2L")
end

function press_LSK3L()
	xpl_command("laminar/B738/button/fmc2_3L")
end

function press_LSK4L()
	xpl_command("laminar/B738/button/fmc2_4L")
end

function press_LSK5L()
	xpl_command("laminar/B738/button/fmc2_5L")
end

function press_LSK6L()
	xpl_command("laminar/B738/button/fmc2_6L")
end

-- LSK#R

function press_LSK1R()
	xpl_command("laminar/B738/button/fmc2_1R")
end

function press_LSK2R()
	xpl_command("laminar/B738/button/fmc2_2R")
end

function press_LSK3R()
	xpl_command("laminar/B738/button/fmc2_3R")
end

function press_LSK4R()
	xpl_command("laminar/B738/button/fmc2_4R")
end

function press_LSK5R()
	xpl_command("laminar/B738/button/fmc2_5R")
end

function press_LSK6R()
	xpl_command("laminar/B738/button/fmc2_6R")
end

-- Based on sample instrument "Boeing 737NG - Comm Nav Stack" from Sim Innovations

gbl_power	= false
img_CDU_OFF = img_add_fullscreen("737-800X_cdu.png")visible(img_CDU_OFF,true)

function set_power_xpl(bus_volts,avionics_on)

	if  bus_volts == nil or avionics_on == nil then
		visible(img_CDU_OFF,true)
		return
	end

	gbl_power = fif((bus_volts[1] > 10 or bus_volts[2] > 10) and avionics_on, true, false)

	if gbl_power == false then
		visible(img_CDU_OFF,true)
	else
		visible(img_CDU_OFF,false)
	end
end

--====================================================================================
--								DATAREFS SUBSCRIPTIONS
--====================================================================================

xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts", "FLOAT[4]",
					  "sim/cockpit/electrical/avionics_on", "INT",set_power_xpl)
					  
xpl_dataref_subscribe("laminar/B738/fmc2/Line00_L", "STRING", data_0_L)
xpl_dataref_subscribe("laminar/B738/fmc2/Line00_M", "STRING", data_0_M)
xpl_dataref_subscribe("laminar/B738/fmc2/Line00_S", "STRING", data_0_S)

xpl_dataref_subscribe("laminar/B738/fmc2/Line01_X", "STRING", data_1_X)
xpl_dataref_subscribe("laminar/B738/fmc2/Line01_L", "STRING", data_1_L)
xpl_dataref_subscribe("laminar/B738/fmc2/Line01_M", "STRING", data_1_M)
xpl_dataref_subscribe("laminar/B738/fmc2/Line01_G", "STRING", data_1_G)
xpl_dataref_subscribe("laminar/B738/fmc2/Line01_I", "STRING", data_1_I)
xpl_dataref_subscribe("laminar/B738/fmc2/Line01_S", "STRING", data_1_S)

xpl_dataref_subscribe("laminar/B738/fmc2/Line02_X", "STRING", data_2_X)
xpl_dataref_subscribe("laminar/B738/fmc2/Line02_L", "STRING", data_2_L)
xpl_dataref_subscribe("laminar/B738/fmc2/Line02_M", "STRING", data_2_M)
xpl_dataref_subscribe("laminar/B738/fmc2/Line02_G", "STRING", data_2_G)
xpl_dataref_subscribe("laminar/B738/fmc2/Line02_I", "STRING", data_2_I)
xpl_dataref_subscribe("laminar/B738/fmc2/Line02_S", "STRING", data_2_S)

xpl_dataref_subscribe("laminar/B738/fmc2/Line03_X", "STRING", data_3_X)
xpl_dataref_subscribe("laminar/B738/fmc2/Line03_L", "STRING", data_3_L)
xpl_dataref_subscribe("laminar/B738/fmc2/Line03_M", "STRING", data_3_M)
xpl_dataref_subscribe("laminar/B738/fmc2/Line03_G", "STRING", data_3_G)
xpl_dataref_subscribe("laminar/B738/fmc2/Line03_I", "STRING", data_3_I)
xpl_dataref_subscribe("laminar/B738/fmc2/Line03_S", "STRING", data_3_S)

xpl_dataref_subscribe("laminar/B738/fmc2/Line04_X", "STRING", data_4_X)
xpl_dataref_subscribe("laminar/B738/fmc2/Line04_L", "STRING", data_4_L)
xpl_dataref_subscribe("laminar/B738/fmc2/Line04_M", "STRING", data_4_M)
xpl_dataref_subscribe("laminar/B738/fmc2/Line04_G", "STRING", data_4_G)
xpl_dataref_subscribe("laminar/B738/fmc2/Line04_I", "STRING", data_4_I)
xpl_dataref_subscribe("laminar/B738/fmc2/Line04_S", "STRING", data_4_S)

xpl_dataref_subscribe("laminar/B738/fmc2/Line05_X", "STRING", data_5_X)
xpl_dataref_subscribe("laminar/B738/fmc2/Line05_L", "STRING", data_5_L)
xpl_dataref_subscribe("laminar/B738/fmc2/Line05_M", "STRING", data_5_M)
xpl_dataref_subscribe("laminar/B738/fmc2/Line05_G", "STRING", data_5_G)
xpl_dataref_subscribe("laminar/B738/fmc2/Line05_I", "STRING", data_5_I)
xpl_dataref_subscribe("laminar/B738/fmc2/Line05_S", "STRING", data_5_S)

xpl_dataref_subscribe("laminar/B738/fmc2/Line06_X", "STRING", data_6_X)
xpl_dataref_subscribe("laminar/B738/fmc2/Line06_L", "STRING", data_6_L)
xpl_dataref_subscribe("laminar/B738/fmc2/Line06_M", "STRING", data_6_M)
xpl_dataref_subscribe("laminar/B738/fmc2/Line06_G", "STRING", data_6_G)
xpl_dataref_subscribe("laminar/B738/fmc2/Line06_I", "STRING", data_6_I)
xpl_dataref_subscribe("laminar/B738/fmc2/Line06_S", "STRING", data_6_S)

xpl_dataref_subscribe("laminar/B738/fmc2/Line_entry", "STRING", Line_entry)
xpl_dataref_subscribe("laminar/B738/fmc2/Line_entry_I", "STRING", Line_entry_I)

xpl_dataref_subscribe("laminar/B738/fmc/fmc_message", "FLOAT", "laminar/B738/indicators/fmc_exec_lights", "FLOAT", cdu_lite_status)

--====================================================================================
--										BUTTONS
--====================================================================================

--	FMC FUNCTIONS

BRGHT_button	= button_add(nil, nil,520,508,35,35,tune_BRGHT)
INIT_button		= button_add("737-800X_INIT_off.png" , "737-800X_INIT_on.png",70,508,61,44,press_INIT)
RTE_button		= button_add("737-800X_RTE_off.png" , "737-800X_RTE_on.png",149,508,61,44,press_RTE)
CLB_button		= button_add("737-800X_CLB_off.png" , "737-800X_CLB_on.png",228,508,61,44,press_CLB)
CRZ_button		= button_add("737-800X_CRZ_off.png" , "737-800X_CRZ_on.png",307,508,61,44,press_CRZ)
DES_button		= button_add("737-800X_DES_off.png" , "737-800X_DES_on.png",387,508,61,44,press_DES)
MENU_button		= button_add("737-800X_MENU_off.png" , "737-800X_MENU_on.png",69,570,61,44,press_MENU)
LEGS_button		= button_add("737-800X_LEGS_off.png" , "737-800X_LEGS_on.png",149,570,61,44,press_LEGS)
DEPARR_button	= button_add("737-800X_DEPARR_off.png" , "737-800X_DEPARR_on.png",228,570,61,44,press_DEPARR)
HOLD_button		= button_add("737-800X_HOLD_off.png" , "737-800X_HOLD_on.png",307,570,61,44,press_HOLD)
PROG_button 	= button_add("737-800X_PROG_off.png" , "737-800X_PROG_on.png",387,570,61,44,press_PROG)
N1_button		= button_add("737-800X_N1_off.png" , "737-800X_N1_on.png",69,631,61,44,press_N1)
FIX_button		= button_add("737-800X_FIX_off.png" , "737-800X_FIX_on.png",149,631,61,44,press_FIX)
PREV_button 	= button_add("737-800X_PREV_off.png" , "737-800X_PREV_on.png",69,692,61,44,press_PREV)
NEXT_button 	= button_add("737-800X_NEXT_off.png" , "737-800X_NEXT_on.png",149,692,61,44,press_NEXT)
EXEC_button 	= button_add("737-800X_EXEC_off.png" , "737-800X_EXEC_on.png",489,580,61,32,press_EXEC)

--	ALPHA

A_button 		= button_add("737-800X_A_off.png" , "737-800X_A_on.png",260,631,43,44,press_A)
B_button 		= button_add("737-800X_B_off.png" , "737-800X_B_on.png",324,631,43,44,press_B)
C_button 		= button_add("737-800X_C_off.png" , "737-800X_C_on.png",386,631,43,44,press_C)
D_button 		= button_add("737-800X_D_off.png" , "737-800X_D_on.png",448,631,43,44,press_D)
E_button 		= button_add("737-800X_E_off.png" , "737-800X_E_on.png",510,631,43,44,press_E)
F_button 		= button_add("737-800X_F_off.png" , "737-800X_F_on.png",261,693,43,44,press_F)
G_button 		= button_add("737-800X_G_off.png" , "737-800X_G_on.png",324,693,43,44,press_G)
H_button 		= button_add("737-800X_H_off.png" , "737-800X_H_on.png",386,693,43,44,press_H)
I_button 		= button_add("737-800X_I_off.png" , "737-800X_I_on.png",448,693,43,44,press_I)
J_button 		= button_add("737-800X_J_off.png" , "737-800X_J_on.png",511,693,43,44,press_J)
K_button 		= button_add("737-800X_K_off.png" , "737-800X_K_on.png",261,753,43,44,press_K)
L_button 		= button_add("737-800X_L_off.png" , "737-800X_L_on.png",323,752,43,44,press_L)
M_button 		= button_add("737-800X_M_off.png" , "737-800X_M_on.png",387,752,43,44,press_M)
N_button 		= button_add("737-800X_N_off.png" , "737-800X_N_on.png",449,753,43,44,press_N)
O_button 		= button_add("737-800X_O_off.png" , "737-800X_O_on.png",511,753,43,44,press_O)
P_button 		= button_add("737-800X_P_off.png" , "737-800X_P_on.png",261,816,43,44,press_P)
Q_button 		= button_add("737-800X_Q_off.png" , "737-800X_Q_on.png",323,816,43,44,press_Q)
R_button 		= button_add("737-800X_R_off.png" , "737-800X_R_on.png",387,816,43,44,press_R)
S_button 		= button_add("737-800X_S_off.png" , "737-800X_S_on.png",449,815,43,44,press_S)
T_button 		= button_add("737-800X_T_off.png" , "737-800X_T_on.png",512,816,43,44,press_T)
U_button 		= button_add("737-800X_U_off.png" , "737-800X_U_on.png",261,878,43,44,press_U)
V_button 		= button_add("737-800X_V_off.png" , "737-800X_V_on.png",324,878,43,44,press_V)
W_button 		= button_add("737-800X_W_off.png" , "737-800X_W_on.png",386,878,43,44,press_W)
X_button 		= button_add("737-800X_X_off.png" , "737-800X_X_on.png",449,878,43,44,press_X)
Y_button 		= button_add("737-800X_Y_off.png" , "737-800X_Y_on.png",512,878,43,44,press_Y)
Z_button 		= button_add("737-800X_Z_off.png" , "737-800X_Z_on.png",261,942,43,44,press_Z)
SPACE_button	= button_add("737-800X_SPACE_off.png" , "737-800X_SPACE_on.png",324,942,43,44,press_SPACE)
DEL_button		= button_add("737-800X_DEL_off.png" , "737-800X_DEL_on.png",387,942,43,44,press_DEL)
SLASH_button	= button_add("737-800X_SLASH_off.png" , "737-800X_SLASH_on.png",450,942,43,44,press_SLASH)
CLR_button		= button_add("737-800X_CLR_off.png" , "737-800X_CLR_on.png",512,941,43,44,press_CLR)

--	NUMERIC

ONE_button		= button_add("737-800X_1_off.png" , "737-800X_1_on.png",61,752,43,44,press_ONE)
TWO_button		= button_add("737-800X_2_off.png" , "737-800X_2_on.png",125,752,43,44,press_TWO)
THREE_button	= button_add("737-800X_3_off.png" , "737-800X_3_on.png",188,752,43,44,press_THREE)
FOUR_button		= button_add("737-800X_4_off.png" , "737-800X_4_on.png",61,814,43,44,press_FOUR)
FIVE_button		= button_add("737-800X_5_off.png" , "737-800X_5_on.png",124,814,43,44,press_FIVE)
SIX_button		= button_add("737-800X_6_off.png" , "737-800X_6_on.png",188,814,43,44,press_SIX)
SEVEN_button	= button_add("737-800X_7_off.png" , "737-800X_7_on.png",61,877,43,44,press_SEVEN)
EIGHT_button	= button_add("737-800X_8_off.png" , "737-800X_8_on.png",124,877,43,44,press_EIGHT)
NINE_button		= button_add("737-800X_9_off.png" , "737-800X_9_on.png",188,877,43,44,press_NINE)
PERIOD_button	= button_add("737-800X_PERIOD_off.png" , "737-800X_PERIOD_on.png",61,939,43,44,press_PERIOD)
ZERO_button		= button_add("737-800X_0_off.png" , "737-800X_0_on.png",125,939,43,44,press_ZERO)
MINUS_button	= button_add("737-800X_MINUS_off.png" , "737-800X_MINUS_on.png",188,939,43,44,press_MINUS)

--	LSK#L

LSK1L_button	= button_add("737-800X_LSKL_off.png" , "737-800X_LSKL_on.png",7,133,40,30,press_LSK1L)
LSK2L_button	= button_add("737-800X_LSKL_off.png" , "737-800X_LSKL_on.png",7,183,40,30,press_LSK2L)
LSK3L_button	= button_add("737-800X_LSKL_off.png" , "737-800X_LSKL_on.png",7,231,40,30,press_LSK3L)
LSK4L_button	= button_add("737-800X_LSKL_off.png" , "737-800X_LSKL_on.png",7,280,40,30,press_LSK4L)
LSK5L_button	= button_add("737-800X_LSKL_off.png" , "737-800X_LSKL_on.png",7,328,40,30,press_LSK5L)
LSK6L_button	= button_add("737-800X_LSKL_off.png" , "737-800X_LSKL_on.png",6,378,40,30,press_LSK6L)

--	LSK#R

LSK1R_button	= button_add("737-800X_LSKR_off.png" , "737-800X_LSKR_on.png",567,132,40,30,press_LSK1R)
LSK2R_button	= button_add("737-800X_LSKR_off.png" , "737-800X_LSKR_on.png",567,181,40,30,press_LSK2R)
LSK3R_button	= button_add("737-800X_LSKR_off.png" , "737-800X_LSKR_on.png",567,230,40,30,press_LSK3R)
LSK4R_button	= button_add("737-800X_LSKR_off.png" , "737-800X_LSKR_on.png",568,279,40,30,press_LSK4R)
LSK5R_button	= button_add("737-800X_LSKR_off.png" , "737-800X_LSKR_on.png",568,327,40,30,press_LSK5R)
LSK6R_button	= button_add("737-800X_LSKR_off.png" , "737-800X_LSKR_on.png",568,377,40,30,press_LSK6R)
