-- ============================================================================================================
-- 		External LANDING GEARS Lever and Annunciators dedicated to Boeing B737-800X ZiboMod for X-Plane 11
-- ============================================================================================================
--						Hardware Ready using Arduino board for Cockpitbuilders

	up_info_shown_bln = user_prop_add_boolean("DISPLAY CHECK INFOS", false, "Display Release infos")
	info_shown_bln = user_prop_get(up_info_shown_bln)

	btnmarks_bln = true

	up_btnmarks_bln = user_prop_add_boolean("Display Upper-Left corner clickable area marks", btnmarks_bln, "Display the upper-left mark for each three (3) clickable area for easier spot locating")
	btnmarks_bln = user_prop_get(up_btnmarks_bln)

----------------------------------------
--			AUTHORING SECTION
----------------------------------------

-- Values to be updated by Authors

	local AM_Main_Release = "AM3.7"			-- Minimal AM release requirement
	local Z_2D_XP_LNDG_Gears = "1.0.1"		-- Current LANDING GEARS Lever and Annunciators release
	local Date_Release = "04/04/2023"		-- Current LANDING GEARS Lever and Annunciators release date
 
--=============================================================================
--=============================================================================

-- Don't change these following values
-- or at least,
-- only for personal usage

	local Title = "Z_2D_XP LANDING GEARS"
	local InitialRelease_Date="05/07/2020"
	local InitialAuthor = "enjxp_SimPassion" -- "enjxp" on x-plane.org forum and "SimPassion" on Sim Innovations forum (same person)

--=============================================================================
--=============================================================================

----------------------------------------
--			RELEASE SECTION
----------------------------------------

local ZiboProject_Builders = "Zibo/AeroSimDevGroup/Fay/Twkster/Audiobirdxp/DrGluck/Flightdeck2sim/Folko/JBrik/Unsafe05"

local Z_2D_XP_LANDING_Gears_ScriptAuthors = "	enjxp_SimPassion/	/	/	/	/	"

-- Register here each of the successive revisions with comments

--	Author						Date			Release		Comments
--	enjxp_SimPassion			04/04/2023		1.0.1		Release number edited to match the new Sim Innovations « Instrument Submission Guidelines v2 ».
--	enjxp_SimPassion			05/08/2021		1.0.0		Release number edited to match the new Sim Innovations « Instrument Submission Guidelines v2 ».
--															Added turning LEDs lights OFF on closing instrument
--	enjxp_SimPassion			04/05/2021		0.0.5		Added Annunciators hardware LEDs handling
--															Added 3 buttons for current Gears Handle 3 positions (Software and Hardware)
--															Added Toggle button for showing/hiding the 3 green marks helpers (Software and Hardware)
--															Corrected handle behavior
--	enjxp_SimPassion			08/11/2020		0.0.4		Fixed behavior from new Landing Gears lever handling in the ZiboMod
--	enjxp_SimPassion			05/24/2020		0.0.3		Updated ScriptAuthor variable
--	enjxp_SimPassion			05/17/2020		0.0.2		Added version number displayed to be able to check version on tablet devices
--															Added ability to hide check infos
--	enjxp_SimPassion			05/07/2020		0.0.1		Initial release

--=============================================================================
------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
--  Initial release based on initial graphic design by AudioBirdXP and ZiboMod 3.31d,
--	thanks to AudioBirdXP agreement for publishing
---------------------------------------------------------------------------------------------------------------------------------------------

--  Note that this panel only mimics the 737 LANDING GEARS by sending inputs
--  and displaying the 737 outputs.

--	Default size = 203 x 1101

------------------------------------------------------------------------------

----------------------------------------
--			INSTALLATION SECTION
----------------------------------------

-- Unzip the file, then copy/paste the inside folder named with a suite of digits and letters, into the "\Users\%username%\Air Manager\instruments\OPEN_DIRECTORY" folder or in the "\Users\%username%\Air Manager BETA\instruments\OPEN_DIRECTORY" folder 

-- This instrument could be send on a remote PC, or on the same PC to Air Player, in order to run in standalone mode : waiting for an Air Player 3.5 Release
-- it also could be send to Air Player running on Android, iPad, Linux, Windows, Mac or Raspberry Pi with the appropriate licence of Air Player

