-- Load images in Z-order
-- Gauge PROP RPM_Left adaptée Duke_turbine (c) JoelmarC
img_add_fullscreen("propspdback.png")
img_needle = img_add_fullscreen("needle.png")
img_add_fullscreen("needlecap.png")

-- Add text
txt_rpm = txt_add("0000", "size:34px; color:orange; halign:right;", 70, 188, 100, 43)

-- Functions
function new_propspeed_xpl(propspeed)

    rpm = var_cap(propspeed[1], 0, 2400)
    rotate(img_needle, 240 / 2400 * rpm )
    
    txt_set(txt_rpm, string.format("%04.0f", rpm) )

end

function new_propspeed_fsx(propspeed)

    rpm = var_cap(propspeed, 0, 2400)
    rotate(img_needle, 240 / 2400 * rpm )
    
    txt_set(txt_rpm, string.format("%04.0f", rpm) )
    
end

-- Data bus subscribe
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/prop_speed_rpm", "FLOAT[8]", new_propspeed_xpl)
fsx_variable_subscribe("PROP RPM:1", "RPM", new_propspeed_fsx)
fs2020_variable_subscribe("PROP RPM:1", "RPM", new_propspeed_fsx)