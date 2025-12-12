--THIS LIBRARY IS MANAGING THE AoA AND RA STUFF--------------------------------------------------------------

local glbl_stop = 0
local var_whitegauge_on = 0
local blinkon_rad = true

function lib_aoa_ra_init()

img_ralt_gauge_white = img_add("radio_altimeter_gauge_white.png", 537, 110, 100, 100)visible(img_ralt_gauge_white, false)
img_ralt_gauge_line_white_0180   = img_add("raalt_gauge_line_white_0180.png", 537, 110, 100, 100)visible(img_ralt_gauge_line_white_0180, false)
img_ralt_gauge_line_white_180360 = img_add("raalt_gauge_line_white_180360.png", 537, 110, 100, 100)visible(img_ralt_gauge_line_white_180360, false)
img_ralt_gauge_line_amber_0180   = img_add("raalt_gauge_line_amber_0180.png", 537, 110, 100, 100)visible(img_ralt_gauge_line_amber_0180, false)
img_ralt_gauge_line_amber_180360 = img_add("raalt_gauge_line_amber_180360.png", 537, 110, 100, 100)visible(img_ralt_gauge_line_amber_180360, false)
img_ralt_gauge_amber = img_add("radio_altimeter_gauge_amber.png", 537, 110, 100, 100)visible(img_ralt_gauge_amber, false)
img_ralt_arrow_green = img_add("set_raalt_green.png", 537, 110, 100, 100)visible(img_ralt_arrow_green, false)
img_ralt_arrow_amber = img_add("set_raalt_amber.png", 537, 110, 100, 100)visible(img_ralt_arrow_amber, false)
img_aoa_rose = img_add("angle_attack.png",550, 110, 82, 99)visible(img_aoa_rose, false)
img_AA_needle = img_add("VS_Needle.png",538, 63, 90, 200)visible(img_AA_needle, false)
img_rotate(img_AA_needle,225)

viewport_rect(img_ralt_gauge_line_white_0180, 587, 110, 50, 100)
viewport_rect(img_ralt_gauge_line_white_180360, 537, 110, 50, 100)
viewport_rect(img_ralt_gauge_line_amber_0180, 587, 110, 50, 100)
viewport_rect(img_ralt_gauge_line_amber_180360, 537, 110, 50, 100)

txt_angleAttack = txt_add(" ", "size:28px; font:FreeSansBold.ttf; color: white ; halign:right;", 350, 170, 200, 200)
txt_radio_alt_white = txt_add("","size:26px; font:BCG.ttf; color: white;  halign:center;", 545, 147, 80, 30)
txt_radio_alt_amber = txt_add("","size:26px; font:BCG.ttf; color: #edbf38;  halign:center;", 545, 147, 80, 30)
txt_radio_baro = txt_add(" ","size:20px; font:BCG.ttf; color: lime;  halign:right;", 470, 730, 150, 130)
txt_radio_baro_top = txt_add(" ","size:18px; font:BCG.ttf; color: lime;  halign:left;", 490, 95, 100, 50)
txt_minimum_value = txt_add(" ","size:20px; font:BCG.ttf; color: lime;  halign:right;", 465, 755, 150, 130)
txt_minimum_value_top = txt_add(" ","size:18px; font:BCG.ttf; color: lime;  halign:left;", 570, 95, 100, 50)

-- Angle of attack and RA and Circular RA
function aoa_ra(angleattack, ra_dialed, landing_alt, decision_height, radio_baro, route_end, blinkon, onground)

