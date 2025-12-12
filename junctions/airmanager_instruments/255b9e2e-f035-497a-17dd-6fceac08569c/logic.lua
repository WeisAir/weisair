--[[
*****************************************************************
************FSS ERJ - 1XX - Auto-Brake*************************
*****************************************************************
##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
--]]

img_add_fullscreen("background.png")
--[[
----night test
img_bg_night = img_add_fullscreen("background_night.png")
img_labels_backlight = img_add_fullscreen("backlighting.png")
--=======Back  Lighting============
function ss_backlighting(value, pwr)
    value = var_round(value*10,2)
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04) 
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
        
    end
end
fs2020_variable_subscribe("L:FSS_EXX_AUTOBRAKE", "Number",ss_backlighting)                                     
-----------------------------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
            
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

------end of night test
--]]
--------------------------------------------

function autobrake_rto_pressed()
		xpl_command("sim/flight_controls/brakes_rto_auto", "FLOAT")
end
button_add(nil, nil, 49,148,45,27, autobrake_rto_pressed)

function autobrake_off_pressed()
		xpl_command("sim/flight_controls/brakes_off_auto", "FLOAT")
end
button_add(nil, nil, 105,129,45,27, autobrake_off_pressed)

function autobrake_lo_pressed()
		xpl_command("sim/flight_controls/brakes_1_auto", "FLOAT")
end
button_add(nil, nil, 156,144,45,27, autobrake_lo_pressed)

function autobrake_med_pressed()
		xpl_command("sim/flight_controls/brakes_2_auto", "FLOAT")
end
button_add(nil, nil, 180,171,45,27, autobrake_med_pressed)
function autobrake_hi_pressed()
		xpl_command("sim/flight_controls/brakes_3_auto", "FLOAT")
end
button_add(nil, nil, 186,199,45,28, autobrake_hi_pressed)

img_sw_abk_rto = img_add("diam_up.png",  78,165, 100,100) visible(img_sw_abk_rto, false)
img_sw_abk_off = img_add("diam_up.png",  78,165, 100,100) visible(img_sw_abk_off, true)
img_sw_abk_lo = img_add("diam_up.png",   78,165, 100,100) visible(img_sw_abk_lo, false)
img_sw_abk_med = img_add("diam_up.png",   78,165, 100,100) visible(img_sw_abk_med, false)
img_sw_abk_hi = img_add("diam_up.png",   78,165, 100,100) visible(img_sw_abk_hi, false)
rotate(img_sw_abk_rto, - 37)
rotate(img_sw_abk_lo, 32)
rotate(img_sw_abk_med, 59)
rotate(img_sw_abk_hi, 88)

function abk_image_cb (state)
        switch_set_position(sw_abk, state)     
        visible(img_sw_abk_rto, state == 0)
        visible(img_sw_abk_off, state == 1)
        visible(img_sw_abk_lo, state == 2)
        visible(img_sw_abk_med, state == 3)
        visible(img_sw_abk_hi, state == 4)
 end

xpl_dataref_subscribe("sim/cockpit/switches/auto_brake_settings", "INT", abk_image_cb)

function cb_sw_abk(val,dir)
        fs2020_variable_write("L:FSS_EXX_AUTOBRAKE", "Number", val + dir)  
end
sw_abk = switch_add(nil,nil,nil,nil,nil, 78,165, 0,0, cb_sw_abk)