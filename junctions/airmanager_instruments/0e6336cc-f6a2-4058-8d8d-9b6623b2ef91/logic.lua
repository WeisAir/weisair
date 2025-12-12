-------------------------------------------
-- Sim Innovations - All rights reserved --
--     Beechcraft C90 Prop RPM Left      --
-------------------------------------------

-- IMAGES
img_add_fullscreen("background.png")
img_needle = img_add("needle.png", 230, 0, 40, 500)
img_add("cap.png", 200, 200, 100, 100)

-- FUNCTIONS
function new_data_xpl(rpm)

    rpm = var_cap(rpm[1], 0, 2200)
    
    if rpm > 1200 then
        rotate(img_needle, 210 / 1000 * (rpm - 1200) + 109)
    elseif rpm > 1150 then
        rotate(img_needle, 17 / 50 * (rpm - 1150) + 92)
    else
        rotate(img_needle, 92 / 1150 * rpm)
    end

end

function new_data_fsx(rpm)

    rpm = var_cap(rpm, 0, 2200)
    
    if rpm > 1200 then
        rotate(img_needle, 210 / 1000 * (rpm - 1200) + 109)
    elseif rpm > 1150 then
        rotate(img_needle, 17 / 50 * (rpm - 1150) + 92)
    else
        rotate(img_needle, 92 / 1150 * rpm)
    end
    
end

-- DATA BUS SUBSCRIBE
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/prop_speed_rpm", "FLOAT[8]", new_data_xpl)
fsx_variable_subscribe("PROP RPM:1", "Rpm", new_data_fsx)
fs2020_variable_subscribe("PROP RPM:1", "Rpm", new_data_fsx)