screws_prop = user_prop_add_boolean("Screws", true, "Show the screws")

img_add_fullscreen("screwset.png", "visible:"..tostring(user_prop_get(screws_prop)) )
img_add_fullscreen("background.png")
img_left = img_add("needle_left.png", 245, 0, 60, 550)
img_right = img_add("needle_right.png", 245, 0, 60, 550)

rotate(img_left, -112)
rotate(img_right, -112)

xpl_dataref_subscribe("sim/cockpit2/engine/indicators/engine_speed_rpm", "FLOAT[8]", function(rpm)

    local rpm_left  = var_cap(rpm[1], 477, 3000)
    local rpm_right = var_cap(rpm[2], 477, 3000)

    rotate(img_left, 220 / 2500 * (rpm_left - 500) - 110)
    rotate(img_right, 220 / 2500 * (rpm_right - 500) - 110)

end)

fsx_variable_subscribe("GENERAL ENG RPM:1", "RPM",
                       "GENERAL ENG RPM:2", "RPM", function(rpm_left, rpm_right)

    rpm_left  = var_cap(rpm_left, 477, 3000)
    rpm_right = var_cap(rpm_right, 477, 3000)

    rotate(img_left, 220 / 2500 * (rpm_left - 500) - 110)
    rotate(img_right, 220 / 2500 * (rpm_right - 500) - 110)

end)

fs2020_variable_subscribe("GENERAL ENG RPM:1", "RPM",
                          "GENERAL ENG RPM:2", "RPM", function(rpm_left, rpm_right)

    rpm_left  = var_cap(rpm_left, 477, 3000)
    rpm_right = var_cap(rpm_right, 477, 3000)

    rotate(img_left, 220 / 2500 * (rpm_left - 500) - 110)
    rotate(img_right, 220 / 2500 * (rpm_right - 500) - 110)

end)