-- For execution, mandatory requirement is one of the following Sim Innovations product and license : Air Manager on Windows or Air Player on Android / iPad / Raspberry Pi

--========================================================================================================================================================================================================

--		CAVEATS for coding : in this LUA script the order in which appear the statements concerning texts, buttons and images positioning, is of primary importance,
--		as all objects are displayed with a layer order : the first objects appear behind and the last objects appear in front following the order in which they're been wrote in the script

--========================================================================================================================================================================================================


--======================================================================================
--								SCRIPT START
--======================================================================================

----------------------------------------
--			PRE INIT
----------------------------------------

local txt_style0	= "font:arimo_bold.ttf; size:17px; color: yellow; halign: center;"
local brightrt		= 0.5
local testrt		= 0
local vis_mark		= true

img_landing_gear_bg			= img_add_fullscreen("landing_gear_bg.png")
img_ann_left_gear_off_up	= img_add("ann_left_gear_off.png",		 17, 263, 79, 40)
img_ann_left_gear_off_dn	= img_add("ann_left_gear_off.png",		 17, 303, 79, 40)
img_ann_nose_gear_off_up	= img_add("ann_nose_gear_off.png",		 59, 179, 79, 40)
img_ann_nose_gear_off_dn	= img_add("ann_nose_gear_off.png",		 59, 219, 79, 40)
img_ann_right_gear_off_up	= img_add("ann_right_gear_off.png",	103, 263, 79, 40)
img_ann_right_gear_off_dn	= img_add("ann_right_gear_off.png",	103, 303, 79, 40)

img_ann_left_gear_red		= img_add("ann_left_gear_red.png",		 17, 263, 79, 40)
img_ann_left_gear_green		= img_add("ann_left_gear_green.png",	 17, 303, 79, 40)
img_ann_nose_gear_red		= img_add("ann_nose_gear_red.png",		 59, 179, 79, 40)
img_ann_nose_gear_green		= img_add("ann_nose_gear_green.png",	 59, 219, 79, 40)
img_ann_right_gear_red		= img_add("ann_right_gear_red.png",	103, 263, 79, 40)
img_ann_right_gear_green	= img_add("ann_right_gear_green.png",	103, 303, 79, 40)

img_gear_lever_up			= img_add_fullscreen("gear_lever_up.png")
img_gear_lever_off			= img_add_fullscreen("gear_lever_off.png")
img_gear_lever_down			= img_add_fullscreen("gear_lever_down.png")
visible(img_gear_lever_up,false)
visible(img_gear_lever_off,false)
visible(img_gear_lever_down,true)

hw_led_left_dep = hw_led_add("LEFT_DEPL", 0)
hw_led_left_trn = hw_led_add("LEFT_TRAN", 0)
hw_led_nose_dep = hw_led_add("NOSE_DEPL", 0)
hw_led_nose_trn = hw_led_add("NOSE_TRAN", 0)
hw_led_rght_dep = hw_led_add("RGHT_DEPL", 0)
hw_led_rght_trn = hw_led_add("RGHT_TRAN", 0)

