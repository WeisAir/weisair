-- Global variables
local gbl_vs_mode = true
local gbl_hdg = 0
local gbl_alt = 0

-- Add background image
img_add_fullscreen("background.png")

-- Button callbacks
function callback_hdg()

    xpl_command("sim/autopilot/heading")
    fs2020_event("AP_HDG_HOLD")

end

function callback_apr()

    xpl_command("sim/autopilot/approach")
    fs2020_event("AP_APR_HOLD")

end

function callback_nav()

    xpl_command("sim/autopilot/NAV")
    fs2020_event("AP_NAV1_HOLD")

end

function callback_trk()

    xpl_command("sim/autopilot/track")
    --fs2020_event("")

end

function callback_ap()
    
    xpl_command("sim/autopilot/servos_toggle")
    fs2020_event("AP_MASTER")

end

function callback_fd()
    
    xpl_command("sim/autopilot/fdir_toggle")
    fs2020_event("TOGGLE_FLIGHT_DIRECTOR")

end

function callback_lvl()

    xpl_command("sim/autopilot/wing_leveler")
    fs2020_event("AP_WING_LEVELER")

end

function callback_yd()

    xpl_command("sim/systems/yaw_damper_toggle")
    fs2020_event("YAW_DAMPER_TOGGLE")

end

function callback_ias()

    xpl_command("sim/autopilot/level_change")
    fs2020_event("AP_AIRSPEED_HOLD")

end

function callback_vnv()

    xpl_command("sim/autopilot/vnav")
    --fs2020_event("")

end

function callback_vs()

    xpl_command("sim/autopilot/vertical_speed")
    fs2020_event("AP_PANEL_VS_HOLD")

end

function callback_alt()

    xpl_command("sim/autopilot/altitude_arm")
    fs2020_event("AP_ALT_HOLD")

end

-- Dials
function heading_input(direction)
    if direction == 1 then
        xpl_command("sim/autopilot/heading_up")
        fs2020_event("HEADING_BUG_INC")
    else
        xpl_command("sim/autopilot/heading_down")
        fs2020_event("HEADING_BUG_DEC")
    end
end

function altitude_input(direction)
    if direction == 1 then
        xpl_command("sim/autopilot/altitude_up")
        fs2020_event("AP_ALT_VAR_INC")
    else
        xpl_command("sim/autopilot/altitude_down")
        fs2020_event("AP_ALT_VAR_DEC")
    end
end

function vs_callback(direction)
    if direction == 1 then
        if gbl_vs_mode then
            xpl_command("sim/autopilot/vertical_speed_up")
            fs2020_event("AP_VS_VAR_INC")
        else
            xpl_command("sim/autopilot/airspeed_down")
            fs2020_event("AP_SPD_VAR_DEC")
        end
    else
        if gbl_vs_mode then
            xpl_command("sim/autopilot/vertical_speed_down")
            fs2020_event("AP_VS_VAR_DEC")
        else
            xpl_command("sim/autopilot/airspeed_up")
            fs2020_event("AP_SPD_VAR_INC")
        end
    end
end


-- Create scroll wheel
vs_scroll = scrollwheel_add_ver("vs_grid.png", 999, 132, 62, 264, 62, 56, vs_callback)
img_add("vs_overlay.png", 999, 132, 62, 264)

-- Add push buttons
btn_hdg = button_add("btn_hdg.png", "btn_hdg_pressed.png", 118, 373, 186, 150, callback_hdg)
btn_apr = button_add("btn_apr.png", "btn_apr_pressed.png", 314, 53, 186, 150, callback_apr)
btn_nav = button_add("btn_nav.png", "btn_nav_pressed.png", 314, 213, 186, 150, callback_nav)
btn_trk = button_add("btn_trk.png", "btn_trk_pressed.png", 314, 373, 186, 150, callback_trk)

btn_ap = button_add("btn_ap.png", "btn_ap_pressed.png", 512, 133, 186, 150, callback_ap)
btn_fd = button_add("btn_fd.png", "btn_fd_pressed.png", 512, 293, 186, 150, callback_fd)
btn_lvl = button_add("btn_lvl.png", "btn_lvl_pressed.png", 708, 133, 186, 150, callback_lvl)
btn_yd = button_add("btn_yd.png", "btn_yd_pressed.png", 708, 293, 186, 150, callback_yd)

btn_ias = button_add("btn_ias.png", "btn_ias_pressed.png", 1100, 53, 186, 150, callback_ias)
btn_vnav = button_add("btn_vnav.png", "btn_vnav_pressed.png", 1100, 213, 186, 150, callback_vnv)
btn_vs = button_add("btn_vs.png", "btn_vs_pressed.png", 1100, 373, 186, 150, callback_vs)
btn_alt = button_add("btn_alt.png", "btn_alt_pressed.png", 1296, 373, 186, 150, callback_alt)

-- Add rotary images
img_add("rotary_bg.png", 134, 103, 154, 154)
rotary_hdg = dial_add("rotary_hdg.png", 134, 103, 154, 154, 3, heading_input)
img_add("rotary_bg.png", 1312, 103, 154, 154)
rotary_alt = dial_add("rotary_alt.png", 1312, 103, 154, 154, 3, altitude_input)

