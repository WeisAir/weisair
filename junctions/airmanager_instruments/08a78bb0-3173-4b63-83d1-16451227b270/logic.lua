-- Options
knob_functions = "COM 1 coarse down,COM 1 coarse up,COM 1 coarse down (8.33 kHz),COM 1 coarse up (8.33 kHz),COM 1 standby coarse down,COM 1 standby coarse up,COM 1 standby coarse down (8.33kHz),COM 1 standby coarse up (8.33kHz),COM 1 fine down (25kHz)COM 1 fine up (25kHz),COM 1 fine down (8.33 kHz),COM 1 fine up (8.33 kHz),COM 1 standby fine down (25kHz),COM 1 standby fine up (25kHz),COM 1 standby fine down (8.33kHz),COM 1 standby fine up (8.33kHz),COM 2 coarse down,COM 2 coarsup,COM 2 coarse down (8.33kHz),COM 2 coarse up (8.33kHz),COM 2 standby coarse down,COM 2 standby coarse up,COM 2 standby coarse down (8.33kHz),COM 2 standby coarse up (8.33kHz),COM 2 fine down (25kHz),COM 2 fine up (25kHz),COM 2 findown (8.33kHz),COM 2 fine up (8.33kHz),COM 2 standby fine down (25kHz),COM 2 standby fine up (25kHz),COM 2 standby fine down (8.33kHz),COM 2 standby fine up (8.33kHz),NAV 1 coarse down,NAV 1 coarse up,NAV 1 standby coarse down,NAV standby coarse up,NAV 1 fine down,NAV 1 fine up,NAV 1 standby fine down,NAV 1 standby fine up,NAV 2 coarse down,NAV 2 coarse up,NAV 2 standby coarse down,NAV 2 standby coarse up,NAV 2 fine down,NAV 2 fine up,NAV 2 standby fine downNAV 2 standby fine up,DME coarse down,DME coarse up,DME standby coarse down,DME standby coarse up,DME fine down,DME fine up,DME standby fine down,DME standby fine up,GPS coarse select down,GPS coarse select up,GPS fine select downGPS fine select up,G430 COM/NAV 1 coarse down,G430 COM/NAV 1 coarse up,G430 COM/NAV 1 fine down,G430 COM/NAV 1 fine up,G430 COM/NAV 2 coarse down,G430 COM/NAV 2 coarse up,G430 COM/NAV 2 fine down,G430 COM/NAV 2 fine up"
button_functions = "NAV 1 flip standby,NAV 2 flip standby,COM 1 flip standby,COM 2 flip standby,ADF 1 flip standby,ADF 2 flip standby,DME flip standby"
outter_knob_ccw_options = user_prop_add_enum("Counter-clockwise outter knob function", knob_functions, "COM 1 standby coarse down", "Select the outter knob counter-clockwise function")
outter_knob_cw_options = user_prop_add_enum("Clockwise outter knob function", knob_functions, "COM 1 standby coarse up", "Select the outter knob counter-clockwise function")
inner_knob_ccw_options = user_prop_add_enum("Counter-clockwise inner knob function", knob_functions, "COM 1 coarse down", "Select the outter knob counter-clockwise function")
inner_knob_cw_options = user_prop_add_enum("Clockwise inner knob function", knob_functions, "COM 1 coarse down", "Select the outter knob counter-clockwise function")
button_options = user_prop_add_enum("Button function", button_functions, "NAV 1 flip standby", "Select the function for the push button")

