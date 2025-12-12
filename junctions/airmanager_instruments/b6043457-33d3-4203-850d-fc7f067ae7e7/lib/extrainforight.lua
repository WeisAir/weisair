--THIS LIBRARY IS MANAGING THE EXTRA INFO FOR THE RIHGT SIDE OF THE PFD

--Global Vars--------------------------
gbl_stored_baro_alt = 0

function lib_extra_info_right_init()

img_altmarker = img_add("altmarker.png", 682, 148, 39, 74)
img_groundlevel = img_add("ground_level-1.png",683,-252,58,750)
img_minimums_marker = img_add("minimums_marker.png", 650, 200, 178, 100)visible(img_minimums_marker, false)
img_minimums_marker_radio = img_add("minimums_marker_radio.png", 665, 200,20, 42)visible(img_minimums_marker_radio, false)
img_alt_disagree = img_add("alt_disagree.png",677, 740, 140, 65) visible(img_alt_disagree, false)
img_std_warning_up = img_add("baro_box-2.png", 675, 812, 140, 40) visible(img_std_warning_up, false)  --amber box
img_std_warning_down = img_add("baro_box-2.png", 675, 812, 140, 40) visible(img_std_warning_down, false)--amber field filled
img_altbox_meters = img_add("altbox_meters.png", 704, 390, 140, 90) visible(img_altbox_meters, false)

txt_inhg = txt_add(" ", "size:20px; font:BCG.ttf; color: lime;  halign:right;", 640, 820, 160, 140)
txt_std =  txt_add(" ", "size:24px; font:BCG.ttf; color: lime;  halign:right;", 690, 820, 160, 140)
txt_std_amber =  txt_add(" ", "size:24px; font:BCG.ttf; color: #f9bc1b;  halign:right;", 690, 820, 160, 140) --was#f78b18
txt_inhg_amber = txt_add(" ", "size:20px; font:BCG.ttf; color: #f9bc1b;  halign:right;", 640, 820, 160, 140)
txt_altbox_meters = txt_add(" ", "size:26px; font:BCG.ttf; color: white;  halign:right;", 710, 399, 100, 100)
txt_ap_alt_meters = txt_add(" ", "size:26px; font:BCG.ttf; color: magenta ; halign:right;", 625, 35, 150, 100)
txt_m = txt_add("M", "size:22px; font:BCG.ttf; color: #0cc2ef ; halign:right;", 780, 40, 15, 100)visible(txt_m, false)
txt_baro = txt_add(" ", "size:16px; font:BCG.ttf; color: white;  halign:right;", 640, 850, 160, 140)visible(txt_baro, false)

viewport_rect(img_groundlevel,660, 110, 125, 695)
viewport_rect(img_altmarker,682,115,137,695)
viewport_rect(img_minimums_marker,650, 115, 130, 695)
viewport_rect(img_minimums_marker_radio,650, 115, 130, 695)

alt_warning_box = canvas_add(0,0,900,900)


function right_info(altitude, altmarker, altid, onground, alt_warning, in_hpa_sel, alt_disagree, std, show_std_box, trans_alt, 
trans_lvl, inhg, land_alt, des_runw_alt, runw_alt, ground_alt, total_dist, dist_to_dest, route_end, std_baro_set, descent)

-- Autopilot altitude marker and warning
	y_altmarker = ((altmarker - altitude) * -0.80) + 427	
	y_altmarker = var_cap(y_altmarker, 0, 900)--50, 800
	if altmarker > 0 then
		move(img_altmarker,nil,y_altmarker,nil,nil)
	else
		move(img_altmarker,nil,-8,nil,nil)				--marker not visible
	end
	
--white altitude warning box	
	if alt_warning == 1 then
		canvas_draw(alt_warning_box, function()
			_rect(682, 58, 125, 45)
			_stroke("white", 4)
			end)
	else
		canvas_draw(alt_warning_box, function() end)
	end

--yellow groundlevel image

	if route_end == 1 then
		visible(img_groundlevel,false)
	else
		local y_groundlevel = ((runw_alt-altitude) * -0.80) - 248
		visible(img_groundlevel,true)
		move(img_groundlevel, nil, y_groundlevel, nil, nil)
	end


