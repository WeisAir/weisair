prop_logo = user_prop_add_boolean("Logo", true, "Show Beechcraft logo")
prop_amps = user_prop_add_integer("Amps", 5, 30, 13, "Amps when on")

-- Add images --
img_add_fullscreen("prop_amps_backdrop.png")
img_needle = img_add("neddle.png", 0, 90, 256, 256, "angle_z: -45; rotate_animation_type: LOG; rotate_animation_speed: 0.05")
if user_prop_get(prop_logo) then
    img_add_fullscreen("cover_bc.png")
else
    img_add_fullscreen("cover_none.png")
end

function PT_amp_xpl(amps)

    if amps == 1 then
        rotate(img_needle, -45 + (90 / 30 * user_prop_get(prop_amps)) )
    else
        rotate(img_needle, -45)
    end

end

function PT_amp_fsx(amps)
    
    if amps then
        rotate(img_needle, -45 + (90 / 30 * user_prop_get(prop_amps)) )
    else
        rotate(img_needle, -45)
    end
    
end

xpl_dataref_subscribe("sim/cockpit/switches/anti_ice_prop_heat", "INT", PT_amp_xpl)
fsx_variable_subscribe("PROP DEICE SWITCH:1", "BOOL", PT_amp_fsx)
msfs_variable_subscribe("PROP DEICE SWITCH", "BOOL", PT_amp_fsx)