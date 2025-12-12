---------------------------------------------
--  Sim Innovations - All rights reserved  --
--     Robinson R22 Attitude indicator     --
---------------------------------------------

prop_bezel = user_prop_add_boolean("Bezel", true, "Show the bezel and screws")
local gbl_hoop_heigt = 0

-- Add images --
img_add("background.png", 25, 25, 500, 500)
img_horizon = img_add("horizon.png", 25, 140, 500, 270)
img_flag = img_add("off_flag.png", 394, -48, 53, 302)
img_ring = img_add("ring.png", 25, 25, 500, 500)
img_add("center_indicator.png", 233, 22, 84, 114)
img_airplane = img_add("airplane.png", 139, 264, 272, 216)
img_add("bottom_black.png", 90, 358, 370, 164)
img_ball = img_add("ball.png", 257, 382, 36, 48)
img_add("glass_shine.png", 172, 379, 206, 54)
img_add_fullscreen("bezel.png", "visible:" .. tostring(user_prop_get(prop_bezel)) )

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/suction_1_ratio", "FLOAT", 
                      "sim/cockpit2/gauges/indicators/roll_vacuum_deg_pilot", "FLOAT", 
                      "sim/cockpit2/gauges/indicators/pitch_vacuum_deg_pilot", "FLOAT", 
                      "sim/cockpit2/gauges/indicators/slip_deg", "FLOAT",
                      "sim/cockpit/misc/ah_adjust", "FLOAT", function(suction, roll, pitch, slip, hoop_height)

    -- Off flag
    if suction > 2 then
        rotate(img_flag, -33, "LOG", 0.06)
    else
        rotate(img_flag, 0, "LOG", 0.01)
    end
    
    -- Pitch and roll
    rotate(img_ring, -roll)
    rotate(img_horizon, -roll)
    
    pitch = var_cap(pitch, -25, 25)
    local radial = math.rad(-roll)
    local x = -(math.sin(radial) * pitch * 3.7)
    local y = (math.cos(radial) * pitch * 3.7)
    move(img_horizon, 25 + x, y + 140, nil, nil)
    
    -- Hoop height
    gbl_hoop_heigt = hoop_height
    move(img_airplane, nil, 264 - (hoop_height * 1.2), nil, nil, "LINEAR", 0.1)
    
    -- Slip indicator
    slip_deg = var_cap(slip * 0.9, -6.5, 6.5)
    x, y = geo_rotate_coordinates(slip_deg + 180, 700)
    move(img_ball, x + 257, y + -318, nil, nil)
    rotate(img_ball, slip_deg)

end)

dial_add(nil, 225, 428, 100, 100, 4, function(direction)
    xpl_dataref_write("sim/cockpit/misc/ah_adjust", "FLOAT", var_cap(gbl_hoop_heigt + direction, -30, 30) )
end)

function cage_pressed_callback()
    xpl_dataref_write("sim/cockpit/gyros/gyr_cage_ratio", "FLOAT[6]", {1}, 4)
end

function cage_released_callback()
    xpl_dataref_write("sim/cockpit/gyros/gyr_cage_ratio", "FLOAT[6]", {0}, 4)
end

button_cage = button_add("pull_in.png", "pull_out.png", 420, 420, 130, 130, cage_pressed_callback, cage_released_callback)