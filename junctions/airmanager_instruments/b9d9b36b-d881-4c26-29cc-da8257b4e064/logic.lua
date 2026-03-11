--*********************************************************************************************************
--**                                                                                                     **
--**                                   CUSTOM ADJUSTMENTS                                                **
--**                                                                                                     **
--**                           USE VARIABLES BELOW TO SET PROPERTIES                                     **
--**                                                                                                     **
--**                  Enter values based on marking on dial regardless of units                          **
--**                                                                                                     **
--**                                                                                                     **
--********************************************************************************************************* 
-- Panel Background
local panel_back = user_prop_add_boolean("Show Panel", true, "Show the panel background")
local panel_background = user_prop_get(panel_back)

-- Panel Background color
local prop_panel_back_color = user_prop_add_string("Panel color", "#808080", "Panel background color in HEX format")
local panel_back_color = user_prop_get(prop_panel_back_color)

-- Screws Visible
local screws_prop = user_prop_add_boolean("Show screws", true, "Show the screws")
local screws_visible = user_prop_get(screws_prop)

-- Bezel Visible
local bezel_prop  = user_prop_add_boolean("Show bezel", true, "Show the bezel")
local bezel_ring = user_prop_get(bezel_prop)

-- Speed Units
local units_prop = user_prop_add_enum("Speed Units", "Knots,MPH,KPH" , "Knots" , "Select Units displayed")
local unit = user_prop_get(units_prop)

-- Bottom of scale
local lowspd_prop = user_prop_add_enum("Lowest grad Speed", "20,40,60", "40" , "Enter speed for lowest major graduation")
local lowest_speed = tonumber(user_prop_get(lowspd_prop))

-- Top of scale
local hispd_prop = user_prop_add_enum("Highest grad Speed", "100,120,140,160,180,200,220,240,260,280,300", "180" , "Enter speed for highest major graduation")
local highest_speed = tonumber(user_prop_get(hispd_prop))

-- Major graduation spacing
local gradspace_prop = user_prop_add_enum("Major grad spacing", "10,20,40", "10", "Enter speed for highest major graduation")
local grad_spacing = tonumber(user_prop_get(gradspace_prop))

-- Speed label spacing
local lablespace_prop = user_prop_add_enum("Label spacing", "10,20,40", "20", "Enter label spacing interval in knots")
local lable_spacing = tonumber(user_prop_get(lablespace_prop))

-- Vne Redline
local vne_prop = user_prop_add_integer("Redline Speed", 20, 260, 175, "Enter redline(Vne)")
local vne = user_prop_get(vne_prop)

-- Start of Caution
local caution_prop = user_prop_add_integer("Start Yellow Arc", 20, 260, 140, "Enter start (lowest value) of yellow arc (Vno)")
local yellow_start = user_prop_get(caution_prop)

-- Start of Green Arc
local normal_prop = user_prop_add_integer("Start Green Arc", 20, 260, 60, "Enter start (lowest value) of green arc (Vs1)")
local green_start = user_prop_get(normal_prop)        

-- Start of White Arc
local stall_prop = user_prop_add_integer("Start White Arc", 20, 260, 45, "Enter start (lowest value) of white arc (Vso)")
local white_start = user_prop_get(stall_prop)

--  End of White Arc
local flaps_prop = user_prop_add_integer("End White Arc", 20, 260, 80, "Enter end (highest value) of white arc (Vfe)")
local white_end = user_prop_get(flaps_prop)

-- Multi-engine airplanes
-- Red Radial
local vmcvis_prop = user_prop_add_boolean("Show red radial", true, "Show red radial(Vmc)")
local red_radial_visible = user_prop_get(vmcvis_prop)    

local vmc_prop = user_prop_add_real("Red Radial Speed", 20, 260, 70, "Enter value of Red Radial(Vmc)")
local red_radial_spd = user_prop_get(vmc_prop)    

-- Blue Radial
local vysevis_prop = user_prop_add_boolean("Show blue radial", true, "Show blue radial(Vyse)")
local blue_radial_visible = user_prop_get(vysevis_prop)    

local vyse_prop = user_prop_add_real("Blue Radial Speed", 20, 260, 87, "Enter value of Blue Radial(Vyse)")
local blue_radial_spd = user_prop_get(vyse_prop)    


--*********************************************************************************************************--
--**                                                                                                     **--
--**                            END OF CUSTOM ADJUSTMENTS                                                **--
--**                                                                                                     **--
--*********************************************************************************************************--
local scale_range = highest_speed - lowest_speed
local grads = scale_range / grad_spacing
local angle_grads = 315 / grads

function knots_2_mph( kts )
    return kts * 1.15078
end

function knots_2_kph( kts )
    return kts * 1.852
end


