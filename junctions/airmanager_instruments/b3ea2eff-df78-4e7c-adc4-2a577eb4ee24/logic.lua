img_add_fullscreen("rpm_backdrop.png")
img_neddle = img_add("engine_neddle.png",98,0,60,256)
img_add("engine_center.png",98,98,60,60)

function PT_rpm(rpm)

    rpm = var_cap(rpm[1], 0, 3500)
    rotate(img_neddle, (240 / 3500 * rpm) -60)

end

function PT_rpm_FSX(rpm)

    PT_rpm({rpm})
    
end

-- Bus subscribe --
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/prop_speed_rpm", "FLOAT[8]", PT_rpm)
fsx_variable_subscribe("PROP RPM:1", "RPM", PT_rpm_FSX)
fs2020_variable_subscribe("PROP RPM:1", "RPM", PT_rpm_FSX)