----Barometric setting
	if in_hpa_sel == 1 then							--when baro is chosen
		visible(txt_inhg,true)
		local hpa = var_round(inhg*33.86,0)
		local hpa1 = string.format("%.f", hpa)
		txt_set(txt_inhg, hpa1 .. "   HPA")
	else
		visible(txt_inhg,true)						--when inch is chosen
		txt_set(txt_inhg, var_round(inhg,2) .. "   IN")
	end
	

--baro set after STD setting is chosen--------------------------------------------------------	
	if std == 1 and std_baro_set == 1 and in_hpa_sel == 1 then				--when baro is chosen
		visible(txt_baro, true)											 
		local hpa = var_round(inhg*33.86,0)
		local hpa1 = string.format("%.f", hpa)
		txt_set(txt_baro, hpa1 .. " HPA")
	elseif std == 1 and std_baro_set == 1 and in_hpa_sel == 0 then			--when inch is chosen
		visible(txt_baro, true)
		txt_set(txt_inhg, var_round(inhg,2) .. "   IN")
	else
		visible(txt_baro, false)
	end 

	
	if alt_disagree == 1 then
		visible(img_alt_disagree, true)
	else
		visible(img_alt_disagree, false)
	end
	
	
----STD mode's	
	if std == 1 and show_std_box == 0 then
		visible(txt_inhg_amber,false)
		visible(txt_inhg,false)
		visible(txt_std_amber, false)
		visible(txt_std,true)					--show STD color lime
		txt_set(txt_std, "STD      ")
		visible(img_std_warning_up, false)
	elseif std == 1 and show_std_box == 1 then
		visible(txt_inhg_amber,false)
		visible(txt_inhg,false)
		visible(txt_std,false)
		visible(txt_std_amber, true)			--show STD color amber
		txt_set(txt_std_amber, "STD      ")
	else
		visible(txt_std,false)
		visible(txt_std_amber, false)
	end
	
--***************STD WARNINGS****************************************
	if descent ~= 3 then				
		if altid > trans_alt and std == 0 and in_hpa_sel == 1 then  --if HPA is chosen
			visible(img_std_warning_up, true)
			txt_set(txt_inhg_amber, string.format("%.f",var_round(inhg*33.86,0)) .. "   HPA")
			--txt_set(txt_inhg_amber, var_round(inhg*33.86,0) .. "   HPA")
			--txt_set(txt_inhg, var_round(inhg*33.86,0) .. "   HPA")
			txt_set(txt_inhg, "")
		elseif altid > trans_alt and std == 0 and in_hpa_sel == 0 then	--if inhg is chosen
			visible(img_std_warning_up, true)
			txt_set(txt_inhg_amber, var_round(inhg,2) .. "   IN")
			--txt_set(txt_inhg, var_round(inhg,2) .. "   IN")
			txt_set(txt_inhg, "")
		else	
			txt_set(txt_inhg_amber, "")
			visible(img_std_warning_up, false)
		end
	else 
		visible(img_std_warning_up, false)
	end

	if descent == 3 then	
		if altid < trans_lvl and std == 1 and in_hpa_sel == 1 then
			visible(img_std_warning_down, true)
		elseif altid < trans_lvl and std == 1 and in_hpa_sel == 0 then
			visible(img_std_warning_down, true)
		else	
			visible(img_std_warning_down, false)
		end
	else 
		visible(img_std_warning_down, false)	
	end
