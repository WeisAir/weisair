prop_engine_num = user_prop_add_integer("Engine number", 1, 2, 1, "Choose the engine number")

-- IMAGES
img_add_fullscreen("saab_eng_background.png")
img_needle = img_add("needle.png", -55, -50, 600,600)
img_add("cap.png", 0, 0, 500, 500)
rotate(img_needle, -1)

function callback_rpm(rpm)
    rpm = var_cap(rpm,0,110)
    rotate(img_needle, (239 / 110 * rpm) - 1)
end

function callback_rpm_xpl(rpm)
    rpm = var_cap(rpm[user_prop_get(prop_engine_num)],0,110)
    rotate(img_needle, (239 / 110 * rpm) - 1)
end

fsx_variable_subscribe("GENERAL ENG PCT MAX RPM:" .. user_prop_get(prop_engine_num), "Percent", callback_rpm)
fs2020_variable_subscribe("GENERAL ENG PCT MAX RPM:" .. user_prop_get(prop_engine_num), "Percent", callback_rpm)
xpl_dataref_subscribe("sim/flightmodel/engine/ENGN_N2_", "FLOAT[8]", callback_rpm_xpl)