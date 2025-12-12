-- VERTICAL SPEED LIBRARY --

function lib_vertical_speed_init()

-- Images
img_vsi_needle = img_add("vsi_needle.png", 640, 376, 470, 4)
viewport_rect(img_vsi_needle, 744, 187, 53, 382)
img_vs_bug = img_add("vs_bug.png", 746, 374, 21, 8)

-- Text --
txt_vs_up = txt_add(" ",   "font:monofonto.ttf; size:30px; color: white; halign:right;", 636, 127, 150, 60)
txt_vs_down = txt_add(" ", "font:monofonto.ttf; size:30px; color: white; halign:right;", 636, 600, 150, 60)

end

-- Functions
function vertical_speed_callback(vspeed, APvspeed)

    -- Vertical speed text
    visible(txt_vs_up, vspeed >= 400)
    txt_set(txt_vs_up, math.floor(vspeed / 50) * 50 )
    visible(txt_vs_down, vspeed <= -400)
    txt_set(txt_vs_down, math.abs(math.floor(vspeed / 50) * 50) )
	
	-- Vertical speed needle
	-- Cap the speed at 6000 fpm for the needle
	vspeed = var_cap(vspeed, -6000, 6000)
	
	if vspeed > 2000 then
		rotate(img_vsi_needle, 6.5 / 4000 * (vspeed - 2000) + 49)
	elseif vspeed > 1500 then
		rotate(img_vsi_needle, 6.5 / 500 * (vspeed - 1500) + 42.5)
	elseif vspeed > 1000 then
		rotate(img_vsi_needle, 8.5 / 500 * (vspeed - 1000) + 34)
	elseif vspeed > 500 then
		rotate(img_vsi_needle, 15 / 500 * (vspeed - 500) + 19)
	elseif vspeed >= 0 then
		rotate(img_vsi_needle, 19 / 500 * vspeed)
	elseif vspeed < -2000 then
		rotate(img_vsi_needle, 6.5 / 4000 * (vspeed + 2000) - 49)
	elseif vspeed < -1500 then
		rotate(img_vsi_needle, 6.5 / 500 * (vspeed + 1500) - 42.5)
	elseif vspeed < -1000 then
		rotate(img_vsi_needle, 8.5 / 500 * (vspeed + 1000) - 34)
	elseif vspeed < -500 then
		rotate(img_vsi_needle, 15 / 500 * (vspeed + 500) - 19)
	elseif vspeed < 0 then
		rotate(img_vsi_needle, 19 / 500 * vspeed)
	end
	
	
	-- Move the vertical speed bug
	visible(img_vs_bug, APvspeed > 10 or APvspeed < -10)
	APvspeed = var_cap(APvspeed, -6000, 6000)

	if APvspeed >= 2000 then
		move(img_vs_bug, nil, 226 - 40 / 4000 * (APvspeed - 2000), nil, nil)
	elseif APvspeed >= 1000 then
		move(img_vs_bug, nil, 286 - 60 / 1000 * (APvspeed - 1000), nil, nil)
	elseif APvspeed >= 0 then
		move(img_vs_bug, nil, 374 - 88 / 1000 * APvspeed, nil, nil)
	elseif APvspeed <= -4000 then
		move(img_vs_bug, nil, 40 / 4000 * math.abs(APvspeed + 2000) + 522, nil, nil)
	elseif APvspeed <= -1000 then
		move(img_vs_bug, nil, 60 / 1000 * math.abs(APvspeed + 1000) + 462, nil, nil)
	elseif APvspeed < 0 then
		move(img_vs_bug, nil, 88 / 1000 * math.abs(APvspeed) + 374, nil, nil)
	end	

end

-- Variable subscribe
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT", 
					  "sim/cockpit/autopilot/vertical_velocity", "FLOAT", vertical_speed_callback)