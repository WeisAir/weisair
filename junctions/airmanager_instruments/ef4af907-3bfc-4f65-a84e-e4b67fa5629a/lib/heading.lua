-- HEADING LIBRARY --
-- TO DO TO DO TO DO TO DO TO DO --
-- Limit the rotation of the autopilot heading indicator, so it doesn't exit the screen.
-- See if the MAG symbol is yellow sometimes and when is this the case.
-- Make the heading bug a bit thicker.
-- TO DO TO DO TO DO TO DO TO DO --

function lib_heading_init()

img_compass_rose = img_add("heading.png", 99, 698, 500, 500)
viewport_rect(img_compass_rose, 0, 690, 800, 108)

img_heading_bug = img_add("headingbug.png", 329, 680, 40, 18)
viewport_rect(img_heading_bug, 0, 670, 800, 128)

img_add("lubberline.png", 338, 680, nil, nil)

img_ground_track = img_add("ground_track_ind.png", 339, 698, nil, nil)
viewport_rect(img_ground_track, 0, 670, 800, 128)

img_magn_norm = img_add("magnetic_norm.png", 400, 770, 47, 27)
-- img_magn_warn = img_add("magnetic_warn.png", 400, 770, 47, 27)

txt_hdng_bug = txt_add(" ", "font:monofonto.ttf; size:26px; color: magenta; halign:right;", 214, 766, 100, 60)
txt_add("H",                "font:monofonto.ttf; size:20px; color: magenta; halign:center;", 272, 771, 100, 60)

end

-- Now do something with the text and images we've just added
function heading_callback(APheading, heading, ground_track)

    -- Rotate the compass heading (electric gyro)
    rotate(img_compass_rose, heading * -1)

	-- Rotate the ground track indicator
	rotate(img_ground_track, (heading - ground_track) * -1)

    -- Set the text for the autopilot heading bug
    txt_set(txt_hdng_bug, string.format("%03.0f", var_round(APheading, 0)))
	
	-- Rotate and move the autopilot heading bug
	xbug, ybug = geo_rotate_coordinates(APheading - heading, 259)

	rotate(img_heading_bug, APheading - heading)
	move(img_heading_bug, xbug + 329, 939 + ybug, nil, nil)

end

-- Variable subscribe
xpl_dataref_subscribe("sim/cockpit/autopilot/heading_mag", "FLOAT",
					  "sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot", "FLOAT",
					  "sim/flightmodel/position/true_psi", "FLOAT", heading_callback)