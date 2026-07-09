-- Instrument property
callsign_prop = user_prop_add_string("Callsign", "PH-BYB", "Set your own callsign")

-- Add the elements
img_add_fullscreen("call_sign_backdrop.png")
txt_callsign = txt_add(" ", "font:arimo_bold.ttf; size:50px; color: #909090; halign: center;", 0, 56, 256, 160)

-- Write the callsign into the text element
txt_set(txt_callsign, user_prop_get(callsign_prop))