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
panel_back = user_prop_add_boolean("Show Panel", true, "Show the panel background")
local panel_background = user_prop_get(panel_back)

-- Panel Background color
prop_panel_back_color = user_prop_add_string("Panel color", "#808080", "Panel background color in HEX format")
local panel_back_color = user_prop_get(prop_panel_back_color)

-- Screws Visible
screws_prop = user_prop_add_boolean("Show screws", true, "Show the screws")
local screws_visible = user_prop_get(screws_prop)

-- Bezel Visible
bezel_prop  = user_prop_add_boolean("Show bezel", true, "Show the bezel")
local bezel_ring = user_prop_get(bezel_prop)

-- Speed Units
units_prop = user_prop_add_enum("Speed Units", "Knots,MPH,KPH" , "Knots" , "Select Units displayed")
local unit = user_prop_get(units_prop)

-- Bottom of scale
lowspd_prop = user_prop_add_enum("Lowest grad Speed", "20,40,60", "40" , "Enter speed for lowest major graduation")
local lowest_speed = tonumber(user_prop_get(lowspd_prop))

-- Top of scale
hispd_prop = user_prop_add_enum("Highest grad Speed", "100,120,140,160,180,200,220,240,260,280,300", "180" , "Enter speed for highest major graduation")
local highest_speed = tonumber(user_prop_get(hispd_prop))

-- Major graduation spacing
gradspace_prop = user_prop_add_enum("Major grad spacing", "10,20,40", "10", "Enter speed for highest major graduation")
local grad_spacing = tonumber(user_prop_get(gradspace_prop))

-- Speed label spacing
lablespace_prop = user_prop_add_enum("Label spacing", "10,20,40", "20", "Enter label spacing interval in knots")
local lable_spacing = tonumber(user_prop_get(lablespace_prop))

-- Vne Redline
vne_prop = user_prop_add_integer("Redline Speed", 20, 260, 175, "Enter redline(Vne)")
local vne = user_prop_get(vne_prop)

-- Start of Caution
caution_prop = user_prop_add_integer("Start Yellow Arc", 20, 260, 140, "Enter start (lowest value) of yellow arc (Vno)")
local yellow_start = user_prop_get(caution_prop)

-- Start of Green Arc
normal_prop = user_prop_add_integer("Start Green Arc", 20, 260, 60, "Enter start (lowest value) of green arc (Vs1)")
local green_start = user_prop_get(normal_prop)        

-- Start of White Arc
stall_prop = user_prop_add_integer("Start White Arc", 20, 260, 45, "Enter start (lowest value) of white arc (Vso)")
local white_start = user_prop_get(stall_prop)

--  End of White Arc
flaps_prop = user_prop_add_integer("End White Arc", 20, 260, 80, "Enter end (highest value) of white arc (Vfe)")
local white_end = user_prop_get(flaps_prop)

-- Multi-engine airplanes
-- Red Radial
vmcvis_prop = user_prop_add_boolean("Show red radial", true, "Show red radial(Vmc)")
local red_radial_visible = user_prop_get(vmcvis_prop)    

vmc_prop = user_prop_add_integer("Red Radial Speed", 20, 260, 70, "Enter value of Red Radial(Vmc)")
local red_radial_spd = user_prop_get(vmc_prop)    

-- Blue Radial
vysevis_prop = user_prop_add_boolean("Show blue radial", true, "Show blue radial(Vyse)")
local blue_radial_visible = user_prop_get(vysevis_prop)    