function spd_2_angle( spd )
    return ((spd - lowest_speed) * 315 / scale_range) + 25
end

-- Add panel backgrounds
local background_canvas = canvas_add(0, 0, 500, 500, function()
    if panel_background then
        _rect(0,0,500,500)
        _fill(panel_back_color)
    end
    _circle(250, 250, 210)
    _fill(0,0,0)
    if unit == "MPH" then
        _txt("MILES PER HOUR", "font:roboto_bold.ttf; size:26; color:#FFFFFF; halign:center; valign:center;", 250, 212)
    elseif unit == "KPH" then
        _txt("KPH", "font:roboto_bold.ttf; size:26; color:#FFFFFF; halign:center; valign:center;", 250, 212)
    else
        _txt("KNOTS", "font:roboto_bold.ttf; size:26; color:#FFFFFF; halign:center; valign:center;", 250, 212)
    end
end)

-- Add redline if desired
local start_angle_r = spd_2_angle( vne ) - 90
local end_angle_r = start_angle_r + 5 
-- Add yellow arc if desired
local start_angle_y = spd_2_angle( yellow_start )- 90
local end_angle_y = start_angle_r
-- Add green arc if desired
local start_angle_g = spd_2_angle( green_start ) - 90 
local end_angle_g = start_angle_y
-- Add white arc if desired
local start_angle_w = spd_2_angle( white_start ) - 90
local end_angle_w = spd_2_angle( white_end ) - 90

-- Always add face graphics
local arc_canvas = canvas_add(0, 0, 500, 500, function()
    _arc(250, 250, start_angle_r, end_angle_r, 185)
    _stroke(1, 0, 0, 30)
    _arc(250, 250, start_angle_y, end_angle_y, 190)
    _stroke(1, 1, 0, 20)
    _arc(250, 250, start_angle_g, end_angle_g, 190)
    _stroke(0, 0.5, 0, 20)
    _arc(250, 250, start_angle_w, end_angle_w, 175)
    _stroke(1, 1, 1, 15)

    for i = 0, grads do
        _arc(250, 250, 25 + i * angle_grads - 90, 25 + i * angle_grads - 88, 179)
        _stroke(1, 1, 1, 40)
    end

    for i = 0, grads - 1 do
        _arc(250, 250, 25 + angle_grads/2  + i * angle_grads - 90, 25 + angle_grads/2  + i * angle_grads - 89, 185)
        _stroke(1, 1, 1, 30)
    end
end)

local lable_grads = scale_range / lable_spacing
local angle_labels = 315 / lable_grads
for i = 0, lable_grads do
    local txt_angle = 25 + i * angle_labels
    local x, y = geo_rotate_coordinates(txt_angle, 120)
    local label_text = string.format("%d", lowest_speed + lable_spacing * i)
    txt_add(label_text, "font:roboto_bold.ttf; size:40; color: white; halign:center;", 200 + x, 220 + y, 100, 50)
end

-- Add stall speed radials if desired
local angle_red  = spd_2_angle(red_radial_spd)
local angle_blue = spd_2_angle(blue_radial_spd)
local stall_speed_canvas = canvas_add(0, 0, 500, 500, function()
    -- Red radial
    if red_radial_visible then
        _rotate(angle_red)
        _move_to(250, 50)
        _line_to(250, 120)
        _stroke(1, 0, 0, 8)
        _rotate(angle_red * -1)
    end
    -- Blue radial
    if blue_radial_visible then
        _rotate(angle_blue)
        _move_to(250, 50)
        _line_to(250, 154)
        _stroke(0, 0, 1, 8)
        _rotate(angle_blue * -1)
    end
end)

-- Add bezel ring if desired
img_add_fullscreen("bezel_ring.png", "visible:" .. tostring(bezel_ring))
 
-- Add screws if desired
img_add_fullscreen("screw_set.png", "visible:" .. tostring(screws_visible))
 
-- Add the needle
local pointer = img_add("needle.png", 200, 0, 100, 500, "rotate_animation_type: LOG; rotate_animation_speed: 0.1")

-- Now make the meter operate
function set_speed(speed)
    -- Convert to MPH/KPH if that is what is diaplayed on the gauge
    if unit == "MPH" then speed = knots_2_mph(speed) end
    if unit == "KPH" then speed = knots_2_kph(speed) end
    speed = var_cap(speed, 0, highest_speed)

    if speed >= lowest_speed then
        rotate(pointer, 315 / (highest_speed - lowest_speed) * (speed - lowest_speed) + 26)
    else
        rotate(pointer, (26 / lowest_speed^2) * speed^2)
    end
end
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", set_speed)
fsx_variable_subscribe("AIRSPEED INDICATED", "Knots", set_speed)    
msfs_variable_subscribe("AIRSPEED INDICATED", "Knots", set_speed)    