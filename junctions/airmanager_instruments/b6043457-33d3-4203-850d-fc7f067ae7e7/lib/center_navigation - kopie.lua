--THIS LIBRARY IS MANAGING THE NAVIGATION STUFF IN THE MIDDLE OF THE PFD-------------------------------

--Global vars --
local stop = 0
local show_ind = 0

function lib_center_navigation_init()

img_localiser_scale_hor  = img_add("localiser_scale_hor.png", 237,685 , 320, 50) visible(img_localiser_scale_hor, false)
img_localiser_scale_ver  = img_add("localiser_scale_ver.png", 615,314 , 50, 320) visible(img_localiser_scale_ver, false)
img_localiser_scale_hor_amber  = img_add("lnav_dots_amber.png", 237,685 , 320, 50) visible(img_localiser_scale_hor_amber, false)
img_localiser_scale_ver_amber  = img_add("vnav_dots_amber.png", 615,314 , 50, 320) visible(img_localiser_scale_ver_amber, false)
img_localiser_marker_ver =  img_add("localiser_marker_ver.png", 632, 446, 23, 40) visible(img_localiser_marker_ver,false)--632, 446, 27, 55
img_localiser_marker_hor =  img_add("localiser_marker_hor.png", 369, 696, 40, 23) visible(img_localiser_marker_hor,false)--369, 695, 55, 27
img_localiser_marker_ver_solid = img_add("localiser_marker_ver_full.png", 632, 446, 23, 40) visible(img_localiser_marker_ver_solid,false)--632, 446, 27, 55
img_localiser_marker_hor_solid = img_add("localiser_marker_hor_full.png", 369, 696, 40, 23) visible(img_localiser_marker_hor_solid,false)--369, 695, 55, 27
img_vnav_hor_bar = img_add("vnav_hor.png",213, 688, 360, 40) visible(img_vnav_hor_bar, false)
img_vnav_vert_bar = img_add("vnav_vert.png",624, 280, 40, 360) visible(img_vnav_vert_bar, false)
img_nps_markerh = img_add("vnav_hor_triangle.png",376, 703, 35, 20) visible(img_nps_markerh, false)
img_nps_markerv = img_add("vnav_vert_triangle.png",640, 443, 20, 35) visible(img_nps_markerv, false) --443
img_outer_marker_black = img_add("Outer_Marker_black.png",550, 220, 60, 60) visible(img_outer_marker_black, false)
img_middle_marker = img_add("Middle_Marker.png",550, 220, 60, 60) visible(img_middle_marker, false)
img_inner_marker = img_add("Inner_Marker.png",550, 220, 60, 60) visible(img_inner_marker, false)
img_pull_up = img_add("Pull_Up.png",310, 720, 180, 35) visible(img_pull_up, false)

viewport_rect(img_nps_markerv,630, 330, 40, 265)--630, 290, 40, 300
viewport_rect(img_localiser_marker_hor_solid,190, 695, 400, 40)--190, 695, 400, 40
viewport_rect(img_localiser_marker_hor,190, 695, 400, 40)--369, 695, 222, 40

function new_data(hsi_v_signal, hsi_h_signal, hsi_v_dots, hsi_h_dots, cap_course, backcourse, blinkon, pfdmode, 
td_distance, pullup, hor_nps_marker, ver_nps_marker, autopilot_on, radaltitude)

	-- Convert integers to booleans
	--hsi_v_signal = hsi_v_signal == 1
	--hsi_h_signal = hsi_h_signal == 1
	
--VERTICAL--------------------------------------------------------------------------------------------
	--Used to determin if vertical indicator is to be shown
	if hsi_v_dots == -2.500000 then
		show_ind = 0				--hide indicator
	else
		show_ind = 1				--show indicator
	end
--print(show_ind)
    -- Should we show the vertical navigation scales?   hsi_v_signal vervangen door show_scale
	if var_round(hsi_v_dots,6) ~= 0.000000 and hsi_v_signal == 1 then
