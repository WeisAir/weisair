img_add_fullscreen( "img_ifsd_background.png")

-- hp in button
hp_in_button= img_add( "button_down.png", 485,23,165,50)
visible(hp_in_button, false)
function hp_in_pressed()
xpl_command("laminar/B738/toggle_switch/standby_alt_hpin")
end

button_add( nil, "button_down.png",485,23,165,50, hp_in_pressed)


function hp_in_down(position)
visible(hp_in_button, position == 1)
end

xpl_dataref_subscribe("laminar/B738/knobs/standby_alt_hpin_pos", "FLOAT", hp_in_down)
-- end hp in button

-- app button
app_button= img_add( "button_down.png", 188,23,165,50)
visible(app_button, false)
function app_pressed()
xpl_command("laminar/B738/toggle_switch/standby_alt_app")
end

button_add( nil, "button_down.png",188,23,165,50, app_pressed)


function app_down(position)
visible(app_button, position == 1)
end

xpl_dataref_subscribe("laminar/B738/knobs/standby_alt_app_pos", "FLOAT", app_down)
-- end app button

-- rst button
rst_button= img_add( "button_down.png", 185,760,165,50)
visible(rst_button, false)
function rst_pressed()
xpl_command("laminar/B738/toggle_switch/standby_alt_rst")
end

button_add( nil, "button_down.png",185,760,165,50, rst_pressed)


function rst_down(position)
visible(rst_button, position == 1)
end

xpl_dataref_subscribe("laminar/B738/knobs/standby_alt_rst_pos", "FLOAT", rst_down)
-- end rst button


-- plus button
plus_button= img_add( "button_down.png", 20,197,50,165)
visible(plus_button, false)
function plus_pressed()
xpl_command("laminar/B738/toggle_switch/standby_alt_plus")
end

button_add( nil, "button_down.png",20,197,50,165, plus_pressed)


function plus_down(position)
visible(plus_button, position == 1)
end

xpl_dataref_subscribe("laminar/B738/knobs/standby_alt_plus_pos", "FLOAT", plus_down)
-- end plus button

-- minus button
minus_button= img_add( "button_down.png", 20,475,50,165)
visible(minus_button, false)
function minus_pressed()
xpl_command("laminar/B738/toggle_switch/standby_alt_minus")
end

button_add( nil, "button_down.png",20,475,50,165, minus_pressed)


function minus_down(position)
    visible(minus_button, position == 1)
end

xpl_dataref_subscribe("laminar/B738/knobs/standby_alt_minus_pos", "FLOAT", minus_down)
-- end minus button


-- baro_knob

function set_stby_baro(direction)
    if direction == 1 then
        xpl_command("laminar/B738/knob/standby_alt_baro_up")
    else
        xpl_command("laminar/B738/knob/standby_alt_baro_dn")
    end
end

dial_add( "stby_alt_knob.png", 617,633,200,200, set_stby_baro)
--end baro knob