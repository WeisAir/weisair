-- =======================================================================================
--  External EFB 2D Tablet dedicated to Boeing B737-800X/700U/900U ZiboMod for X-Plane 11
-- =======================================================================================


----------------------------------------
--			AUTHORING SECTION
----------------------------------------

-- Values to be updated by Authors

 local AM_Main_Release	= "AM4.1"		-- Minimal AM release requirement
 local Z_2D_XP_EFB		= "1.4.9"		-- Current EFB release
 local Date_Release		= "01.25.2022"	-- Current release Date

--=============================================================================
--=============================================================================

-- Don't change these following values
-- or at least,
-- only for personal usage

 local Title = "Z_2D_XP EFB"				-- EFB Tablet Name
 local InitialRelease_Date="10.18.2018"		-- Initial Release Date
 local InitialAuthor = "enjxp_SimPassion"	-- "enjxp" on x-plane.org forum and "SimPassion" on Sim Innovations forum (same person)

--=============================================================================
--=============================================================================
--			Preamble
-- -------------------------------
-- I've tried to make the initial script as simple as possible
-- in order to stay free to be enhance by anyone from the community who made the request
-- Initial Editing in Notepad++ with a "Tab size:4" in [Settings/Preferences/Tab Settings]

--=========================================================================================

-- Thanks to Zibo and all the Team for this master piece of work : Zibo, Audiobirdxp, Twkster, AeroSimDevGroup, Folko, DrGluck, Fay, Flightdeck2sim, JBrik, Unsafe05, MugZ, 737ngworld, m.philippi

-- Thanks to Birdy.dma for initial dataref and xpl_command : https://forums.x-plane.org/index.php?/forums/topic/155578-datarefs-and-api-for-new-zibo-329-tablet-display/&do=findComment&comment=1468720
-- I was also using DataRefTool with filtering to check real time values

-- Based on initial 3D Cockpit EFB Tablet behavior inside the cockpit
-- This script use all initial EFB Tablet Graphics designed by AudioBirdXP, Zibo for logic and/or Zibo Team, remaining their own intellectual properties

----------------------------------------
--			INSTALLATION SECTION
----------------------------------------

-- This instrument could be send on a remote PC, or on the same PC, to Air Player, in order to run in standalone mode
-- it also could be send to Air Player running on Android, iPad, Linux, Windows, Mac or Raspberry Pi with the appropriate licence of Air Player

-- For execution, mandatory requirement is one of the following Sim Innovations product and license : Air Manager on Windows or Air Player on Android / iPad / Raspberry Pi

--========================================================================================================================================================================================================

--		CAVEATS for coding : in this LUA script the order in which appear the statements concerning texts, buttons and images positioning, is of primary importance,
--		as all objects are displayed with a layer order : the first objects appears behind and the last objects appears in front, following the order in which they're been wrote in the script
--		See and Read [Sim Innovations API] for further References : http://siminnovations.com/wiki/index.php?title=Air_Manager_Instrument_Logic_API

--========================================================================================================================================================================================================


local ZiboProject_Builders				= "Zibo/Audiobirdxp/Twkster/AeroSimDevGroup/Folko/DrGluck/Fay/Flightdeck2sim/JBrik/Unsafe05/sim4pilots"

local Z_2D_XP_EFBTablet_ScriptAuthors	= "enjxp_SimPassion/   /   /   /   /   "

-- -----------------------------------------
--				2B-DONE
-- -----------------------------------------