---------------------------------------------------------------------------------------------------------------	
end	
--function right_info(altitude, altmarker, altid, onground, alt_warning, in_hpa_sel, alt_disagree, std,
--show_std_box, trans_alt, trans_lvl, inhg, land_alt, std_baro_set, descent)
xpl_dataref_subscribe("sim/flightmodel/misc/h_ind", "FLOAT", 										--altitude
					  --"sim/cockpit/autopilot/altitude", "FLOAT",									--altmarker
					  "laminar/B738/autopilot/mcp_alt_dial", "FLOAT",								--altmarker
					  "sim/flightmodel/misc/h_ind", "FLOAT",										--altid
					  --"sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "FLOAT",	--minimum_position
					  "sim/flightmodel2/gear/on_ground", "INT[10]",									--onground
					  "laminar/B738/autopilot/rec_alt_alert", "FLOAT",								--alt_warning
					  "laminar/B738/EFIS_control/capt/baro_in_hpa", "INT",							--in_hpa_sel
					  "laminar/B738/autopilot/alt_disagree", "INT",									--alt_disagree
					  "laminar/B738/EFIS/baro_set_std_pilot", "INT",								--std
					  "laminar/B738/EFIS/baro_std_box_pilot_show", "FLOAT",							--show_std_box
					  "laminar/B738/FMS/fmc_trans_alt", "FLOAT",									--trans_alt
					  "laminar/B738/FMS/fmc_trans_lvl", "FLOAT",									--trans_lvl
					  "laminar/B738/EFIS/baro_sel_in_hg_pilot", "FLOAT",							--inhg
					  "sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "FLOAT",	--land_alt
					  "laminar/B738/fms/dest_runway_alt", "FLOAT",									--des_runw_alt
					  "laminar/B738/pfd/rwy_altitude", "FLOAT",										--runw_alt
					  "laminar/B738/autopilot/altitude", "FLOAT",									--ground_alt
					  "laminar/B738/FMS/fpln_dist", "FLOAT",										--total_dist
					  "laminar/B738/FMS/dist_dest", "FLOAT",										--dist_to_dest
					  "laminar/B738/fms/end_route", "FLOAT",										--route_end
					  "laminar/B738/EFIS/baro_sel_pilot_show", "FLOAT",								--std_baro_set
					  "laminar/B738/FMS/descent_now", "INT", right_info)							--descent
--*************************************************************************************************************

					  
--******Capt Minimums******************************************************************************************
function cap_minimums(discision_hight, radio_or_baro, ra_dialed, ra_altitude, runway_hight, calculated_disc_hight, altitude)

--green marker for radio and/or baro minimums
		if discision_hight > 0 and radio_or_baro == 1 then						--BARO MINS
			visible(img_minimums_marker, true)
			visible(img_minimums_marker_radio, false)
			move(img_minimums_marker, nil, ((discision_hight - altitude)* -0.80)+415, nil, nil)	--was 435
		elseif discision_hight > 0 and radio_or_baro == 0 then					--RADIO MINS
			if runway_hight == 0 or ra_altitude == 0 then
				visible(img_minimums_marker_radio, true)
				visible(img_minimums_marker, false)
				move(img_minimums_marker_radio, nil, -discision_hight+455, nil, nil)	--230=dest  74=dep	was 475		
			elseif runway_hight ~= 0 then											--beware EHAM is minus
				visible(img_minimums_marker_radio, true)
				visible(img_minimums_marker, false)
				move(img_minimums_marker_radio, nil, (((runway_hight-altitude) * -0.80) + 460) - discision_hight, nil, nil)--478
			end
		else
			visible(img_minimums_marker, false)
			visible(img_minimums_marker_radio, false)
		end	
	
end
xpl_dataref_subscribe("laminar/B738/pfd/dh_pilot", "FLOAT",										--discision_hight
					  "laminar/B738/EFIS_control/cpt/minimums", "INT", 							--radio_or_baro
					  "laminar/B738/pfd/ra_dial", "FLOAT",										--ra_dialed  0=AoA  1=RA
					  "laminar/B738/PFD/agl_pilot", "FLOAT",									--ra_altitude
					  "laminar/B738/pfd/rwy_altitude", "FLOAT",									--runway_hight
					  "sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "FLOAT",--calculated_disc_hight
					  "laminar/B738/autopilot/altitude", "FLOAT", cap_minimums)					--altitude
--************************************************************************************************************

function cap_meters(button_mtr, mcp_alt, altitude)

	if button_mtr == 1 then
		visible(img_altbox_meters, true)
		visible(txt_m, true)
		txt_set(txt_ap_alt_meters, string.format("%.f", mcp_alt / 3.2808399))
		local new_alt = var_round((altitude / 3.2808399),0)
		if new_alt <100 then
			txt_set(txt_altbox_meters, string.format("%03.f", (altitude / 3.2808399)))
		else
			txt_set(txt_altbox_meters, string.format("%.f", (altitude / 3.2808399)))
		end
	else
		visible(img_altbox_meters, false)
		txt_set(txt_altbox_meters,"")
		txt_set(txt_ap_alt_meters,"")
		visible(txt_m, false)
	end


end
xpl_dataref_subscribe("laminar/B738/PFD/capt/alt_mode_is_meters", "FLOAT",
					  "sim/cockpit/autopilot/altitude", "FLOAT",
					  "laminar/B738/autopilot/altitude", "FLOAT", cap_meters)
-------------------------------------------------------------------------------------------------------------

end