function sync_heading_pressed()

    xpl_command("sim/autopilot/heading_sync")
    fs2020_event("HEADING_BUG_SET", math.floor(gbl_hdg) )

end
button_add(nil, "sync.png", 181, 150, 60, 60, sync_heading_pressed)

function sync_altitude_pressed()

    xpl_command("sim/autopilot/altitude_sync")
    fs2020_event("AP_ALT_VAR_SET_ENGLISH", math.floor(gbl_alt) )

end
button_add(nil, "sync.png", 1359, 150, 60, 60, sync_altitude_pressed)

-- Active mode leds
img_hdg_active = img_add("active_led.png", 197, 360, 28, 16, "visible:false")
img_trk_active = img_add("active_led.png", 393, 360, 28, 16, "visible:false")
img_nav_active = img_add("active_led.png", 393, 200, 28, 16, "visible:false")
img_apr_active = img_add("active_led.png", 393, 40, 28, 16, "visible:false")
img_ap_active = img_add("active_led.png", 591, 120, 28, 16, "visible:false")
img_fd_active = img_add("active_led.png", 591, 280, 28, 16, "visible:false")
img_lvl_active = img_add("active_led.png", 787, 120, 28, 16, "visible:false")
img_yd_active = img_add("active_led.png", 787, 280, 28, 16, "visible:false")
img_alt_active = img_add("active_led.png", 1375, 360, 28, 16, "visible:false")
img_vs_active = img_add("active_led.png", 1179, 360, 28, 16, "visible:false")
img_vnav_active = img_add("active_led.png", 1179, 200, 28, 16, "visible:false")
img_ias_active = img_add("active_led.png", 1179, 40, 28, 16, "visible:false")


-- Bus subscribe
xpl_dataref_subscribe("sim/cockpit2/autopilot/heading_status", "INT", 
                      "sim/cockpit2/autopilot/track_status", "INT", 
                      "sim/cockpit2/autopilot/nav_status", "INT",
                      "sim/cockpit2/autopilot/approach_status", "INT",
                      "sim/cockpit/autopilot/autopilot_mode", "INT", 
                      "sim/cockpit2/annunciators/flight_director", "INT",
                      "sim/cockpit2/autopilot/roll_status", "INT",
                      "sim/cockpit/warnings/annunciators/yaw_damper", "INT", 
                      "sim/cockpit2/autopilot/speed_status", "INT",
                      "sim/cockpit2/autopilot/vnav_status", "INT",
                      "sim/cockpit2/autopilot/vvi_status", "INT",
                      "sim/cockpit2/autopilot/altitude_hold_status", "INT", function(hdg, trk, nav, apr, ap_mode, fd_mode, lvl, yaw, ias, vnav, vs, alt)
                      
    visible(img_hdg_active, hdg == 2)
    visible(img_trk_active, trk == 2)
    visible(img_nav_active, nav == 2)
    visible(img_apr_active, apr == 2)
    visible(img_ap_active, ap_mode == 2)
    visible(img_fd_active, fd_mode == 1)
    -- visible(img_lvl_active, lvl == 2) -- does not seem to work very well
    visible(img_yd_active, yaw == 1)
    visible(img_ias_active, ias == 2)
    visible(img_vnav_active, vnav == 2)
    visible(img_vs_active, vs == 2)
    visible(img_alt_active, alt == 2)
    gbl_vs_mode = vs == 2
    
end)

fs2020_variable_subscribe("PLANE HEADING DEGREES MAGNETIC", "Degrees",
                          "INDICATED ALTITUDE", "Feet", 
                          "AUTOPILOT HEADING LOCK", "Bool",
                          "AUTOPILOT APPROACH HOLD", "Bool",
                          "AUTOPILOT NAV1 LOCK", "Bool",
                          "AUTOPILOT MASTER", "Bool",
                          "AUTOPILOT FLIGHT DIRECTOR ACTIVE", "Bool",
                          "AUTOPILOT WING LEVELER", "Bool",
                          "AUTOPILOT YAW DAMPER", "Bool",
                          "AUTOPILOT AIRSPEED HOLD", "Bool",
                          "AUTOPILOT VERTICAL HOLD", "Bool",
                          "AUTOPILOT ALTITUDE LOCK", "Bool", function(heading_deg, altitude_ft, hdg, apr, nav, ap_master, fd, lvl, yd, ias, vs, alt)

    gbl_hdg = heading_deg
    gbl_alt = altitude_ft
    gbl_vs_mode = not ias

    visible(img_hdg_active, hdg)
    visible(img_apr_active, apr)
    visible(img_nav_active, nav)
    -- visible(img_trk_active, )
        
    visible(img_ap_active, ap_master)
    visible(img_fd_active, fd)
    visible(img_lvl_active, lvl)
    visible(img_yd_active, yd)
    
    visible(img_ias_active, ias)
    -- visible(img_vnav_active, )
    visible(img_vs_active, vs)
    visible(img_alt_active, alt)

end)