knobs_table = {
    ["COM 1 coarse down"] = "sim/radios/actv_com1_coarse_down",
    ["COM 1 coarse up"] = "sim/radios/actv_com1_coarse_up",
    ["COM 1 coarse down (8.33 kHz)"] = "sim/radios/actv_com1_coarse_down_833",
    ["COM 1 coarse up (8.33 kHz)"] = "sim/radios/actv_com1_coarse_up_833",
    ["COM 1 standby coarse down"] = "sim/radios/stby_com1_coarse_down",
    ["COM 1 standby coarse up"] = "sim/radios/stby_com1_coarse_up",
    ["COM 1 standby coarse down (8.33kHz)"] = "sim/radios/stby_com1_coarse_down_833",
    ["COM 1 standby coarse up (8.33kHz)"] = "sim/radios/stby_com1_coarse_up_833",
    ["COM 1 fine down (25kHz)"] = "sim/radios/actv_com1_fine_down",
    ["COM 1 fine up (25kHz)"] = "sim/radios/actv_com1_fine_up",
    ["COM 1 fine down (8.33 kHz)"] = "sim/radios/actv_com1_fine_down_833",
    ["COM 1 fine up (8.33 kHz)"] = "sim/radios/actv_com1_fine_up_833",
    ["COM 1 standby fine down (25kHz)"] = "sim/radios/stby_com1_fine_down",
    ["COM 1 standby fine up (25kHz)"] = "sim/radios/stby_com1_fine_up",
    ["COM 1 standby fine down (8.33kHz)"] = "sim/radios/stby_com1_fine_down_833",
    ["COM 1 standby fine up (8.33kHz)"] = "sim/radios/stby_com1_fine_up_833",
    ["COM 2 coarse down"] = "sim/radios/actv_com2_coarse_down",
    ["COM 2 coarse up"] = "sim/radios/actv_com2_coarse_up",
    ["COM 2 coarse down (8.33kHz)"] = "sim/radios/actv_com2_coarse_down_833",
    ["COM 2 coarse up (8.33kHz)"] = "sim/radios/actv_com2_coarse_up_833",
    ["COM 2 standby coarse down"] = "sim/radios/stby_com2_coarse_down",
    ["COM 2 standby coarse up"] = "sim/radios/stby_com2_coarse_up",
    ["COM 2 standby coarse down (8.33kHz)"] = "sim/radios/stby_com2_coarse_down_833",
    ["COM 2 standby coarse up (8.33kHz)"] = "sim/radios/stby_com2_coarse_up_833",
    ["COM 2 fine down (25kHz)"] = "sim/radios/actv_com2_fine_down",
    ["COM 2 fine up (25kHz)"] = "sim/radios/actv_com2_fine_up",
    ["COM 2 fine down (8.33kHz)"] = "sim/radios/actv_com2_fine_down_833",
    ["COM 2 fine up (8.33kHz)"] = "sim/radios/actv_com2_fine_up_833",
    ["COM 2 standby fine down (25kHz)"] = "sim/radios/stby_com2_fine_down",
    ["COM 2 standby fine up (25kHz)"] = "sim/radios/stby_com2_fine_up",
    ["COM 2 standby fine down (8.33kHz)"] = "sim/radios/stby_com2_fine_down_833",
    ["COM 2 standby fine up (8.33kHz)"] = "sim/radios/stby_com2_fine_up_833",
    ["NAV 1 coarse down"] = "sim/radios/actv_nav1_coarse_down",
    ["NAV 1 coarse up"] = "sim/radios/actv_nav1_coarse_up",
    ["NAV 1 standby coarse down"] = "sim/radios/stby_nav1_coarse_down",
    ["NAV 1 standby coarse up"] = "sim/radios/stby_nav1_coarse_up",
    ["NAV 1 fine down"] = "sim/radios/actv_nav1_fine_down",
    ["NAV 1 fine up"] = "sim/radios/actv_nav1_fine_up",
    ["NAV 1 standby fine down"] = "sim/radios/stby_nav1_fine_down",
    ["NAV 1 standby fine up"] = "sim/radios/stby_nav1_fine_up",
    ["NAV 2 coarse down"] = "sim/radios/actv_nav2_coarse_down",
    ["NAV 2 coarse up"] = "sim/radios/actv_nav2_coarse_up",
    ["NAV 2 standby coarse down"] = "sim/radios/stby_nav2_coarse_down",
    ["NAV 2 standby coarse up"] = "sim/radios/stby_nav2_coarse_up",
    ["NAV 2 fine down"] = "sim/radios/actv_nav2_fine_down",
    ["NAV 2 fine up"] = "sim/radios/actv_nav2_fine_up",
    ["NAV 2 standby fine down"] = "sim/radios/stby_nav2_fine_down",
    ["NAV 2 standby fine up"] = "sim/radios/stby_nav2_fine_up",
    ["DME coarse down"] = "sim/radios/actv_dme_coarse_down",
    ["DME coarse up"] = "sim/radios/actv_dme_coarse_up",
    ["DME standby coarse down"] = "sim/radios/stby_dme_coarse_down",
    ["DME standby coarse up"] = "sim/radios/stby_dme_coarse_up",
    ["DME fine down"] = "sim/radios/actv_dme_fine_down",
    ["DME fine up"] = "sim/radios/actv_dme_fine_up",
    ["DME standby fine down"] = "sim/radios/stby_dme_fine_down",
    ["DME standby fine up"] = "sim/radios/stby_dme_fine_up",
    ["GPS coarse select down"] = "sim/GPS/coarse_select_down",
    ["GPS coarse select up"] = "sim/GPS/coarse_select_up",
    ["GPS fine select down"] = "sim/GPS/fine_select_down",
    ["GPS fine select up"] = "sim/GPS/fine_select_up",
    ["G430 COM/NAV 1 coarse down"] = "sim/GPS/g430n1_coarse_down",
    ["G430 COM/NAV 1 coarse up"] = "sim/GPS/g430n1_coarse_up",
    ["G430 COM/NAV 1 fine down"] = "sim/GPS/g430n1_fine_down",
    ["G430 COM/NAV 1 fine up"] = "sim/GPS/g430n1_fine_up",
    ["G430 COM/NAV 2 coarse down"] = "sim/GPS/g430n2_coarse_down",
    ["G430 COM/NAV 2 coarse up"] = "sim/GPS/g430n2_coarse_up",
    ["G430 COM/NAV 2 fine down"] = "sim/GPS/g430n2_fine_down",
    ["G430 COM/NAV 2 fine up"] = "sim/GPS/g430n2_fine_up"
}