--print("hier1")
		visible(img_localiser_scale_ver, true)
		visible (img_vnav_vert_bar, false)
		visible (img_nps_markerv, false)
		
		--visible(img_localiser_scale_ver_amber, hsi_v_signal and radaltitude < 1000 and (hsi_v_dots >= 2.48 or hsi_v_dots <= -2.48) and autopilot_on == 1)

		-- Should we show the vertical navigation indicators?
		--visible(img_localiser_marker_ver_solid, hsi_v_signal==1 and (hsi_v_dots < 2.48 and hsi_v_dots > -2.48))
		if hsi_v_signal == 1 and (hsi_v_dots < 2.48 and hsi_v_dots > -2.48) and stop == 0 and radaltitude > 1500 then
			visible(img_localiser_marker_ver_solid, true)
			visible(img_localiser_marker_ver, false)
		elseif hsi_v_signal == 1 and (hsi_v_dots < 2.48 and hsi_v_dots > -2.48) and stop == 0 and radaltitude < 1500 then 
			visible(img_localiser_marker_ver_solid, blinkon)
			visible(img_localiser_marker_ver, false)
			blink_off_timer_ver_solid = timer_start(3000,nil,blinkoff)					--start 3sec timer
		else	
			timer_stop(blink_off_timer_ver_solid)											--stop 3sec timer
			visible(img_localiser_marker_ver_solid, true)								--just to be sure it's visible after timer
			--visible(img_localiser_marker_ver_solid, false)
		end
		
		if hsi_v_signal == 1 and (hsi_v_dots >= 2.48 or hsi_v_dots <= -2.48) then --radaltitude > 1000 then
			visible(img_localiser_marker_ver, true)							--show open diamond
			visible(img_localiser_marker_ver_solid,false)			
		--elseif hsi_v_signal==1 and (hsi_v_dots >= 2.48 or hsi_v_dots <= -2.48) and autopilot_on == 1 then --and radaltitude < 1500 then
			--visible(img_localiser_marker_ver, blinkon)
			--visible(img_localiser_marker_ver_solid,false)
			--blink_off_timer_ver_solid = timer_start(3000,nil,blinkoff)					--start 3sec timer
		else
			--timer_stop(blink_off_timer_ver_solid)											--stop 3sec timer
			visible(img_localiser_marker_ver, false)
		end
		
		-- Now move the vertical navigation indicator (magenta hollow or solid diamond)
		img_move (img_localiser_marker_ver_solid,nil,630-((250-(hsi_v_dots*100))*0.708),nil,nil)
		img_move (img_localiser_marker_ver,nil,630-((250-(hsi_v_dots*100))*0.708),nil,nil)  --615
		
	--end	
		
	else
		visible(img_localiser_scale_ver, false)
		visible(img_localiser_marker_ver_solid,false)
	end
	
--------------------------------------------------------------------------------------------------------------------------
--HORIZONTAL--------------------------------------------------------------------------------------------------

	if hsi_h_signal == 1 then
--print("hier1")
		visible(img_localiser_scale_hor, true)
		visible(img_localiser_scale_hor_amber, false)
		visible (img_vnav_hor_bar, false)
		visible (img_nps_markerh, false)
	end
	
--(radaltitude < 1000 and radaltitude > 0)	
	if hsi_h_signal == 1 and radaltitude < 1000 and (hsi_h_dots >= 2.48 or hsi_h_dots <= -2.48) and autopilot_on == 1 then
--print("hier2")
		visible(img_localiser_scale_hor_amber, true)
		visible(img_localiser_scale_hor, false)
		visible (img_vnav_hor_bar, false)
		visible (img_nps_markerh, false)
	end
	
	--visible(img_localiser_scale_hor, hsi_h_signal)
	--visible(img_localiser_scale_hor_amber, hsi_h_signal and radaltitude < 1000 and (hsi_h_dots >= 2.48 or hsi_h_dots <= -2.48) and autopilot_on == 1)
  
    -- Should we show the horizontal navigation indicator?
    visible(img_localiser_marker_hor_solid, hsi_h_signal==1 and hsi_h_dots < 2.48 and hsi_h_dots > -2.48)
	if hsi_h_signal == 1 and (hsi_h_dots < 2.48 and hsi_h_dots > -2.48) and stop == 0 and radaltitude > 1500 then
		visible(img_localiser_marker_hor_solid, true)
		visible(img_localiser_marker_hor, false)
	elseif hsi_h_signal == 1 and (hsi_h_dots < 2.48 and hsi_h_dots > -2.48) and stop == 0 and radaltitude < 1500 then	
		visible(img_localiser_marker_hor_solid, blinkon)
		visible(img_localiser_marker_hor, false)
		blink_off_timer_hor_solid = timer_start(3000,nil,blinkoff)					--start 3sec timer
	else
		timer_stop(blink_off_timer_hor_solid)										--stop 3sec timer
		visible(img_localiser_marker_hor_solid, true)								--just to be sure it's visible after timer
		--visible(img_localiser_marker_hor, false)
	end
		
--[[	
	-- Make the HNAV/LNAV out of range indicator blink when the localizer is armed but not captured beneath 1000 FT AGL
	if hsi_h_signal==1 and (hsi_h_dots >= 2.48 or hsi_h_dots <= -2.48) then
		visible(img_localiser_marker_hor, true)
		visible(img_localiser_marker_hor_solid,false)
	--elseif hsi_h_signal==1 and radaltitude < 1500 then --and autopilot_on == 1 then
		--visible(img_localiser_marker_hor, blinkon)
		--visible(img_localiser_marker_hor_solid,false)
	else
		visible(img_localiser_marker_hor, false)
	end]]

    -- Now move the horizontal navigation indicator (magenta solid diamond)
    img_move (img_localiser_marker_hor_solid,550-((250-(hsi_h_dots*100))*0.708),nil,nil,nil)   --540
	img_move (img_localiser_marker_hor,550-((250-(hsi_h_dots*100))*0.708),nil,nil,nil)		--540
	