vyse_prop = user_prop_add_integer("Blue Radial Speed", 20, 260, 87, "Enter value of Blue Radial(Vyse)")
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

    -- Add panel background if desired
    if panel_background then 
        canvas_add(0, 0, 500, 500, function()
            _rect(0,0,500,500)
            _fill(panel_back_color)
        end)
    end
        
    -- Always add face background
    img_add_fullscreen("face_background.png")
    mph_plac = img_add("unit_mph_img.png", 174, 199, 168, 27)
    visible( mph_plac, false )
    kph_plac = img_add("unit_kph_img.png", 168, 199, 168, 27)
    visible( kph_plac, false )

    -- Change unit text image for MPH/KPH if necessary
    if unit=="MPH" then visible( mph_plac, true) end
    if unit=="KPH" then visible( kph_plac, true) end

        -- Add redline if desired
        start_angle_r = spd_2_angle( vne ) - 90
        end_angle_r = start_angle_r + 5 
        -- Add yellow arc if desired
        start_angle_y = spd_2_angle( yellow_start )- 90
        end_angle_y = start_angle_r
        -- Add green arc if desired
        start_angle_g = spd_2_angle( green_start ) - 90 
        end_angle_g = start_angle_y
        -- Add white arc if desired
        start_angle_w = spd_2_angle( white_start ) - 90
        end_angle_w = spd_2_angle( white_end ) - 90

        -- Always add face graphics
        arc_canvas = canvas_add(0, 0, 500, 500, function()
            _arc(250, 250, start_angle_r, end_angle_r, 185)
            _stroke("red", 30)
            _arc(250, 250, start_angle_y, end_angle_y, 190)
            _stroke("yellow", 20)
            _arc(250, 250, start_angle_g, end_angle_g, 190)
            _stroke("#008700", 20)
            _arc(250, 250, start_angle_w, end_angle_w, 175)
            _stroke("white", 15)

            local n = 0
            while n <= grads do
                _arc(250, 250, 25 + n * angle_grads - 90, 25 + n * angle_grads - 88, 179)
                _stroke("white", 40)
                n = n + 1
            end

            local m = 0
            while m < grads do
                _arc(250, 250, 25 + angle_grads/2  + m * angle_grads - 90, 25 + angle_grads/2  + m * angle_grads - 89, 185)
                _stroke("white", 30)
                m = m + 1
            end
        end)

        local lable_grads = scale_range / lable_spacing
        local angle_labels = 315 / lable_grads
        local j = 0
        while j <= lable_grads do
            txt_angle = 25 + j * angle_labels
            x, y = geo_rotate_coordinates(txt_angle,120)
            label_text = string.format( "%d", lowest_speed + lable_spacing * j)
            txt_add(label_text, "font:roboto_bold.ttf; size:40; color: white; halign:center;", 200 + x, 220 + y, 100, 50)
            j = j + 1
        end

        -- Add red radial if desired
        if red_radial_visible then
            red_radial =  img_add("red_radial.png", 246, 0, 8, 500)
            rotate(red_radial, spd_2_angle( red_radial_spd ))
        end    
        
        -- Add blue radial if desired
        if blue_radial_visible then
            blue_radial =  img_add( "blue_radial.png", 246, 0, 8, 500)
            rotate(blue_radial, spd_2_angle(blue_radial_spd))
        end    
         
        -- Add bezel ring if desired
        if bezel_ring then img_add_fullscreen("bezel_ring.png") end
         
        -- Add bezel ring if desired
        if screws_visible then img_add_fullscreen("screw_set.png") end
         
        -- Always add the needle
        pointer = img_add("needle.png", 200, 0, 100, 500)
         
        -- Now make the meter operate
        function set_speed(speed)
            
            -- Convert to MPH/KPH if that is what is diaplayed on the gauge
            if unit=="MPH" then speed = knots_2_mph(speed) end
            if unit=="KPH" then speed = knots_2_kph(speed) end
            speed = var_cap(speed, 0, highest_speed)

            if speed >= lowest_speed then
                rotate(pointer, 315 / (highest_speed - lowest_speed) * (speed - lowest_speed) + 26)
            else
                rotate(pointer, (26 / lowest_speed^2) * speed^2)
        end
end

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", set_speed)
fsx_variable_subscribe("AIRSPEED INDICATED", "Knots", set_speed)    
fs2020_variable_subscribe("AIRSPEED INDICATED", "Knots", set_speed)    