--Is in the AviTab chosen for AoA or for RA or for Circular RA ?
	if ra_dialed == 0 then										--user has AoA chosen
		visible(img_ralt_gauge_white, false)
		visible(img_ralt_gauge_line_white_0180, false)
		visible(img_ralt_gauge_line_white_180360, false)
		visible(img_ralt_gauge_line_amber_0180, false)
		visible(img_ralt_gauge_line_amber_180360, false)
		visible(img_ralt_gauge_amber, false)
		visible(img_ralt_arrow_green, false)
		visible(img_ralt_arrow_amber, false)
		visible(txt_radio_alt_white, false)
		visible(txt_radio_alt_amber, false)
		
		--If AoA then all the minimum text is shown at the bottom------------
		if radio_baro == 1 then									--baro is chosen
			txt_set(txt_radio_baro_top,"")
			txt_set(txt_minimum_value_top, "")
			visible(txt_radio_baro, true)
			visible(txt_minimum_value, true)
			txt_set(txt_radio_baro," BARO ")
			txt_set(txt_minimum_value, string.format ("%.f",decision_height))
		else													--radio is chosen
			txt_set(txt_radio_baro_top,"")
			txt_set(txt_minimum_value_top, "")
			visible(txt_radio_baro, true)
			visible(txt_minimum_value, true)
			txt_set(txt_radio_baro," RADIO ")
			txt_set(txt_minimum_value, string.format ("%.f",decision_height))
		end
		
		if onground[1] == 1 and onground[2] == 1 and onground[3] == 1 then
			visible(img_aoa_rose, true)
			txt_set(txt_angleAttack ,"0.0")
			visible(img_AA_needle, true)
			img_rotate(img_AA_needle,-135)
		else
			visible(img_aoa_rose, true)
			angleattack=var_cap(angleattack,-6,21)
			txt_set(txt_angleAttack ,var_round(angleattack,1))
			visible(img_AA_needle, true)
			img_rotate(img_AA_needle,(-angleattack * 9) + 225)
		end
	end
	
	if ra_dialed == 1 then													--user has RA chosen 
		--If RA chosen, then RadioAltitude is shown in center and minimums for baro and radio are 
		--shown below
		
		--If RA then all the minimum text is shown at the bottom------------
		if radio_baro == 1 then									--baro is chosen
			txt_set(txt_radio_baro_top,"")
			txt_set(txt_minimum_value_top, "")
			if decision_height > 0 then
				visible(txt_radio_baro, true)
				visible(txt_minimum_value, true)
				txt_set(txt_radio_baro," BARO ")
				txt_set(txt_minimum_value, string.format ("%.f",decision_height))
			end	
		elseif radio_baro == 0 then								--radio is chosen
			txt_set(txt_radio_baro_top,"")
			txt_set(txt_minimum_value_top, "")
			if decision_height > 0 then
				visible(txt_radio_baro, true)
				visible(txt_minimum_value, true)
				txt_set(txt_radio_baro," RADIO ")
				txt_set(txt_minimum_value, string.format ("%.f",decision_height))
			end
		end
	
	end
	
	if ra_dialed == 2 then													--user has Circular RA chosen
		visible(img_aoa_rose, false)
		visible(img_AA_needle, false)
		txt_set(txt_angleAttack,"")
		--If Circular RA chosen then minimums for baro are shown below and for radio are shown at top
		if radio_baro == 1 then									--baro is chosen
			txt_set(txt_radio_baro_top,"")
			txt_set(txt_minimum_value_top, "")
			if decision_height > 0 then
				visible(txt_radio_baro, true)
				visible(txt_minimum_value, true)
				txt_set(txt_radio_baro," BARO ")
				txt_set(txt_minimum_value, string.format ("%.f",decision_height))
			end
		elseif radio_baro == 0 then													--radio is chosen
			txt_set(txt_radio_baro,"")
			txt_set(txt_minimum_value, "")
			if decision_height > 0 then
				visible(txt_radio_baro_top, true)
				visible(txt_minimum_value_top, true)
				txt_set(txt_radio_baro_top," RADIO ")
				txt_set(txt_minimum_value_top, string.format ("%.f",decision_height))
			end
		end
		
		visible(txt_radio_alt_white, (landing_alt - 4 < 2500 and landing_alt - 4 > decision_height) or landing_alt == 0)
		visible(txt_radio_alt_amber, (landing_alt - 4 < decision_height) and landing_alt - 4 > 1)
					
		if (landing_alt - 4 < 1000 and landing_alt - 4 > decision_height) or landing_alt-4 == 0 then		
			visible(img_ralt_gauge_white, true)						--white gauge is shown)
			var_whitegauge_on = 1
			if radio_baro == 0 then									--radio is chosen			
				visible(txt_radio_baro_top, false)
				visible(txt_minimum_value_top, false)				--minimum text is hidden
				txt_set(txt_radio_baro_top,"")
				txt_set(txt_minimum_value_top,"")
			end
		else
			visible(img_ralt_gauge_white, false)					--white gauge is hidden
			var_whitegauge_on = 0
			if radio_baro == 1 then									--baro is chosen
				visible(txt_radio_baro, true)
				visible(txt_minimum_value, true)
				txt_set(txt_radio_baro," BARO ")					--hpa setting are visible at the center bottom
				txt_set(txt_minimum_value, string.format ("%.f",decision_height))
				visible(txt_radio_baro_top, false)
				visible(txt_minimum_value_top, false)				--minimum radio text is hidden
				txt_set(txt_radio_baro_top,"")
				txt_set(txt_minimum_value_top,"")
			elseif radio_baro == 0 then								--radio is chosen
				visible(txt_radio_baro_top, true)
				visible(txt_minimum_value_top, true)				--minimum radio text is shown
				txt_set(txt_radio_baro_top," RADIO ")
				txt_set(txt_minimum_value_top, string.format ("%.f",decision_height))
				visible(txt_radio_baro, false)
				visible(txt_minimum_value, false)					--minimum baro text is hidden
				txt_set(txt_radio_baro,"")
				txt_set(txt_minimum_value,"")
			end			
		end
				
		if (landing_alt - 4 < decision_height) and landing_alt - 4 > 1 and var_whitegauge_on == 0 then
			visible(img_ralt_gauge_amber, true)						--amber gauge is shown
			if radio_baro == 0 then									--radio is chosen			
				visible(txt_radio_baro_top, false)
				visible(txt_minimum_value_top, false)				--minimum text is hidden
				txt_set(txt_radio_baro_top,"")
				txt_set(txt_minimum_value_top,"")
			end
		else
			visible(img_ralt_gauge_amber, false)					--amber gauge is hidden
			if radio_baro == 1 and var_whitegauge_on == 0 then		--baro is chosen			
				visible(txt_radio_baro, true)
				visible(txt_minimum_value, true)
				txt_set(txt_radio_baro," BARO ")					--hpa setting are visible at the center bottom
				txt_set(txt_minimum_value, string.format ("%.f",decision_height))
				visible(txt_radio_baro_top, false)
				visible(txt_minimum_value_top, false)				--minimum text is hidden
				txt_set(txt_radio_baro_top,"")
				txt_set(txt_minimum_value_top,"")
			elseif radio_baro == 0 and var_whitegauge_on == 0 then
				visible(txt_radio_baro_top, true)
				visible(txt_minimum_value_top, true)				--minimum text is shown
				txt_set(txt_radio_baro_top," RADIO ")
				txt_set(txt_minimum_value_top, string.format ("%.f",decision_height))
				visible(txt_radio_baro, false)
				visible(txt_minimum_value, false)					--minimum baro text is hidden
				txt_set(txt_radio_baro,"")
				txt_set(txt_minimum_value,"")
			end	
		end
				
		visible(img_ralt_gauge_line_white_0180, (landing_alt - 4 < 1000 and landing_alt - 4 > decision_height) or landing_alt-4 == 0)
		visible(img_ralt_gauge_line_white_180360, (landing_alt - 4 < 1000 and landing_alt - 4 > decision_height) or landing_alt-4 == 0)
		visible(img_ralt_gauge_line_amber_0180, (landing_alt - 4 < decision_height) and landing_alt - 4 > 1)
		
		if landing_alt - 4 < decision_height and landing_alt - 4 > 1 and glbl_stop == 0 then
			visible(img_ralt_gauge_amber, blinkon_rad)
			visible(img_ralt_gauge_line_amber_0180, blinkon_rad)
			visible(img_ralt_gauge_line_amber_180360, blinkon_rad)
			visible(img_ralt_arrow_amber, blinkon_rad)
			blink_off_timer = timer_start(3000,nil,blinkoff)		--start 3sec timer
		elseif landing_alt - 4 < decision_height and landing_alt - 4 > 1 and glbl_stop == 1 then
			visible(img_ralt_gauge_amber, true)						--show amber gauge after 3 sec timer has elapsed
			visible(img_ralt_gauge_line_amber_0180, true)
			visible(img_ralt_gauge_line_amber_180360, true)
			visible(img_ralt_arrow_amber, true)
		else
			visible(img_ralt_gauge_amber, false)
			visible(img_ralt_gauge_line_amber_0180, false)
			visible(img_ralt_gauge_line_amber_180360, false)
			visible(img_ralt_arrow_amber, false)
		end
				
		visible(img_ralt_arrow_green,  ((landing_alt - 4 < 1000 and landing_alt - 4 > decision_height) or landing_alt-4 == 0) and decision_height > 0)
		visible(img_ralt_arrow_amber, ((landing_alt - 4 < decision_height) and landing_alt - 4 > 1) and decision_height > 0)
				
		if landing_alt-4 == 0 then
			txt_set(txt_radio_alt_white,"")
		else
			txt_set(txt_radio_alt_white,string.format("%.f",landing_alt-4))
		end
		
		if (landing_alt - 4 < decision_height) and (landing_alt - 4 > 1) then
			txt_set(txt_radio_alt_amber,string.format("%.f",landing_alt-4))
		else
			txt_set(txt_radio_alt_amber, "")
		end
		
		img_rotate(img_ralt_arrow_green, 360 / 1000 * decision_height)
		img_rotate(img_ralt_arrow_amber, 360 / 1000 * decision_height)
		
		img_rotate(img_ralt_gauge_line_white_0180, (180 / 500 * var_cap(landing_alt-4, 0, 500)) - 180)
		img_rotate(img_ralt_gauge_line_white_180360, (180 / 500 * var_cap(landing_alt-4, 500, 1000)) )
		img_rotate(img_ralt_gauge_line_amber_0180, (180 / 500 * var_cap(landing_alt-4, 0, 500)) - 180)
		img_rotate(img_ralt_gauge_line_amber_180360, (180 / 500 * var_cap(landing_alt-4, 500, 1000)) )
		
	end		