-----------------------------------------------------------------------------------------------------------------	
	
	--NPS and ANP -- Navigation Performance Scales and Actual Navigation Performance
	if pfdmode == 2 or pfdmode == 0 then
		visible (img_vnav_hor_bar, true)
		visible (img_nps_markerh, true)								--horizontal ANP
		visible(img_localiser_scale_hor, false)
		visible(img_localiser_scale_hor_amber,false)
		mark_hor = 375 + (hor_nps_marker * -51.5)
		mark_hor = var_cap(mark_hor,250,510)
		img_move (img_nps_markerh, mark_hor, nil, nil, nil)
		visible(img_localiser_marker_hor, false)
		visible(img_localiser_marker_hor_solid, false)
	end
	
	if pfdmode == 2 and td_distance == 0 then
		visible (img_vnav_vert_bar, true)
		visible (img_nps_markerv, true)								--vertical ANP
		visible(img_localiser_scale_ver, false)
		visible(img_localiser_scale_ver_amber, false)
		visible(img_localiser_marker_ver_solid,false)
		visible(img_localiser_marker_ver,false)
		mark_ver = 323 + ((400-ver_nps_marker)*0.3)
		if ver_nps_marker > 400 then
			img_move (img_nps_markerv, nil, 323, nil, nil)
		else
			img_move (img_nps_markerv,nil,(mark_ver), nil, nil)
		end
	end
		
	if ver_nps_marker< -400 then
		img_move (img_nps_markerv,nil,563,nil,nil)
	else
		img_move (img_nps_markerv,nil,(mark_ver),nil,nil)
	end
	
	if  pullup == 1 then					--was gpws(ground proximity warning
		visible(img_pull_up, true)
	else
		visible(img_pull_up, false)
	end
	
end

--function new_data(hsi_v_signal, hsi_h_signal, hsi_v_dots, hsi_h_dots, cap_course, backcourse, blinkon, pfdmode, 
--td_distance, pullup, hor_nps_marker, ver_nps_marker, autopilot_on, radaltitude)
xpl_dataref_subscribe("sim/cockpit2/radios/indicators/hsi_display_vertical_pilot", "INT", 					--hsi_v_signal
					  "sim/cockpit2/radios/indicators/hsi_display_horizontal_pilot", "INT",					--hsi_h_signal 
					  "sim/cockpit2/radios/indicators/hsi_vdef_dots_pilot", "FLOAT",						--hsi_v_dots 
					  "sim/cockpit2/radios/indicators/hsi_hdef_dots_pilot", "FLOAT",						--hsi_h_dots 
					  "laminar/radios/pilot/nav_obs", "FLOAT",												--cap_course
					  "laminar/B738/fms/gps_track_degtm", "FLOAT",											--backcourse
					  "laminar/B738/autopilot/blink", "INT",												--blinkon
					  "laminar/B738/autopilot/pfd_mode", "INT",												--pfdmode
					  "laminar/B738/fms/vnav_td_dist", "FLOAT",												--td_distance
					  "laminar/b738/alert/pfd_pull_up", "FLOAT",											--pullup
					  "laminar/B738/autopilot/gps_horizont", "FLOAT",										--hor_nps_marker
					  "laminar/B738/fms/vnav_err_pfd", "FLOAT",												--ver_nps_marker
					  "laminar/B738/autopilot/cmd_a_status", "INT",											--autopilot_on
					  "sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "FLOAT", new_data)					  
------------------------------------------------------------------------------------------------------------------------

--*************OUTER_***MIDDLE_******INNER MARKERS**************************************
function ils_markers(blink, inner_marker, middle_marker, outer_marker)

	if outer_marker == 1 then
		visible(img_outer_marker_black, blink==0)
	else
		visible(img_outer_marker_black,false)
	end
	
	if inner_marker == 1 then
		visible(img_inner_marker, blink==0)
	else
		visible(img_inner_marker, false)
	end
	
	if middle_marker == 1 then
		visible(img_middle_marker, blink==0)
	else
		visible(img_middle_marker,false)
	end
end
xpl_dataref_subscribe("laminar/B738/autopilot/blink", "INT",
					  "sim/cockpit/misc/over_inner_marker", "INT",
					  "sim/cockpit/misc/over_middle_marker", "INT",
					  "sim/cockpit/misc/over_outer_marker", "INT", ils_markers)
------------------------------------------------------------------------------------------------------

--Timer	
function blinkoff()
	stop = 1
	--print("stop is nu 1")
	--visible (img_localiser_marker_hor_solid, blinkon==false)
end

end