function pr_landing_gear(gear_handle_down,
								ann_left_safe,
								ann_left_transit,
								ann_nose_safe,
								ann_nose_transit,
								ann_right_safe,
								ann_right_transit,
								bright_test
								)

	if bright_test == -1 then
		testrt = 0.5
	else
		testrt = 1
	end

	visible(img_ann_left_gear_green,	(ann_left_safe > 0))		hw_led_set(hw_led_left_dep,fif((ann_left_safe > 0),brightrt * testrt,0))
	visible(img_ann_left_gear_red,		(ann_left_transit > 0))		hw_led_set(hw_led_left_trn,fif((ann_left_transit > 0),brightrt * testrt,0))
	visible(img_ann_nose_gear_green,	(ann_nose_safe > 0))		hw_led_set(hw_led_nose_dep,fif((ann_nose_safe > 0),brightrt * testrt,0))
	visible(img_ann_nose_gear_red,		(ann_nose_transit > 0))		hw_led_set(hw_led_nose_trn,fif((ann_nose_transit > 0),brightrt * testrt,0))
	visible(img_ann_right_gear_green,	(ann_right_safe > 0))		hw_led_set(hw_led_rght_dep,fif((ann_right_safe > 0),brightrt * testrt,0))
	visible(img_ann_right_gear_red,		(ann_right_transit > 0))	hw_led_set(hw_led_rght_trn,fif((ann_right_transit > 0),brightrt * testrt,0))

	opacity(img_ann_left_gear_green,	testrt)
	opacity(img_ann_left_gear_red,		testrt)
	opacity(img_ann_nose_gear_green,	testrt)
	opacity(img_ann_nose_gear_red,		testrt)
	opacity(img_ann_right_gear_green,	testrt)
	opacity(img_ann_right_gear_red,		testrt)

	visible(img_gear_lever_up,false)
	visible(img_gear_lever_off,false)
	visible(img_gear_lever_down,false)

	visible(img_gear_lever_up,gear_handle_down == 0)
	visible(img_gear_lever_off,(gear_handle_down ~= 0) and (gear_handle_down ~= 1))
	visible(img_gear_lever_down,gear_handle_down == 1)
end

function pr_landing_gear_up()
	xpl_command("laminar/B738/push_button/gear_up")
end
btn_landing_gear_up = button_add(nil, nil, 65, 405, 100, 50, pr_landing_gear_up)
hw_button_gup		= hw_button_add("Gears UP",pr_landing_gear_up)

function pr_landing_gear_off()
	xpl_command("laminar/B738/push_button/gear_off")
end
btn_landing_gear_off	= button_add(nil, nil, 65, 567, 100, 50, pr_landing_gear_off)
hw_button_goff			= hw_button_add("Gears OFF",pr_landing_gear_off)

function pr_landing_gear_down()
	xpl_command("laminar/B738/push_button/gear_down")
end
btn_landing_gear_down	= button_add(nil, nil, 65, 736, 100, 50, pr_landing_gear_down)
hw_button_gdown			= hw_button_add("Gears DOWN",pr_landing_gear_down)

img_loc1 = img_add("loc.png",65,405,10,10)
img_loc2 = img_add("loc.png",65,567,10,10)
img_loc3 = img_add("loc.png",65,736,10,10)

grp_marks = group_add(img_loc1,img_loc2,img_loc3)
visible(grp_marks,btnmarks_bln)
if info_shown_bln then
	lbl_ver_lndg_gears = txt_add	(Z_2D_XP_LNDG_Gears, txt_style0, 74, 5, 55, 20)
end

function pr_toggle_visible_marks()
	vis_mark=not(vis_mark)
	visible(grp_marks,fif(vis_mark==true,true,false))
end
btn_tvm			= button_add(nil, nil, 0, 0, 203, 50, pr_toggle_visible_marks)
hw_button_tvm	= hw_button_add("Toggle visible green Marks",pr_toggle_visible_marks)

xpl_dataref_subscribe("laminar/B738/controls/gear_handle_down", "FLOAT",
						"laminar/B738/annunciator/left_gear_safe" , "FLOAT" ,
						"laminar/B738/annunciator/left_gear_transit", "FLOAT",
						"laminar/B738/annunciator/nose_gear_safe" , "FLOAT" ,
						"laminar/B738/annunciator/nose_gear_transit", "FLOAT",
						"laminar/B738/annunciator/right_gear_safe" , "FLOAT" ,
						"laminar/B738/annunciator/right_gear_transit", "FLOAT",
						"laminar/B738/toggle_switch/bright_test","FLOAT",
						pr_landing_gear)

function pr_leds_off(event)	-- [STARTED / SHOWING / CLOSING / FLIGHT_SIM_CHANGED]
    if event == "CLOSING" then
		hw_led_set(hw_led_left_dep,0)
		hw_led_set(hw_led_left_trn,0)
		hw_led_set(hw_led_nose_dep,0)
		hw_led_set(hw_led_nose_trn,0)
		hw_led_set(hw_led_rght_dep,0)
		hw_led_set(hw_led_rght_trn,0)
    end
end

event_subscribe(pr_leds_off)