button_table = {
    ["NAV 1 flip standby"] = "sim/radios/nav1_standy_flip",
    ["NAV 2 flip standby"] = "sim/radios/nav2_standy_flip",
    ["COM 1 flip standby"] = "sim/radios/com1_standy_flip",
    ["COM 2 flip standby"] = "sim/radios/com2_standy_flip",
    ["ADF 1 flip standby"] = "sim/radios/adf1_standy_flip",
    ["ADF 2 flip standby"] = "sim/radios/adf2_standy_flip",
    ["DME flip standby"] = "sim/radios/dme_standby_flip"
}

local knob_rot = 6
local outter_knob_ccw_function = knobs_table[user_prop_get(outter_knob_ccw_options)]
local outter_knob_cw_function = knobs_table[user_prop_get(outter_knob_cw_options)]
local inner_knob_ccw_function = knobs_table[user_prop_get(inner_knob_ccw_options)]
local inner_knob_cw_function = knobs_table[user_prop_get(inner_knob_cw_options)]
local button_function = button_table[user_prop_get(button_options)]

-- BACKGROUND
img_add_fullscreen("background.png")

-- OUTTER KNOB
function dial_outter(direction)
    if direction == 1 then
        xpl_command(outter_knob_ccw_function)
    elseif direction== -1 then
        xpl_command(outter_knob_cw_function)
    end
end

outter_knob = dial_add("outter_knob.png", 5, 43, 91, 91, dial_outter)
dial_click_rotate(outter_knob, knob_rot)
touch_setting(outter_knob , "ROTATE_TICK", 30)

-- INNER KNOB
function dial_inner(direction)
    if direction == 1 then
        xpl_command(inner_knob_ccw_function)
    elseif direction== -1 then
        xpl_command(inner_knob_cw_function)
    end
end

inner_knob = dial_add("inner_knob.png", 19, 57, 64, 64, dial_inner)
dial_click_rotate(inner_knob, knob_rot)
touch_setting(inner_knob , "ROTATE_TICK", 30)

-- BUTTON
function button_click()
    xpl_command("sim/radios/com1_standy_flip")
end

button_add("button.png", "button_in.png", 28, 65, 48, 47, button_click)