------------------------------------
-- Garmin GMC305 autopilot module --
--     Made by Sim Innovations    --
------------------------------------
-- Global variables
local gbl_ap_mode = 0
local gbl_althold = 0
local gbl_vshold  = 0

-- Add images
img_add_fullscreen("ap_background.png")
img_ap_on = img_add("led_on.png", 271, 10, 55, 55)
visible( img_ap_on,false)
--img_fd_on = img_add("fd_on.png", 238, 94, 40, 40)

-- Button callbacks
function callback_hdg()

    xpl_command("sim/autopilot/heading")

end

function callback_nav()

    xpl_command("sim/autopilot/NAV")

end

function callback_ap()

    if gbl_ap_mode < 2 then
        xpl_dataref_write("sim/cockpit/autopilot/autopilot_mode", "INT", 2)
    else
        xpl_dataref_write("sim/cockpit/autopilot/autopilot_mode", "INT", 0)
    end

end

function callback_lvl()

    xpl_command("sim/autopilot/wing_leveler")

end

function callback_flc()

    xpl_command("sim/autopilot/level_change")

end

function callback_alt()

    xpl_command("sim/autopilot/altitude_hold")

end

function callback_apr()

    xpl_command("sim/autopilot/approach")

end

function callback_fd()
    
    if gbl_ap_mode ~=1 then
        xpl_command("sim/autopilot/flight_dir_on_only")
    else
        xpl_dataref_write("sim/cockpit/autopilot/autopilot_mode", "INT", 0)
    end

end

function callback_vs()

    xpl_command("sim/autopilot/vertical_speed")

end

function callback_vnv()

    xpl_command("sim/autopilot/vnav")

end

function callback_yd()

    xpl_command("sim/systems/yaw_damper_toggle")

end

function altitude_input(direction)

    if direction == 1 then
        xpl_command("sim/autopilot/altitude_up")
	else
        xpl_command("sim/autopilot/altitude_down")
	end

end

-- Functions
function new_ap_xpl(mode, ap_state)

    gbl_ap_mode = mode

    visible(img_ap_on, mode == 2)

    -- Altitude hold or VS active?
    gbl_althold = fif( (ap_state >> 14) & 1, true, false)
    gbl_vshold = fif( (ap_state >> 4) & 1, true, false)

end

function new_ap_fsx(apmode, fdmode, althold, vsmode)

    if apmode then
        gbl_ap_mode = 2
    elseif not apmode and fdmode then
        gbl_ap_mode = 1
    else
        gbl_ap_mode = 0
    end

    visible(img_ap_on, gbl_ap_mode == 2)
    visible(img_fd_on, gbl_ap_mode == 1)

    -- Altitude hold or VS active?    
    gbl_althold = althold
    gbl_vshold = vsmode
    
end

function heading_input(direction)

    if direction == 1 then
        xpl_command("sim/autopilot/heading_up")
    else
        xpl_command("sim/autopilot/heading_down")
	end

end



function vs_callback(direction)

    if direction == 1 then
        xpl_command("sim/autopilot/vertical_speed_up")
    else
        xpl_command("sim/autopilot/vertical_speed_down")
    end

end

-- Create a new scroll wheel
vs_scrollwheel = scrollwheel_add_ver("vs_thumb.png", 424, 64, 28, 122, 28, 32, vs_callback)

img_add("shadow.png", 424,65,29,122)

-- Add the buttons
button_hdg = button_add(nil , "autopilot_button_in.png", 63, 173, 60, 43, callback_hdg)
button_nav = button_add(nil , "autopilot_button_in.png", 147, 173, 60, 43, callback_nav)
button_ap = button_add(nil , "autopilot_button_in.png", 230, 66, 60, 43,  callback_ap)
button_lvl = button_add(nil , "autopilot_button_in.png", 310, 66, 60, 43,  callback_lvl)
button_flc = button_add(nil , "autopilot_button_in.png", 477, 34, 60, 43,  callback_flc)
button_alt = button_add(nil , "autopilot_button_in.png", 567, 175, 60, 43,  callback_alt)
button_apr = button_add(nil , "autopilot_button_in.png", 147, 39, 60, 43, callback_apr)
button_fd = button_add(nil , "autopilot_button_in.png", 232, 139, 60, 43,  callback_fd)
button_vs = button_add(nil , "autopilot_button_in.png", 477, 175, 60, 43, callback_vs)
button_vnv = button_add(nil , "autopilot_button_in.png", 477, 105, 60, 43, callback_vnv)
button_yd= button_add(nil , "autopilot_button_in.png", 310, 139, 60, 43, callback_yd)

heading_dial = dial_add( "autopilot_knob.png", 60,53,67,67,3, heading_input)
altitude_dial = dial_add( "autopilot_knob.png", 562,53,67,67,3, altitude_input)

function sync_heading()

    xpl_command("sim/autopilot/heading_sync")

end
button_add( nil,nil,78,71,31,31, sync_heading)
--Autopilot heading sync. sim/autopilot/heading_sync

function sync_altitude()

    xpl_command("sim/autopilot/altitude_sync")

end
button_add( nil,nil,580,71,31,31, sync_altitude)


-- Bus subscribe
xpl_dataref_subscribe("sim/cockpit/autopilot/autopilot_mode", "INT",
                      "sim/cockpit/autopilot/autopilot_state", "INT", new_ap_xpl)
fsx_variable_subscribe("AUTOPILOT MASTER", "Bool",
                       "AUTOPILOT FLIGHT DIRECTOR ACTIVE", "Bool",
                       "AUTOPILOT ALTITUDE LOCK", "Bool", 
                       "AUTOPILOT VERTICAL HOLD", "Bool", new_ap_fsx)
fs2020_variable_subscribe("AUTOPILOT MASTER", "Bool",
                          "AUTOPILOT FLIGHT DIRECTOR ACTIVE", "Bool",
                          "AUTOPILOT ALTITUDE LOCK", "Bool", 
                          "AUTOPILOT VERTICAL HOLD", "Bool", new_ap_fsx)					   