--------------------------------------------------------------------------------------------------------------------

	if route_end == 1 then							--at the end of the route show minimums again
		visible(txt_radio_baro_top, true)
		visible(txt_minimum_value_top, true)
	end

	
	if decision_height == 0 then					--if RST button is pressed					
		visible(txt_radio_baro_top, false)
		visible(txt_minimum_value_top, false)
		visible(txt_radio_baro, false)
		visible(txt_minimum_value, false)
	end

end
xpl_dataref_subscribe("sim/flightmodel2/misc/AoA_angle_degrees", "FLOAT", 			--angleattack
					  "laminar/B738/aoa_ra", "FLOAT",								--ra_dialed	0=AoA  1=RA  2=circRA
					  "laminar/B738/PFD/agl_pilot", "FLOAT",						--landing_alt
					  "laminar/B738/pfd/dh_pilot", "FLOAT",							--decision_height
					  "laminar/B738/EFIS_control/cpt/minimums", "INT", 				--radio_baro	0=radio  1=baro  
					  "laminar/B738/fms/end_route", "FLOAT",						--route_end
					  "laminar/B738/autopilot/blink", "INT",						--blinkon
					  "sim/flightmodel2/gear/on_ground", "INT[10]", aoa_ra)			--onground
--laminar/B738/fms/fpln_acive
--------------------------------------------------------------------------------------------------------------

timer_start(0,300, function()
blinkon_rad = not blinkon_rad
end)

function blinkoff()
	glbl_stop = 1
end

end