--	00 - Check with Zibo : (°) "Degree" Symbol handling, wrongly reported as <`> (Grave Accent) in "laminar/B738/tab/line06" dataref (Line #6 on PERFORMANCE TAKEOFF and PERFORMANCE LANDING pages in EFB), or replace it "on the fly"
--	1 - iPAD resolution : 2732 x 2048 / 2048 x 1536 / 1024 x 768 = 4/3 = ‭1.333333333333333‬
--	2 - ANDROID resolution : 2048 x 1536 = 1.333333333333333‬ or 1280 x 800 /  = 16/10 = ‭1.6
--	3 - event_subscribe(event_callback)	function event_callback(event)	if event == "FLIGHT_SIM_CHANGED"	http://siminnovations.com/wiki/index.php?title=Event_subscribe
--	4 - panel_width = panel_prop("WIDTH") panel_height = panel_prop("HEIGHT")	http://siminnovations.com/wiki/index.php?title=Panel_prop
--	5 - instr_pref_width = instrument_prop("PREF_WIDTH") instr_pref_height = instrument_prop("PREF_HEIGHT")	http://siminnovations.com/wiki/index.php?title=Instrument_prop
--	6 - instr_width = instrument_prop("WIDTH") instr_height = instrument_prop("HEIGHT")
--	7 - str_plateform = panel_prop("PLATFORM") 
--	8 - str_plateform = instrument_prop("PLATFORM") 

----------------------------------------
--			RELEASE SECTION
----------------------------------------

-- -----------------------------------------
--				Authoring Section
-- -----------------------------------------

-- Register here each of the successive revisions with comments

--	Author				Date			Release		Comments
--	-----------------	-----------		--------	-----------------------------
--	enjxp_SimPassion	01.25.2022		1.4.9		ADD: Updated to new custom color switching
--													FIX: Saved Flights labels appearing on shutdown
--													FIX: Added missing last large Credits
--													FIX: Enhance boot handling and poweroff
--	enjxp_SimPassion	01.24.2022		1.4.8		FIX: Updated title line and text lines color, also in sync with LevelUp scheme
--													FIX: Title area centering
--													ADD: String Trim function
--													ADD: Blinking Checklist line
--													ADD: Message for saving Failures settings on exiting options page
--													ENH: Adjusted overall text colors
--	enjxp_SimPassion	01.16.2022		1.4.7		FIX: Refined real time subscribe distribution across several functions
--													FIX: Removed duplicate time count
--													FIX: time field display length
--													FIX: Reworked styles definitions
--													ADD: Updated to both ZiboMod and LevelUp detection - however, rather use LevelUP dedicated Z_2D_XP EFB
--													FIX: Reworked EFB Bitmaps icons tools color
--													ADD: New Doors management
--													FIX: Line click area length
--													ADD: 3_15_15/16 Failures integration
--													FIX: DOORS STATUS on EFB POWER OFF
--													FIX: INFO DISPLAYED on EFB BOOT after POWER OFF
--	enjxp_SimPassion	11.08.2021		1.4.6		FIX: Updated and replaced preview file
--													ADD: Added new credits_strip bitmap file
--													FIX: Checked and re arrange credits_strip display order
--	enjxp_SimPassion	10.31.2021		1.4.5		ADD: Added new Autosaved Flight bitmap
--													ADD: Added new last autosaved flight detail on EFB start
--													ADD: Added BOEING-style font and label reflecting ACF acf_tailnum
--													ADD: Enhanced X-Plane state management and Aircraft detection
--													FIX: Performed coding cleaning
--	enjxp_SimPassion	10.27.2021		1.4.4		FIX: Fixed warning flag appearing on instrument start while X-Plane isn't running
--	enjxp_SimPassion	10.27.2021		1.4.3		FIX: Fixed DISPLAY AND VARIANTS page not cleared on EFB shutdown
--	enjxp_SimPassion	10.27.2021		1.4.2		ADD: Added warning flag on Doors STATUS/COMMANDS page
--	enjxp_SimPassion	10.26.2021		1.4.1		ADD: Added saved flights handling
--													ADD: Added new Doors management
--	enjxp_SimPassion	09.09.2021		1.4.0		ADD: Added Vanish_y handling
--													ADD: Added Futura font handling for Release Infos display
--	enjxp_SimPassion	08.19.2021		1.3.9		FIX: Script header cleaning
--													FIX: Prtdbg function reworked
--													FIX: Fixed Flight Load/Save Page #2 displaying wrong icons numbers
--	enjxp_SimPassion	04.21.2021		1.3.8		ADD: Added Autoload handling
--	enjxp_SimPassion	03.21.2021		1.3.7		FIX: Corrected Average FPS on display (was properly calculated previously, however wrong variable usage on display)
--													ADD: Updated Credits Strip 2-1 bitmap file
--													ADD: Added new bitmaps for "DISPLAY AND VARIANTS" page
--	enjxp_SimPassion	02.15.2021		1.3.6		ADD: Updated Credits Strip 2-1 bitmap file
--													ADD: Updated Ground Services Icons/Tabs
--													FIX: Fixed Failures state handling
--	enjxp_SimPassion	08.29.2020		1.3.5		ADD: Updated Credits files with latest reworked high resolution version
--	enjxp_SimPassion	08.29.2020		1.3.4		ADD: Updated Bitmaps Credit Strip and Credit Large files
--	enjxp_SimPassion	08.27.2020		1.3.3		ADD: Added new Credit step
--													ADD: Updated Perfs out rw bitmaps
--													ADD: Added original screen dust
--	enjxp_SimPassion	07.29.2020		1.3.2		FIX: Fixed FUEL Dataref type from LUA to C++ Transition
--	enjxp_SimPassion	07.17.2020		1.3.1		FIX: Fixed an FPS display issue
--													ADD: Added APPROACH RATE handling from 3_42_15
--	enjxp_SimPassion	04.24.2020		1.3.0		FIX: Removed log(..) for 3.6 compatibility thanks to Ralph at Sim Innovations
--													ADD: Updated to new Credits image from Zibo, for JBRIK and UNSAFE05 participants in the project
--	enjxp_SimPassion	03.25.2020		1.2.9		FIX: Fixed Landing Rating computing, thanks to Zibo data and advice received
--													Landing Rate banner location and opacity fixed
--	enjxp_SimPassion	03.21.2020		1.2.8		FIX: Fixed FUEL, PAYLOAD, CG, OPT PAGE reference
--													FIX: Re organize new menu structure that come with 3_34_Full release
--													FIX: Fixed ICONS/TAB still displayed when EFB is powered off
--	enjxp_SimPassion	03.14.2020		1.2.7		FIX: Fixed in previous release : Aircraft redraw issue on AM Instrument restart in FUEL PAYLOAD page (1.4), when numpad is 
--													displayed
--													ADD: Added Z_2D_XP EFB version to AM logs
--													ADD: Added Load/Save Flight handling as well as Icons/Tabs and page
--	enjxp_SimPassion	02.20.2020		1.2.6		FIX: Refined Tools Icons (Home/Arrows/Return/Info/Power/XP Status)
--													ADD: Added last enhancements on FUEL, PAYLOAD, CG, OPT, PERFS TAKEOFF/LANDING
--													ADD: Added Landing Rate
--													FIX: Reworked formulas for drawing on CG ENVELOPE
--													FIX: Updated text lines spacing to match Perfs BG
--													FIX: Updated checkbox spacing
--													FIX: Updated click area spacing
--													ADD: Added click field on Perfs pages
--													FIX: Script cleaned
--													FIX: Removed unused bitmaps
--													FIX: Simplified Active click line management
--													ADD: Added Numpad buttons
--	enjxp_SimPassion	01.21.2020		1.2.5		ADD: Added missing amber Text Fields on Payload page #1
--	enjxp_SimPassion	01.21.2020		1.2.4		FIX: Activating the proper Lines Input on Payload page #2, wrongly assigned previously
--	enjxp_SimPassion	01.21.2020		1.2.3		FIX: Added missing Weight values in CG Envelope page from 1.2.2 (Payload Page #3)
--	enjxp_SimPassion	01.21.2020		1.2.2		ADD: Updated to be in conformity for latest Payload pages and new process handling
--													ADD: New bitmap added
--													ADD: CG Envelope handling
--													FIX: Move Debug Fields Layer up and location
--													FIX: Reworked Payload pages logic
--	enjxp_SimPassion	12.30.2019		1.2.1		FIX: Typo Fixed for airstairs bitmap name, related to case sensitive on Android device
--													FIX: Removed unused bitmaps files
--													FIX: Removed Font files and renamed font styles to embedded available font from inside Air Manager/Air Player
--	enjxp_SimPassion	10.21.2019		1.2.0		FIX: Fixed PowerOFF issue on Icons/tab
--													ADD: Handling Zibo Warning Messages displayed
--													ADD: Added Pressurization failures Icon/tab
--													FIX: Fixed Text Lines Height and location
--	enjxp_SimPassion	10.10.2019		1.1.9		FIX: Fixed an issue on Icons/tab management for Page #12 & #13
--													ADD: Added Failures Fix Icons/tab
--						09.19.2019					FIX: Enhanced XP / Aircraft loading detection
--													FIX: Improved design
--	enjxp_SimPassion	09.19.2019		1.1.8		FIX: Fixed wrong variable used for De-Icing feature that may hide an Icon/tab when ASU is connected
--	enjxp_SimPassion	09.15.2019		1.1.7		ADD: Added missing FuelTrucks Icon/tab displayed
--													FIX: Enhanced Aircraft detection
--	enjxp_SimPassion	09.14.2019		1.1.6		FIX: Missing bitmap handling
--	enjxp_SimPassion	09.14.2019		1.1.5		ADD: Added FuelTrucks and Failures features
--	enjxp_SimPassion	09.06.2019		1.1.4		ADD: Updated with last new Airstairs Icons
--	enjxp_SimPassion	08.28.2019		1.1.3		ADD: Added Airstairs Icons
--	enjxp_SimPassion	07.14.2019		1.1.2		FIX: Tab Icon Replaced for "MANAGE AUDIO PRESETS"
--	enjxp_SimPassion	05.26.2019		1.1.1		FIX: Fixed checked mark drawn outside checkboxes
--	enjxp_SimPassion	05.26.2019		1.1.0		ADD: Z_2D_XP EFB Launch compatible with "B737-800X", "737-700U" and "737-900U"
--	enjxp_SimPassion	05.20.2019		1.0.9		ADD: Updated ASU Icons
--													ADD: Adding De-Icing Trucks Icons and Menu handling
--													FIX: Enhanced script comments for MENU pages
--	enjxp_SimPassion	04.19.2019		1.0.8		FIX: Removed and replaced OTF font not displaying on iPad
--													FIX: Check mark location moved for improved touch handling
--	enjxp_SimPassion	04.18.2019		1.0.7		ADD: External Air Start feature and button/icon handling
--	enjxp_SimPassion	04.02.2019		1.0.6		FIX: Previous fonts removed and new one added for a licensing concern
--													FIX: Text fields size adjusted accordingly
--	enjxp_SimPassion	02.22.2019		1.0.5		FIX: Better Z_2D_XP EFB Tablet Hide/Unhide handling
--													FIX: Enhanced FPS AVG computing
--													ADD: WIP : X-Plane load and Aircraft load detection
--	enjxp_SimPassion	01.27.2019		1.0.4a		ADD: Adding Page #12 for SWITCHES STATE PRESETS added in 3.32e Beta 5
--													FIX: Increase size of edges buttons for touch
--													ADD: Adding FPS handling
--													ADD: Adding Newly designed bitmaps from recent ZiboMod release
--													FIX: Reduced green Titles and Icons intensity for better comfort during night flights
--	enjxp_SimPassion	10.22.2018		1.0.4		FIX: Instrument launch enhancement
--													FIX: Buttons visibility on launch enhancement
--													FIX: Comments enhancement
--													FIX: Re organize launch section
--													ADD: Original 3D Tablet graphics included thanks to kind authorization from Zibo
--													FIX: Constants created for buttons location
--													FIX: Left and Right Arrows buttons relocated.
--													FIX: Back and Credits buttons moved on the same line
--	enjxp_SimPassion	10.22.2018		1.0.3		FIX: img_bg updated
--													FIX: txt_add statements updated with "width" argument values, to follow new Air Manager handling
--													ADD: Added INIT SECTION
--													FIX: Removed 'at' char in "local ZiboProject_Builders" value, to be able to post on x-plane.org without issue
--													ADD: Authoring and preambule section updated
--													ADD: Release section updated
--													FIX: Reduced debug text size from 40 to 30
--													ADD: Text warning and related style added for Avitab page
--	enjxp_SimPassion	10.20.2018		1.0.2		FIX: Debug Text field moving
--	enjxp_SimPassion	10.20.2018		1.0.1		ADD: Custom debug values
--	enjxp_SimPassion	10.18.2018		1.0.0		Initial release

--======================================================================================
--								SCRIPT START
--======================================================================================

----------------------------------------
--				INIT SECTION
----------------------------------------

--	DEBUG MODE

-- http://siminnovations.com/wiki/index.php?title=Log

--log("INFO","Z_2D_XP EFB v"..instrument_prop("VERSION"))

local setdebug				= false	-- default value to disable debug mode
-- local setdebug				= true	-- default value to enable debug mode

--	CONSTANTS

-- 1634 / 880 = 1.857
-- 1260 / 600 = 2.1

local x_width				= 1634							-- Z_2D_XP EFB Window width
local y_height				= 1260							-- Z_2D_XP EFB Window height
local xbgratio				= x_width / 880
local ybgratio				= y_height / 600

local txt_height			= 65							-- Text lines height
local title_loc				= 90							-- Title line y location
local line_loc				= 235							-- First line y location
local line_start			= 80							-- Line x start location
local line_width			= x_width - (2 * line_start)	-- Line width

local aircraft_desc600		= "B736"
local aircraft_desc700		= "B737"
local aircraft_desc800		= "B738"
local aircraft_desc900		= "B739"

		-- PAYLOAD / FUEL DRAWING

local cg_memo				= 1133	-- CENTER = 1155	Approximatively CG RANGE = [0---77]	-- CG Position

		-- | SHIFT CG RANGE is -51 to 104 as allowed to be input without Error thrown |

local wt_memo				= 1266	-- LEFT = 1125	Range=143	Ratio=1.6628	for lbs		-- Wing Tank Fuel position			| Fuel 1 to 17 for Wings Tank |
local ct_memo				= 1216	-- LEFT = 1115	Range=101	Ratio=3.6607	for lbs		-- Center Tank Fuel position		| Fuel 18 to 45 for Center Tank |
	
local info_pos				= -300	-- INFO Page default Y position
	
		-- Buttons size

local x_btn					= 350	-- buttons width
local y_btn					= 306	-- buttons height

		-- Doors status

local x_drst				= 176	-- status width
local y_drst				= 50	-- status height

		-- Doors gap

local x_drgp				= 88	-- gap width
local y_drgp				= 220	-- gap height
	
		-- Buttons location	
	
local c1_btn				=   75	-- button #1 column
local c2_btn				=  455	-- button #2 column
local c3_btn				=  835	-- button #3 column
local c4_btn				= 1215	-- button #4 column
local l1_btn				=  200	-- buttons line #1
local l2_btn				=  526	-- buttons line #2

		-- Checkbox location	

local ckbx_c				= 1450

--	VARIABLES	
	
local power_state			= 0					-- Is Tablet Powered ON ?  | will be updated live, once x-plane launched and ZiboMod loaded
local boot_state			= 0						-- Is Tablet Booting ?
local max_time				= 20					-- Launch delay time in seconds
local memo_power			= 1						-- Save last power state on power switching
local avitab_pnl_en			= 0						-- avitab_pnl_en = 1 if any Avitab feature is Active else = 0
local credits_stripmode		= 0						-- Credits Strips mode only
local cred_pgmode		= 0						-- Credits Page mode
local arrows_state			= 0						-- Pages Arrows state
--local flight_run = 0								-- current X-Plane running time
local flight_run_memo		= 0						-- X-Plane running time backup
local xplane_aircraft_memo	= "Not selected"		-- X-Plane running Aircraft description backup
local xplane_version_memo	= 0						-- X-Plane current Version backup
local str_aircraft_desc		= "Boeing 737-n00X/U"
local aircraft_selected		= 0

tablet_show					= 1						-- toggle the Z_2D_XP EFB visibility -- Now handled using a dedicated Panel Layout

local FPS					= 0
local FPS_num				= 0
local FPS_min				= 10000
local FPS_MAX				= 0
local FPS_avg				= 0
local FPS_int				= 0
local gbl_startupr			= 0
local str_Z_2D_XP_EFBTitle	= Title.." v"..Z_2D_XP_EFB.." "..InitialAuthor.." "..Date_Release
-- local str_Z_2D_XP_EFBTitle	= Title.." - "..InitialAuthor
local str_Z_2D_XP_EFBFPS	= ""
local linbx					= 60
local flightrunning			= 0

-- Compute CG Envelope Coordinates

	-- x,y = 0,0 = 269,461	|	x,y = 40,80 = 632,94
	--	[x = 0 | 269]	...		632		gap = 363
	--	[y = 0 | 461]	...		94		gap = 367

	-- oew_cg		range 0  .. 40 [% MAC] (if 0 then OEW is not displayed) - shift x coordinate
	-- oew_weight	range 40 .. 80 [kg] (always in kg) - shift y coordinate
	-- oew_str			string - text for OEW
	-- tow_cg		range 0  .. 40 [% MAC] (if 0 then TOW is not displayed) - shift x coordinate
	-- tow_weight	range 40 .. 80 [kg] (always in kg) - shift y coordinate
	-- tow_str			string - text for TOW
	-- zfw_cg		range 0  .. 40 [% MAC] (if 0 then ZFW is not displayed) - shift x coordinate
	-- zfw_weight	range 40 .. 80 [kg] (always in kg) - shift y coordinate
	-- zfw_str			string - text for ZFW
	-- lw_cg		range 0  .. 40 [% MAC] (if 0 then LW is not displayed) - shift x coordinate
	-- lw_weight	range 40 .. 80 [kg] (always in kg) - shift y coordinate
	-- lw_str			string - text for LW

local cgxratio = 363 / 41
local cgyratio = 367 / 40

function pr_x_cgenv(x)
	x = math.floor((441 + (cgxratio * x)) * xbgratio)
	return x
end

function pr_y_cgenv(y)
	y = math.floor((461 - cgyratio * (y -40)) * ybgratio)
	return y
end


----------------------------------------
--EFB XP12 Texture Stream
----------------------------------------

local stream_width = 1680
local stream_height = 1190

video_stream_id = video_stream_add("xpl/gauges[1]", 0, 0, stream_width, stream_height, 1157, 11, 873, 593)

----------------------------------------
--				TEXT STYLES
----------------------------------------

-- TEXT STYLES USED BY TEXT FIELDS

font0		= "arimo_regular"
font1		= "arimo_bold"
font2		= "inconsolata_bold"
font3		= "inconsolata_regular"
font4		= "digital-7-mono"
font5		= "roboto_bold"
font6		= "roboto_regular"
font7		= "futrfw"
font8		= "futura_medium_condensed_bt"
font9		= "boeing-style"

size1		= 25
size2		= 30
size3		= 35
size4		= 40
size5		= 45
size6		= 60
size6i		= 64
size7		= 67
size8		= 80

-- B737-800X Color Scheme

color01		= "#000000"				-- BLACK
color02		= "#00AA00"				-- GREEN
color03		= "#999999"				-- DARK
color04		= "#BBBBBB"				-- DARK GREY
color05		= "#CC8800"				-- AMBER
color06		= "#CCCCCC"				-- MEDIUM GREY
color07		= "#936C1C"				-- AMBER DARK
color08		= "#FFFF00"				-- YELLOW
color09		= "#FFFFFF"				-- WHITE
color10		= "#108FAF"				-- CYAN
color11		= "#315EA5"				-- MEDIUM BLUE
-- color07		= "#FFAA00"				-- AMBER BRIGHT
-- color10		= "#2870AD"				-- BLUE
-- color11		= "#345290"				-- MEDIUM BLUE #2

style_0_w	= "font:"..font1..".ttf; size:"..size5.."; color:"..color03.."; halign:left;"
style_1_w	= "font:"..font2..".ttf; size:"..size7.."; color:"..color04.."; halign:left;"
style_1_c	= "font:"..font2..".ttf; size:"..size7.."; color:"..color10.."; halign:left;"
style_2_bs	= "font:"..font2..".ttf; size:"..size6i.."; color:"..color11.."; halign:left;"
style_2_ws	= "font:"..font2..".ttf; size:"..size6i.."; color:"..color04.."; halign:left;"
style_3_a	= "font:"..font2..".ttf; size:"..size7.."; color:"..color07.."; halign:left;"
style_4_cs	= "font:"..font2..".ttf; size:"..size6i.."; color:"..color10.."; halign:left;"
style_5_g	= "font:"..font2..".ttf; size:"..size7.."; color:"..color02.."; halign:left;"

style_1t_w	= "font:"..font2..".ttf; size:"..size7.."; color:"..color04.."; halign:center;"
style_1t_g	= "font:"..font2..".ttf; size:"..size7.."; color:"..color02.."; halign:center;"
style_1t_c	= "font:"..font2..".ttf; size:"..size7.."; color:"..color10.."; halign:center;"
style_7_w	= "font:"..font1..".ttf; size:"..size3.."; color:"..color03.."; halign:center;"
style_9_w	= "font:"..font3..".ttf; size:"..size4.."; color:"..color09.."; halign:left;"
style_f_w	= "font:"..font8..".ttf; size:"..size6.."; color:"..color06.."; halign:left;"
style_g_w	= "font:"..font9..".ttf; size:"..size3.."; color:"..color04.."; halign:left;"
style_5_a	= "font:"..font2..".ttf; size:"..size2.."; color:"..color07.."; halign:left;"
style_8_a	= "font:"..font2..".ttf; size:"..size1.."; color:"..color05.."; halign:left;"
style_3_dg	= "font:"..font4..".ttf; size:"..size8.."; color:"..color04.."; halign:right;"
style_4_mg	= "font:"..font4..".ttf; size:"..size4.."; color:"..color06.."; halign:left;"
style_e_mg	= "font:"..font7..".ttf; size:"..size2.."; color:"..color06.."; halign:left;"
style_h_mg	= "font:"..font7..".ttf; size:"..size4.."; color:"..color06.."; halign:left;"
style_a_g	= "font:"..font3..".ttf; size:"..size4.."; color:"..color02.."; halign:left;"
style_c_bk	= "font:"..font2..".ttf; size:"..size4.."; color:"..color01.."; halign:left;"
style_b_y	= "font:"..font3..".ttf; size:"..size4.."; color:"..color08.."; halign:left;"
style_6_y	= "font:"..font2..".ttf; size:"..size8.."; color:"..color08.."; halign:center;"

----------------------------------------
--				IMAGES
----------------------------------------

-- Black Background image when Tablet is powered OFF

img_bk = img_add("black_bg.png",0,0,x_width,y_height) visible(img_bk,true)

-- Background image when Tablet is powered ON

img_bg = img_add("background.png",0,0,x_width,y_height) visible(img_bg,false)

-- X-Plane and Aircraft status images

img_xprunning_bg		= img_add("status_xp.png",0,190,x_width,881) visible(img_xprunning_bg,false)
img_acft_status			= img_add("status_aircraft.png",0,190,x_width,881) visible(img_acft_status,false)
img_not_xp_status		= img_add("not_xp_status.png",0,190,x_width,881)	visible(img_not_xp_status,false)			-- Original size : 2560 x 1440
img_not_aircraft_status	= img_add("not_aircraft_status.png",417,415,800,431) visible(img_not_aircraft_status,false)		-- Original size : 2560 x 1440

-- MENU PAGES BUTTONS

-- MENU 1 PAGE 1 BUTTONS	--	MAIN MENU 1/2

img_m_1_1_1		= img_add("announc-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_1_1_1,false)				-- where with img_m_1_3_2	: m = menu (to identify variable group in this script)  1 = laminar/B738/tab/menu_page | 3 = laminar/B738/tab/page | 2 = buttons#/8
img_m_1_1_2_1	= img_add("flight_leg_end-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_1_1_2_1,false)	-- with img_m_1_1_2_1 and 1_1_2_2 : two different pictures for the same button depending on state
img_m_1_1_2_2	= img_add("flight_leg_start-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_1_1_2_2,false)
img_m_1_1_3_1	= img_add("cargo_load_end-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_1_1_3_1,false)	-- buttons are located as follow		1	2	3	4
img_m_1_1_3_2	= img_add("cargo_load_start-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_1_1_3_2,false)	--										5	6	7	8
img_m_1_1_4		= img_add("fuel-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_1_1_4,false)
img_m_1_1_5		= img_add("checklist-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_1_1_5,false)
img_m_1_1_6		= img_add("ground_services-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_1_1_6,false)
img_m_1_1_7		= img_add("avitab-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_1_1_7,false)
img_m_1_1_8		= img_add("load_save-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_1_1_8,false)

-- MENU 1 PAGE 2 BUTTONS	--	MAIN MENU 2/2

img_m_1_2_1		= img_add("settings-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_1_2_1,false)
img_m_1_2_4		= img_add("failures-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_1_2_4,false)

-- MENU 2 PAGE 1 BUTTONS	--	SETTINGS AND FEATURES

img_m_2_1_1		= img_add("optional-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_2_1_1,false)
img_m_2_1_2		= img_add("hardware-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_2_1_2,false)
img_m_2_1_3		= img_add("realism-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_2_1_3,false)
img_m_2_1_4		= img_add("visual-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_2_1_4,false)
img_m_2_1_5		= img_add("config-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_2_1_5,false)
img_m_2_1_6		= img_add("features-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_2_1_6,false)
img_m_2_1_7		= img_add("volume-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_2_1_7,false)
img_m_2_1_8		= img_add("calibration-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_2_1_8,false)

-- MENU 3 PAGE 1 BUTTONS	--	ANNOUNCEMENTS

img_m_3_1_1		= img_add("welcome-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_3_1_1,false)
img_m_3_1_2		= img_add("cruise-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_3_1_2,false)
img_m_3_1_3		= img_add("descent-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_3_1_3,false)
img_m_3_1_4		= img_add("preland-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_3_1_4,false)
img_m_3_1_5		= img_add("turbulence-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_3_1_5,false)
img_m_3_1_8		= img_add("ann_settings-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_3_1_8,false)

-- MENU 4 PAGE 1 BUTTONS	--	CHECKLIST 1/3

img_m_4_1_1		= img_add("prelim_preflight-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_4_1_1,false)
img_m_4_1_2		= img_add("cdu_preflight-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_4_1_2,false)
img_m_4_1_3		= img_add("cpt_preflight-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_4_1_3,false)
img_m_4_1_4		= img_add("fo_preflight-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_4_1_4,false)
img_m_4_1_5		= img_add("before_start-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_4_1_5,false)
img_m_4_1_6		= img_add("pushback-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_4_1_6,false)
img_m_4_1_7		= img_add("eng_start-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_4_1_7,false)
img_m_4_1_8		= img_add("before_taxi-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_4_1_8,false)

-- MENU 4 PAGE 2 BUTTONS	--	CHECKLIST 2/3

img_m_4_2_1		= img_add("takeoff-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_4_2_1,false)
img_m_4_2_2		= img_add("climb_cruise-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_4_2_2,false)
img_m_4_2_3		= img_add("descent_cl-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_4_2_3,false)
img_m_4_2_4		= img_add("approach-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_4_2_4,false)
img_m_4_2_5		= img_add("landing_ils-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_4_2_5,false)
img_m_4_2_6		= img_add("landing_ian-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_4_2_6,false)
img_m_4_2_7		= img_add("landing_vnav-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_4_2_7,false)
img_m_4_2_8		= img_add("goaround-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_4_2_8,false)

-- MENU 4 PAGE 3 BUTTONS	--	CHECKLIST 3/3

img_m_4_3_1		= img_add("after_landing-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_4_3_1,false)
img_m_4_3_2		= img_add("shutdown-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_4_3_2,false)
img_m_4_3_3		= img_add("secure-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_4_3_3,false)

-- MENU 5 PAGE 1 BUTTONS	--	LOAD / SAVE

img_m_5_1_1		= img_add("config_audio-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_5_1_1,false)
img_m_5_1_2		= img_add("config_presets-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_5_1_2,false)
img_m_5_1_3		= img_add("audio_presets-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_5_1_3,false)
img_m_5_1_4		= img_add("state_presets-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_5_1_4,false)
img_m_5_1_5		= img_add("reset_cfg_audio-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_5_1_5,false)
img_m_5_1_6		= img_add("reset_cfg-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_5_1_6,false)
img_m_5_1_7		= img_add("load_autoflt-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_5_1_7,false)
img_m_5_1_8		= img_add("load_save_flt-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_5_1_8,false)

-- MENU 6 PAGE 1 BUTTONS	--	LOAD/SAVE CONFIG PRESETS

img_m_6_1_1		= img_add("load_cfg_preset1-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_6_1_1,false)
img_m_6_1_2		= img_add("load_cfg_preset2-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_6_1_2,false)
img_m_6_1_3		= img_add("load_cfg_preset3-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_6_1_3,false)
img_m_6_1_4		= img_add("load_cfg_preset4-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_6_1_4,false)
img_m_6_1_5		= img_add("save_cfg_preset1-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_6_1_5,false)
img_m_6_1_6		= img_add("save_cfg_preset2-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_6_1_6,false)
img_m_6_1_7		= img_add("save_cfg_preset3-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_6_1_7,false)
img_m_6_1_8		= img_add("save_cfg_preset4-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_6_1_8,false)

-- MENU 7 PAGE 1 BUTTONS	--	LOAD/SAVE AUDIO PRESETS

img_m_7_1_1		= img_add("load_audio_preset1-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_7_1_1,false)
img_m_7_1_2		= img_add("load_audio_preset2-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_7_1_2,false)
img_m_7_1_3		= img_add("load_audio_preset3-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_7_1_3,false)
img_m_7_1_4		= img_add("load_audio_preset4-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_7_1_4,false)
img_m_7_1_5		= img_add("save_audio_preset1-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_7_1_5,false)
img_m_7_1_6		= img_add("save_audio_preset2-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_7_1_6,false)
img_m_7_1_7		= img_add("save_audio_preset3-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_7_1_7,false)
img_m_7_1_8		= img_add("save_audio_preset4-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_7_1_8,false)

-- MENU 9 PAGE 1 BUTTONS	--	GROUND SERVICES

img_m_9_1_1_1	= img_add("gpu_disconnect-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_9_1_1_1,false)
img_m_9_1_1_2	= img_add("gpu_connect-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_9_1_1_2,false)
img_m_9_1_2_1	= img_add("chocks_off-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_9_1_2_1,false)
img_m_9_1_2_2	= img_add("chocks_on-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_9_1_2_2,false)
img_m_9_1_3		= img_add("better_pushback-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_9_1_3,false)
img_m_9_1_4_1	= img_add("ext_air_disconnect-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_9_1_4_1,false)
img_m_9_1_4_2	= img_add("ext_air_connect-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_9_1_4_2,false)
img_m_9_1_5_1	= img_add("de_icing_start-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_9_1_5_1,false)
img_m_9_1_5_2	= img_add("de_icing_stop-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_9_1_5_2,false)
img_m_9_1_6_1	= img_add("airstairs_dn-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_9_1_6_1,false)
img_m_9_1_6_2	= img_add("airstairs_up-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_9_1_6_2,false)
img_m_9_1_7		= img_add("doors-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_9_1_7,false)
img_m_9_1_8		= img_add("lighting-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_9_1_8,false)

-- MENU 10 PAGE 1 BUTTONS	--	BETTER PUSHBACK

img_m_10_1_1	= img_add("bp_preplan-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_10_1_1,false)
img_m_10_1_2	= img_add("bp_start-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_10_1_2,false)
img_m_10_1_3	= img_add("bp_disconnect-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_10_1_3,false)
img_m_10_1_4	= img_add("bp_reconnect-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_10_1_4,false)
img_m_10_1_5	= img_add("bp_stop-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_10_1_5,false)

-- MENU 11 PAGE 1 BUTTONS	--	AVITAB

img_m_11_1_1	= img_add("avitab_charts-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_11_1_1,false)
img_m_11_1_2	= img_add("avitab_apt-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_11_1_2,false)
img_m_11_1_3	= img_add("avitab_routes-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_11_1_3,false)
img_m_11_1_4	= img_add("avitab_map-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_11_1_4,false)
img_m_11_1_8	= img_add("avitab_credits-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_11_1_8,false)

-- MENU 12 PAGE 1 BUTTONS	--	SWITCHES STATE PRESETS

img_m_12_1_1	= img_add("reset_cd-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_12_1_1,false)
img_m_12_1_2	= img_add("reset_ta-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_12_1_2,false)
img_m_12_1_3	= img_add("load_p1-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_12_1_3,false)
img_m_12_1_4	= img_add("load_p2-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_12_1_4,false)
img_m_12_1_5	= img_add("save_cd-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_12_1_5,false)
img_m_12_1_6	= img_add("save_ta-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_12_1_6,false)
img_m_12_1_7	= img_add("save_p1-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_12_1_7,false)
img_m_12_1_8	= img_add("save_p2-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_12_1_8,false)

-- MENU 13 PAGE 1 BUTTONS	--	FAILURES

img_m_13_1_1	= img_add("failures_elec-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_13_1_1,false)
img_m_13_1_2	= img_add("failures_hyd-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_13_1_2,false)
img_m_13_1_3	= img_add("failures_sys-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_13_1_3,false)
img_m_13_1_4	= img_add("failures_pressure-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_13_1_4,false)
img_m_13_1_5	= img_add("failures_eng-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_13_1_5,false)							-- Added from 3_51_15
img_m_13_1_6	= img_add("failures_enable_rnd-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_13_1_6,false)					-- Added from 3_51_15
img_m_13_1_7	= img_add("failures_disable_rnd-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_13_1_7,false)					-- Added from 3_51_15
img_m_13_1_8_0	= img_add("failures_fix_all_off-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_13_1_8_0,false)
img_m_13_1_8_1	= img_add("failures_fix_all-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_13_1_8_1,false)
img_m_13_1_8_2	= img_add("failures_fix_all2-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_13_1_8_2,false)

-- MENU 14 PAGE 1 BUTTONS	--	FUEL, PAYLOAD, CG, OPT

img_m_14_1_1	= img_add("payload-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_14_1_1,false)
img_m_14_1_2	= img_add("perf_takeoff-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_14_1_2,false)
img_m_14_1_3	= img_add("perf_landing-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_14_1_3,false)
img_m_14_1_4	= img_add("approach_rating-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_14_1_4,false)
img_m_14_1_5_1	= img_add("fueltruck_call-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_14_1_5_1,false)
img_m_14_1_5_2	= img_add("fueltruck_cancel-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_14_1_5_2,false)

-- MENU 15 PAGE 1 BUTTONS	--	LOAD / SAVE FLIGHT Page #1

img_m_15_1_1	= img_add("load_flt_01-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_15_1_1,false)
img_m_15_1_2	= img_add("load_flt_02-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_15_1_2,false)
img_m_15_1_3	= img_add("load_flt_03-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_15_1_3,false)
img_m_15_1_4	= img_add("load_flt_04-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_15_1_4,false)
img_m_15_1_5	= img_add("save_flt_01-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_15_1_5,false)
img_m_15_1_6	= img_add("save_flt_02-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_15_1_6,false)
img_m_15_1_7	= img_add("save_flt_03-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_15_1_7,false)
img_m_15_1_8	= img_add("save_flt_04-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_15_1_8,false)

-- MENU 15 PAGE 2 BUTTONS	--	LOAD / SAVE FLIGHT Page #2

img_m_15_2_1	= img_add("load_flt_05-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_15_2_1,false)
img_m_15_2_2	= img_add("load_flt_06-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_15_2_2,false)
img_m_15_2_3	= img_add("load_flt_07-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_15_2_3,false)
img_m_15_2_4	= img_add("load_flt_08-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_15_2_4,false)
img_m_15_2_5	= img_add("save_flt_05-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_15_2_5,false)
img_m_15_2_6	= img_add("save_flt_06-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_15_2_6,false)
img_m_15_2_7	= img_add("save_flt_07-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_15_2_7,false)
img_m_15_2_8	= img_add("save_flt_08-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_15_2_8,false)

-- MENU 16 PAGE 1 BUTTONS	--	DISPLAYS AND VARIANTS

img_m_16_1_1	= img_add("exterior-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_16_1_1,false)
img_m_16_1_2	= img_add("systems-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_16_1_2,false)
img_m_16_1_3	= img_add("displays-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_16_1_3,false)
img_m_16_1_4	= img_add("fms-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_16_1_4,false)
img_m_16_1_5	= img_add("autoflight-1.png",c1_btn,l2_btn,x_btn,y_btn) visible(img_m_16_1_5,false)
img_m_16_1_6	= img_add("callouts-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_16_1_6,false)
img_m_16_1_7	= img_add("placards-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_16_1_7,false)

-- MENU 17 PAGE 1 BUTTONS	--	DOORS STATUS/COMMANDS

img_m_17_1_2	= img_add("fwd_entry-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_17_1_2,false)
img_m_17_1_3	= img_add("fwd_service-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_17_1_3,false)
img_m_17_1_4	= img_add("fwd_cargo-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_17_1_4,false)
img_m_17_1_6	= img_add("aft_entry-1.png",c2_btn,l2_btn,x_btn,y_btn) visible(img_m_17_1_6,false)
img_m_17_1_7	= img_add("aft_service-1.png",c3_btn,l2_btn,x_btn,y_btn) visible(img_m_17_1_7,false)
img_m_17_1_8	= img_add("aft_cargo-1.png",c4_btn,l2_btn,x_btn,y_btn) visible(img_m_17_1_8,false)

-- MENU 17 PAGE 2 BUTTONS	--	DOORS STATUS/COMMANDS

img_m_17_2_1	= img_add("lt_fwd_wing-1.png",c1_btn,l1_btn,x_btn,y_btn) visible(img_m_17_2_1,false)
img_m_17_2_2	= img_add("lt_aft_wing-1.png",c2_btn,l1_btn,x_btn,y_btn) visible(img_m_17_2_2,false)
img_m_17_2_3	= img_add("rt_fwd_wing-1.png",c3_btn,l1_btn,x_btn,y_btn) visible(img_m_17_2_3,false)
img_m_17_2_4	= img_add("rt_aft_wing-1.png",c4_btn,l1_btn,x_btn,y_btn) visible(img_m_17_2_4,false)

-- MENU 17 PAGE 1 STATUS	--	DOORS STATUS/COMMANDS

img_m_17_1_2_cl = img_add("door_close-1.png",c2_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_2_cl,false)
img_m_17_1_3_cl = img_add("door_close-1.png",c3_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_3_cl,false)
img_m_17_1_4_cl = img_add("door_close-1.png",c4_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_4_cl,false)
img_m_17_1_6_cl = img_add("door_close-1.png",c2_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_6_cl,false)
img_m_17_1_7_cl = img_add("door_close-1.png",c3_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_7_cl,false)
img_m_17_1_8_cl = img_add("door_close-1.png",c4_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_8_cl,false)

img_m_17_1_2_mv = img_add("door_moving-1.png",c2_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_2_mv,false)
img_m_17_1_3_mv = img_add("door_moving-1.png",c3_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_3_mv,false)
img_m_17_1_4_mv = img_add("door_moving-1.png",c4_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_4_mv,false)
img_m_17_1_6_mv = img_add("door_moving-1.png",c2_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_6_mv,false)
img_m_17_1_7_mv = img_add("door_moving-1.png",c3_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_7_mv,false)
img_m_17_1_8_mv = img_add("door_moving-1.png",c4_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_8_mv,false)

img_m_17_1_2_op = img_add("door_open-1.png",c2_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_2_op,false)
img_m_17_1_3_op = img_add("door_open-1.png",c3_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_3_op,false)
img_m_17_1_4_op = img_add("door_open-1.png",c4_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_4_op,false)
img_m_17_1_6_op = img_add("door_open-1.png",c2_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_6_op,false)
img_m_17_1_7_op = img_add("door_open-1.png",c3_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_7_op,false)
img_m_17_1_8_op = img_add("door_open-1.png",c4_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_8_op,false)

img_m_17_1_2_wn = img_add("warn-1.png",c2_btn+x_drgp+x_drst,l1_btn+y_drgp,y_drst,y_drst) visible(img_m_17_1_2_wn,false)
img_m_17_1_3_wn = img_add("warn-1.png",c3_btn+x_drgp+x_drst,l1_btn+y_drgp,y_drst,y_drst) visible(img_m_17_1_3_wn,false)
img_m_17_1_4_wn = img_add("warn-1.png",c4_btn+x_drgp+x_drst,l1_btn+y_drgp,y_drst,y_drst) visible(img_m_17_1_4_wn,false)
img_m_17_1_6_wn = img_add("warn-1.png",c2_btn+x_drgp+x_drst,l2_btn+y_drgp,y_drst,y_drst) visible(img_m_17_1_6_wn,false)
img_m_17_1_7_wn = img_add("warn-1.png",c3_btn+x_drgp+x_drst,l2_btn+y_drgp,y_drst,y_drst) visible(img_m_17_1_7_wn,false)
img_m_17_1_8_wn = img_add("warn-1.png",c4_btn+x_drgp+x_drst,l2_btn+y_drgp,y_drst,y_drst) visible(img_m_17_1_8_wn,false)

img_m_17_1_2_lk = img_add("door_locked-1.png",c2_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_2_lk,false)
img_m_17_1_3_lk = img_add("door_locked-1.png",c3_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_3_lk,false)
img_m_17_1_4_lk = img_add("door_locked-1.png",c4_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_4_lk,false)
img_m_17_1_6_lk = img_add("door_locked-1.png",c2_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_6_lk,false)
img_m_17_1_7_lk = img_add("door_locked-1.png",c3_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_7_lk,false)
img_m_17_1_8_lk = img_add("door_locked-1.png",c4_btn+x_drgp,l2_btn+y_drgp,x_drst,y_drst) visible(img_m_17_1_8_lk,false)

-- MENU 17 PAGE 2 STATUS	--	DOORS STATUS/COMMANDS

img_m_17_2_1_cl = img_add("door_close-1.png",c1_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_1_cl,false)
img_m_17_2_2_cl = img_add("door_close-1.png",c2_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_2_cl,false)
img_m_17_2_3_cl = img_add("door_close-1.png",c3_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_3_cl,false)
img_m_17_2_4_cl = img_add("door_close-1.png",c4_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_4_cl,false)

img_m_17_2_1_mv = img_add("door_moving-1.png",c1_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_1_mv,false)
img_m_17_2_2_mv = img_add("door_moving-1.png",c2_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_2_mv,false)
img_m_17_2_3_mv = img_add("door_moving-1.png",c3_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_3_mv,false)
img_m_17_2_4_mv = img_add("door_moving-1.png",c4_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_4_mv,false)

img_m_17_2_1_op = img_add("door_open-1.png",c1_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_1_op,false)
img_m_17_2_2_op = img_add("door_open-1.png",c2_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_2_op,false)
img_m_17_2_3_op = img_add("door_open-1.png",c3_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_3_op,false)
img_m_17_2_4_op = img_add("door_open-1.png",c4_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_4_op,false)

img_m_17_2_1_wn = img_add("warn-1.png",c1_btn+x_drgp+x_drst,l1_btn+y_drgp,y_drst,y_drst) visible(img_m_17_2_1_wn,false)
img_m_17_2_2_wn = img_add("warn-1.png",c2_btn+x_drgp+x_drst,l1_btn+y_drgp,y_drst,y_drst) visible(img_m_17_2_2_wn,false)
img_m_17_2_3_wn = img_add("warn-1.png",c3_btn+x_drgp+x_drst,l1_btn+y_drgp,y_drst,y_drst) visible(img_m_17_2_3_wn,false)
img_m_17_2_4_wn = img_add("warn-1.png",c4_btn+x_drgp+x_drst,l1_btn+y_drgp,y_drst,y_drst) visible(img_m_17_2_4_wn,false)

img_m_17_2_1_lk = img_add("door_locked-1.png",c1_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_1_lk,false)
img_m_17_2_2_lk = img_add("door_locked-1.png",c2_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_2_lk,false)
img_m_17_2_3_lk = img_add("door_locked-1.png",c3_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_3_lk,false)
img_m_17_2_4_lk = img_add("door_locked-1.png",c4_btn+x_drgp,l1_btn+y_drgp,x_drst,y_drst) visible(img_m_17_2_4_lk,false)

-- CREDITS IMAGES

-- FullScreen Images

img_cred1		= img_add("credits_large_1-1.png",0,0,x_width,y_height) visible(img_cred1,false)
img_cred2		= img_add("credits_large_2-1.png",0,0,x_width,y_height) visible(img_cred2,false)
img_cred3		= img_add("credits_large_3-1.png",0,0,x_width,y_height) visible(img_cred3,false)
img_cred4		= img_add("credits_large_4-1.png",0,0,x_width,y_height) visible(img_cred4,false)
img_cred5		= img_add("credits_strip_4-1.png",0,870,x_width,185) visible(img_cred5,false)

-- Strip Images

img_credstrip1	= img_add("credits_strip_1-1.png",0,870,x_width,185) visible(img_credstrip1,false)
img_credstrip2	= img_add("credits_strip_2-1.png",0,870,x_width,185) visible(img_credstrip2,false)
img_credstrip3	= img_add("credits_strip_3-1.png",0,870,x_width,185) visible(img_credstrip3,false)
img_credstrip4	= img_add("credits_strip_4-1.png",0,870,x_width,185) visible(img_credstrip4,false)
img_credstrip5	= img_add("credits_strip_5-1.png",0,870,x_width,185) visible(img_credstrip5,false)

-- ============================================================================================

-- These following 3 images set should not be re ordered, to properly fit specific layer order

-- UFiles

img_credstrip4m_bg	= img_add("credits_unsupport.png",0,940,x_width,185) visible(img_credstrip4m_bg,false)
img_credstrip4m		= img_add("credits_unsupport-1.png",0,940,x_width,185) visible(img_credstrip4m,false)

-- Experimental Flight Model

img_credstrip5m_bg	= img_add("credits_fm_experimental.png",0,940,x_width,185) visible(img_credstrip5m_bg,false)
img_credstrip5m		= img_add("credits_fm_experimental-1.png",0,940,x_width,185) visible(img_credstrip5m,false)

-- Custom Navdata

img_credstrip6m_bg	= img_add("custom_navdata.png",0,940,x_width,185) visible(img_credstrip6m_bg,false)
img_credstrip6m		= img_add("custom_navdata-1.png",0,940,x_width,185) visible(img_credstrip6m,false)

-- Vanish y value

img_credstrip7m_bg	= img_add("custom_navdata.png",0,940,x_width,185) visible(img_credstrip7m_bg,false)
img_credstrip7m		= img_add("credits_restart_xp-1.png",0,940,x_width,185) visible(img_credstrip7m,false)

-- ============================================================================================

------------------------------------------------
--			FUEL/PAYLOAD/CG ENVELOPE/PERFS PAGE
------------------------------------------------

img_aircraft_bg		= img_add("fuel_bgnd-1.png",0,0,x_width,y_height) visible(img_aircraft_bg,false)
img_aircraft_wgr	= img_add("fuel_fill_wing-1.png",1125,315,150,150) visible(img_aircraft_wgr,false)
img_aircraft_ctr	= img_add("fuel_fill_ctr-1.png",1115,469,200,106) visible(img_aircraft_ctr,false)
img_aircraft_wgl	= img_add("fuel_fill_wing-1.png",1125,581,150,148) visible(img_aircraft_wgl,false)
img_aircraft_tk		= img_add("fuel_bgnd2-1.png",0,0,x_width,y_height) visible(img_aircraft_tk,false)
img_aircraft_cg		= img_add("cg-1.png",1155,500,44,44) visible(img_aircraft_cg,false)
img_pldzone_bg		= img_add("zone_bgnd-1.png",0,0,x_width,y_height) visible(img_pldzone_bg,false)
img_cgenvkg_bg		= img_add("cg_kg_bgnd-1.png",0,0,x_width,y_height) visible(img_cgenvkg_bg,false)
img_cgenvlb_bg		= img_add("cg_lb_bgnd-1.png",0,0,x_width,y_height) visible(img_cgenvlb_bg,false)
img_c_lw_bg			= img_add("lw-1.png",0,0,20*ybgratio,20*ybgratio) visible(img_c_lw_bg,false)
img_c_oew_bg		= img_add("oew-1.png",0,0,20*ybgratio,20*ybgratio) visible(img_c_oew_bg,false)
img_c_zfw_bg		= img_add("oew-1.png",0,0,20*ybgratio,20*ybgratio) visible(img_c_zfw_bg,false)
img_c_tow_bg		= img_add("tow-1.png",0,0,20*ybgratio,20*ybgratio) visible(img_c_tow_bg,false)
img_p_to_bg			= img_add("perf_to_bgnd-1.png",	0,0,x_width,y_height) visible(img_p_to_bg,false)
img_p_lnd_bg		= img_add("perf_land_bgnd-1.png",	0,0,x_width,y_height) visible(img_p_lnd_bg,false)
txt_lw_bg			= txt_add("", style_c_bk, 0, 0, 400, 40) visible(txt_lw_bg,false)
txt_oew_bg			= txt_add("", style_c_bk, 0, 0, 400, 40) visible(txt_oew_bg,false)
txt_zfw_bg			= txt_add("", style_c_bk, 0, 0, 400, 40) visible(txt_zfw_bg,false)
txt_tow_bg			= txt_add("", style_c_bk, 0, 0, 400, 40) visible(txt_tow_bg,false)
txt_lw				= txt_add("", style_a_g, 0, 0, 400, 40) visible(txt_lw,false)
txt_oew				= txt_add("", style_b_y, 0, 0, 400, 40) visible(txt_oew,false)
txt_zfw				= txt_add("", style_b_y, 0, 0, 400, 40) visible(txt_zfw,false)
txt_tow				= txt_add("", style_9_w, 0, 0, 400, 40) visible(txt_tow,false)

		-- PERFS Pages

-- Runway = 88 - 681 = 593

-- ORIGIN = 84 x 355
-- AD ORIGIN = 14 x 355

img_p_brk_bg	= img_add("perf_brks_bgnd-1.png",	0,0,x_width,y_height) visible(img_p_brk_bg,false)
img_p_ad		= img_add("perf_ad-1.png",			0,0,112*xbgratio,128*ybgratio) visible(img_p_ad,false)
img_p_mm_i		= img_add("perf_mm-1.png",			0,0,32*xbgratio,128*ybgratio) visible(img_p_mm_i,false)
img_p_mm_o		= img_add("perf_mm_out-1.png",		0,0,32*xbgratio,128*ybgratio) visible(img_p_mm_o,false)
img_p_ma_i		= img_add("perf_ma-1.png",			0,0,32*xbgratio,128*ybgratio) visible(img_p_ma_i,false)
img_p_ma_o		= img_add("perf_ma_out-1.png",		0,0,32*xbgratio,128*ybgratio) visible(img_p_ma_o,false)
img_p_ab1_i		= img_add("perf_ab11-1.png",		0,0,32*xbgratio,128*ybgratio) visible(img_p_ab1_i,false)
img_p_ab1_o		= img_add("perf_ab11_out-1.png",	0,0,32*xbgratio,128*ybgratio) visible(img_p_ab1_o,false)
img_p_ab2_i		= img_add("perf_ab2-1.png",		0,0,32*xbgratio,128*ybgratio) visible(img_p_ab2_i,false)
img_p_ab2_o		= img_add("perf_ab2_out-1.png",	0,0,32*xbgratio,128*ybgratio) visible(img_p_ab2_o,false)
img_p_ab3_i		= img_add("perf_ab3-1.png",		0,0,32*xbgratio,128*ybgratio) visible(img_p_ab3_i,false)
img_p_ab3_o		= img_add("perf_ab3_out-1.png",	0,0,32*xbgratio,128*ybgratio) visible(img_p_ab3_o,false)
img_p_on_rw		= img_add("perf_on_rwy-1.png",		0,0,32,4) visible(img_p_on_rw,false)
img_p_out_rw	= img_add("perf_out_rwy-1.png",	0,0,32,4) visible(img_p_out_rw,false)

		-- LANDING RATE

lndrt = 0.7
img_p_lnd_rt0	= img_add("lr_0-1.png",	0,880,x_width,185) visible(img_p_lnd_rt0,false) opacity(img_p_lnd_rt0,lndrt)
img_p_lnd_rt1	= img_add("lr_1-1.png",	0,880,x_width,185) visible(img_p_lnd_rt1,false) opacity(img_p_lnd_rt1,lndrt)
img_p_lnd_rt2	= img_add("lr_2-1.png",	0,880,x_width,185) visible(img_p_lnd_rt2,false) opacity(img_p_lnd_rt2,lndrt)
img_p_lnd_rt3	= img_add("lr_3-1.png",	0,880,x_width,185) visible(img_p_lnd_rt3,false) opacity(img_p_lnd_rt3,lndrt)
img_p_lnd_rt4	= img_add("lr_4-1.png",	0,880,x_width,185) visible(img_p_lnd_rt4,false) opacity(img_p_lnd_rt4,lndrt)
img_p_lnd_rt5	= img_add("lr_5-1.png",	0,880,x_width,185) visible(img_p_lnd_rt5,false) opacity(img_p_lnd_rt5,lndrt)

		-- APPROACH RATE

apprrt = 0.7
img_p_appr_rt0	= img_add("ar_0-1.png",	0,880,x_width,185) visible(img_p_appr_rt0,false) opacity(img_p_appr_rt0,apprrt)
img_p_appr_rt1	= img_add("ar_1-1.png",	0,880,x_width,185) visible(img_p_appr_rt1,false) opacity(img_p_appr_rt1,apprrt)
img_p_appr_rt2	= img_add("ar_2-1.png",	0,880,x_width,185) visible(img_p_appr_rt2,false) opacity(img_p_appr_rt2,apprrt)
img_p_appr_rt3	= img_add("ar_3-1.png",	0,880,x_width,185) visible(img_p_appr_rt3,false) opacity(img_p_appr_rt3,apprrt)
img_p_appr_rt4	= img_add("ar_4-1.png",	0,880,x_width,185) visible(img_p_appr_rt4,false) opacity(img_p_appr_rt4,apprrt)
img_p_appr_rt5	= img_add("ar_5-1.png",	0,880,x_width,185) visible(img_p_appr_rt5,false) opacity(img_p_appr_rt5,apprrt)

----------------------------------------
--				TEXT SECTION
----------------------------------------

-- TEXT FIELDS : #9 text lines & Title on #00

lingap = 92
colgap = 30

-- #1 ITEMS - STD COLOR SCHEME - WHITE
txt_L00 = txt_add("", style_1t_w,  line_start, title_loc, line_width, txt_height)
txt_L01 = txt_add("", style_1_w,  line_start, line_loc, line_width, txt_height)
txt_L02 = txt_add("", style_1_w,  line_start, line_loc + lingap * 1, line_width, txt_height)
txt_L03 = txt_add("", style_1_w,  line_start, line_loc + lingap * 2, line_width, txt_height)
txt_L04 = txt_add("", style_1_w,  line_start, line_loc + lingap * 3, line_width, txt_height)
txt_L05 = txt_add("", style_1_w,  line_start, line_loc + lingap * 4, line_width, txt_height)
txt_L06 = txt_add("", style_1_w,  line_start, line_loc + lingap * 5, line_width, txt_height)
txt_L07 = txt_add("", style_1_w,  line_start, line_loc + lingap * 6, line_width, txt_height)
txt_L08 = txt_add("", style_1_w,  line_start, line_loc + lingap * 7, line_width, txt_height)
txt_L09 = txt_add("", style_1_w,  line_start, line_loc + lingap * 8, line_width, txt_height)

-- #3 ITEMS - HIGHLIGHT COLOR SCHEME - AMBER
txt_L01a = txt_add("", style_3_a,  line_start, line_loc, line_width, txt_height)
txt_L02a = txt_add("", style_3_a,  line_start, line_loc + lingap * 1, line_width, txt_height)
txt_L03a = txt_add("", style_3_a,  line_start, line_loc + lingap * 2, line_width, txt_height)
txt_L04a = txt_add("", style_3_a,  line_start, line_loc + lingap * 3, line_width, txt_height)
txt_L05a = txt_add("", style_3_a,  line_start, line_loc + lingap * 4, line_width, txt_height)
txt_L06a = txt_add("", style_3_a,  line_start, line_loc + lingap * 5, line_width, txt_height)
txt_L07a = txt_add("", style_3_a,  line_start, line_loc + lingap * 6, line_width, txt_height)
txt_L08a = txt_add("", style_3_a,  line_start, line_loc + lingap * 7, line_width, txt_height)
txt_L09a = txt_add("", style_3_a,  line_start, line_loc + lingap * 8, line_width, txt_height)

-- #2 ITEMS - NEW COLOR SCHEME - BLUE SMALL
txt_L00bs = txt_add("", style_2_bs,  line_start, title_loc, line_width, txt_height)
txt_L01bs = txt_add("", style_2_bs,  line_start + colgap, line_loc, line_width, txt_height)
txt_L02bs = txt_add("", style_2_bs,  line_start + colgap, line_loc + lingap * 1, line_width, txt_height)
txt_L03bs = txt_add("", style_2_bs,  line_start + colgap, line_loc + lingap * 2, line_width, txt_height)
txt_L04bs = txt_add("", style_2_bs,  line_start + colgap, line_loc + lingap * 3, line_width, txt_height)
txt_L05bs = txt_add("", style_2_bs,  line_start + colgap, line_loc + lingap * 4, line_width, txt_height)
txt_L06bs = txt_add("", style_2_bs,  line_start + colgap, line_loc + lingap * 5, line_width, txt_height)
txt_L07bs = txt_add("", style_2_bs,  line_start + colgap, line_loc + lingap * 6, line_width, txt_height)
txt_L08bs = txt_add("", style_2_bs,  line_start + colgap, line_loc + lingap * 7, line_width, txt_height)
txt_L09bs = txt_add("", style_2_bs,  line_start + colgap, line_loc + lingap * 8, line_width, txt_height)

-- #1 ITEMS - HIGHLIGHT COLOR SCHEME - CYAN
txt_L00c = txt_add("", style_1t_c,  line_start, title_loc, line_width, txt_height)
txt_L01c = txt_add("", style_1_c,  line_start, line_loc, line_width, txt_height)
txt_L02c = txt_add("", style_1_c,  line_start, line_loc + lingap * 1, line_width, txt_height)
txt_L03c = txt_add("", style_1_c,  line_start, line_loc + lingap * 2, line_width, txt_height)
txt_L04c = txt_add("", style_1_c,  line_start, line_loc + lingap * 3, line_width, txt_height)
txt_L05c = txt_add("", style_1_c,  line_start, line_loc + lingap * 4, line_width, txt_height)
txt_L06c = txt_add("", style_1_c,  line_start, line_loc + lingap * 5, line_width, txt_height)
txt_L07c = txt_add("", style_1_c,  line_start, line_loc + lingap * 6, line_width, txt_height)
txt_L08c = txt_add("", style_1_c,  line_start, line_loc + lingap * 7, line_width, txt_height)
txt_L09c = txt_add("", style_1_c,  line_start, line_loc + lingap * 8, line_width, txt_height)

-- #4 ITEMS - NEW COLOR SCHEME - CYAN SMALL
txt_L00cs = txt_add("", style_4_cs,  1460,   title_loc, 100, txt_height)
txt_L01cs = txt_add("", style_4_cs,  line_start + colgap, line_loc, line_width, txt_height)
txt_L02cs = txt_add("", style_4_cs,  line_start + colgap, line_loc + lingap * 1, line_width, txt_height)
txt_L03cs = txt_add("", style_4_cs,  line_start + colgap, line_loc + lingap * 2, line_width, txt_height)
txt_L04cs = txt_add("", style_4_cs,  line_start + colgap, line_loc + lingap * 3, line_width, txt_height)
txt_L05cs = txt_add("", style_4_cs,  line_start + colgap, line_loc + lingap * 4, line_width, txt_height)
txt_L06cs = txt_add("", style_4_cs,  line_start + colgap, line_loc + lingap * 5, line_width, txt_height)
txt_L07cs = txt_add("", style_4_cs,  line_start + colgap, line_loc + lingap * 6, line_width, txt_height)
txt_L08cs = txt_add("", style_4_cs,  line_start + colgap, line_loc + lingap * 7, line_width, txt_height)
txt_L09cs = txt_add("", style_4_cs,  line_start + colgap, line_loc + lingap * 8, line_width, txt_height)

-- #4 ITEMS - SELECTED COLOR SCHEME - GREEN
txt_L00g = txt_add("", style_1t_g,  line_start, title_loc, line_width, txt_height)
txt_L01g = txt_add("", style_5_g,  line_start, line_loc, line_width, txt_height)
txt_L02g = txt_add("", style_5_g,  line_start, line_loc + lingap * 1, line_width, txt_height)
txt_L03g = txt_add("", style_5_g,  line_start, line_loc + lingap * 2, line_width, txt_height)
txt_L04g = txt_add("", style_5_g,  line_start, line_loc + lingap * 3, line_width, txt_height)
txt_L05g = txt_add("", style_5_g,  line_start, line_loc + lingap * 4, line_width, txt_height)
txt_L06g = txt_add("", style_5_g,  line_start, line_loc + lingap * 5, line_width, txt_height)
txt_L07g = txt_add("", style_5_g,  line_start, line_loc + lingap * 6, line_width, txt_height)
txt_L08g = txt_add("", style_5_g,  line_start, line_loc + lingap * 7, line_width, txt_height)
txt_L09g = txt_add("", style_5_g,  line_start, line_loc + lingap * 8, line_width, txt_height)

-- #2 ITEMS - STD COLOR SCHEME - WHITE SMALL
txt_L00s = txt_add("", style_2_ws,  1460,   title_loc, 100, txt_height)
txt_L01s = txt_add("", style_2_ws,  line_start + colgap, line_loc, line_width, txt_height)
txt_L02s = txt_add("", style_2_ws,  line_start + colgap, line_loc + lingap * 1, line_width, txt_height)
txt_L03s = txt_add("", style_2_ws,  line_start + colgap, line_loc + lingap * 2, line_width, txt_height)
txt_L04s = txt_add("", style_2_ws,  line_start + colgap, line_loc + lingap * 3, line_width, txt_height)
txt_L05s = txt_add("", style_2_ws,  line_start + colgap, line_loc + lingap * 4, line_width, txt_height)
txt_L06s = txt_add("", style_2_ws,  line_start + colgap, line_loc + lingap * 5, line_width, txt_height)
txt_L07s = txt_add("", style_2_ws,  line_start + colgap, line_loc + lingap * 6, line_width, txt_height)
txt_L08s = txt_add("", style_2_ws,  line_start + colgap, line_loc + lingap * 7, line_width, txt_height)
txt_L09s = txt_add("", style_2_ws,  line_start + colgap, line_loc + lingap * 8, line_width, txt_height)

-- SAVED FLIGHTS

local txtSF_height	= 35
local y_sfgp		= 165

txt_SF01	= txt_add("", style_7_w,  c1_btn, l1_btn, x_btn, txtSF_height)			visible(txt_SF01,false)
txt_SF01b	= txt_add("", style_7_w,  c1_btn, l1_btn + y_sfgp, x_btn, txtSF_height)	visible(txt_SF01b,false)
txt_SF02	= txt_add("", style_7_w,  c2_btn, l1_btn, x_btn, txtSF_height)			visible(txt_SF02,false)
txt_SF02b	= txt_add("", style_7_w,  c2_btn, l1_btn + y_sfgp, x_btn, txtSF_height)	visible(txt_SF02b,false)
txt_SF03	= txt_add("", style_7_w,  c3_btn, l1_btn, x_btn, txtSF_height)			visible(txt_SF03,false)
txt_SF03b	= txt_add("", style_7_w,  c3_btn, l1_btn + y_sfgp, x_btn, txtSF_height)	visible(txt_SF03b,false)
txt_SF04	= txt_add("", style_7_w,  c4_btn, l1_btn, x_btn, txtSF_height)			visible(txt_SF04,false)
txt_SF04b	= txt_add("", style_7_w,  c4_btn, l1_btn + y_sfgp, x_btn, txtSF_height)	visible(txt_SF04b,false)
txt_SF05	= txt_add("", style_7_w,  c1_btn, l1_btn, x_btn, txtSF_height)			visible(txt_SF05,false)
txt_SF05b	= txt_add("", style_7_w,  c1_btn, l1_btn + y_sfgp, x_btn, txtSF_height)	visible(txt_SF05b,false)
txt_SF06	= txt_add("", style_7_w,  c2_btn, l1_btn, x_btn, txtSF_height)			visible(txt_SF06,false)
txt_SF06b	= txt_add("", style_7_w,  c2_btn, l1_btn + y_sfgp, x_btn, txtSF_height)	visible(txt_SF06b,false)
txt_SF07	= txt_add("", style_7_w,  c3_btn, l1_btn, x_btn, txtSF_height)			visible(txt_SF07,false)
txt_SF07b	= txt_add("", style_7_w,  c3_btn, l1_btn + y_sfgp, x_btn, txtSF_height)	visible(txt_SF07b,false)
txt_SF08	= txt_add("", style_7_w,  c4_btn, l1_btn, x_btn, txtSF_height)			visible(txt_SF08,false)
txt_SF08b	= txt_add("", style_7_w,  c4_btn, l1_btn + y_sfgp, x_btn, txtSF_height)	visible(txt_SF08b,false)

-- CREDITS

img_info = img_add("tablet_info-1.png",1014,info_pos,620,320) visible(img_info,false)
txt_rel1 = txt_add("", style_f_w,  1025, info_pos + 150, 600, 60)
txt_rel2 = txt_add("", style_f_w,  1025, info_pos + 200, 600, 60)
txt_rel3 = txt_add("", style_f_w,  1025, info_pos + 250, 600, 60)

-- TABLET TOOLS

-- img_map			= img_add("img_map.png", 0, 100, x_width, y_height - 100 - 75) visible(img_map,false)

img_tb			= img_add("tablet_bar-1.png",0,0,x_width,54) visible(img_tb,false)
img_xprunoff	= img_add("xprunoff.png", 360, 4, 45, 45)
img_xprunon		= img_add("xprunon.png", 360, 4, 45, 45) visible(img_xprunon,false)
txt_Title		= txt_add("", style_7_w,  0,   10, x_width, 40)
txt_ACF			= txt_add("", style_g_w,  20,   60, 450, 40)
txt_FPS			= txt_add("", style_8_a,  470,   60, x_width, 40) visible(txt_FPS,false)
img_pwroff		= img_add("poweroff.png",1412,4,45,45) visible(img_pwroff,false)
img_pwron		= img_add("poweron.png",1412,4,45,45) visible(img_pwron,false)
txt_time		= txt_add("", style_0_w,  1300, 4, 110, 40)
txt_warn		= txt_add("", style_6_y,  0, 590, x_width, 60)

txt_set(txt_Title,str_Z_2D_XP_EFBTitle)

----------------------------------------
--				FUNCTIONS
----------------------------------------

-- TOOLS FUNCTIONS

function pr_prtdbg(label,param,dbgstep,dbgprt)
	-- print("dbg: "..dbgstep)
	if setdebug and dbgprt then
		print("<"..dbgstep.."> "..label..": ["..param.."]")	-- Don't comment out this line, it will not be used, depending on setdebug parameter which has been set to 'false' by default
	end
end

function pr_str_lftextract(str,nb)
	return str:sub(1,nb)
end

-- http://lua-users.org/wiki/CommonFunctions
function pr_trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function pr_convert_times_to_dhms(time_sec)
	secs_nb = math.floor(time_sec)
	days_nb = math.floor(secs_nb/86400)
	secs_nb = secs_nb - (days_nb * 86400)
	hours_nb = math.floor(secs_nb/3600)
	secs_nb = secs_nb - (hours_nb * 3600)
	mins_nb = math.floor(secs_nb/60)
	secs_nb = secs_nb - (mins_nb * 60)
	str_days = string.format("%01d",days_nb)
	str_hours = string.format("%02d",hours_nb)
	str_mins = string.format("%02d",mins_nb)
	str_secs = string.format("%02d",secs_nb)
	return str_days.." day(s) + "..str_hours..":"..str_mins..":"..str_secs
end

local gbl_fl_time_disp		= pr_convert_times_to_dhms(0)

-- LAUNCH MANAGEMENT

function pr_inst_launch(aircraft_desc,xplane_ver)

	if aircraft_desc == nil
		or xplane_ver == nil then
		return
	end

	pr_prtdbg("Aircraft",aircraft_desc,"dbg01",true)	-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	txt_set(txt_ACF,"")
	xplane_aircraft_memo = aircraft_desc
	
	-- visible(txt_ACF,false)
	
	if aircraft_desc == aircraft_desc600 or aircraft_desc == aircraft_desc700 or aircraft_desc == aircraft_desc800 or aircraft_desc == aircraft_desc900 then
		aircraft_selected = 1
		visible(img_not_aircraft_status,false)
		if aircraft_desc == aircraft_desc600 then
			txt_set(txt_ACF,"B737-600NG")
		elseif aircraft_desc == aircraft_desc700 then
			txt_set(txt_ACF,"B737-700NG")
		elseif aircraft_desc == aircraft_desc800 then
			txt_set(txt_ACF,"B737-800NG")
		elseif aircraft_desc == aircraft_desc900 then
			txt_set(txt_ACF,"B737-900NG/ER")
		end
	else
		txt_set(txt_ACF,"Unhandled")
		aircraft_selected = 0
		pr_all_off()
	end
	
	pr_prtdbg("XP Flight Time",flight_run_memo,"dbg02",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


	if flight_run_memo > 0 then
		flightrunning = 1
	else
		flightrunning = 0
	end

	if flight_run_memo > max_time then
--	if flight_run_memo > max_time and aircraft_selected == 1 then
		flightrunning = 2
	end

	pr_prtdbg("XP Running_AfterCTRL",flightrunning,"dbg03",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	xplane_ver = pr_str_lftextract(tostring(xplane_ver),2)

	pr_prtdbg("X-Plane",xplane_ver,"dbg04",false)	-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	if xplane_ver  == "11" then
		xplaunched = 1
		visible(img_xprunon,true)
	else
		xplaunched = 0
		visible(img_xprunon,false)
		visible(img_not_aircraft_status,false)
	end

	xplane_version_memo = xplane_ver
	
	pr_prtdbg("Power State",power_state,"dbg05",true)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
	if power_state == 1 then
		visible(img_xprunning_bg,false)
		visible(img_acft_status,false)
		visible(img_not_xp_status,false)
		visible(img_not_aircraft_status,false)
	else
		visible(img_xprunning_bg,true)
		visible(img_not_xp_status,false)

	pr_prtdbg("XP Launched",xplaunched,"dbg06",true)	-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

		if xplaunched == 0 then										-- xplaunched == 0	X-PLANE Not already Launched by User
			visible(img_acft_status,false)
			visible(img_not_xp_status,true)
		else															-- xplaunched == 1	X-PLANE Launched by User
			if flightrunning ~= 0 then
				visible(img_acft_status,true)
				if flightrunning == 1 then									-- flightrunning == 1	X-PLANE Flight Running

	pr_prtdbg("XP FlightRunning1_OK",flightrunning,"dbg07",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

					visible(img_not_xp_status,false)
					visible(img_acft_status,false)
					visible(img_xprunning_bg,false)

--				elseif flightrunning == 2 and aircraft_selected == 1 then		-- flightrunning == 2	X-PLANE Flight Running for more than "max_time" seconds
				elseif flightrunning == 2 then		-- flightrunning == 2	X-PLANE Flight Running for more than "max_time" seconds
				
	pr_prtdbg("XP FlightRunning2_OK_GT_MAXTIME",flightrunning,"dbg08",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
					visible(img_not_xp_status,false)
					visible(img_acft_status,false)
					visible(img_xprunning_bg,false)
				end
	pr_prtdbg("XP AIRCRAFT SELECTED",aircraft_selected,"dbg09",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
				if aircraft_selected == 1 then
					visible(img_not_aircraft_status,false)
				else
					visible(img_xprunning_bg,true)
					visible(img_acft_status,true)
					visible(img_not_aircraft_status,true)
				end
			elseif flightrunning == 0 then										-- flightrunning == 0	X-PLANE on MENU or before Aircraft and Scenery Loading
			
	pr_prtdbg("XP FlightRunning0_NOK",flightrunning,"dbg10",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
				--visible(img_not_xp_status,false)
				--visible(img_acft_status,false)
			end
		end
	end
	
end

function pr_xpld(scld)
	if setdebug then
		if scld == 1 then
			txt_set(txt_warn,"LOADING SCENERY ASYNC")
		else
			txt_set(txt_warn,"")
		end
	end
end

-- xpl_dataref_subscribe(
						-- "sim/time/sim_speed", "INT",
						-- -- "sim/graphics/scenery/async_scenery_load_in_progress", "FLOAT",
						-- pr_xpld)

function pr_check_alive()
	if xplane_version_memo == 0 then
		pr_prtdbg("XP Not Alive",xplane_version_memo,"dbg11",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		request_callback(pr_inst_launch)
	else
		pr_prtdbg("XP Alive",xplane_version_memo,"dbg12",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		request_callback(pr_inst_launch)
	end
end

timer_start(1000,3000,pr_check_alive)

function pr_flight_running(flight_run)	-- flight_run = "sim/time/total_running_time_sec"
	gbl_fl_time_disp = pr_convert_times_to_dhms(flight_run)
	if flight_run == nil then
		flight_run_memo = -1
		return
	end
	flight_run = math.floor(flight_run)
	if flight_run == 0 then
		flight_run_memo = 0
	end
	if (flight_run - flight_run_memo) > 0.1 then
		flight_run_memo = flight_run
		-- pr_inst_launch(xplane_aircraft_memo,xplane_version_memo)
	end

	str_Z_2D_XP_EFBFPS		= "  "..FPS_num.." FPS | AVG:"..FPS.." (min:"..FPS_min.."/MAX:"..FPS_MAX..") | X-Plane Flight Time = "..gbl_fl_time_disp
	txt_set(txt_FPS,str_Z_2D_XP_EFBFPS)

	pr_prtdbg("Flight RUN MEMO",flight_run_memo,"dbg13",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

end

-- BUTTONS CLICKED

-- TOOLS BUTTONS CALLBACK

function btn_back_clicked() xpl_command("laminar/B738/tab/back") end
function btn_left_clicked() xpl_command("laminar/B738/tab/left") end
function btn_home_clicked() xpl_command("laminar/B738/tab/home") end
function btn_right_clicked() xpl_command("laminar/B738/tab/right") end
function btn_credits_clicked() xpl_command("laminar/B738/tab/spec") end
function btn_unmark_clicked() xpl_command("laminar/B738/tab/spec") end
function btn_power_clicked() pr_all_off() xpl_command("laminar/B738/tab/power") end
function btn_info_clicked() xpl_command("laminar/B738/tab/info") end

-- CLICK ON LINE CALLBACK

function btn_l1_clicked() xpl_command("laminar/B738/tab/line1") end
function btn_l2_clicked() xpl_command("laminar/B738/tab/line2") end
function btn_l3_clicked() xpl_command("laminar/B738/tab/line3") end
function btn_l4_clicked() xpl_command("laminar/B738/tab/line4") end
function btn_l5_clicked() xpl_command("laminar/B738/tab/line5") end
function btn_l6_clicked() xpl_command("laminar/B738/tab/line6") end
function btn_l7_clicked() xpl_command("laminar/B738/tab/line7") end
function btn_l8_clicked() xpl_command("laminar/B738/tab/line8") end
function btn_l9_clicked() xpl_command("laminar/B738/tab/line9") end

-- CLICK ON PERF BUTTONS CALLBACK

function btn_p1_clicked() xpl_command("laminar/B738/tab/perf1") end
function btn_p2_clicked() xpl_command("laminar/B738/tab/perf2") end
function btn_p3_clicked() xpl_command("laminar/B738/tab/perf3") end
function btn_p4_clicked() xpl_command("laminar/B738/tab/perf4") end
function btn_p5_clicked() xpl_command("laminar/B738/tab/perf5") end
function btn_p6_clicked() xpl_command("laminar/B738/tab/perf6") end
function btn_p7_clicked() xpl_command("laminar/B738/tab/perf7") end
function btn_p8_clicked() xpl_command("laminar/B738/tab/perf8") end
function btn_p9_clicked() xpl_command("laminar/B738/tab/perf9") end
function btn_p10_clicked() xpl_command("laminar/B738/tab/perf10") end
function btn_p11_clicked() xpl_command("laminar/B738/tab/perf11") end
function btn_p12_clicked() xpl_command("laminar/B738/tab/perf12") end
function btn_p13_clicked() xpl_command("laminar/B738/tab/perf13") end
function btn_p14_clicked() xpl_command("laminar/B738/tab/perf14") end
function btn_p15_clicked() xpl_command("laminar/B738/tab/perf15") end
function btn_p16_clicked() xpl_command("laminar/B738/tab/perf16") end

-- CLICK ON MENU BUTTONS CALLBACK

function btn_f1_clicked() xpl_command("laminar/B738/tab/menu1") end
function btn_f2_clicked() xpl_command("laminar/B738/tab/menu2") end
function btn_f3_clicked() xpl_command("laminar/B738/tab/menu3") end
function btn_f4_clicked() xpl_command("laminar/B738/tab/menu4") end
function btn_f5_clicked() xpl_command("laminar/B738/tab/menu5") end
function btn_f6_clicked() xpl_command("laminar/B738/tab/menu6") end
function btn_f7_clicked() xpl_command("laminar/B738/tab/menu7") end
function btn_f8_clicked() xpl_command("laminar/B738/tab/menu8") end

-- CLICK ON NUMPAD KEYS CALLBACK

function btn_num7_clicked() xpl_command("laminar/B738/tab/numpad_7") end
function btn_num8_clicked() xpl_command("laminar/B738/tab/numpad_8") end
function btn_num9_clicked() xpl_command("laminar/B738/tab/numpad_9") end
function btn_num4_clicked() xpl_command("laminar/B738/tab/numpad_4") end
function btn_num5_clicked() xpl_command("laminar/B738/tab/numpad_5") end
function btn_num6_clicked() xpl_command("laminar/B738/tab/numpad_6") end
function btn_num1_clicked() xpl_command("laminar/B738/tab/numpad_1") end
function btn_num2_clicked() xpl_command("laminar/B738/tab/numpad_2") end
function btn_num3_clicked() xpl_command("laminar/B738/tab/numpad_3") end
function btn_num0_clicked() xpl_command("laminar/B738/tab/numpad_0") end
function btn_num_p_clicked() xpl_command("laminar/B738/tab/numpad_comma") end
function btn_num_e_clicked() xpl_command("laminar/B738/tab/numpad_enter") end
function btn_num_m_clicked() xpl_command("laminar/B738/tab/numpad_minus") end
function btn_num_c_clicked() xpl_command("laminar/B738/tab/numpad_clr") end
function btn_num_x_clicked() xpl_command("laminar/B738/tab/numpad_close") end

-- NULL FUNCTION FOR DEFAULT CALLBACK

function btn_nothing()
end

-- CHECK BOX UNCHECKED

img_chk1 = img_add("mark.png",ckbx_c,linbx + lingap *  2,50,50) visible(img_chk1,false)
img_chk2 = img_add("mark.png",ckbx_c,linbx + lingap *  3,50,50) visible(img_chk2,false)
img_chk3 = img_add("mark.png",ckbx_c,linbx + lingap *  4,50,50) visible(img_chk3,false)
img_chk4 = img_add("mark.png",ckbx_c,linbx + lingap *  5,50,50) visible(img_chk4,false)
img_chk5 = img_add("mark.png",ckbx_c,linbx + lingap *  6,50,50) visible(img_chk5,false)
img_chk6 = img_add("mark.png",ckbx_c,linbx + lingap *  7,50,50) visible(img_chk6,false)
img_chk7 = img_add("mark.png",ckbx_c,linbx + lingap *  8,50,50) visible(img_chk7,false)
img_chk8 = img_add("mark.png",ckbx_c,linbx + lingap *  9,50,50) visible(img_chk8,false)
img_chk9 = img_add("mark.png",ckbx_c,linbx + lingap * 10,50,50) visible(img_chk9,false)

-- CHECKBOX CLICKED BUTTONS LIGHTING

btn_mrkc1 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap *  2,50,50,btn_nothing,btn_l1_clicked)
btn_mrkc2 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap *  3,50,50,btn_nothing,btn_l2_clicked)
btn_mrkc3 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap *  4,50,50,btn_nothing,btn_l3_clicked)
btn_mrkc4 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap *  5,50,50,btn_nothing,btn_l4_clicked)
btn_mrkc5 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap *  6,50,50,btn_nothing,btn_l5_clicked)
btn_mrkc6 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap *  7,50,50,btn_nothing,btn_l6_clicked)
btn_mrkc7 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap *  8,50,50,btn_nothing,btn_l7_clicked)
btn_mrkc8 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap *  9,50,50,btn_nothing,btn_l8_clicked)
btn_mrkc9 = button_add(nil,"unmark.png",ckbx_c,linbx + lingap * 10,50,50,btn_nothing,btn_l9_clicked)

-- CHECK BOX CHECKED

img_ok1 = img_add("checked.png",ckbx_c,linbx + lingap *  2,50,50) visible(img_ok1,false)
img_ok2 = img_add("checked.png",ckbx_c,linbx + lingap *  3,50,50) visible(img_ok2,false)
img_ok3 = img_add("checked.png",ckbx_c,linbx + lingap *  4,50,50) visible(img_ok3,false)
img_ok4 = img_add("checked.png",ckbx_c,linbx + lingap *  5,50,50) visible(img_ok4,false)
img_ok5 = img_add("checked.png",ckbx_c,linbx + lingap *  6,50,50) visible(img_ok5,false)
img_ok6 = img_add("checked.png",ckbx_c,linbx + lingap *  7,50,50) visible(img_ok6,false)
img_ok7 = img_add("checked.png",ckbx_c,linbx + lingap *  8,50,50) visible(img_ok7,false)
img_ok8 = img_add("checked.png",ckbx_c,linbx + lingap *  9,50,50) visible(img_ok8,false)
img_ok9 = img_add("checked.png",ckbx_c,linbx + lingap * 10,50,50) visible(img_ok9,false)

-- AUTOLOAD State

img_auto_ld		= img_add("auto_load-1.png",(x_width / 2) - (460 * xbgratio / 2),59,460 * xbgratio,400 * ybgratio) visible(img_auto_ld,false)
img_fail_sv		= img_add("failure_save-1.png",(x_width / 2) - (460 * xbgratio / 2),59,460 * xbgratio,400 * ybgratio) visible(img_fail_sv,false)
img_auto_ld_y	= img_add("yes-1.png",c2_btn,l2_btn,173 * xbgratio,151 * ybgratio) visible(img_auto_ld_y,false)
img_auto_ld_n	= img_add("no-1.png",c3_btn,l2_btn,173 * xbgratio,151 * ybgratio) visible(img_auto_ld_n,false)
txt_SF09		= txt_add("", style_h_mg,  c2_btn, l1_btn + y_sfgp * 1.6, x_btn, txtSF_height)
txt_SF09b		= txt_add("", style_h_mg,  c3_btn, l1_btn + y_sfgp * 1.6, x_btn, txtSF_height)

-- SET NUMPAD DISPLAY LEDS

function pr_numpad(numpad_val)
	if numpad_val == nil then
		return
	end
	txt_set(txt_numpad,numpad_val)
end

-- SET CURRENT RELEASE TO RELEASE TEXT FIELDS

function pr_release(release1,release2,release3)
	if release1 == nil then
		return
	end
	txt_set(txt_rel1,release1)
	txt_set(txt_rel2,release2)
	txt_set(txt_rel3,release3)
end

function pr_info_pos(page_info_pos)
	if page_info_pos == nil then
		return
	end
	if power_state == 1 and avitab_pnl_en == 0 then
		move(img_info,nil,info_pos+(page_info_pos*2))
		move(txt_rel1,nil,info_pos+(page_info_pos*2)+150)
		move(txt_rel2,nil,info_pos+(page_info_pos*2)+200)
		move(txt_rel3,nil,info_pos+(page_info_pos*2)+250)
	end
end

function pr_text_lines(l00,l00bs,l00c,l00cs,l00g,l00s,
						l01,l01a,l01bs,l01c,l01cs,l01g,l01s,
						l02,l02a,l02bs,l02c,l02cs,l02g,l02s,
						l03,l03a,l03bs,l03c,l03cs,l03g,l03s,
						l04,l04a,l04bs,l04c,l04cs,l04g,l04s,
						l05,l05a,l05bs,l05c,l05cs,l05g,l05s,
						l06,l06a,l06bs,l06c,l06cs,l06g,l06s,
						l07,l07a,l07bs,l07c,l07cs,l07g,l07s,
						l08,l08a,l08bs,l08c,l08cs,l08g,l08s,
						l09,l09a,l09bs,l09c,l09cs,l09g,l09s,
						efb_colr_schm)	-- 1 = New Color scheme / 0 = Classic Color scheme
	if l00 == nil then
		return
	end

-- pr_prtdbg("TITLE Trim",pr_trim(l00g),"dbg001",false)

	txt_set(txt_L00,pr_trim(l00))
	txt_set(txt_L00bs,pr_trim(l00bs))
	txt_set(txt_L00c,pr_trim(l00c))
	txt_set(txt_L00cs,pr_trim(l00cs))
	txt_set(txt_L00g,pr_trim(l00g))
	txt_set(txt_L00s,pr_trim(l00s))
	
	if boot_active == 0 then
		visible(txt_L00,true)
		visible(txt_L00bs,true)
		visible(txt_L00c,true)
		visible(txt_L00cs,true)
		visible(txt_L00g,true)
		visible(txt_L00s,true)
	end

	if l01 == " " and l01a == " " and l01bs == " " and l01c == " " and l01cs == " " and l01g == " " and l01s == " " then
		credits_stripmode = 1	-- We are on main pages with buttons
		visible(txt_L01,false)	visible(txt_L01a,false)	visible(txt_L01bs,false)	visible(txt_L01c,false)	visible(txt_L01cs,false)	visible(txt_L01g,false)	visible(txt_L01s,false)
		visible(txt_L02,false)	visible(txt_L02a,false)	visible(txt_L02bs,false)	visible(txt_L02c,false)	visible(txt_L02cs,false)	visible(txt_L02g,false)	visible(txt_L02s,false)
		visible(txt_L03,false)	visible(txt_L03a,false)	visible(txt_L03bs,false)	visible(txt_L03c,false)	visible(txt_L03cs,false)	visible(txt_L03g,false)	visible(txt_L03s,false)
		visible(txt_L04,false)	visible(txt_L04a,false)	visible(txt_L04bs,false)	visible(txt_L04c,false)	visible(txt_L04cs,false)	visible(txt_L04g,false)	visible(txt_L04s,false)
		visible(txt_L05,false)	visible(txt_L05a,false)	visible(txt_L05bs,false)	visible(txt_L05c,false)	visible(txt_L05cs,false)	visible(txt_L05g,false)	visible(txt_L05s,false)
		visible(txt_L06,false)	visible(txt_L06a,false)	visible(txt_L06bs,false)	visible(txt_L06c,false)	visible(txt_L06cs,false)	visible(txt_L06g,false)	visible(txt_L06s,false)
		visible(txt_L07,false)	visible(txt_L07a,false)	visible(txt_L07bs,false)	visible(txt_L07c,false)	visible(txt_L07cs,false)	visible(txt_L07g,false)	visible(txt_L07s,false)
		visible(txt_L08,false)	visible(txt_L08a,false)	visible(txt_L08bs,false)	visible(txt_L08c,false)	visible(txt_L08cs,false)	visible(txt_L08g,false)	visible(txt_L08s,false)
		visible(txt_L09,false)	visible(txt_L09a,false)	visible(txt_L09bs,false)	visible(txt_L09c,false)	visible(txt_L09cs,false)	visible(txt_L09g,false)	visible(txt_L09s,false)
	else                                                
		-- We are on text pages                         
		credits_stripmode = 0                           
		visible(txt_L00,true)	visible(txt_L00bs,true)	visible(txt_L00c,true)	visible(txt_L00cs,true)	visible(txt_L00g,true)	visible(txt_L00s,true)
		visible(txt_L01,true)	visible(txt_L01a,true)	visible(txt_L01bs,true)	visible(txt_L01c,true)	visible(txt_L01cs,true)	visible(txt_L01g,true)	visible(txt_L01s,true)
		visible(txt_L02,true)	visible(txt_L02a,true)	visible(txt_L02bs,true)	visible(txt_L02c,true)	visible(txt_L02cs,true)	visible(txt_L02g,true)	visible(txt_L02s,true)
		visible(txt_L03,true)	visible(txt_L03a,true)	visible(txt_L03bs,true)	visible(txt_L03c,true)	visible(txt_L03cs,true)	visible(txt_L03g,true)	visible(txt_L03s,true)
		visible(txt_L04,true)	visible(txt_L04a,true)	visible(txt_L04bs,true)	visible(txt_L04c,true)	visible(txt_L04cs,true)	visible(txt_L04g,true)	visible(txt_L04s,true)
		visible(txt_L05,true)	visible(txt_L05a,true)	visible(txt_L05bs,true)	visible(txt_L05c,true)	visible(txt_L05cs,true)	visible(txt_L05g,true)	visible(txt_L05s,true)
		visible(txt_L06,true)	visible(txt_L06a,true)	visible(txt_L06bs,true)	visible(txt_L06c,true)	visible(txt_L06cs,true)	visible(txt_L06g,true)	visible(txt_L06s,true)
		visible(txt_L07,true)	visible(txt_L07a,true)	visible(txt_L07bs,true)	visible(txt_L07c,true)	visible(txt_L07cs,true)	visible(txt_L07g,true)	visible(txt_L07s,true)
		visible(txt_L08,true)	visible(txt_L08a,true)	visible(txt_L08bs,true)	visible(txt_L08c,true)	visible(txt_L08cs,true)	visible(txt_L08g,true)	visible(txt_L08s,true)
		visible(txt_L09,true)	visible(txt_L09a,true)	visible(txt_L09bs,true)	visible(txt_L09c,true)	visible(txt_L09cs,true)	visible(txt_L09g,true)	visible(txt_L09s,true)
		txt_set(txt_L01,l01)	txt_set(txt_L01a,l01a)	txt_set(txt_L01bs,l01bs)	txt_set(txt_L01c,l01c)	txt_set(txt_L01cs,l01cs)	txt_set(txt_L01g,l01g)	txt_set(txt_L01s,l01s)
		txt_set(txt_L02,l02)	txt_set(txt_L02a,l02a)	txt_set(txt_L02bs,l02bs)	txt_set(txt_L02c,l02c)	txt_set(txt_L02cs,l02cs)	txt_set(txt_L02g,l02g)	txt_set(txt_L02s,l02s)
		txt_set(txt_L03,l03)	txt_set(txt_L03a,l03a)	txt_set(txt_L03bs,l03bs)	txt_set(txt_L03c,l03c)	txt_set(txt_L03cs,l03cs)	txt_set(txt_L03g,l03g)	txt_set(txt_L03s,l03s)		
		txt_set(txt_L04,l04)	txt_set(txt_L04a,l04a)	txt_set(txt_L04bs,l04bs)	txt_set(txt_L04c,l04c)	txt_set(txt_L04cs,l04cs)	txt_set(txt_L04g,l04g)	txt_set(txt_L04s,l04s)
		txt_set(txt_L05,l05)	txt_set(txt_L05a,l05a)	txt_set(txt_L05bs,l05bs)	txt_set(txt_L05c,l05c)	txt_set(txt_L05cs,l05cs)	txt_set(txt_L05g,l05g)	txt_set(txt_L05s,l05s)
		txt_set(txt_L06,l06)	txt_set(txt_L06a,l06a)	txt_set(txt_L06bs,l06bs)	txt_set(txt_L06c,l06c)	txt_set(txt_L06cs,l06cs)	txt_set(txt_L06g,l06g)	txt_set(txt_L06s,l06s)
		txt_set(txt_L07,l07)	txt_set(txt_L07a,l07a)	txt_set(txt_L07bs,l07bs)	txt_set(txt_L07c,l07c)	txt_set(txt_L07cs,l07cs)	txt_set(txt_L07g,l07g)	txt_set(txt_L07s,l07s)
		txt_set(txt_L08,l08)	txt_set(txt_L08a,l08a)	txt_set(txt_L08bs,l08bs)	txt_set(txt_L08c,l08c)	txt_set(txt_L08cs,l08cs)	txt_set(txt_L08g,l08g)	txt_set(txt_L08s,l08s)
		txt_set(txt_L09,l09)	txt_set(txt_L09a,l09a)	txt_set(txt_L09bs,l09bs)	txt_set(txt_L09c,l09c)	txt_set(txt_L09cs,l09cs)	txt_set(txt_L09g,l09g)	txt_set(txt_L09s,l09s)
	end

	if l00c == " " then
		cred_pgmode = 1	-- Credits running
	else
		cred_pgmode = 0	-- Credits OFF
	end

end

function pr_state(power,				--	1
					boot_active,		--	2
					nav,				--	3
					nav2,				--	4
					arrows_enable,		--	5
					credits,			--	6
					menu_page,			--	7
					page,				--	8
					menuitems,			--	9
					items,				--	10
					items_checked,		--	11
					leg_state,			--	12
					cargo_state,		--	13
					gpu_hide,			--	14
					chock_status,		--	15
					extair_status,		--	16
					numpad,				--	17
					fuel_mgmt,			--	18
					cg_pos,				--	19
					l_tank_lbs,			--	20
					c_tank_lbs,			--	21
					r_tank_lbs,			--	22
					avitab_pnl_state,	--	23
					deicing_trucks,		--	24
					tab_time,			--	25
					airstairs,			--	26
					ufiles,				--	27
					fueltrucks,			--	28
					failuresfix,		--	29
					expfm,				--	30
					custnavdata,		--	31
					fmcunits,			--	32
					maniplines,			--	33
					oew_cg,				--	34	range 0  .. 40 [% MAC] (if 0 then OEW is not displayed) - shift x coordinate
					oew_weight,			--	35	range 40 .. 80 [kg] (always in kg) - shift y coordinate
					oew_str,			--	36	string - text for OEW
					tow_cg,				--	37	range 0  .. 40 [% MAC] (if 0 then TOW is not displayed) - shift x coordinate
					tow_weight,			--	38	range 40 .. 80 [kg] (always in kg) - shift y coordinate
					tow_str,			--	39	string - text for TOW
					zfw_cg,				--	40	range 0  .. 40 [% MAC] (if 0 then ZFW is not displayed) - shift x coordinate
					zfw_weight,			--	41	range 40 .. 80 [kg] (always in kg) - shift y coordinate
					zfw_str,			--	42	string - text for ZFW
					lw_cg,				--	43	range 0  .. 40 [% MAC] (if 0 then LW is not displayed) - shift x coordinate
					lw_weight,			--	44	range 40 .. 80 [kg] (always in kg) - shift y coordinate
					lw_str,				--	45	string - text for LW
					bgperf_to,			--	46	PerfsBG TO displayed
					bgperf_lnd,			--	47	PerfsBG LND displayed
					prf_ab1,			--	48	Autobrake 1 computed distance
					prf_ab1_st,			--	49	Autobrake 1 state
					prf_ab2,			--	50	Autobrake 2 computed distance
					prf_ab2_st,			--	51	Autobrake 2 state
					prf_ab3,			--	52	Autobrake 3 computed distance
					prf_ab3_st,			--	53	Autobrake 3 state
					prf_ad,				--	54	
					prf_clrw,			--	55	
					prf_clrw_sh,		--	56	
					prf_ma,				--	57	Autobrake Auto MAX distance
					prf_ma_st,			--	58	Autobrake Auto MAX state
					prf_mm,				--	59	Autobrake Manual MAX distance
					prf_mm_st,			--	60	Autobrake Manual MAX state
					prf_on_rw,			--	61	Runway Entry point
					prf_out_rw,			--	62	Runway Exit point
					prf_stpw,			--	63
					prf_stpw_sh,		--	64
					prf_lnd_rt,			--	65	LANDING RATE
					prf_lnd_rt_sh,		--	66	LANDING RATE Show
					num_spec1,			--	67	Numpad Spec1
					num_spec2,			--	68	Numpad Spec2
					prf_appr_rt,		--	69	APPROACH RATE
					prf_appr_rt_sh,		--	70	APPROACH RATE Show
					autoload_state,		--	71	EXISTING AUTOSAVED FLIGHT
					vanish_y,			--	72	VANISH_Y status
					doors_status,		--	73	DOORS STATE
					doors_lock,			--	74	DOORS LOCK STATE
					fail_save_state		--	75	SAVE FAILURE SETTINGS Message displayed
						)
	if power == nil
		or boot_active == nil			or nav == nil				or nav2 == nil				or arrows_enable == nil			or credits == nil
		or menu_page == nil				or page == nil				or menuitems == nil			or items == nil					or items_checked == nil
		or leg_state == nil				or cargo_state == nil		or gpu_hide == nil			or chock_status == nil			or extair_status == nil
		or numpad == nil				or fuel_mgmt == nil			or cg_pos == nil			or l_tank_lbs == nil			or c_tank_lbs == nil
		or r_tank_lbs == nil			or avitab_pnl_state == nil	or deicing_trucks == nil	or tab_time == nil				or airstairs == nil
		or ufiles == nil				or fueltrucks == nil		or failuresfix == nil		or expfm == nil					or custnavdata == nil
		or fmcunits == nil				or maniplines == nil		or oew_cg == nil			or oew_weight == nil			or oew_str == nil
		or tow_cg == nil				or tow_weight == nil		or tow_str == nil			or zfw_cg == nil				or zfw_weight == nil
		or zfw_str == nil				or lw_cg == nil				or lw_weight == nil			or lw_str == nil				or bgperf_to == nil
		or bgperf_lnd == nil			or prf_ab1 == nil			or prf_ab1_st == nil		or prf_ab2 == nil				or prf_ab2_st == nil
		or prf_ab3 == nil				or prf_ab3_st == nil		or prf_ad == nil			or prf_clrw == nil				or prf_clrw_sh == nil
		or prf_ma == nil				or prf_ma_st == nil			or prf_mm == nil			or prf_mm_st == nil				or prf_on_rw == nil
		or prf_out_rw == nil			or prf_stpw == nil			or prf_stpw_sh == nil		or prf_lnd_rt == nil			or prf_lnd_rt_sh == nil
		or num_spec1 == nil				or num_spec2 == nil			or prf_appr_rt == nil		or prf_appr_rt_sh == nil		or doors_status == nil
		or fail_save_state == nil
		then
			return
	end

	avitab_pnl_en = avitab_pnl_state

	visible(img_auto_ld,autoload_state == 1)
	visible(img_fail_sv,fail_save_state == 1)
	visible(txt_SF09,autoload_state == 1)
	visible(txt_SF09b,autoload_state == 1)
	msg_ovl = autoload_state == 1 or fail_save_state == 1
	visible(img_auto_ld_y,msg_ovl)
	visible(img_auto_ld_n,msg_ovl)

-- Set Debug Fields | Enable these two text fields on Debugging, by setting "setdebug" value to TRUE (value located at the script start)

	if setdebug then
		if flightrunning == 1 then
			txt_set(txt_warn,"AIRCRAFT LOADING")
			visible(img_acft_status,true)
		else
			txt_set(txt_warn,"")
			visible(img_acft_status,false)
		end
		txt_set(txt_dbg_menu,"MENU:"..math.floor(menu_page))
		txt_set(txt_dbg_page,"PAGE:"..math.floor(page).." CR:"..math.floor(credits).." CM:"..math.floor(cred_pgmode).." ACF:"..xplane_aircraft_memo)
--	txt_set(txt_dbg_menu,"Z_2D_XP_State:"..tablet_show)
	end

-- Start Processing

	pr_prtdbg("Power READING",power,"dbg14",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
	boot_state = boot_active
	power_state = power

	pr_prtdbg("Power State AFTER READING",power_state,"dbg15",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	if memo_power == 1 and power_state == 0 then
		memo_power = 0
	elseif memo_power == 1 and power_state == 1 then
		memo_power = 1
	elseif memo_power == 0 and power_state == 1 then
		memo_power = 1
	elseif memo_power == 0 and power_state == 0 then
		memo_power = 0
	end
	if aircraft_selected == 1 then
		-- visible(img_acft_status,false)
	end
	arrows_state = arrows_enable
	txt_set(txt_time,tab_time)
	if power_state == 0 then				-- Power OFF
		visible(txt_FPS,false)
		visible(btn_unmark,false)
		visible(img_bk,true)
		visible(img_pwroff,true)
		visible(btn_power,true)
		request_callback(pr_inst_launch)
	else											-- Power ON
		-- if boot_active == 1 and flight_run_memo > 1 then		-- Boot running
		if boot_active == 1 then					-- Boot running
			pr_all_off()
			visible(img_bk,false)
			visible(img_bg,false)
			visible(txt_FPS,false)
			visible(img_cred1,true)
			visible(btn_power,false)
			visible(btn_credits,false)
			visible(btn_info,false)
			visible(btn_left,false)
			visible(btn_right,false)
			visible(btn_back,false)
			visible(btn_home,false)
			visible(btn_unmark,false)
			request_callback(pr_inst_launch)
		else
			visible(txt_L00,true)
			visible(txt_L00bs,true)
			visible(txt_L00c,true)
			visible(txt_L00cs,true)
			visible(txt_L00g,true)
			visible(txt_L00s,true)
			visible(img_xprunning_bg,false)		visible(img_bk,true)			visible(img_bg,true)
			visible(btn_unmark,false)			visible(img_cred1,false)		visible(img_cred2,false)
			visible(img_cred3,false)			visible(img_cred4,false)		visible(img_cred5,false)
			visible(img_tb,true)				visible(txt_time,true)
			visible(img_pwron,true)				visible(btn_power,true)			visible(btn_info,true)
			visible(btn_back,true)				visible(btn_home,true)			visible(img_info,true)
			visible(txt_rel1,true)				visible(txt_rel2,true)			visible(txt_rel3,true)
			if menu_page == 8 and cred_pgmode == 1 then	-- DISPLAY CREDITS FULL PAGE
				pr_all_off()
				visible(btn_back,true)			visible(btn_home,true)			visible(txt_time,true)
				visible(img_pwron,true)			visible(btn_power,true)			visible(img_info,true)
				visible(txt_rel1,true)			visible(txt_rel2,true)			visible(txt_rel3,true)
				if credits == 0 then
					visible(img_cred1,true)
					visible(img_cred2,false)
					visible(img_cred3,false)
					visible(img_cred4,false)
					visible(img_cred5,false)
				end
				if credits == 1 then
					visible(img_cred2,true)
					visible(img_cred1,false)
					visible(img_cred3,false)
					visible(img_cred4,false)
					visible(img_cred5,false)
				end
				if credits == 2 then
					visible(img_cred3,true)
					visible(img_cred1,false)
					visible(img_cred2,false)
					visible(img_cred4,false)
					visible(img_cred5,false)
				end
				if credits == 3 then
					visible(img_cred4,true)
					visible(img_cred1,false)
					visible(img_cred2,false)
					visible(img_cred3,false)
					visible(img_cred5,false)
				end
				if credits == 4 then
					visible(img_cred5,true)
					visible(img_cred1,false)
					visible(img_cred2,false)
					visible(img_cred3,false)
					visible(img_cred4,false)
				end
			end

-- MENU 1 PAGE 1 BUTTONS	--	MAIN MENU 1/2
-- MENU 1 PAGE 2 BUTTONS	--	MAIN MENU 2/2

			if menu_page == 1 then									-- DISPLAY MAIN PAGE
				if page == 1 then
					visible(img_m_1_1_1,true)
					if leg_state == 0 then
						visible(img_m_1_1_2_1,false)
						visible(img_m_1_1_2_2,true)
					else
						visible(img_m_1_1_2_1,true)
						visible(img_m_1_1_2_2,false)
					end
					if cargo_state == 0 then
						visible(img_m_1_1_3_1,false)
						visible(img_m_1_1_3_2,true)
					else
						visible(img_m_1_1_3_1,true)
						visible(img_m_1_1_3_2,false)
					end
					visible(img_m_1_1_4,true)		visible(img_m_1_1_5,true)		visible(img_m_1_1_6,true)
					visible(img_m_1_1_7,true)		visible(img_m_1_1_8,true)		visible(img_m_1_2_1,false)
					-- visible(img_m_1_2_2,false)		visible(img_m_1_2_3,false)
					visible(img_m_1_2_4,false)
				else
					visible(img_m_1_1_1,false)		visible(img_m_1_1_2_1,false)	visible(img_m_1_1_2_2,false)
					visible(img_m_1_1_3_1,false)	visible(img_m_1_1_3_2,false)	visible(img_m_1_1_4,false)
					visible(img_m_1_1_5,false)		visible(img_m_1_1_6,false)		visible(img_m_1_1_7,false)
					visible(img_m_1_1_8,false)		visible(img_m_1_2_1,true)
					-- visible(img_m_1_2_2,true)		visible(img_m_1_2_3,true)
					visible(img_m_1_2_4,true)
				end
			else
				visible(img_m_1_1_1,false)			visible(img_m_1_1_2_1,false)	visible(img_m_1_1_2_2,false)
				visible(img_m_1_1_3_1,false)		visible(img_m_1_1_3_2,false)	visible(img_m_1_1_4,false)
				visible(img_m_1_1_5,false)			visible(img_m_1_1_6,false)		visible(img_m_1_1_7,false)
				visible(img_m_1_1_8,false)			visible(img_m_1_2_1,false)
				-- visible(img_m_1_2_2,false)			visible(img_m_1_2_3,false)
				visible(img_m_1_2_4,false)
			end

-- MENU 2 PAGE 1 BUTTONS	--	SETTINGS AND FEATURES

			if menu_page == 2 then						-- DISPLAY  PAGE
				visible(img_m_2_1_1,true)			visible(img_m_2_1_2,true)		visible(img_m_2_1_3,true)
				visible(img_m_2_1_4,true)			visible(img_m_2_1_5,true)		visible(img_m_2_1_6,true)
				visible(img_m_2_1_7,true)			visible(img_m_2_1_8,true)
			else
				visible(img_m_2_1_1,false)			visible(img_m_2_1_2,false)		visible(img_m_2_1_3,false)
				visible(img_m_2_1_4,false)			visible(img_m_2_1_5,false)		visible(img_m_2_1_6,false)
				visible(img_m_2_1_7,false)			visible(img_m_2_1_8,false)
			end

-- MENU 3 PAGE 1 BUTTONS	--	ANNOUNCEMENTS

			if menu_page == 3 then						-- DISPLAY  PAGE
				visible(img_m_3_1_1,true)			visible(img_m_3_1_2,true)		visible(img_m_3_1_3,true)
				visible(img_m_3_1_4,true)			visible(img_m_3_1_5,true)		visible(img_m_3_1_8,true)
			else
				visible(img_m_3_1_1,false)			visible(img_m_3_1_2,false)		visible(img_m_3_1_3,false)
				visible(img_m_3_1_4,false)			visible(img_m_3_1_5,false)		visible(img_m_3_1_8,false)
			end

-- MENU 4 PAGE 1 BUTTONS	--	CHECKLIST 1/3
-- MENU 4 PAGE 2 BUTTONS	--	CHECKLIST 2/3
-- MENU 4 PAGE 3 BUTTONS	--	CHECKLIST 3/3

			if menu_page == 4 then						-- DISPLAY  PAGE
				visible(img_m_4_1_1,false)			visible(img_m_4_1_2,false)		visible(img_m_4_1_3,false)
				visible(img_m_4_1_4,false)			visible(img_m_4_1_5,false)		visible(img_m_4_1_6,false)
				visible(img_m_4_1_7,false)			visible(img_m_4_1_8,false)		visible(img_m_4_2_1,false)
				visible(img_m_4_2_2,false)			visible(img_m_4_2_3,false)		visible(img_m_4_2_4,false)
				visible(img_m_4_2_5,false)			visible(img_m_4_2_6,false)		visible(img_m_4_2_7,false)
				visible(img_m_4_2_8,false)			visible(img_m_4_3_1,false)		visible(img_m_4_3_2,false)
				visible(img_m_4_3_3,false)
				if page == 1 then
					visible(img_m_4_1_1,true)		visible(img_m_4_1_2,true)		visible(img_m_4_1_3,true)
					visible(img_m_4_1_4,true)		visible(img_m_4_1_5,true)		visible(img_m_4_1_6,true)
					visible(img_m_4_1_7,true)		visible(img_m_4_1_8,true)
				elseif page == 2 then
					visible(img_m_4_2_1,true)		visible(img_m_4_2_2,true)		visible(img_m_4_2_3,true)
					visible(img_m_4_2_4,true)		visible(img_m_4_2_5,true)		visible(img_m_4_2_6,true)
					visible(img_m_4_2_7,true)		visible(img_m_4_2_8,true)		elseif page == 3 then
					visible(img_m_4_3_1,true)		visible(img_m_4_3_2,true)		visible(img_m_4_3_3,true)
				end
			else
				visible(img_m_4_1_1,false)			visible(img_m_4_1_2,false)		visible(img_m_4_1_3,false)
				visible(img_m_4_1_4,false)			visible(img_m_4_1_5,false)		visible(img_m_4_1_6,false)
				visible(img_m_4_1_7,false)			visible(img_m_4_1_8,false)		visible(img_m_4_2_1,false)
				visible(img_m_4_2_2,false)			visible(img_m_4_2_3,false)		visible(img_m_4_2_4,false)
				visible(img_m_4_2_5,false)			visible(img_m_4_2_6,false)		visible(img_m_4_2_7,false)
				visible(img_m_4_2_8,false)			visible(img_m_4_3_1,false)		visible(img_m_4_3_2,false)
				visible(img_m_4_3_3,false)
			end

-- MENU 5 PAGE 1 BUTTONS	--	LOAD / SAVE
			
			if menu_page == 5 then						-- DISPLAY  PAGE
				visible(img_m_5_1_1,true)			visible(img_m_5_1_2,true)		visible(img_m_5_1_3,true)
				visible(img_m_5_1_4,true)			visible(img_m_5_1_5,true)		visible(img_m_5_1_6,true)
				visible(img_m_5_1_7,true)			visible(img_m_5_1_8,true)
			else
				visible(img_m_5_1_1,false)			visible(img_m_5_1_2,false)		visible(img_m_5_1_3,false)
				visible(img_m_5_1_4,false)			visible(img_m_5_1_5,false)		visible(img_m_5_1_6,false)
				visible(img_m_5_1_7,false)			visible(img_m_5_1_8,false)
			end

-- MENU 6 PAGE 1 BUTTONS	--	LOAD/SAVE CONFIG PRESETS

			if menu_page == 6 then						-- DISPLAY  PAGE
				visible(img_m_6_1_1,true)			visible(img_m_6_1_2,true)		visible(img_m_6_1_3,true)
				visible(img_m_6_1_4,true)			visible(img_m_6_1_5,true)		visible(img_m_6_1_6,true)
				visible(img_m_6_1_7,true)			visible(img_m_6_1_8,true)
			else
				visible(img_m_6_1_1,false)			visible(img_m_6_1_2,false)		visible(img_m_6_1_3,false)
				visible(img_m_6_1_4,false)			visible(img_m_6_1_5,false)		visible(img_m_6_1_6,false)
				visible(img_m_6_1_7,false)			visible(img_m_6_1_8,false)
			end

-- MENU 7 PAGE 1 BUTTONS	--	LOAD/SAVE AUDIO PRESETS

			if menu_page == 7 then						-- DISPLAY  PAGE
				visible(img_m_7_1_1,true)			visible(img_m_7_1_2,true)		visible(img_m_7_1_3,true)
				visible(img_m_7_1_4,true)			visible(img_m_7_1_5,true)		visible(img_m_7_1_6,true)
				visible(img_m_7_1_7,true)			visible(img_m_7_1_8,true)
			else
				visible(img_m_7_1_1,false)			visible(img_m_7_1_2,false)		visible(img_m_7_1_3,false)
				visible(img_m_7_1_4,false)			visible(img_m_7_1_5,false)		visible(img_m_7_1_6,false)
				visible(img_m_7_1_7,false)			visible(img_m_7_1_8,false)
			end

-- MENU 8 PAGE 0 1 2	--	CREDITS STRIPS

			if menu_page ~= 8 and credits_stripmode == 1 and avitab_pnl_en == 0 then	-- DISPLAY CREDITS STRIPS
				if ufiles == 0 then
					visible(img_credstrip4m_bg,true)
					visible(img_credstrip4m,true)
				else
					visible(img_credstrip4m_bg,false)
					visible(img_credstrip4m,false)
				end
				if expfm ~= 0 then
					visible(img_credstrip5m_bg,true)
					visible(img_credstrip5m,true)
				else
					visible(img_credstrip5m_bg,false)
					visible(img_credstrip5m,false)
				end
				if custnavdata ~= 0 then
					visible(img_credstrip6m_bg,true)
					visible(img_credstrip6m,true)
				else
					visible(img_credstrip6m_bg,false)
					visible(img_credstrip6m,false)
				end
				if vanish_y ~= 0 then
					visible(img_credstrip7m_bg,true)
					visible(img_credstrip7m,true)
				else
					visible(img_credstrip7m_bg,false)
					visible(img_credstrip7m,false)
				end
				if credits == 0 then
					visible(img_credstrip1,true)
					visible(img_credstrip2,false)
					visible(img_credstrip3,false)
					visible(img_credstrip4,false)
					visible(img_credstrip5,false)
				end
				if credits == 1 then
					visible(img_credstrip2,true)
					visible(img_credstrip1,false)
					visible(img_credstrip3,false)
					visible(img_credstrip4,false)
					visible(img_credstrip5,false)
				end
				if credits == 2 then
					visible(img_credstrip3,true)
					visible(img_credstrip1,false)
					visible(img_credstrip2,false)
					visible(img_credstrip4,false)
					visible(img_credstrip5,false)
				end
				if credits == 3 then
					visible(img_credstrip5,true)
					visible(img_credstrip1,false)
					visible(img_credstrip2,false)
					visible(img_credstrip3,false)
					visible(img_credstrip4,false)
				end
				if credits == 4 then
					visible(img_credstrip4,true)
					visible(img_credstrip1,false)
					visible(img_credstrip2,false)
					visible(img_credstrip3,false)
					visible(img_credstrip5,false)
				end
				visible(btn_credits,false)
			else
				visible(img_credstrip1,false)
				visible(img_credstrip2,false)
				visible(img_credstrip3,false)
				visible(img_credstrip4,false)
				visible(img_credstrip5,false)
			end

-- MENU 9 PAGE 1 BUTTONS	--	GROUND SERVICES
			
			if menu_page == 9 then							-- DISPLAY GROUND SERVICES PAGE
				if gpu_hide == 0 then
					visible(img_m_9_1_1_1,true)
					visible(img_m_9_1_1_2,false)
				elseif gpu_hide == 1 then
					visible(img_m_9_1_1_2,true)
					visible(img_m_9_1_1_1,false)
				end
				if chock_status == 1 then
					visible(img_m_9_1_2_1,true)
					visible(img_m_9_1_2_2,false)
				elseif chock_status == 0 then
					visible(img_m_9_1_2_2,true)
					visible(img_m_9_1_2_1,false)
				end
				visible(img_m_9_1_3,true)
				if extair_status == 1 then
					visible(img_m_9_1_4_1,true)
					visible(img_m_9_1_4_2,false)
				elseif extair_status == 0 then
					visible(img_m_9_1_4_2,true)
					visible(img_m_9_1_4_1,false)
				end
				if deicing_trucks == 1 then
					visible(img_m_9_1_5_1,true)
					visible(img_m_9_1_5_2,false)
				elseif deicing_trucks == 0 then
					visible(img_m_9_1_5_2,true)
					visible(img_m_9_1_5_1,false)
				end
				if airstairs == 1 then
					visible(img_m_9_1_6_1,true)
					visible(img_m_9_1_6_2,false)
				elseif airstairs == 0 then
					visible(img_m_9_1_6_2,true)
					visible(img_m_9_1_6_1,false)
				end
				visible(img_m_9_1_7,true)			visible(img_m_9_1_8,true)
			else
				visible(img_m_9_1_1_1,false)		visible(img_m_9_1_1_2,false)		visible(img_m_9_1_2_1,false)
				visible(img_m_9_1_2_2,false)		visible(img_m_9_1_3,false)			visible(img_m_9_1_4_1,false)
				visible(img_m_9_1_4_2,false)		visible(img_m_9_1_5_1,false)		visible(img_m_9_1_5_2,false)
				visible(img_m_9_1_6_1,false)		visible(img_m_9_1_6_2,false)		visible(img_m_9_1_7,false)
				visible(img_m_9_1_8,false)
			end

-- MENU 10 PAGE 1 BUTTONS	--	BETTER PUSHBACK

			if menu_page == 10 then
				visible(img_m_10_1_1,true)			visible(img_m_10_1_2,true)			visible(img_m_10_1_3,true)
				visible(img_m_10_1_4,true)			visible(img_m_10_1_5,true)
			else
				visible(img_m_10_1_1,false)			visible(img_m_10_1_2,false)			visible(img_m_10_1_3,false)
				visible(img_m_10_1_4,false)			visible(img_m_10_1_5,false)
			end

-- MENU 11 PAGE 1 BUTTONS	--	AVITAB

			if menu_page == 11 and avitab_pnl_en == 0 then		-- DISPLAY AVITAB PAGE
				-- txt_set(txt_warn,"")
				visible(img_m_11_1_1,true)			visible(img_m_11_1_2,true)			visible(img_m_11_1_3,true)
				visible(img_m_11_1_4,true)			visible(img_m_11_1_8,true)			visible(btn_f1,true)
				visible(btn_f2,true)				visible(btn_f3,true)				visible(btn_f4,true)
				visible(btn_f8,true)
			elseif menu_page == 11 and avitab_pnl_en == 1 then
				-- txt_set(txt_warn,"")
				visible(img_m_11_1_1,false)			visible(img_m_11_1_2,false)			visible(img_m_11_1_3,false)
				visible(img_m_11_1_4,false)			visible(img_m_11_1_8,false)			visible(btn_f1,false)
				visible(btn_f2,false)				visible(btn_f3,false)				visible(btn_f4,false)
				visible(btn_f8,false)
			elseif menu_page ~= 11 then
				visible(img_m_11_1_1,false)			visible(img_m_11_1_2,false)			visible(img_m_11_1_3,false)
				visible(img_m_11_1_4,false)			visible(img_m_11_1_8,false)			visible(btn_f1,false)
				visible(btn_f2,false)				visible(btn_f3,false)				visible(btn_f4,false)
				visible(btn_f8,false)
			end

-- MENU 12 PAGE 1 BUTTONS	--	SWITCHES STATE PRESETS

			if menu_page == 12 then		-- DISPLAY SWITCHES STATE PRESETS PAGE
				visible(img_m_12_1_1,true)			visible(img_m_12_1_2,true)			visible(img_m_12_1_3,true)
				visible(img_m_12_1_4,true)			visible(img_m_12_1_5,true)			visible(img_m_12_1_6,true)
				visible(img_m_12_1_7,true)			visible(img_m_12_1_8,true)
			elseif menu_page ~= 12 then
				visible(img_m_12_1_1,false)			visible(img_m_12_1_2,false)			visible(img_m_12_1_3,false)
				visible(img_m_12_1_4,false)			visible(img_m_12_1_5,false)			visible(img_m_12_1_6,false)
				visible(img_m_12_1_7,false)			visible(img_m_12_1_8,false)
			end

-- MENU 13 PAGE 1 BUTTONS	--	FAILURES

			if menu_page == 13 then		-- DISPLAY FAILURES PAGE
				visible(img_m_13_1_1,true)			visible(img_m_13_1_2,true)			visible(img_m_13_1_3,true)
				visible(img_m_13_1_4,true)			visible(img_m_13_1_5,true)			visible(img_m_13_1_6,true)
				visible(img_m_13_1_7,true)			visible(img_m_13_1_8_0,true)
				if failuresfix == 1 then
					visible(img_m_13_1_8_2,false)
					visible(img_m_13_1_8_1,true)
				elseif failuresfix == 2 then
					visible(img_m_13_1_8_1,false)
					visible(img_m_13_1_8_2,true)
				end
			elseif menu_page ~= 13 then
				visible(img_m_13_1_1,false)			visible(img_m_13_1_2,false)			visible(img_m_13_1_3,false)
				visible(img_m_13_1_4,false)			visible(img_m_13_1_5,false)			visible(img_m_13_1_6,false)
				visible(img_m_13_1_7,false)			visible(img_m_13_1_8_0,false)		visible(img_m_13_1_8_1,false)
				visible(img_m_13_1_8_2,false)
			end

-- MENU 14 PAGE 1 BUTTONS	--	FUEL, PAYLOAD, CG, OPT PAGE

			if menu_page == 14 then		-- DISPLAY FUEL, PAYLOAD, CG, OPT PAGE
				visible(img_m_14_1_1,true)			visible(img_m_14_1_2,true)			visible(img_m_14_1_3,true)
				visible(img_m_14_1_4,true)
				if fueltrucks == 1 then
					visible(img_m_14_1_5_1,true)
					visible(img_m_14_1_5_2,false)
				elseif fueltrucks == 0 then
					visible(img_m_14_1_5_2,true)
					visible(img_m_14_1_5_1,false)
				end
				
		-- LANDING RATE				
				
				visible(img_p_lnd_rt0, (prf_lnd_rt_sh == 6))
				visible(img_p_lnd_rt1, (prf_lnd_rt_sh == 5))
				visible(img_p_lnd_rt2, (prf_lnd_rt_sh == 4))
				visible(img_p_lnd_rt3, (prf_lnd_rt_sh == 3))
				visible(img_p_lnd_rt4, (prf_lnd_rt_sh == 2))
				visible(img_p_lnd_rt5, (prf_lnd_rt_sh == 1))

		-- APPROACH RATE				
				
				visible(img_p_appr_rt0, (prf_appr_rt_sh == 6))
				visible(img_p_appr_rt1, (prf_appr_rt_sh == 5))
				visible(img_p_appr_rt2, (prf_appr_rt_sh == 4))
				visible(img_p_appr_rt3, (prf_appr_rt_sh == 3))
				visible(img_p_appr_rt4, (prf_appr_rt_sh == 2))
				visible(img_p_appr_rt5, (prf_appr_rt_sh == 1))
			elseif menu_page ~= 14 then
				visible(img_m_14_1_1,false)
				visible(img_m_14_1_2,false)
				visible(img_m_14_1_3,false)
				visible(img_m_14_1_4,false)
				visible(img_m_14_1_5_1,false)
				visible(img_m_14_1_5_2,false)
				visible(img_p_lnd_rt0, false)
				visible(img_p_lnd_rt1, false)
				visible(img_p_lnd_rt2, false)
				visible(img_p_lnd_rt3, false)
				visible(img_p_lnd_rt4, false)
				visible(img_p_lnd_rt5, false)
				visible(img_p_appr_rt0, false)
				visible(img_p_appr_rt1, false)
				visible(img_p_appr_rt2, false)
				visible(img_p_appr_rt3, false)
				visible(img_p_appr_rt4, false)
				visible(img_p_appr_rt5, false)
			end

			if numpad == 1 then						-- NUMPAD IS DISPLAYED
				visible(img_numpad,true)			visible(txt_numpad,true)		visible(btn_num_7,true)
				visible(btn_num_8,true)				visible(btn_num_9,true)			visible(btn_num_4,true)
				visible(btn_num_5,true)				visible(btn_num_6,true)			visible(btn_num_1,true)
				visible(btn_num_2,true)				visible(btn_num_3,true)			visible(btn_num_0,true)
				visible(btn_num_c,true)				visible(btn_num_x,true)			visible(btn_num_m,true)
				visible(btn_num_p,true)				visible(btn_num_e,true)
				visible(img_numslh,num_spec2 == 1)
				visible(img_nummfk,num_spec2 == 2)
				visible(img_numrnd,num_spec1 == 1)
				visible(img_numpax,num_spec1 == 2)
			else
				visible(txt_numpad,false)			visible(btn_num_7,false)		visible(btn_num_8,false)
				visible(btn_num_9,false)			visible(btn_num_4,false)		visible(btn_num_5,false)
				visible(btn_num_6,false)			visible(btn_num_1,false)		visible(btn_num_2,false)
				visible(btn_num_3,false)			visible(btn_num_0,false)		visible(btn_num_c,false)
				visible(btn_num_x,false)			visible(btn_num_m,false)		visible(btn_num_p,false)
				visible(btn_num_e,false)			visible(img_numpad,false)		visible(img_numslh,false)
				visible(img_nummfk,false)			visible(img_numrnd,false)		visible(img_numpax,false)
			end

-- MENU 15 PAGE 1 BUTTONS	--	LOAD / SAVE FLIGHT
			
			if menu_page == 15 then						-- DISPLAY  PAGE
				if page == 1 then
					visible(img_m_15_1_1,true)		visible(img_m_15_1_2,true)		visible(img_m_15_1_3,true)
					visible(img_m_15_1_4,true)		visible(img_m_15_1_5,true)		visible(img_m_15_1_6,true)
					visible(img_m_15_1_7,true)		visible(img_m_15_1_8,true)
					visible(img_m_15_2_1,false)		visible(img_m_15_2_2,false)		visible(img_m_15_2_3,false)
					visible(img_m_15_2_4,false)		visible(img_m_15_2_5,false)		visible(img_m_15_2_6,false)
					visible(img_m_15_2_7,false)		visible(img_m_15_2_8,false)

					visible(txt_SF01,true)			visible(txt_SF01b,true)
					visible(txt_SF02,true)			visible(txt_SF02b,true)
					visible(txt_SF03,true)			visible(txt_SF03b,true)
					visible(txt_SF04,true)			visible(txt_SF04b,true)

					visible(txt_SF05,false)			visible(txt_SF05b,false)
					visible(txt_SF06,false)			visible(txt_SF06b,false)
					visible(txt_SF07,false)			visible(txt_SF07b,false)
					visible(txt_SF08,false)			visible(txt_SF08b,false)

				else
					visible(img_m_15_1_1,false)		visible(img_m_15_1_2,false)		visible(img_m_15_1_3,false)
					visible(img_m_15_1_4,false)		visible(img_m_15_1_5,false)		visible(img_m_15_1_6,false)
					visible(img_m_15_1_7,false)		visible(img_m_15_1_8,false)
					visible(img_m_15_2_1,true)		visible(img_m_15_2_2,true)		visible(img_m_15_2_3,true)
					visible(img_m_15_2_4,true)		visible(img_m_15_2_5,true)		visible(img_m_15_2_6,true)
					visible(img_m_15_2_7,true)		visible(img_m_15_2_8,true)

					visible(txt_SF01,false)			visible(txt_SF01b,false)
					visible(txt_SF02,false)			visible(txt_SF02b,false)
					visible(txt_SF03,false)			visible(txt_SF03b,false)
					visible(txt_SF04,false)			visible(txt_SF04b,false)

					visible(txt_SF05,true)			visible(txt_SF05b,true)
					visible(txt_SF06,true)			visible(txt_SF06b,true)
					visible(txt_SF07,true)			visible(txt_SF07b,true)
					visible(txt_SF08,true)			visible(txt_SF08b,true)

				end
			else
				visible(img_m_15_1_1,false)			visible(img_m_15_1_2,false)	visible(img_m_15_1_3,false)
				visible(img_m_15_1_4,false)			visible(img_m_15_1_5,false)	visible(img_m_15_1_6,false)
				visible(img_m_15_1_7,false)			visible(img_m_15_1_8,false)
				visible(img_m_15_2_1,false)			visible(img_m_15_2_2,false)	visible(img_m_15_2_3,false)
				visible(img_m_15_2_4,false)			visible(img_m_15_2_5,false)	visible(img_m_15_2_6,false)
				visible(img_m_15_2_7,false)			visible(img_m_15_2_8,false)
				visible(txt_SF01,false)				visible(txt_SF01b,false)
				visible(txt_SF02,false)				visible(txt_SF02b,false)
				visible(txt_SF03,false)				visible(txt_SF03b,false)
				visible(txt_SF04,false)				visible(txt_SF04b,false)
				visible(txt_SF05,false)				visible(txt_SF05b,false)
				visible(txt_SF06,false)				visible(txt_SF06b,false)
				visible(txt_SF07,false)				visible(txt_SF07b,false)
				visible(txt_SF08,false)				visible(txt_SF08b,false)
			end

-- MENU 16 PAGE 1 BUTTONS	--	DISPLAYS AND VARIANTS
			
			if menu_page == 16 then						-- DISPLAY  PAGE
				visible(img_m_16_1_1,true)			visible(img_m_16_1_2,true)		visible(img_m_16_1_3,true)
				visible(img_m_16_1_4,true)			visible(img_m_16_1_5,true)		visible(img_m_16_1_6,true)
				visible(img_m_16_1_7,true)
			else
				visible(img_m_16_1_1,false)			visible(img_m_16_1_2,false)		visible(img_m_16_1_3,false)
				visible(img_m_16_1_4,false)			visible(img_m_16_1_5,false)		visible(img_m_16_1_6,false)
				visible(img_m_16_1_7,false)
			end

-- MENU 17 PAGE 1 BUTTONS	--	DOORS STATUS/COMMANDS
-- MENU 17 PAGE 2 BUTTONS	--	DOORS STATUS/COMMANDS

			if menu_page == 17 then									-- DISPLAY MAIN PAGE
				if page == 1 then
					visible(img_m_17_1_2,true)
					visible(img_m_17_1_3,true)
					visible(img_m_17_1_4,true)
					visible(img_m_17_1_6,true)
					visible(img_m_17_1_7,true)
					visible(img_m_17_1_8,true)

					visible(img_m_17_2_1,false)
					visible(img_m_17_2_2,false)
					visible(img_m_17_2_3,false)
					visible(img_m_17_2_4,false)

					-- MENU 17 PAGE 1 STATUS	--	DOORS STATUS/COMMANDS

					visible(img_m_17_1_2_cl,doors_status[1]==2)
					visible(img_m_17_1_3_cl,doors_status[2]==2)
					visible(img_m_17_1_4_cl,doors_status[3]==2)
					visible(img_m_17_1_6_cl,doors_status[4]==2)
					visible(img_m_17_1_7_cl,doors_status[5]==2)
					visible(img_m_17_1_8_cl,doors_status[6]==2)

					visible(img_m_17_1_2_mv,doors_status[1]==1)
					visible(img_m_17_1_3_mv,doors_status[2]==1)
					visible(img_m_17_1_4_mv,doors_status[3]==1)
					visible(img_m_17_1_6_mv,doors_status[4]==1)
					visible(img_m_17_1_7_mv,doors_status[5]==1)
					visible(img_m_17_1_8_mv,doors_status[6]==1)

					visible(img_m_17_1_2_op,doors_status[1]==0)
					visible(img_m_17_1_3_op,doors_status[2]==0)
					visible(img_m_17_1_4_op,doors_status[3]==0)
					visible(img_m_17_1_6_op,doors_status[4]==0)
					visible(img_m_17_1_7_op,doors_status[5]==0)
					visible(img_m_17_1_8_op,doors_status[6]==0)

					visible(img_m_17_1_2_wn,doors_status[1]==0)
					visible(img_m_17_1_3_wn,doors_status[2]==0)
					visible(img_m_17_1_4_wn,doors_status[3]==0)
					visible(img_m_17_1_6_wn,doors_status[4]==0)
					visible(img_m_17_1_7_wn,doors_status[5]==0)
					visible(img_m_17_1_8_wn,doors_status[6]==0)

					visible(img_m_17_1_2_lk,doors_lock[1]==1)
					visible(img_m_17_1_3_lk,doors_lock[2]==1)
					visible(img_m_17_1_4_lk,doors_lock[3]==1)
					visible(img_m_17_1_6_lk,doors_lock[4]==1)
					visible(img_m_17_1_7_lk,doors_lock[5]==1)
					visible(img_m_17_1_8_lk,doors_lock[6]==1)

					-- MENU 17 PAGE 2 STATUS	--	DOORS STATUS/COMMANDS

					visible(img_m_17_2_1_cl,false)
					visible(img_m_17_2_2_cl,false)
					visible(img_m_17_2_3_cl,false)
					visible(img_m_17_2_4_cl,false)

					visible(img_m_17_2_1_mv,false)
					visible(img_m_17_2_2_mv,false)
					visible(img_m_17_2_3_mv,false)
					visible(img_m_17_2_4_mv,false)

					visible(img_m_17_2_1_op,false)
					visible(img_m_17_2_2_op,false)
					visible(img_m_17_2_3_op,false)
					visible(img_m_17_2_4_op,false)

					visible(img_m_17_2_1_wn,false)
					visible(img_m_17_2_2_wn,false)
					visible(img_m_17_2_3_wn,false)
					visible(img_m_17_2_4_wn,false)

					visible(img_m_17_2_1_lk,false)
					visible(img_m_17_2_2_lk,false)
					visible(img_m_17_2_3_lk,false)
					visible(img_m_17_2_4_lk,false)
				else
					visible(img_m_17_1_2,false)
					visible(img_m_17_1_3,false)
					visible(img_m_17_1_4,false)
					visible(img_m_17_1_6,false)
					visible(img_m_17_1_7,false)
					visible(img_m_17_1_8,false)

					visible(img_m_17_2_1,true)
					visible(img_m_17_2_2,true)
					visible(img_m_17_2_3,true)
					visible(img_m_17_2_4,true)

					-- MENU 17 PAGE 1 STATUS	--	DOORS STATUS/COMMANDS

					visible(img_m_17_1_2_cl,false)
					visible(img_m_17_1_3_cl,false)
					visible(img_m_17_1_4_cl,false)
					visible(img_m_17_1_6_cl,false)
					visible(img_m_17_1_7_cl,false)
					visible(img_m_17_1_8_cl,false)

					visible(img_m_17_1_2_mv,false)
					visible(img_m_17_1_3_mv,false)
					visible(img_m_17_1_4_mv,false)
					visible(img_m_17_1_6_mv,false)
					visible(img_m_17_1_7_mv,false)
					visible(img_m_17_1_8_mv,false)

					visible(img_m_17_1_2_op,false)
					visible(img_m_17_1_3_op,false)
					visible(img_m_17_1_4_op,false)
					visible(img_m_17_1_6_op,false)
					visible(img_m_17_1_7_op,false)
					visible(img_m_17_1_8_op,false)

					visible(img_m_17_1_2_wn,false)
					visible(img_m_17_1_3_wn,false)
					visible(img_m_17_1_4_wn,false)
					visible(img_m_17_1_6_wn,false)
					visible(img_m_17_1_7_wn,false)
					visible(img_m_17_1_8_wn,false)

					visible(img_m_17_1_2_lk,false)
					visible(img_m_17_1_3_lk,false)
					visible(img_m_17_1_4_lk,false)
					visible(img_m_17_1_6_lk,false)
					visible(img_m_17_1_7_lk,false)
					visible(img_m_17_1_8_lk,false)

					-- MENU 17 PAGE 2 STATUS	--	DOORS STATUS/COMMANDS

					visible(img_m_17_2_1_cl,doors_status[7]==2)
					visible(img_m_17_2_2_cl,doors_status[8]==2)
					visible(img_m_17_2_3_cl,doors_status[9]==2)
					visible(img_m_17_2_4_cl,doors_status[10]==2)

					visible(img_m_17_2_1_mv,doors_status[7]==1)
					visible(img_m_17_2_2_mv,doors_status[8]==1)
					visible(img_m_17_2_3_mv,doors_status[9]==1)
					visible(img_m_17_2_4_mv,doors_status[10]==1)

					visible(img_m_17_2_1_op,doors_status[7]==0)
					visible(img_m_17_2_2_op,doors_status[8]==0)
					visible(img_m_17_2_3_op,doors_status[9]==0)
					visible(img_m_17_2_4_op,doors_status[10]==0)

					visible(img_m_17_2_1_wn,doors_status[7]==0)
					visible(img_m_17_2_2_wn,doors_status[8]==0)
					visible(img_m_17_2_3_wn,doors_status[9]==0)
					visible(img_m_17_2_4_wn,doors_status[10]==0)

					visible(img_m_17_2_1_lk,doors_lock[7]==1)
					visible(img_m_17_2_2_lk,doors_lock[8]==1)
					visible(img_m_17_2_3_lk,doors_lock[9]==1)
					visible(img_m_17_2_4_lk,doors_lock[10]==1)

				end
			else
					visible(img_m_17_1_2,false)
					visible(img_m_17_1_3,false)
					visible(img_m_17_1_4,false)
					visible(img_m_17_1_6,false)
					visible(img_m_17_1_7,false)
					visible(img_m_17_1_8,false)
					visible(img_m_17_2_1,false)
					visible(img_m_17_2_2,false)
					visible(img_m_17_2_3,false)
					visible(img_m_17_2_4,false)

					visible(img_m_17_1_2_cl,false)
					visible(img_m_17_1_3_cl,false)
					visible(img_m_17_1_4_cl,false)
					visible(img_m_17_1_6_cl,false)
					visible(img_m_17_1_7_cl,false)
					visible(img_m_17_1_8_cl,false)

					visible(img_m_17_1_2_mv,false)
					visible(img_m_17_1_3_mv,false)
					visible(img_m_17_1_4_mv,false)
					visible(img_m_17_1_6_mv,false)
					visible(img_m_17_1_7_mv,false)
					visible(img_m_17_1_8_mv,false)

					visible(img_m_17_1_2_op,false)
					visible(img_m_17_1_3_op,false)
					visible(img_m_17_1_4_op,false)
					visible(img_m_17_1_6_op,false)
					visible(img_m_17_1_7_op,false)
					visible(img_m_17_1_8_op,false)

					visible(img_m_17_1_2_wn,false)
					visible(img_m_17_1_3_wn,false)
					visible(img_m_17_1_4_wn,false)
					visible(img_m_17_1_6_wn,false)
					visible(img_m_17_1_7_wn,false)
					visible(img_m_17_1_8_wn,false)

					visible(img_m_17_1_2_lk,false)
					visible(img_m_17_1_3_lk,false)
					visible(img_m_17_1_4_lk,false)
					visible(img_m_17_1_6_lk,false)
					visible(img_m_17_1_7_lk,false)
					visible(img_m_17_1_8_lk,false)

					visible(img_m_17_2_1_cl,false)
					visible(img_m_17_2_2_cl,false)
					visible(img_m_17_2_3_cl,false)
					visible(img_m_17_2_4_cl,false)

					visible(img_m_17_2_1_mv,false)
					visible(img_m_17_2_2_mv,false)
					visible(img_m_17_2_3_mv,false)
					visible(img_m_17_2_4_mv,false)

					visible(img_m_17_2_1_op,false)
					visible(img_m_17_2_2_op,false)
					visible(img_m_17_2_3_op,false)
					visible(img_m_17_2_4_op,false)

					visible(img_m_17_2_1_wn,false)
					visible(img_m_17_2_2_wn,false)
					visible(img_m_17_2_3_wn,false)
					visible(img_m_17_2_4_wn,false)

					visible(img_m_17_2_1_lk,false)
					visible(img_m_17_2_2_lk,false)
					visible(img_m_17_2_3_lk,false)
					visible(img_m_17_2_4_lk,false)

			end

-- MENU FUEL/PAYLOAD PAGE

			if menu_page == 0 then		-- DISPLAY FUEL MANAGEMENT / PAYLOAD / CG ENVELOPE
				if fuel_mgmt == 1 then						-- DISPLAY FUEL/PAYLOAD PAGE
					visible(img_pldzone_bg,false)
					visible(img_cgenvkg_bg,false)		visible(img_cgenvlb_bg,false)		visible(img_c_lw_bg,false)
					visible(img_c_oew_bg,false)			visible(img_c_zfw_bg,false)			visible(img_c_tow_bg,false)
					visible(txt_oew_bg,false)			visible(txt_tow_bg,false)			visible(txt_zfw_bg,false)
					visible(txt_lw_bg,false)			visible(txt_oew,false)				visible(txt_tow,false)
					visible(txt_zfw,false)				visible(txt_lw,false)				visible(img_p_to_bg,false)
					visible(img_p_lnd_bg,false)			visible(img_p_brk_bg,false)			visible(img_p_ad,false)
					visible(img_p_mm_i,false)			visible(img_p_mm_o,false)			visible(img_p_ma_i,false)
					visible(img_p_ma_o,false)			visible(img_p_ab1_i,false)			visible(img_p_ab1_o,false)
					visible(img_p_ab2_i,false)			visible(img_p_ab2_o,false)			visible(img_p_ab3_i,false)
					visible(img_p_ab3_o,false)			visible(img_p_on_rw,false)			visible(img_p_out_rw,false)
					visible(img_aircraft_bg,false)		visible(img_aircraft_wgl,false)		visible(img_aircraft_ctr,false)
					visible(img_aircraft_wgr,false)		visible(img_aircraft_tk,false)		visible(img_aircraft_cg,false)
					if page == 0 then
						pr_all_off()
					elseif page == 1 then
						move(img_aircraft_cg,cg_memo+cg_pos,nil,nil,nil)
						move(img_aircraft_wgl,wt_memo-l_tank_lbs*1.6628/100,nil,nil,nil)
						move(img_aircraft_ctr,ct_memo-c_tank_lbs*3.6607/1000,nil,nil,nil)
						move(img_aircraft_wgr,wt_memo-r_tank_lbs*1.6628/100,nil,nil,nil)
						visible(img_aircraft_bg,true)	visible(img_aircraft_wgl,true)		visible(img_aircraft_ctr,true)
						visible(img_aircraft_wgr,true)	visible(img_aircraft_tk,true)		visible(img_aircraft_cg,true)
					elseif page == 2 then
						visible(img_pldzone_bg,true)
					elseif page == 3 then
						if fmcunits == 0 then
							visible(img_cgenvlb_bg,true)
						elseif fmcunits == 1 then
							visible(img_cgenvkg_bg,true)
						end
						if oew_cg > 0 then
							move(img_c_oew_bg,pr_x_cgenv(oew_cg),pr_y_cgenv(oew_weight),nil,nil)
							visible(img_c_oew_bg,true)
							txt_set(txt_oew_bg,oew_str)
							txt_set(txt_oew,oew_str)
							move(txt_oew_bg,pr_x_cgenv(oew_cg)+25*ybgratio,pr_y_cgenv(oew_weight)+1,nil,nil)
							move(txt_oew,pr_x_cgenv(oew_cg)+25*ybgratio,pr_y_cgenv(oew_weight)+2,nil,nil)
							visible(txt_oew_bg,true)
							visible(txt_oew,true)
						end
						if tow_cg > 0 then
							move(img_c_tow_bg,pr_x_cgenv(tow_cg),pr_y_cgenv(tow_weight),nil,nil)
							visible(img_c_tow_bg,true)
							txt_set(txt_tow_bg,tow_str)
							txt_set(txt_tow,tow_str)
							move(txt_tow_bg,pr_x_cgenv(tow_cg)+25*ybgratio,pr_y_cgenv(tow_weight)+1,nil,nil)
							move(txt_tow,pr_x_cgenv(tow_cg)+25*ybgratio,pr_y_cgenv(tow_weight)+2,nil,nil)
							visible(txt_tow_bg,true)
							visible(txt_tow,true)
						end
						if zfw_cg > 0 then
							move(img_c_zfw_bg,pr_x_cgenv(zfw_cg),pr_y_cgenv(zfw_weight),nil,nil)
							visible(img_c_zfw_bg,true)
							txt_set(txt_zfw_bg,zfw_str)
							txt_set(txt_zfw,zfw_str)
							move(txt_zfw_bg,pr_x_cgenv(zfw_cg)+25*ybgratio,pr_y_cgenv(zfw_weight)+1,nil,nil)
							move(txt_zfw,pr_x_cgenv(zfw_cg)+25*ybgratio,pr_y_cgenv(zfw_weight)+2,nil,nil)
							visible(txt_zfw_bg,true)
							visible(txt_zfw,true)
						end
						if lw_cg > 0 then
							move(img_c_lw_bg,pr_x_cgenv(lw_cg),pr_y_cgenv(lw_weight),nil,nil)
							visible(img_c_lw_bg,true)
							txt_set(txt_lw_bg,lw_str)
							txt_set(txt_lw,lw_str)
							move(txt_lw_bg,pr_x_cgenv(lw_cg)+25*ybgratio,pr_y_cgenv(lw_weight)+1,nil,nil)
							move(txt_lw,pr_x_cgenv(lw_cg)+25*ybgratio,pr_y_cgenv(lw_weight)+2,nil,nil)
							visible(txt_lw_bg,true)
							visible(txt_lw,true)
						end
					elseif page == 4 then
					end
				end
				visible(img_p_to_bg,false)		visible(img_p_lnd_bg,false)		visible(img_p_brk_bg,false)
				visible(img_p_ad,false)			visible(img_p_mm_i,false)		visible(img_p_mm_o,false)
				visible(img_p_ma_i,false)		visible(img_p_ma_o,false)		visible(img_p_ab1_i,false)
				visible(img_p_ab1_o,false)		visible(img_p_ab2_i,false)		visible(img_p_ab2_o,false)
				visible(img_p_ab3_i,false)		visible(img_p_ab3_o,false)		visible(img_p_on_rw,false)
				visible(img_p_out_rw,false)
				if bgperf_to == 1 then
					visible(img_p_to_bg,true)
				elseif bgperf_lnd == 1 and page == 1 then
					visible(img_p_lnd_bg,true)
				elseif bgperf_lnd == 1 and page == 2 then		-- PERFORMANCE LANDING
					visible(img_p_brk_bg,true)

		-- Center Line : Start = 98 / End = 691

					posy = math.floor(355 * ybgratio)
					posym = math.floor((434) * ybgratio)
					
					posx = math.floor((14 + prf_ad) * xbgratio)
					move(img_p_ad, posx, posy,nil,nil) visible(img_p_ad,true)
					posx_ad_tch = math.floor((14 + prf_ad + 84) * xbgratio)

					out_state = false

					posx = math.floor((84 + prf_ab1) * xbgratio)
					if prf_ab1_st == 1 then
						move(img_p_ab1_i, posx, posy,nil,nil) visible(img_p_ab1_i,true)
					elseif prf_ab1_st == 2 then
						move(img_p_ab1_o, posx, posy,nil,nil) visible(img_p_ab1_o,true)
						out_state = true
						out_start = prf_ab1
					end

					posx = math.floor((84 + prf_ab2) * xbgratio)
					if prf_ab2_st == 1 then
						move(img_p_ab2_i, posx, posy,nil,nil) visible(img_p_ab2_i,true)
					elseif prf_ab2_st == 2 then
						move(img_p_ab2_o, posx, posy,nil,nil) visible(img_p_ab2_o,true)
						out_state = true
						out_start = prf_ab2
					end

					posx = math.floor((84 + prf_ab3) * xbgratio)
					if prf_ab3_st == 1 then
						move(img_p_ab3_i, posx, posy,nil,nil) visible(img_p_ab3_i,true)
					elseif prf_ab3_st == 2 then
						move(img_p_ab3_o, posx, posy,nil,nil) visible(img_p_ab3_o,true)
						out_state = true
						out_start = prf_ab3
					end

					posx = math.floor((84 + prf_ma) * xbgratio)
					if prf_ma_st == 1 then
						move(img_p_ma_i, posx, posy,nil,nil) visible(img_p_ma_i,true)
					elseif prf_ma_st == 2 then
						move(img_p_ma_o, posx, posy,nil,nil) visible(img_p_ma_o,true)
						out_state = true
						out_start = prf_ma
					end

					posx = math.floor((84 + prf_mm) * xbgratio)
					if prf_mm_st == 1 then
						move(img_p_mm_i, posx, posy,nil,nil) visible(img_p_mm_i,true)
					elseif prf_mm_st == 2 then
						move(img_p_mm_o, posx, posy,nil,nil) visible(img_p_mm_o,true)
						out_state = true
						out_start = prf_mm
					end

					if out_state then
						length_on = math.floor((691) * xbgratio) - posx_ad_tch
						move(img_p_on_rw, posx_ad_tch, posym, length_on, nil) visible(img_p_on_rw,true)
						length_out = math.floor((84 + prf_ab1 + 20) * xbgratio - (691 * xbgratio))
						move(img_p_out_rw, math.floor((691) * xbgratio), posym, length_out, nil) visible(img_p_out_rw,true)
					else
						length_on = math.floor((84 + prf_ab1 + 20) * xbgratio) - posx_ad_tch
						move(img_p_on_rw, posx_ad_tch, posym, length_on, nil) visible(img_p_on_rw,true)
					end
				end
			else
				visible(btn_num_7,false)			visible(btn_num_8,false)			visible(btn_num_9,false)
				visible(btn_num_4,false)			visible(btn_num_5,false)			visible(btn_num_6,false)
				visible(btn_num_1,false)			visible(btn_num_2,false)			visible(btn_num_3,false)
				visible(btn_num_0,false)			visible(btn_num_c,false)			visible(btn_num_x,false)
				visible(btn_num_m,false)			visible(btn_num_p,false)			visible(btn_num_e,false)
				visible(txt_numpad,false)			visible(img_numpad,false)			visible(img_aircraft_bg,false)
				visible(img_aircraft_wgl,false)		visible(img_aircraft_ctr,false)		visible(img_aircraft_wgr,false)
				visible(img_aircraft_tk,false)		visible(img_aircraft_cg,false)		visible(img_pldzone_bg,false)
				visible(img_cgenvkg_bg,false)		visible(img_cgenvlb_bg,false)		visible(img_c_lw_bg,false)
				visible(img_c_oew_bg,false)			visible(img_c_zfw_bg,false)			visible(img_c_tow_bg,false)
				visible(txt_oew_bg,false)			visible(txt_tow_bg,false)			visible(txt_zfw_bg,false)
				visible(txt_lw_bg,false)			visible(txt_oew,false)				visible(txt_tow,false)
				visible(txt_zfw,false)				visible(txt_lw,false)				visible(img_p_to_bg,false)
				visible(img_p_lnd_bg,false)			visible(img_p_brk_bg,false)			visible(img_p_ad,false)
				visible(img_p_mm_i,false)			visible(img_p_mm_o,false)			visible(img_p_ma_i,false)
				visible(img_p_ma_o,false)			visible(img_p_ab1_i,false)			visible(img_p_ab1_o,false)
				visible(img_p_ab2_i,false)			visible(img_p_ab2_o,false)			visible(img_p_ab3_i,false)
				visible(img_p_ab3_o,false)			visible(img_p_on_rw,false)			visible(img_p_out_rw,false)
			end

-- MENU BUTTONS	MANAGEMENT

			if menuitems[1] == 1 then	-- MENU PAGES ARE DISPLAYED
				visible(btn_f1,true)
			else
				visible(btn_f1,false)				visible(btn_f2,false)				visible(btn_f3,false)
				visible(btn_f4,false)				visible(btn_f5,false)				visible(btn_f6,false)
				visible(btn_f7,false)				visible(btn_f8,false)
			end

			if menuitems[2] == 1 then
				visible(btn_f2,true)
			else
				visible(btn_f2,false)
			end
			
			if menuitems[3] == 1 then
				visible(btn_f3,true)
			else
				visible(btn_f3,false)
			end

			if menuitems[4] == 1 then
				visible(btn_f4,true)
			else
				visible(btn_f4,false)
			end

			if menuitems[5] == 1 then
				visible(btn_f5,true)
			else
				visible(btn_f5,false)
			end

			if menuitems[6] == 1 then
				visible(btn_f6,true)
			else
				visible(btn_f6,false)
			end

			if menuitems[7] == 1 then
				visible(btn_f7,true)
			else
				visible(btn_f7,false)
			end

			if menuitems[8] == 1 then
				visible(btn_f8,true)
			else
				visible(btn_f8,false)
			end

-- NAVIGATION BAR AND STATUS HANDLING
			
			if nav == 1 then
				visible(img_tb,true)
				visible(btn_info,true)
			else
				visible(img_tb,false)
				visible(btn_info,false)
			end

			if nav2 == 1 then
				visible(btn_left,true)
				visible(btn_right,true)
				visible(btn_credits,true)
			else
				visible(btn_left,false)
				visible(btn_right,false)
				visible(btn_credits,false)
			end

			if arrows_enable == 1 and menu_page ~= 8 then
				visible(btn_left,true)
				visible(btn_right,true)
			else
				visible(btn_left,false)
				visible(btn_right,false)
			end

			if items[1] == 1 then									-- DISPLAY CHECKBOX ON PAGE AS REQUIRED
				visible(img_chk1,true)
				visible(btn_mrkc1,true)
				if items_checked[1] == 1 then
					visible(img_ok1,true)
				else
					visible(img_ok1,false)
				end
				visible(btn_unmark,true)
			else
				visible(img_chk1,false)			visible(img_chk2,false)			visible(img_chk3,false)
				visible(img_chk4,false)			visible(img_chk5,false)			visible(img_chk6,false)
				visible(img_chk7,false)			visible(img_chk8,false)			visible(img_chk9,false)
				visible(img_ok1,false)			visible(img_ok2,false)			visible(img_ok3,false)
				visible(img_ok4,false)			visible(img_ok5,false)			visible(img_ok6,false)
				visible(img_ok7,false)			visible(img_ok8,false)			visible(img_ok9,false)
				visible(btn_unmark,false)		visible(btn_mrkc1,false)		visible(btn_mrkc2,false)
				visible(btn_mrkc3,false)		visible(btn_mrkc4,false)		visible(btn_mrkc5,false)
				visible(btn_mrkc6,false)		visible(btn_mrkc7,false)		visible(btn_mrkc8,false)
				visible(btn_mrkc9,false)
			end
			if items[2] == 1 then
				visible(img_chk2,true)
				visible(btn_mrkc2,true)
				if items_checked[2] == 1 then
					visible(img_ok2,true)
				else
					visible(img_ok2,false)
				end
			else
				visible(img_chk2,false)
				visible(img_ok2,false)
			end
			if items[3] == 1 then
				visible(img_chk3,true)
				visible(btn_mrkc3,true)
				if items_checked[3] == 1 then
					visible(img_ok3,true)
				else
					visible(img_ok3,false)
				end
			else
				visible(img_chk3,false)
				visible(img_ok3,false)
			end
			if items[4] == 1 then
				visible(img_chk4,true)
				visible(btn_mrkc4,true)
				if items_checked[4] == 1 then
					visible(img_ok4,true)
				else
					visible(img_ok4,false)
				end
			else
				visible(img_chk4,false)
				visible(img_ok4,false)
			end
			if items[5] == 1 then
				visible(img_chk5,true)
				visible(btn_mrkc5,true)
				if items_checked[5] == 1 then
					visible(img_ok5,true)
				else
					visible(img_ok5,false)
				end
			else
				visible(img_chk5,false)
				visible(img_ok5,false)
			end
			if items[6] == 1 then
				visible(img_chk6,true)
				visible(btn_mrkc6,true)
				if items_checked[6] == 1 then
					visible(img_ok6,true)
				else
					visible(img_ok6,false)
				end
			else
				visible(img_chk6,false)
				visible(img_ok6,false)
			end
			if items[7] == 1 then
				visible(img_chk7,true)
				visible(btn_mrkc7,true)
				if items_checked[7] == 1 then
					visible(img_ok7,true)
				else
					visible(img_ok7,false)
				end
			else
				visible(img_chk7,false)
				visible(img_ok7,false)
			end
			if items[8] == 1 then
				visible(img_chk8,true)
				visible(btn_mrkc8,true)
				if items_checked[8] == 1 then
					visible(img_ok8,true)
				else
					visible(img_ok8,false)
				end
			else
				visible(img_chk8,false)
				visible(img_ok8,false)
			end
			if items[9] == 1 then
				visible(img_chk9,true)
				visible(btn_mrkc9,true)
				if items_checked[9] == 1 then
					visible(img_ok9,true)
				else
					visible(img_ok9,false)
				end
			else
				visible(img_chk9,false)
				visible(img_ok9,false)
			end
		end
	end
end

function pr_all_off()									-- HIDE ALL OBJECTS AS REQUIRED
	visible(btn_back,false)				visible(btn_left,false)				visible(btn_right,false)
	visible(btn_home,false)				visible(btn_credits,false)
	visible(btn_f1,false)		visible(btn_f2,false)		visible(btn_f3,false)		visible(btn_f4,false)
	visible(btn_f5,false)		visible(btn_f6,false)		visible(btn_f7,false)		visible(btn_f8,false)
	visible(btn_info,false)		visible(btn_unmark,false)	visible(txt_time,false)
	visible(txt_rel1,false)		visible(txt_rel2,false)		visible(txt_rel3,false)
	visible(txt_L00,false)		visible(txt_L00bs,false)	visible(txt_L00c,false)		visible(txt_L00cs,false)	visible(txt_L00g,false)		visible(txt_L00s,false)
	visible(txt_L01,false)		visible(txt_L01a,false)		visible(txt_L01bs,false)	visible(txt_L01c,false)		visible(txt_L01cs,false)	visible(txt_L01g,false)		visible(txt_L01s,false)
	visible(txt_L02,false)		visible(txt_L02a,false)		visible(txt_L02bs,false)	visible(txt_L02c,false)		visible(txt_L02cs,false)	visible(txt_L02g,false)		visible(txt_L02s,false)			
	visible(txt_L03,false)		visible(txt_L03a,false)		visible(txt_L03bs,false)	visible(txt_L03c,false)		visible(txt_L03cs,false)	visible(txt_L03g,false)		visible(txt_L03s,false)
	visible(txt_L04,false)		visible(txt_L04a,false)		visible(txt_L04bs,false)	visible(txt_L04c,false)		visible(txt_L04cs,false)	visible(txt_L04g,false)		visible(txt_L04s,false)
	visible(txt_L05,false)		visible(txt_L05a,false)		visible(txt_L05bs,false)	visible(txt_L05c,false)		visible(txt_L05cs,false)	visible(txt_L05g,false)		visible(txt_L05s,false)			
	visible(txt_L06,false)		visible(txt_L06a,false)		visible(txt_L06bs,false)	visible(txt_L06c,false)		visible(txt_L06cs,false)	visible(txt_L06g,false)		visible(txt_L06s,false)
	visible(txt_L07,false)		visible(txt_L07a,false)		visible(txt_L07bs,false)	visible(txt_L07c,false)		visible(txt_L07cs,false)	visible(txt_L07g,false)		visible(txt_L07s,false)
	visible(txt_L08,false)		visible(txt_L08a,false)		visible(txt_L08bs,false)	visible(txt_L08c,false)		visible(txt_L08cs,false)	visible(txt_L08g,false)		visible(txt_L08s,false)
	visible(txt_L09,false)		visible(txt_L09a,false)		visible(txt_L09bs,false)	visible(txt_L09c,false)		visible(txt_L09cs,false)	visible(txt_L09g,false)		visible(txt_L09s,false)

	visible(img_m_1_1_1,false)			visible(img_m_1_1_2_1,false)
	visible(img_m_1_1_2_2,false)		visible(img_m_1_1_3_1,false)		visible(img_m_1_1_3_2,false)
	visible(img_m_1_1_4,false)			visible(img_m_1_1_5,false)			visible(img_m_1_1_6,false)
	visible(img_m_1_1_7,false)			visible(img_m_1_1_8,false)			visible(img_m_1_2_1,false)
	-- visible(img_m_1_2_2,false)				visible(img_m_1_2_3,false)
	visible(img_m_1_2_4,false)
	visible(img_m_2_1_1,false)			visible(img_m_2_1_2,false)			visible(img_m_2_1_3,false)
	visible(img_m_2_1_4,false)			visible(img_m_2_1_5,false)			visible(img_m_2_1_6,false)
	visible(img_m_2_1_7,false)			visible(img_m_2_1_8,false)			visible(img_m_3_1_1,false)
	visible(img_m_3_1_2,false)			visible(img_m_3_1_3,false)			visible(img_m_3_1_4,false)
	visible(img_m_3_1_5,false)			visible(img_m_3_1_8,false)			visible(img_m_4_1_1,false)
	visible(img_m_4_1_2,false)			visible(img_m_4_1_3,false)			visible(img_m_4_1_4,false)
	visible(img_m_4_1_5,false)			visible(img_m_4_1_6,false)			visible(img_m_4_1_7,false)
	visible(img_m_4_1_8,false)			visible(img_m_4_2_1,false)			visible(img_m_4_2_2,false)
	visible(img_m_4_2_3,false)			visible(img_m_4_2_4,false)			visible(img_m_4_2_5,false)
	visible(img_m_4_2_6,false)			visible(img_m_4_2_7,false)			visible(img_m_4_2_8,false)
	visible(img_m_4_3_1,false)			visible(img_m_4_3_2,false)			visible(img_m_4_3_3,false)
	visible(img_m_5_1_1,false)			visible(img_m_5_1_2,false)			visible(img_m_5_1_3,false)
	visible(img_m_5_1_4,false)			visible(img_m_5_1_5,false)			visible(img_m_5_1_6,false)
	visible(img_m_5_1_7,false)			visible(img_m_5_1_8,false)
	visible(img_m_6_1_1,false)			visible(img_m_6_1_2,false)
	visible(img_m_6_1_3,false)			visible(img_m_6_1_4,false)			visible(img_m_6_1_5,false)
	visible(img_m_6_1_6,false)			visible(img_m_6_1_7,false)			visible(img_m_6_1_8,false)
	visible(img_m_7_1_1,false)			visible(img_m_7_1_2,false)			visible(img_m_7_1_3,false)
	visible(img_m_7_1_4,false)			visible(img_m_7_1_5,false)			visible(img_m_7_1_6,false)
	visible(img_m_7_1_7,false)			visible(img_m_7_1_8,false)			visible(img_m_9_1_1_1,false)
	visible(img_m_9_1_1_2,false)		visible(img_m_9_1_2_1,false)		visible(img_m_9_1_2_2,false)
	visible(img_m_9_1_3,false)			visible(img_m_9_1_4_1,false)		visible(img_m_9_1_4_2,false)
	visible(img_m_9_1_5_1,false)		visible(img_m_9_1_5_2,false)		visible(img_m_9_1_6_1,false)
	visible(img_m_9_1_6_2,false)		visible(img_m_9_1_7,false)			visible(img_m_9_1_8,false)
	visible(img_m_10_1_1,false)			visible(img_m_10_1_2,false)			visible(img_m_10_1_3,false)
	visible(img_m_10_1_4,false)			visible(img_m_10_1_5,false)			visible(img_m_11_1_1,false)
	visible(img_m_11_1_2,false)			visible(img_m_11_1_3,false)			visible(img_m_11_1_4,false)
	visible(img_m_11_1_8,false)			visible(img_m_12_1_1,false)			visible(img_m_12_1_2,false)
	visible(img_m_12_1_3,false)			visible(img_m_12_1_4,false)			visible(img_m_12_1_5,false)
	visible(img_m_12_1_6,false)			visible(img_m_12_1_7,false)			visible(img_m_12_1_8,false)
	visible(img_m_13_1_1,false)			visible(img_m_13_1_2,false)			visible(img_m_13_1_3,false)
	visible(img_m_13_1_4,false)			visible(img_m_13_1_5,false)			visible(img_m_13_1_6,false)
	visible(img_m_13_1_7,false)			visible(img_m_13_1_8_0,false)
	visible(img_m_13_1_8_1,false)		visible(img_m_13_1_8_2,false)		visible(img_m_14_1_1,false)
	visible(img_m_14_1_2,false)			visible(img_m_14_1_3,false)			visible(img_m_14_1_4,false)
	visible(img_m_14_1_5_1,false)		visible(img_m_14_1_5_2,false)
	visible(img_m_15_1_1,false)			visible(img_m_15_1_2,false)			visible(img_m_15_1_3,false)
	visible(img_m_15_1_4,false)			visible(img_m_15_1_5,false)			visible(img_m_15_1_6,false)
	visible(img_m_15_1_7,false)			visible(img_m_15_1_8,false)
	visible(img_m_16_1_1,false)			visible(img_m_16_1_2,false)			visible(img_m_16_1_3,false)
	visible(img_m_16_1_4,false)			visible(img_m_16_1_5,false)			visible(img_m_16_1_6,false)
	visible(img_m_16_1_7,false)
	visible(img_cred1,false)			visible(img_cred2,false)			visible(img_cred3,false)			visible(img_cred4,false)
	visible(img_credstrip1,false)		visible(img_credstrip2,false)		visible(img_credstrip3,false)		visible(img_credstrip4,false)
	visible(img_credstrip5,false)
	visible(img_aircraft_cg,false)		visible(img_aircraft_tk,false)
	visible(img_aircraft_ctr,false)		visible(img_aircraft_wgl,false)		visible(img_aircraft_wgr,false)
	visible(img_aircraft_bg,false)		visible(img_info,false)				visible(img_pwron,false)
	visible(img_pwroff,false)			visible(img_bg,false)				visible(img_tb,false)
	visible(img_chk1,false)				visible(img_chk2,false)				visible(img_chk3,false)
	visible(img_chk4,false)				visible(img_chk5,false)				visible(img_chk6,false)
	visible(img_chk7,false)				visible(img_chk8,false)				visible(img_chk9,false)
	visible(img_ok1,false)				visible(img_ok2,false)				visible(img_ok3,false)
	visible(img_ok4,false)				visible(img_ok5,false)				visible(img_ok6,false)
	visible(img_ok7,false)				visible(img_ok8,false)				visible(img_ok9,false)
	visible(txt_FPS,false)				visible(img_pldzone_bg,false)		visible(img_cgenvkg_bg,false)
	visible(img_cgenvlb_bg,false)		visible(img_c_lw_bg,false)			visible(img_c_oew_bg,false)
	visible(img_c_zfw_bg,false)			visible(img_c_tow_bg,false)			visible(txt_oew_bg,false)
	visible(txt_tow_bg,false)			visible(txt_zfw_bg,false)			visible(txt_lw_bg,false)
	visible(txt_oew,false)				visible(txt_tow,false)				visible(txt_zfw,false)
	visible(txt_lw,false)				visible(img_p_to_bg,false)			visible(img_p_lnd_bg,false)
	visible(img_p_brk_bg,false)			visible(img_p_ad,false)				visible(img_p_mm_i,false)
	visible(img_p_mm_o,false)			visible(img_p_ma_i,false)			visible(img_p_ma_o,false)
	visible(img_p_ab1_i,false)			visible(img_p_ab1_o,false)			visible(img_p_ab2_i,false)
	visible(img_p_ab2_o,false)			visible(img_p_ab3_i,false)			visible(img_p_ab3_o,false)
	visible(img_p_on_rw,false)			visible(img_p_out_rw,false)			visible(img_p_lnd_rt0, false)
	visible(img_p_lnd_rt1, false)		visible(img_p_lnd_rt2, false)		visible(img_p_lnd_rt3, false)
	visible(img_p_lnd_rt4, false)		visible(img_p_lnd_rt5, false)		visible(img_p_appr_rt0, false)
	visible(img_p_appr_rt1, false)		visible(img_p_appr_rt2, false)		visible(img_p_appr_rt3, false)
	visible(img_p_appr_rt4, false)		visible(img_p_appr_rt5, false)		visible(img_numpad,false)
	visible(img_nummfk,false)			visible(img_numslh,false)			visible(img_numrnd,false)
	visible(img_numpax,false)
	visible(img_credstrip4m_bg,false)	visible(img_credstrip4m,false)		visible(img_credstrip5m_bg,false)
	visible(img_credstrip5m,false)		visible(img_credstrip6m_bg,false)	visible(img_credstrip6m,false)
	visible(img_credstrip7m_bg,false)	visible(img_credstrip7m,false)
	visible(txt_SF01,false)				visible(txt_SF01b,false)
	visible(txt_SF02,false)				visible(txt_SF02b,false)
	visible(txt_SF03,false)				visible(txt_SF03b,false)
	visible(txt_SF04,false)				visible(txt_SF04b,false)
	visible(txt_SF05,false)				visible(txt_SF05b,false)
	visible(txt_SF06,false)				visible(txt_SF06b,false)
	visible(txt_SF07,false)				visible(txt_SF07b,false)
	visible(txt_SF08,false)				visible(txt_SF08b,false)

	visible(img_m_17_1_2,false)
	visible(img_m_17_1_3,false)
	visible(img_m_17_1_4,false)
	visible(img_m_17_1_6,false)
	visible(img_m_17_1_7,false)
	visible(img_m_17_1_8,false)
	visible(img_m_17_2_1,false)
	visible(img_m_17_2_2,false)
	visible(img_m_17_2_3,false)
	visible(img_m_17_2_4,false)

	visible(img_m_17_1_2_cl,false)		visible(img_m_17_1_2_mv,false)		visible(img_m_17_1_2_op,false)			visible(img_m_17_1_2_wn,false)
	visible(img_m_17_1_3_cl,false)		visible(img_m_17_1_3_mv,false)		visible(img_m_17_1_3_op,false)			visible(img_m_17_1_3_wn,false)
	visible(img_m_17_1_4_cl,false)		visible(img_m_17_1_4_mv,false)		visible(img_m_17_1_4_op,false)			visible(img_m_17_1_4_wn,false)
	visible(img_m_17_1_6_cl,false)		visible(img_m_17_1_6_mv,false)		visible(img_m_17_1_6_op,false)			visible(img_m_17_1_6_wn,false)
	visible(img_m_17_1_7_cl,false)		visible(img_m_17_1_7_mv,false)		visible(img_m_17_1_7_op,false)			visible(img_m_17_1_7_wn,false)
	visible(img_m_17_1_8_cl,false)		visible(img_m_17_1_8_mv,false)		visible(img_m_17_1_8_op,false)			visible(img_m_17_1_8_wn,false)

	visible(img_m_17_1_2_lk,false)
	visible(img_m_17_1_3_lk,false)
	visible(img_m_17_1_4_lk,false)
	visible(img_m_17_1_6_lk,false)
	visible(img_m_17_1_7_lk,false)
	visible(img_m_17_1_8_lk,false)

	visible(img_m_17_2_1_cl,false)		visible(img_m_17_2_1_mv,false)		visible(img_m_17_2_1_op,false)			visible(img_m_17_2_1_wn,false)
	visible(img_m_17_2_2_cl,false)		visible(img_m_17_2_2_mv,false)		visible(img_m_17_2_2_op,false)			visible(img_m_17_2_2_wn,false)
	visible(img_m_17_2_3_cl,false)		visible(img_m_17_2_3_mv,false)		visible(img_m_17_2_3_op,false)			visible(img_m_17_2_3_wn,false)
	visible(img_m_17_2_4_cl,false)		visible(img_m_17_2_4_mv,false)		visible(img_m_17_2_4_op,false)			visible(img_m_17_2_4_wn,false)

	visible(img_m_17_2_1_lk,false)
	visible(img_m_17_2_2_lk,false)
	visible(img_m_17_2_3_lk,false)
	visible(img_m_17_2_4_lk,false)

	-- if tablet_show == 0 then
		-- visible(img_bk,false)
	-- end
end

function pr_saved_flights(f1,f1b,
								f2,f2b,
								f3,f3b,
								f4,f4b,
								f5,f5b,
								f6,f6b,
								f7,f7b,
								f8,f8b,
								f9,f9b)

					txt_set(txt_SF01,f1)
					txt_set(txt_SF01b,f1b)
					txt_set(txt_SF02,f2)
					txt_set(txt_SF02b,f2b)
					txt_set(txt_SF03,f3)
					txt_set(txt_SF03b,f3b)
					txt_set(txt_SF04,f4)
					txt_set(txt_SF04b,f4b)
					txt_set(txt_SF05,f5)
					txt_set(txt_SF05b,f5b)
					txt_set(txt_SF06,f6)
					txt_set(txt_SF06b,f6b)
					txt_set(txt_SF07,f7)
					txt_set(txt_SF07b,f7b)
					txt_set(txt_SF08,f8)
					txt_set(txt_SF08b,f8b)
					txt_set(txt_SF09,f9)
					txt_set(txt_SF09b,f9b)

end

-- function pr_tablet_show(tablet_state) -- HIDE/UNHIDE Z_2D_XP_EFB
	-- tablet_show = tablet_state
	-- if tablet_show == 0 then
		-- pr_all_off()
		-- visible(z_2d_xp_efb_id,false)
	-- else
		-- visible(z_2d_xp_efb_id,true)
	-- end
-- end

function pr_fps(fps_value,fps_enable,startupr,line,perf)
	if fps_value == nil then
		return
	end

	pr_prtdbg("XP STARTUP Running",startupr,"dbg16",false)		-- DEBUG						<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	gbl_startupr = startupr
	-- if gbl_startupr == 1 then
		-- visible(img_xprunon,true)
	-- else
		-- visible(img_xprunon,false)
	-- end
	if fps_enable == 0 then
--	if fps_enable == 0 or tablet_show == 0 then
		visible(txt_FPS,false)
	else
		if (boot_state == 0) and (power_state == 1) then
			FPS_num = tonumber(fps_value:sub(2,3))
			if flight_run_memo > 0.5 then
				if FPS_num > FPS_MAX then
					FPS_MAX = FPS_num
				end
				if FPS_num < FPS_min then
					FPS_min = FPS_num
				end
				FPS_int = math.floor((FPS_int + FPS_num)/2)
			end
			FPS_avg = FPS_min + math.floor((FPS_MAX-FPS_min)/2)
			FPS = FPS_avg
			-- str_Z_2D_XP_EFBFPS		= "  "..FPS_num.." FPS | AVG:"..FPS.." (min:"..FPS_min.."/MAX:"..FPS_MAX..") | X-Plane Flight Time = "..gbl_fl_time_disp
			-- txt_set(txt_FPS,str_Z_2D_XP_EFBFPS)
			visible(txt_FPS,true)
		end
	end
	visible(btn_l1,line[2] == 1) visible(btn_l2,line[3] == 1) visible(btn_l3,line[4] == 1)
	visible(btn_l4,line[5] == 1) visible(btn_l5,line[6] == 1) visible(btn_l6,line[7] == 1)
	visible(btn_l7,line[8] == 1) visible(btn_l8,line[9] == 1) visible(btn_l9,line[10] == 1)
	visible(btn_p1,perf[1] == 1) visible(btn_p2,perf[2] == 1) visible(btn_p3,perf[3] == 1)
	visible(btn_p4,perf[4] == 1) visible(btn_p5,perf[5] == 1) visible(btn_p6,perf[6] == 1)
	visible(btn_p7,perf[7] == 1) visible(btn_p8,perf[8] == 1) visible(btn_p9,perf[9] == 1)
	visible(btn_p10,perf[10] == 1) visible(btn_p11,perf[11] == 1) visible(btn_p12,perf[12] == 1)
	visible(btn_p13,perf[13] == 1) visible(btn_p14,perf[14] == 1) visible(btn_p15,perf[15] == 1)
	visible(btn_p16,perf[16] == 1)
end

----------------------------------------
--				DATAREF SUBSCRIBE
----------------------------------------

-- LUA type REFERENCES : 	Data type of the DataRef, can be INT,FLOAT,DOUBLE,INT[n],FLOAT[n],DOUBLE[n], BYTE[n] or STRING

xpl_dataref_subscribe("sim/time/total_flight_time_sec","FLOAT",									--	1	Flight Running Time
						pr_flight_running)

xpl_dataref_subscribe("sim/aircraft/view/acf_ICAO", "STRING",									--	1	Aircraft Description
					"sim/version/xplanee_internal_version","INT",								--	2	X-Plane Version
					pr_inst_launch)

xpl_dataref_subscribe("laminar/B738/fps", "STRING",
						"laminar/B738/fps_enable", "FLOAT",
						"sim/operation/prefs/startup_running", "INT",
						"laminar/B738/tab_manip/line", "FLOAT[10]",
						"laminar/B738/tab_manip/perf", "FLOAT[16]",
						pr_fps)

xpl_dataref_subscribe("laminar/B738/tab/line00", "STRING",
						"laminar/B738/tab/line00bs", "STRING",
						"laminar/B738/tab/line00c", "STRING",
						"laminar/B738/tab/line00cs", "STRING",
						"laminar/B738/tab/line00g", "STRING",
						"laminar/B738/tab/line00s", "STRING",
						"laminar/B738/tab/line01", "STRING",
						"laminar/B738/tab/line01a", "STRING",
						"laminar/B738/tab/line01bs", "STRING",
						"laminar/B738/tab/line01c", "STRING",
						"laminar/B738/tab/line01cs", "STRING",
						"laminar/B738/tab/line01g", "STRING",
						"laminar/B738/tab/line01s", "STRING",
						"laminar/B738/tab/line02", "STRING",
						"laminar/B738/tab/line02a", "STRING",
						"laminar/B738/tab/line02bs", "STRING",
						"laminar/B738/tab/line02c", "STRING",
						"laminar/B738/tab/line02cs", "STRING",
						"laminar/B738/tab/line02g", "STRING",
						"laminar/B738/tab/line02s", "STRING",
						"laminar/B738/tab/line03", "STRING",
						"laminar/B738/tab/line03a", "STRING",
						"laminar/B738/tab/line03bs", "STRING",
						"laminar/B738/tab/line03c", "STRING",
						"laminar/B738/tab/line03cs", "STRING",
						"laminar/B738/tab/line03g", "STRING",
						"laminar/B738/tab/line03s", "STRING",
						"laminar/B738/tab/line04", "STRING",
						"laminar/B738/tab/line04a", "STRING",
						"laminar/B738/tab/line04bs", "STRING",
						"laminar/B738/tab/line04c", "STRING",
						"laminar/B738/tab/line04cs", "STRING",
						"laminar/B738/tab/line04g", "STRING",
						"laminar/B738/tab/line04s", "STRING",
						"laminar/B738/tab/line05", "STRING",
						"laminar/B738/tab/line05a", "STRING",
						"laminar/B738/tab/line05bs", "STRING",
						"laminar/B738/tab/line05c", "STRING",
						"laminar/B738/tab/line05cs", "STRING",
						"laminar/B738/tab/line05g", "STRING",
						"laminar/B738/tab/line05s", "STRING",
						"laminar/B738/tab/line06", "STRING",
						"laminar/B738/tab/line06a", "STRING",
						"laminar/B738/tab/line06bs", "STRING",
						"laminar/B738/tab/line06c", "STRING",
						"laminar/B738/tab/line06cs", "STRING",
						"laminar/B738/tab/line06g", "STRING",
						"laminar/B738/tab/line06s", "STRING",
						"laminar/B738/tab/line07", "STRING",
						"laminar/B738/tab/line07a", "STRING",
						"laminar/B738/tab/line07bs", "STRING",
						"laminar/B738/tab/line07c", "STRING",
						"laminar/B738/tab/line07cs", "STRING",
						"laminar/B738/tab/line07g", "STRING",
						"laminar/B738/tab/line07s", "STRING",
						"laminar/B738/tab/line08", "STRING",
						"laminar/B738/tab/line08a", "STRING",
						"laminar/B738/tab/line08bs", "STRING",
						"laminar/B738/tab/line08c", "STRING",
						"laminar/B738/tab/line08cs", "STRING",
						"laminar/B738/tab/line08g", "STRING",
						"laminar/B738/tab/line08s", "STRING",
						"laminar/B738/tab/line09", "STRING",
						"laminar/B738/tab/line09a", "STRING",
						"laminar/B738/tab/line09bs", "STRING",
						"laminar/B738/tab/line09c", "STRING",
						"laminar/B738/tab/line09cs", "STRING",
						"laminar/B738/tab/line09g", "STRING",
						"laminar/B738/tab/line09s", "STRING",
						"laminar/B738/tab/efb_colorize", "FLOAT",
						pr_text_lines)

xpl_dataref_subscribe("laminar/B738/tab/numpad_val","STRING",
						pr_numpad)

xpl_dataref_subscribe("laminar/B738/tab/power", "FLOAT",								--	1	Tablet Powered ON ?
						"laminar/B738/tab/boot_active", "FLOAT",						--	2	Tablet currently booting ?
						"laminar/B738/tab_manip/nav", "FLOAT",							--	3	Top Bar displayed ?
						"laminar/B738/tab_manip/nav2", "FLOAT",							--	4	Bottom Bar displayed ?
						"laminar/B738/tab/arrows_enable", "FLOAT",						--	5	Arrows Enabled ?
						"laminar/B738/tab/credits", "FLOAT",							--	6	Credits current page
						"laminar/B738/tab/menu_page", "FLOAT",							--	7	Main page reference
						"laminar/B738/tab/page", "FLOAT",								--	8	Sub page
						"laminar/B738/tab_manip/menu", "FLOAT[8]",						--	9	Icon Menu present on location 1 to 8 ?
						"laminar/B738/tab/item", "FLOAT[9]",							--	10	Available step to be checked ?
						"laminar/B738/tab/item_checked", "FLOAT[9]",					--	11	Confirm done
						"laminar/b738/fmodpack/leg_started", "FLOAT",					--	12	Leg state
						"laminar/b738/fmodpack/fmod_play_cargo", "FLOAT",				--	13	Cargo Load State
						"laminar/B738/gpu_hide", "FLOAT",								--	14	Gpu hidden
						"laminar/B738/fms/chock_status", "FLOAT",						--	15	Chock State
						"laminar/B738/engine/engine_air_start", "FLOAT",				--	16	Ext Air Start State
						"laminar/B738/tab/numpad_act", "FLOAT",							--	17	Numpad active ?
						"laminar/B738/tab/bgnd_fuel", "FLOAT",							--	18	Fuel management ?
						"laminar/B738/tab/cg_pos", "FLOAT",								--	19	CG Position (Value)
						"laminar/B738/fuel/left_tank_lbs", "FLOAT",						--	20	Left Fuel tank QTY (LBS)
						"laminar/B738/fuel/center_tank_lbs", "FLOAT",					--	21	Center Fuel tank QTY (LBS)
						"laminar/B738/fuel/right_tank_lbs", "FLOAT",					--	22	Right Fuel tank QTY (LBS)
						"avitab/panel_enabled", "INT",									--	23	Avitab Panel display state
						"laminar/B738/de_ice_truck/hide", "FLOAT",						--	24	De-Icing Trucks state
						"laminar/B738/tab/page_info_time", "STRING",					--	25	Current Flight Time
						"laminar/B738/airstairs_hide", "FLOAT",							--	26	Airstairs state
						"laminar/B738/fms/unsupport_files", "INT",						--	27	UFiles
						"laminar/B738/fueltruck_hide", "FLOAT",							--	28	Fuel Trucks
						"laminar/B738/system/rst_fail_available", "FLOAT",				--	29	Failures Fix
						"sim/operation/prefs/using_experimental_fm", "FLOAT",			--	30	Experimental Flight Model
						"laminar/b738/custom_navdata_status", "FLOAT",					--	31	Custom Navdata
						"laminar/B738/FMS/fmc_units", "FLOAT",							--	32	FMC Units ... 0 = KGS / 1 = LBS
						"laminar/B738/tab_manip/line", "FLOAT[10]",						--	33	Manip Lines
						"laminar/B738/tab/oew_cg", "FLOAT",								--	34	range 0  .. 40 [% MAC] (if 0 then OEW is not displayed) - shift x coordinate
						"laminar/B738/tab/oew_weight", "FLOAT",							--	35	range 40 .. 80 [kg] (always in kg) - shift y coordinate
						"laminar/B738/tab/oew_str", "STRING",							--	36	string - text for OEW
						"laminar/B738/tab/tow_cg", "FLOAT",								--	37	range 0  .. 40 [% MAC] (if 0 then TOW is not displayed) - shift x coordinate
						"laminar/B738/tab/tow_weight", "FLOAT",							--	38	range 40 .. 80 [kg] (always in kg) - shift y coordinate
						"laminar/B738/tab/tow_str", "STRING",							--	39	string - text for TOW
						"laminar/B738/tab/zfw_cg", "FLOAT",								--	40	range 0  .. 40 [% MAC] (if 0 then ZFW is not displayed) - shift x coordinate
						"laminar/B738/tab/zfw_weight", "FLOAT",							--	41	range 40 .. 80 [kg] (always in kg) - shift y coordinate
						"laminar/B738/tab/zfw_str", "STRING",							--	42	string - text for ZFW
						"laminar/B738/tab/lw_cg", "FLOAT",								--	43	range 0  .. 40 [% MAC] (if 0 then LW is not displayed) - shift x coordinate
						"laminar/B738/tab/lw_weight", "FLOAT",							--	44	range 40 .. 80 [kg] (always in kg) - shift y coordinate
						"laminar/B738/tab/lw_str", "STRING",							--	45	string - text for LW
						"laminar/B738/tab/bgnd_perf_to", "FLOAT",						--	46	Active PERFS TAKEOFF PAGE
						"laminar/B738/tab/bgnd_perf_lnd", "FLOAT",						--	47	Active PERFS LANDING PAGE
						"laminar/B738/tab/perf_ab1", "FLOAT",							--	48	Autobrake 1 computed distance
						"laminar/B738/tab/perf_ab1_state", "FLOAT",						--	49	Autobrake 1 state
						"laminar/B738/tab/perf_ab2", "FLOAT",							--	50	Autobrake 2 computed distance
						"laminar/B738/tab/perf_ab2_state", "FLOAT",						--	51	Autobrake 2 state
						"laminar/B738/tab/perf_ab3", "FLOAT",							--	52	Autobrake 3 computed distance
						"laminar/B738/tab/perf_ab3_state", "FLOAT",						--	53	Autobrake 3 state
						"laminar/B738/tab/perf_ad", "FLOAT",							--	54	
						"laminar/B738/tab/perf_clearway", "FLOAT",						--	55	
						"laminar/B738/tab/perf_clearway_show", "FLOAT",					--	56	
						"laminar/B738/tab/perf_ma", "FLOAT",							--	57	Autobrake Auto MAX distance
						"laminar/B738/tab/perf_ma_state", "FLOAT",						--	58	Autobrake Auto MAX state
						"laminar/B738/tab/perf_mm", "FLOAT",							--	59	Autobrake Manual MAX distance
						"laminar/B738/tab/perf_mm_state", "FLOAT",						--	60	Autobrake Manual MAX state
						"laminar/B738/tab/perf_on_rwy", "FLOAT",						--	61	Runway Entry point
						"laminar/B738/tab/perf_out_rwy", "FLOAT",						--	62	Runway Exit point
						"laminar/B738/tab/perf_stopway", "FLOAT",						--	63	
						"laminar/B738/tab/perf_stopway_show", "FLOAT",					--	64	
						"laminar/B738/flight/landing_rating", "FLOAT",					--	65	LANDING RATE
						"laminar/B738/flight/landing_rating_show", "FLOAT",				--	66	LANDING RATE displayed
						"laminar/B738/tab/numpad_spec1", "FLOAT",						--	67	Numpad Spec1
						"laminar/B738/tab/numpad_spec2", "FLOAT",						--	68	Numpad Spec2
						"laminar/B738/flight/approach_rating", "FLOAT",					--	69	APPROACH RATE
						"laminar/B738/flight/approach_rating_show", "FLOAT",			--	70	APPROACH RATE displayed
						"laminar/B738/tab/autoload", "FLOAT",							--	71	EXISTING AUTOSAVED FLIGHT
						"laminar/b738/vanish_y_status", "FLOAT",						--	72	VANISH_Y status
						"laminar/B738/doors/status", "FLOAT[16]",						--	73	DOORS STATE
						"laminar/B738/doors/lock", "FLOAT[16]",							--	74	DOORS LOCK STATE
						"laminar/B738/tab/failure_save", "FLOAT",						--	75	SAVE FAILURE SETTINGS Message displayed
						pr_state)
						
xpl_dataref_subscribe("laminar/B738/fms/flight01","STRING",
						"laminar/B738/fms/flight01b","STRING",
						"laminar/B738/fms/flight02","STRING",
						"laminar/B738/fms/flight02b","STRING",
						"laminar/B738/fms/flight03","STRING",
						"laminar/B738/fms/flight03b","STRING",
						"laminar/B738/fms/flight04","STRING",
						"laminar/B738/fms/flight04b","STRING",
						"laminar/B738/fms/flight05","STRING",
						"laminar/B738/fms/flight05b","STRING",
						"laminar/B738/fms/flight06","STRING",
						"laminar/B738/fms/flight06b","STRING",
						"laminar/B738/fms/flight07","STRING",
						"laminar/B738/fms/flight07b","STRING",
						"laminar/B738/fms/flight08","STRING",
						"laminar/B738/fms/flight08b","STRING",
						"laminar/B738/fms/flight09","STRING",
						"laminar/B738/fms/flight09b","STRING",
						pr_saved_flights)

xpl_dataref_subscribe("laminar/B738/release","STRING",									--	1	ZiboMod B737-800X Release
						"laminar/B738/fmod_release","STRING",							--	2	Audiobirdxp FMOD Package Release
						"laminar/B738/fm_release","STRING",								--	3	Twkster Flight Model Release
						pr_release)

xpl_dataref_subscribe("laminar/B738/tab/page_info_pos","FLOAT",
						pr_info_pos)

--	"sim/network/misc/network_time_sec", "FLOAT",
--	"sim/network/misc/opentransport_inited", "INT",
--	"sim/operation/windows/system_window", "INT",
--	"sim/operation/windows/system_window_64, "INT[2]",


----------------------------------------
--				BUTTONS
----------------------------------------

-- TOOLS BUTTONS

btn_power	= button_add(nil,nil,1412,4,50,50,btn_power_clicked,nil) visible(btn_power,false)
btn_info	= button_add(nil,nil,1560,4,50,50,btn_info_clicked,nil) visible(btn_info,false)
btn_left	= button_add("prev.png","prev.png",     0, 593,75,75,btn_left_clicked,nil) visible(btn_left,false)
btn_right	= button_add("next.png","next.png",  1564, 593,75,75,btn_right_clicked,nil) visible(btn_right,false)
btn_back	= button_add("back.png","back.png",   383,1175,75,75,btn_back_clicked,nil) visible(btn_back,false)
btn_home	= button_add("home.png","home.png",   780,1175,75,75,btn_home_clicked,nil) visible(btn_home,false)
btn_credits	= button_add("users.png","users.png",1163,1175,75,75,btn_credits_clicked,nil) visible(btn_credits,false)
btn_unmark	= button_add("mark.png","unmark.png",1438,1170,75,75,btn_unmark_clicked,nil) visible(btn_unmark,false)

-- DEBUG FIELDS

txt_dbg_menu = txt_add("", style_5_a,   20, 1200, 250, 40)
txt_dbg_page = txt_add("", style_5_a,  195, 1200, x_width, 40)

-- LINE BUTTONS

l_start = line_start + 20
l_width = line_width - 40

btn_l1 = button_add(nil,nil,l_start, line_loc + lingap *  0,l_width,50,btn_l1_clicked,nil) visible(btn_l1,false)
btn_l2 = button_add(nil,nil,l_start, line_loc + lingap *  1,l_width,50,btn_l2_clicked,nil) visible(btn_l2,false)
btn_l3 = button_add(nil,nil,l_start, line_loc + lingap *  2,l_width,50,btn_l3_clicked,nil) visible(btn_l3,false)
btn_l4 = button_add(nil,nil,l_start, line_loc + lingap *  3,l_width,50,btn_l4_clicked,nil) visible(btn_l4,false)
btn_l5 = button_add(nil,nil,l_start, line_loc + lingap *  4,l_width,50,btn_l5_clicked,nil) visible(btn_l5,false)
btn_l6 = button_add(nil,nil,l_start, line_loc + lingap *  5,l_width,50,btn_l6_clicked,nil) visible(btn_l6,false)
btn_l7 = button_add(nil,nil,l_start, line_loc + lingap *  6,l_width,50,btn_l7_clicked,nil) visible(btn_l7,false)
btn_l8 = button_add(nil,nil,l_start, line_loc + lingap *  7,l_width,50,btn_l8_clicked,nil) visible(btn_l8,false)
btn_l9 = button_add(nil,nil,l_start, line_loc + lingap *  8,l_width,50,btn_l9_clicked,nil) visible(btn_l9,false)

-- PERFS BUTTONS

-- x=162 w=215 & X=407 w=215

-- x=285 w=180 & x=630 w=90

btn_p1	= button_add(nil,nil,162 * xbgratio, line_loc + lingap *  0,215 * xbgratio,50,btn_p1_clicked,nil) visible(btn_p1,false)
btn_p2	= button_add(nil,nil,162 * xbgratio, line_loc + lingap *  1,215 * xbgratio,50,btn_p2_clicked,nil) visible(btn_p2,false)
btn_p3	= button_add(nil,nil,162 * xbgratio, line_loc + lingap *  2,215 * xbgratio,50,btn_p3_clicked,nil) visible(btn_p3,false)
btn_p4	= button_add(nil,nil,162 * xbgratio, line_loc + lingap *  3,215 * xbgratio,50,btn_p4_clicked,nil) visible(btn_p4,false)
btn_p5	= button_add(nil,nil,162 * xbgratio, line_loc + lingap *  4,215 * xbgratio,50,btn_p5_clicked,nil) visible(btn_p5,false)
btn_p6	= button_add(nil,nil,162 * xbgratio, line_loc + lingap *  5,215 * xbgratio,50,btn_p6_clicked,nil) visible(btn_p6,false)
btn_p7	= button_add(nil,nil,162 * xbgratio, line_loc + lingap *  6,215 * xbgratio,50,btn_p7_clicked,nil) visible(btn_p7,false)
btn_p8	= button_add(nil,nil,285 * xbgratio, line_loc + lingap *  7,180 * xbgratio,50,btn_p8_clicked,nil) visible(btn_p8,false)
btn_p9	= button_add(nil,nil,407 * xbgratio, line_loc + lingap *  0,215 * xbgratio,50,btn_p9_clicked,nil) visible(btn_p9,false)
btn_p10	= button_add(nil,nil,407 * xbgratio, line_loc + lingap *  1,215 * xbgratio,50,btn_p10_clicked,nil) visible(btn_p10,false)
btn_p11	= button_add(nil,nil,407 * xbgratio, line_loc + lingap *  2,215 * xbgratio,50,btn_p11_clicked,nil) visible(btn_p11,false)
btn_p12	= button_add(nil,nil,407 * xbgratio, line_loc + lingap *  3,215 * xbgratio,50,btn_p12_clicked,nil) visible(btn_p12,false)
btn_p13	= button_add(nil,nil,407 * xbgratio, line_loc + lingap *  4,215 * xbgratio,50,btn_p13_clicked,nil) visible(btn_p13,false)
btn_p14	= button_add(nil,nil,407 * xbgratio, line_loc + lingap *  5,215 * xbgratio,50,btn_p14_clicked,nil) visible(btn_p14,false)
btn_p15	= button_add(nil,nil,407 * xbgratio, line_loc + lingap *  6,215 * xbgratio,50,btn_p15_clicked,nil) visible(btn_p15,false)
btn_p16	= button_add(nil,nil,630 * xbgratio, line_loc + lingap *  7,90  * xbgratio,50,btn_p16_clicked,nil) visible(btn_p16,false)

-- NUMPAD BUTTONS

-- NUMPAD IMG

-- 22 77 132
-- 92 144 196 248

-- Numpad Variables and Constants

local w_nump = 530
local zratio = w_nump / 237

-- 237 x 300 = 1.267
local hratio = 1.267
local h_nump = (w_nump * hratio)
local x_nump = math.floor(x_width / 2) - math.floor(w_nump / 2) + 30
local y_nump = 200

img_numpad = img_add("numpad1-1.png",x_nump,y_nump,w_nump,h_nump) visible(img_numpad,false)
img_nummfk = img_add("numpad_mfk-1.png",x_nump+74 *zratio, y_nump+244*zratio,48 * zratio,48 * zratio) visible(img_nummfk,false)
img_numslh = img_add("numpad_slash-1.png",x_nump+74 *zratio, y_nump+244*zratio,48 * zratio,48 * zratio) visible(img_numslh,false)
img_numrnd = img_add("numpad_rnd-1.png",x_nump-1, y_nump+42*ybgratio,48 * zratio,48 * zratio) visible(img_numrnd,false)
img_numpax = img_add("numpad_pax-1.png",x_nump-1, y_nump+42*ybgratio,48 * zratio,48 * zratio) visible(img_numpax,false)

img_add("73ng_cockpit_tablet_glass.png",0,0,x_width,y_height)

txt_numpad = txt_add("", style_3_dg,  x_nump +80, y_nump +102, 400, 80)

btn_num_7 = button_add(nil,nil, x_nump+22 *zratio, y_nump+92 *zratio,41 * zratio,41 * zratio,btn_num7_clicked,nil) visible(btn_num_7,false)
btn_num_8 = button_add(nil,nil, x_nump+77 *zratio, y_nump+92 *zratio,41 * zratio,41 * zratio,btn_num8_clicked,nil) visible(btn_num_8,false)
btn_num_9 = button_add(nil,nil, x_nump+132*zratio, y_nump+92 *zratio,41 * zratio,41 * zratio,btn_num9_clicked,nil) visible(btn_num_9,false)
btn_num_4 = button_add(nil,nil, x_nump+22 *zratio, y_nump+144*zratio,41 * zratio,41 * zratio,btn_num4_clicked,nil) visible(btn_num_4,false)
btn_num_5 = button_add(nil,nil, x_nump+77 *zratio, y_nump+144*zratio,41 * zratio,41 * zratio,btn_num5_clicked,nil) visible(btn_num_5,false)
btn_num_6 = button_add(nil,nil, x_nump+132*zratio, y_nump+144*zratio,41 * zratio,41 * zratio,btn_num6_clicked,nil) visible(btn_num_6,false)
btn_num_1 = button_add(nil,nil, x_nump+22 *zratio, y_nump+196*zratio,41 * zratio,41 * zratio,btn_num1_clicked,nil) visible(btn_num_1,false)
btn_num_2 = button_add(nil,nil, x_nump+77 *zratio, y_nump+196*zratio,41 * zratio,41 * zratio,btn_num2_clicked,nil) visible(btn_num_2,false)
btn_num_3 = button_add(nil,nil, x_nump+132*zratio, y_nump+196*zratio,41 * zratio,41 * zratio,btn_num3_clicked,nil) visible(btn_num_3,false)
btn_num_0 = button_add(nil,nil, x_nump+25 *zratio, y_nump+248*zratio,41 * zratio,41 * zratio,btn_num0_clicked,nil) visible(btn_num_0,false)
btn_num_c = button_add(nil,nil, x_nump+122*ybgratio, y_nump+3  *ybgratio,58,63,btn_num_c_clicked,nil) visible(btn_num_c,false)
btn_num_x = button_add(nil,nil, x_nump+159*ybgratio, y_nump+3  *ybgratio,58,63,btn_num_x_clicked,nil) visible(btn_num_x,false)
btn_num_m = button_add(nil,nil, x_nump+12 *ybgratio, y_nump+51 *ybgratio,56,61,btn_num_m_clicked,nil) visible(btn_num_m,false)
btn_num_p = button_add(nil,nil, x_nump+77 *zratio, y_nump+248*zratio,41 * zratio,41 * zratio,btn_num_p_clicked,nil) visible(btn_num_p,false)
btn_num_e = button_add(nil,nil, x_nump+132*zratio, y_nump+248*zratio,41 * zratio,41 * zratio,btn_num_e_clicked,nil) visible(btn_num_e,false)

-- MENU BUTTONS PRESSED LIGHTING

btn_f1 = button_add(nil,"menu_mark.png",c1_btn,l1_btn,x_btn,y_btn,btn_nothing,btn_f1_clicked) visible(btn_f1,false)
btn_f2 = button_add(nil,"menu_mark.png",c2_btn,l1_btn,x_btn,y_btn,btn_nothing,btn_f2_clicked) visible(btn_f2,false)
btn_f3 = button_add(nil,"menu_mark.png",c3_btn,l1_btn,x_btn,y_btn,btn_nothing,btn_f3_clicked) visible(btn_f3,false)
btn_f4 = button_add(nil,"menu_mark.png",c4_btn,l1_btn,x_btn,y_btn,btn_nothing,btn_f4_clicked) visible(btn_f4,false)
btn_f5 = button_add(nil,"menu_mark.png",c1_btn,l2_btn,x_btn,y_btn,btn_nothing,btn_f5_clicked) visible(btn_f5,false)
btn_f6 = button_add(nil,"menu_mark.png",c2_btn,l2_btn,x_btn,y_btn,btn_nothing,btn_f6_clicked) visible(btn_f6,false)
btn_f7 = button_add(nil,"menu_mark.png",c3_btn,l2_btn,x_btn,y_btn,btn_nothing,btn_f7_clicked) visible(btn_f7,false)
btn_f8 = button_add(nil,"menu_mark.png",c4_btn,l2_btn,x_btn,y_btn,btn_nothing,btn_f8_clicked) visible(btn_f8,false)

-- pr_inst_launch(xplane_aircraft_memo,xplane_version_memo)



--====================
--=====================

opacity(img_bk, 0.0)
opacity(img_bg, 0.0)
opacity(img_xprunning_bg, 0.0)
opacity(img_acft_status, 0.0)
opacity(img_not_xp_status, 0.0)
opacity(img_not_aircraft_status, 0.0)
opacity(img_m_1_1_1, 0.0)
opacity(img_m_1_1_2_1, 0.0)
opacity(img_m_1_1_2_2, 0.0)
opacity(img_m_1_1_3_1, 0.0)
opacity(img_m_1_1_3_2, 0.0)
opacity(img_m_1_1_4, 0.0)
opacity(img_m_1_1_5, 0.0)
opacity(img_m_1_1_6, 0.0)
opacity(img_m_1_1_7, 0.0)
opacity(img_m_1_1_8, 0.0)
opacity(img_m_1_2_1, 0.0)
opacity(img_m_1_2_4, 0.0)
opacity(img_m_2_1_1, 0.0)
opacity(img_m_2_1_2, 0.0)
opacity(img_m_2_1_3, 0.0)
opacity(img_m_2_1_4, 0.0)
opacity(img_m_2_1_5, 0.0)
opacity(img_m_2_1_6, 0.0)
opacity(img_m_2_1_7, 0.0)
opacity(img_m_2_1_8, 0.0)
opacity(img_m_3_1_1, 0.0)
opacity(img_m_3_1_2, 0.0)
opacity(img_m_3_1_3, 0.0)
opacity(img_m_3_1_4, 0.0)
opacity(img_m_3_1_5, 0.0)
opacity(img_m_3_1_8, 0.0)
opacity(img_m_4_1_1, 0.0)
opacity(img_m_4_1_2, 0.0)
opacity(img_m_4_1_3, 0.0)
opacity(img_m_4_1_4, 0.0)
opacity(img_m_4_1_5, 0.0)
opacity(img_m_4_1_6, 0.0)
opacity(img_m_4_1_7, 0.0)
opacity(img_m_4_1_8, 0.0)
opacity(img_m_4_2_1, 0.0)
opacity(img_m_4_2_2, 0.0)
opacity(img_m_4_2_3, 0.0)
opacity(img_m_4_2_4, 0.0)
opacity(img_m_4_2_5, 0.0)
opacity(img_m_4_2_6, 0.0)
opacity(img_m_4_2_7, 0.0)
opacity(img_m_4_2_8, 0.0)
opacity(img_m_4_3_1, 0.0)
opacity(img_m_4_3_2, 0.0)
opacity(img_m_4_3_3, 0.0)
opacity(img_m_5_1_1, 0.0)
opacity(img_m_5_1_2, 0.0)
opacity(img_m_5_1_3, 0.0)
opacity(img_m_5_1_4, 0.0)
opacity(img_m_5_1_5, 0.0)
opacity(img_m_5_1_6, 0.0)
opacity(img_m_5_1_7, 0.0)
opacity(img_m_5_1_8, 0.0)
opacity(img_m_6_1_1, 0.0)
opacity(img_m_6_1_2, 0.0)
opacity(img_m_6_1_3, 0.0)
opacity(img_m_6_1_4, 0.0)
opacity(img_m_6_1_5, 0.0)
opacity(img_m_6_1_6, 0.0)
opacity(img_m_6_1_7, 0.0)
opacity(img_m_6_1_8, 0.0)
opacity(img_m_7_1_1, 0.0)
opacity(img_m_7_1_2, 0.0)
opacity(img_m_7_1_3, 0.0)
opacity(img_m_7_1_4, 0.0)
opacity(img_m_7_1_5, 0.0)
opacity(img_m_7_1_6, 0.0)
opacity(img_m_7_1_7, 0.0)
opacity(img_m_7_1_8, 0.0)
opacity(img_m_9_1_1_1, 0.0)
opacity(img_m_9_1_1_2, 0.0)
opacity(img_m_9_1_2_1, 0.0)
opacity(img_m_9_1_2_2, 0.0)
opacity(img_m_9_1_3, 0.0)
opacity(img_m_9_1_4_1, 0.0)
opacity(img_m_9_1_4_2, 0.0)
opacity(img_m_9_1_5_1, 0.0)
opacity(img_m_9_1_5_2, 0.0)
opacity(img_m_9_1_6_1, 0.0)
opacity(img_m_9_1_6_2, 0.0)
opacity(img_m_9_1_7, 0.0)
opacity(img_m_9_1_8, 0.0)
opacity(img_m_10_1_1, 0.0)
opacity(img_m_10_1_2, 0.0)
opacity(img_m_10_1_3, 0.0)
opacity(img_m_10_1_4, 0.0)
opacity(img_m_10_1_5, 0.0)
opacity(img_m_11_1_1, 0.0)
opacity(img_m_11_1_2, 0.0)
opacity(img_m_11_1_3, 0.0)
opacity(img_m_11_1_4, 0.0)
opacity(img_m_11_1_8, 0.0)
opacity(img_m_12_1_1, 0.0)
opacity(img_m_12_1_2, 0.0)
opacity(img_m_12_1_3, 0.0)
opacity(img_m_12_1_4, 0.0)
opacity(img_m_12_1_5, 0.0)
opacity(img_m_12_1_6, 0.0)
opacity(img_m_12_1_7, 0.0)
opacity(img_m_12_1_8, 0.0)
opacity(img_m_13_1_1, 0.0)
opacity(img_m_13_1_2, 0.0)
opacity(img_m_13_1_3, 0.0)
opacity(img_m_13_1_4, 0.0)
opacity(img_m_13_1_5, 0.0)
opacity(img_m_13_1_6, 0.0)
opacity(img_m_13_1_7, 0.0)
opacity(img_m_13_1_8_0, 0.0)
opacity(img_m_13_1_8_1, 0.0)
opacity(img_m_13_1_8_2, 0.0)
opacity(img_m_14_1_1, 0.0)
opacity(img_m_14_1_2, 0.0)
opacity(img_m_14_1_3, 0.0)
opacity(img_m_14_1_4, 0.0)
opacity(img_m_14_1_5_1, 0.0)
opacity(img_m_14_1_5_2, 0.0)
opacity(img_m_15_1_1, 0.0)
opacity(img_m_15_1_2, 0.0)
opacity(img_m_15_1_3, 0.0)
opacity(img_m_15_1_4, 0.0)
opacity(img_m_15_1_5, 0.0)
opacity(img_m_15_1_6, 0.0)
opacity(img_m_15_1_7, 0.0)
opacity(img_m_15_1_8, 0.0)
opacity(img_m_15_2_1, 0.0)
opacity(img_m_15_2_2, 0.0)
opacity(img_m_15_2_3, 0.0)
opacity(img_m_15_2_4, 0.0)
opacity(img_m_15_2_5, 0.0)
opacity(img_m_15_2_6, 0.0)
opacity(img_m_15_2_7, 0.0)
opacity(img_m_15_2_8, 0.0)
opacity(img_m_16_1_1, 0.0)
opacity(img_m_16_1_2, 0.0)
opacity(img_m_16_1_3, 0.0)
opacity(img_m_16_1_4, 0.0)
opacity(img_m_16_1_5, 0.0)
opacity(img_m_16_1_6, 0.0)
opacity(img_m_16_1_7, 0.0)
opacity(img_m_17_1_2, 0.0)
opacity(img_m_17_1_3, 0.0)
opacity(img_m_17_1_4, 0.0)
opacity(img_m_17_1_6, 0.0)
opacity(img_m_17_1_7, 0.0)
opacity(img_m_17_1_8, 0.0)
opacity(img_m_17_2_1, 0.0)
opacity(img_m_17_2_2, 0.0)
opacity(img_m_17_2_3, 0.0)
opacity(img_m_17_2_4, 0.0)
opacity(img_m_17_1_2_cl, 0.0)
opacity(img_m_17_1_3_cl, 0.0)
opacity(img_m_17_1_4_cl, 0.0)
opacity(img_m_17_1_6_cl, 0.0)
opacity(img_m_17_1_7_cl, 0.0)
opacity(img_m_17_1_8_cl, 0.0)
opacity(img_m_17_1_2_mv, 0.0)
opacity(img_m_17_1_3_mv, 0.0)
opacity(img_m_17_1_4_mv, 0.0)
opacity(img_m_17_1_6_mv, 0.0)
opacity(img_m_17_1_7_mv, 0.0)
opacity(img_m_17_1_8_mv, 0.0)
opacity(img_m_17_1_2_op, 0.0)
opacity(img_m_17_1_3_op, 0.0)
opacity(img_m_17_1_4_op, 0.0)
opacity(img_m_17_1_6_op, 0.0)
opacity(img_m_17_1_7_op, 0.0)
opacity(img_m_17_1_8_op, 0.0)
opacity(img_m_17_1_2_wn, 0.0)
opacity(img_m_17_1_3_wn, 0.0)
opacity(img_m_17_1_4_wn, 0.0)
opacity(img_m_17_1_6_wn, 0.0)
opacity(img_m_17_1_7_wn, 0.0)
opacity(img_m_17_1_8_wn, 0.0)
opacity(img_m_17_1_2_lk, 0.0)
opacity(img_m_17_1_3_lk, 0.0)
opacity(img_m_17_1_4_lk, 0.0)
opacity(img_m_17_1_6_lk, 0.0)
opacity(img_m_17_1_7_lk, 0.0)
opacity(img_m_17_1_8_lk, 0.0)
opacity(img_m_17_2_1_cl, 0.0)
opacity(img_m_17_2_2_cl, 0.0)
opacity(img_m_17_2_3_cl, 0.0)
opacity(img_m_17_2_4_cl, 0.0)
opacity(img_m_17_2_1_mv, 0.0)
opacity(img_m_17_2_2_mv, 0.0)
opacity(img_m_17_2_3_mv, 0.0)
opacity(img_m_17_2_4_mv, 0.0)
opacity(img_m_17_2_1_op, 0.0)
opacity(img_m_17_2_2_op, 0.0)
opacity(img_m_17_2_3_op, 0.0)
opacity(img_m_17_2_4_op, 0.0)
opacity(img_m_17_2_1_wn, 0.0)
opacity(img_m_17_2_2_wn, 0.0)
opacity(img_m_17_2_3_wn, 0.0)
opacity(img_m_17_2_4_wn, 0.0)
opacity(img_m_17_2_1_lk, 0.0)
opacity(img_m_17_2_2_lk, 0.0)
opacity(img_m_17_2_3_lk, 0.0)
opacity(img_m_17_2_4_lk, 0.0)
opacity(img_cred1, 0.0)
opacity(img_cred2, 0.0)
opacity(img_cred3, 0.0)
opacity(img_cred4, 0.0)
opacity(img_cred5, 0.0)
opacity(img_credstrip1, 0.0)
opacity(img_credstrip2, 0.0)
opacity(img_credstrip3, 0.0)
opacity(img_credstrip4, 0.0)
opacity(img_credstrip5, 0.0)
opacity(img_credstrip4m_bg, 0.0)
opacity(img_credstrip4m, 0.0)
opacity(img_credstrip5m_bg, 0.0)
opacity(img_credstrip5m, 0.0)
opacity(img_credstrip6m_bg, 0.0)
opacity(img_credstrip6m, 0.0)
opacity(img_credstrip7m_bg, 0.0)
opacity(img_credstrip7m, 0.0)
opacity(img_aircraft_bg, 0.0)
opacity(img_aircraft_wgr, 0.0)
opacity(img_aircraft_ctr, 0.0)
opacity(img_aircraft_wgl, 0.0)
opacity(img_aircraft_tk, 0.0)
opacity(img_aircraft_cg, 0.0)
opacity(img_pldzone_bg, 0.0)
opacity(img_cgenvkg_bg, 0.0)
opacity(img_cgenvlb_bg, 0.0)
opacity(img_c_lw_bg, 0.0)
opacity(img_c_oew_bg, 0.0)
opacity(img_c_zfw_bg, 0.0)
opacity(img_c_tow_bg, 0.0)
opacity(img_p_to_bg, 0.0)
opacity(img_p_lnd_bg, 0.0)
opacity(img_p_brk_bg, 0.0)
opacity(img_p_ad, 0.0)
opacity(img_p_mm_i, 0.0)
opacity(img_p_mm_o, 0.0)
opacity(img_p_ma_i, 0.0)
opacity(img_p_ma_o, 0.0)
opacity(img_p_ab1_i, 0.0)
opacity(img_p_ab1_o, 0.0)
opacity(img_p_ab2_i, 0.0)
opacity(img_p_ab2_o, 0.0)
opacity(img_p_ab3_i, 0.0)
opacity(img_p_ab3_o, 0.0)
opacity(img_p_on_rw, 0.0)
opacity(img_p_out_rw, 0.0)
opacity(img_p_lnd_rt0, 0.0)
opacity(img_p_lnd_rt1, 0.0)
opacity(img_p_lnd_rt2, 0.0)
opacity(img_p_lnd_rt3, 0.0)
opacity(img_p_lnd_rt4, 0.0)
opacity(img_p_lnd_rt5, 0.0)
opacity(img_p_appr_rt0, 0.0)
opacity(img_p_appr_rt1, 0.0)
opacity(img_p_appr_rt2, 0.0)
opacity(img_p_appr_rt3, 0.0)
opacity(img_p_appr_rt4, 0.0)
opacity(img_p_appr_rt5, 0.0)
opacity(img_info, 0.0)
opacity(img_tb, 0.0)
opacity(img_xprunoff, 0.0)
opacity(img_xprunon, 0.0)
opacity(img_pwroff, 0.0)
opacity(img_pwron, 0.0)
opacity(img_chk1, 0.0)
opacity(img_chk2, 0.0)
opacity(img_chk3, 0.0)
opacity(img_chk4, 0.0)
opacity(img_chk5, 0.0)
opacity(img_chk6, 0.0)
opacity(img_chk7, 0.0)
opacity(img_chk8, 0.0)
opacity(img_chk9, 0.0)
opacity(img_ok1, 0.0)
opacity(img_ok2, 0.0)
opacity(img_ok3, 0.0)
opacity(img_ok4, 0.0)
opacity(img_ok5, 0.0)
opacity(img_ok6, 0.0)
opacity(img_ok7, 0.0)
opacity(img_ok8, 0.0)
opacity(img_ok9, 0.0)
opacity(img_auto_ld, 0.0)
opacity(img_fail_sv, 0.0)
opacity(img_auto_ld_y, 0.0)
opacity(img_auto_ld_n, 0.0)
opacity(img_numpad, 0.0)
opacity(img_nummfk, 0.0)
opacity(img_numslh, 0.0)
opacity(img_numrnd, 0.0)
opacity(img_numpax, 0.0)

opacity(txt_lw_bg, 0.0)
opacity(txt_oew_bg, 0.0)
opacity(txt_zfw_bg, 0.0)
opacity(txt_tow_bg, 0.0)
opacity(txt_lw, 0.0)
opacity(txt_oew, 0.0)
opacity(txt_zfw, 0.0)
opacity(txt_tow, 0.0)
opacity(txt_L00, 0.0)
opacity(txt_L01, 0.0)
opacity(txt_L02, 0.0)
opacity(txt_L03, 0.0)
opacity(txt_L04, 0.0)
opacity(txt_L05, 0.0)
opacity(txt_L06, 0.0)
opacity(txt_L07, 0.0)
opacity(txt_L08, 0.0)
opacity(txt_L09, 0.0)
opacity(txt_L01a, 0.0)
opacity(txt_L02a, 0.0)
opacity(txt_L03a, 0.0)
opacity(txt_L04a, 0.0)
opacity(txt_L05a, 0.0)
opacity(txt_L06a, 0.0)
opacity(txt_L07a, 0.0)
opacity(txt_L08a, 0.0)
opacity(txt_L09a, 0.0)
opacity(txt_L00bs, 0.0)
opacity(txt_L01bs, 0.0)
opacity(txt_L02bs, 0.0)
opacity(txt_L03bs, 0.0)
opacity(txt_L04bs, 0.0)
opacity(txt_L05bs, 0.0)
opacity(txt_L06bs, 0.0)
opacity(txt_L07bs, 0.0)
opacity(txt_L08bs, 0.0)
opacity(txt_L09bs, 0.0)
opacity(txt_L00c, 0.0)
opacity(txt_L01c, 0.0)
opacity(txt_L02c, 0.0)
opacity(txt_L03c, 0.0)
opacity(txt_L04c, 0.0)
opacity(txt_L05c, 0.0)
opacity(txt_L06c, 0.0)
opacity(txt_L07c, 0.0)
opacity(txt_L08c, 0.0)
opacity(txt_L09c, 0.0)
opacity(txt_L00cs, 0.0)
opacity(txt_L01cs, 0.0)
opacity(txt_L02cs, 0.0)
opacity(txt_L03cs, 0.0)
opacity(txt_L04cs, 0.0)
opacity(txt_L05cs, 0.0)
opacity(txt_L06cs, 0.0)
opacity(txt_L07cs, 0.0)
opacity(txt_L08cs, 0.0)
opacity(txt_L09cs, 0.0)
opacity(txt_L00g, 0.0)
opacity(txt_L01g, 0.0)
opacity(txt_L02g, 0.0)
opacity(txt_L03g, 0.0)
opacity(txt_L04g, 0.0)
opacity(txt_L05g, 0.0)
opacity(txt_L06g, 0.0)
opacity(txt_L07g, 0.0)
opacity(txt_L08g, 0.0)
opacity(txt_L09g, 0.0)
opacity(txt_L00s, 0.0)
opacity(txt_L01s, 0.0)
opacity(txt_L02s, 0.0)
opacity(txt_L03s, 0.0)
opacity(txt_L04s, 0.0)
opacity(txt_L05s, 0.0)
opacity(txt_L06s, 0.0)
opacity(txt_L07s, 0.0)
opacity(txt_L08s, 0.0)
opacity(txt_L09s, 0.0)
opacity(txt_SF01, 0.0)
opacity(txt_SF01b, 0.0)
opacity(txt_SF02, 0.0)
opacity(txt_SF02b, 0.0)
opacity(txt_SF03, 0.0)
opacity(txt_SF03b, 0.0)
opacity(txt_SF04, 0.0)
opacity(txt_SF04b, 0.0)
opacity(txt_SF05, 0.0)
opacity(txt_SF05b, 0.0)
opacity(txt_SF06, 0.0)
opacity(txt_SF06b, 0.0)
opacity(txt_SF07, 0.0)
opacity(txt_SF07b, 0.0)
opacity(txt_SF08, 0.0)
opacity(txt_SF08b, 0.0)
opacity(txt_rel1, 0.0)
opacity(txt_rel2, 0.0)
opacity(txt_rel3, 0.0)
opacity(txt_Title, 0.0)
opacity(txt_ACF, 0.0)
opacity(txt_FPS, 0.0)
opacity(txt_time, 0.0)
opacity(txt_warn, 0.0)
opacity(txt_SF09, 0.0)
opacity(txt_SF09b, 0.0)
opacity(txt_dbg_menu, 0.0)
opacity(txt_dbg_page, 0.0)
opacity(txt_numpad, 0.0)




--======================================================================================
--								END OF SCRIPT
--======================================================================================
