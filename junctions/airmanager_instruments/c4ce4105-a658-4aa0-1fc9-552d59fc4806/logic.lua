-----------------------------------------------
-- GAUGE CREATED BY : ISURU ABEYKOON (SIMHOPER)
-- VER : JUNE/2020
-----------------------------------------------
prop_eng = user_prop_add_enum("Engine", "Left,Right", "Left", "Choose the engine.")

img_add_fullscreen("RPM_back.png")
img_needle = img_add_fullscreen("RPM_needle.png")

function callback_rpm_eng(rpm_left_eng, rpm_right_eng)
    rpm_eng = var_cap(fif(user_prop_get(prop_eng) == "Left", rpm_left_eng, rpm_right_eng),0 , 110)
    rotate(img_needle, (234 / 100) * rpm_eng)
end

xpl_dataref_subscribe("LES/saab/engine_pct_rpm_L", "FLOAT",
                      "LES/saab/engine_pct_rpm_R", "FLOAT", callback_rpm_eng)