--[[
*****************************************************************
************FSS ERJ - 1XX - EFIS/Baro************************
*****************************************************************
##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
--]]


img_add_fullscreen("background.png")
--img_bg_night = img_add_fullscreen("background_night.png")
--snd_click = sound_add("click4.wav")

--[[
--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2)
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)         
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)   
    end
end
fs2020_variable_subscribe("L:FSS_EXX_CPLT_BV_MAIN_KNOB", "Number",ss_backlighting)                                         
-----------------------------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)     

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
--]]
---------------------------------------------------------------------------------------------------
--Button Sizes
    HSIWidth = 90
    HSIHeight = 65
    HSIButtonPressed = "button_pressed.png" 

--}}
-------------------------------------------------------------------------------


img_bar_off = img_add("l_base.png", 104, 192, 157, 157)  visible(img_bar_off, false)
img_bar_on = img_add("r_base.png", 104, 192, 157, 157)

--   visible(img_bar_on, false)
 --[[
local BUNIT_value = 0  

function BUNIT_Engage()
		xpl_command("XCrafts/ERJ/units","FLOAT")
end
BUNIT_ENG = button_add(nil, nil, 107,350,150,150, BUNIT_Engage) 
--]]
--BARO DIAL--------------------------------------------------------------

function BARO(dir)
    if dir == -1 then 
		xpl_command("sim/instruments/barometer_up","FLOAT", 1)
    elseif dir == 1 then  
		xpl_command("sim/instruments/barometer_down","FLOAT", 1)
    end
end

img_baro_dial = dial_add("baro_dial.png", 100,192,164,164, BARO)

---- BARO STD BUTTON
local bstd_value = 0

function STD_Engage()
        xpl_command("XCrafts/ERJ/STD","FLOAT")
end
BARO_ENG = button_add(nil, nil, 133, 223, 100, 100, STD_Engage) 

--Minimums radio/baro button------------------------------------------------

-- Add the images for the 0 and 1 states
img_min_off = img_add("l_base.png", 839, 192, 157, 157)
img_min_on = img_add("r_base.png", 839, 192, 157, 157)

function ra_baro_image_cb (state)
		if state == 1 then 
        visible(img_min_off, false)
        visible(img_min_on, true)
		else
		visible(img_min_on, false)
        visible(img_min_off,true)
		end
 end
xpl_dataref_subscribe("XCrafts/ERJ/RA_BARO_Mins", "Int", ra_baro_image_cb)
-- Initially hide the "on" state image

-- Function to update the button image based on the current state
--[[
fs2020_variable_subscribe("L:FSS_EXX_DCP_L_MIN_SRC", "Number",
    function(state)
        if state == 0 then
            visible(img_min_off, true)
            visible(img_min_on, false)
        elseif state == 1 then
            visible(img_min_off, false)
            visible(img_min_on, true)
        end
    end
)
-- Function to handle the button press event
function MIN_Button()
    -- Toggle the value of the LVAR
    fs2020_rpn("(L:FSS_EXX_DCP_L_MIN_SRC) ! (>L:FSS_EXX_DCP_L_MIN_SRC)")

    -- Play the click sound on press
end

-- Add the button interaction (press event)
--img_min_button = button_add(nil, nil, 842,350,150,150, MIN_Button)
--]]
--Minimums DIAL--------------------------------------------------------------
function MIN(dir)
    if dir == -1 then 
		xpl_command("sim/instruments/dh_ref_up","FLOAT", 1)
    elseif dir == 1 then  
		xpl_command("sim/instruments/dh_ref_down","FLOAT", 1)
    end
end
img_min_dial = dial_add("baro_dial.png", 858,214,120,120, MIN)

--PREV-------------------------------------------------------------------

local PREV_value = 0  

function PREV_Engage()
        xpl_command("sim/autopilot/hsi_toggle_preview","FLOAT")
end
PREV_ENG = button_add(nil, "button_pressed.png", 489, 246, 91, 71, PREV_Engage)

--FMS-------------------------------------------------------------------

local FMS_value = 0  

function FMS_Engage()
        xpl_command("sim/autopilot/hsi_select_gps","FLOAT")
end
FMS_ENG = button_add(nil, "button_pressed.png", 635, 86, 91, 71, FMS_Engage)

--VOR/LOC-------------------------------------------------------------------

local VL_value = 0  

function VL_Engage()
        xpl_command("XCrafts/ERJ/CA_DCU_NAV","FLOAT")
end
VL_ENG = button_add(nil, "button_pressed.png", 635, 246, 91, 71, VL_Engage)