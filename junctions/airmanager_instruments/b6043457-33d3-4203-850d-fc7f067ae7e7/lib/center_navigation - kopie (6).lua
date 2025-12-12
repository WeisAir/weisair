--THIS LIBRARY IS MANAGING THE NAVIGATION STUFF IN THE MIDDLE OF THE PFD-------------------------------

--Global vars --
local blinkon_ver = true
local blinkon_hor = true
local blink_flag_ver = 0
local blink_flag_hor = 0
local blink = 0

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

viewport_rect(img_nps_markerv,630, 325, 40, 275)--630, 330, 40, 265
viewport_rect(img_localiser_marker_hor_solid,190, 695, 400, 40)--190, 695, 400, 40
viewport_rect(img_localiser_marker_hor,190, 695, 400, 40)--369, 695, 222, 40


function new_data(hsi_v_signal, hsi_h_signal, hsi_v_dots, hsi_h_dots, pfdmode, pfd_alt_mode, td_distance, pullup, hor_nps_marker, 
ver_nps_marker, autopilot_on, ft_flag, gs_flag, hor_dsp_flag, vert_dsp_flag, diamond_blink, gs_status, autoland_status, radaltitude)


local arm_radaltitude = 1480
	
--VERTICAL--------------------------------------------------------------------------------------------

    -- Should we show the vertical navigation scales?   hsi_v_signal vervangen door show_scale
		if hsi_v_signal == 1 and hsi_h_signal == 1 then
			visible(img_localiser_scale_ver, true)									--show white vertical scale
			visible(img_localiser_scale_hor, true)									--show white horizontal scale
			visible (img_vnav_vert_bar, false)
			visible (img_nps_markerv, false)
			visible (img_vnav_hor_bar, false)
			visible (img_nps_markerh, false)			
		end	
		
	-- Should we show the vertical navigation indicators and blinking scales?			
		if hsi_v_signal == 1 and hsi_h_signal == 1 and (hsi_v_dots < 2.480000 and hsi_v_dots > -2.48000000) 
		and radaltitude < arm_radaltitude then
		--and blink_flag_ver == 0 then --and diamond_blink == 1 then --and radaltitude < arm_radaltitude then			
			--visible(img_localiser_marker_ver_solid, blinkon_ver)				--show blinking solid vertical diamond
			visible(img_localiser_marker_ver, false)							--hide open vertical diamond
			if diamond_blink == 1 and radaltitude < arm_radaltitude and gs_status == 2 and autoland_status == 1 and pfd_alt_mode ~= 3 then
				--timer_start(3000,nil, blinkoff_hor)										--start 3sec timer
				visible(img_localiser_marker_ver_solid, false)
				visible(img_localiser_scale_ver_amber, false)
				visible(img_localiser_scale_hor_amber, false)
				visible(img_localiser_scale_ver, false)							--hide white vertical scale
				visible(img_localiser_scale_hor, false)							--hide white horizontal scale
			elseif diamond_blink == 0 and radaltitude < arm_radaltitude and gs_status == 2 and autoland_status == 1 and pfd_alt_mode ~= 3 then
				visible(img_localiser_marker_ver_solid, true)
				visible(img_localiser_scale_ver_amber, true)
				visible(img_localiser_scale_hor_amber, true)
				visible(img_localiser_scale_ver, false)							--hide white vertical scale
				visible(img_localiser_scale_hor, false)							--hide white horizontal scale
			elseif pfd_alt_mode == 3 and radaltitude < arm_radaltitude then
				visible(img_localiser_marker_ver_solid, true)
				visible(img_localiser_scale_ver_amber, false)
				visible(img_localiser_scale_hor_amber, false)
				visible(img_localiser_scale_ver, true)							--show white vertical scale
				visible(img_localiser_scale_hor, true)							--show white horizontal scale
			end
		elseif hsi_v_signal == 1 and hsi_h_signal == 1 and (var_round(hsi_v_dots,6) < 2.480000 and var_round(hsi_v_dots,6) > -2.480000) 
		and radaltitude > arm_radaltitude and gs_flag == 0 then		--and var_round(hsi_v_dots,6) > 0.000000 then
			visible(img_localiser_marker_ver_solid, true)						--show solid vertical diamond
			visible(img_localiser_marker_ver, false)							--hide open vertical diamond
			--visible(img_localiser_scale_ver, true)							--hide white vertical scale
			--visible(img_localiser_scale_hor, true)							--hide white horizontal scale
		end
		
		
		if hsi_v_signal == 1 and (hsi_v_dots >= 2.480000 or hsi_v_dots <= -2.480000) and ft_flag == 1 then			
			visible(img_localiser_marker_ver, true)							--show open diamond
			visible(img_localiser_marker_ver_solid,false)					--hide closed diamond
		else
            visible(img_localiser_marker_ver, false)
		end
		
		if hsi_v_signal == 1 and var_round(hsi_v_dots,6) == -0.000000 then
			visible(img_localiser_marker_ver_solid,false)
		end
		
		if pfdmode == 0  and td_distance == 0.0 and vert_dsp_flag == 0 then
			visible(img_localiser_marker_ver_solid,false)
			visible(img_localiser_scale_ver, false)
		end
		
		if pfdmode == 2 and hsi_v_signal == 1 then
			visible(img_localiser_scale_ver, false)
		end
		
		
		-- Now move the vertical navigation indicator (magenta hollow or solid diamond)
		img_move (img_localiser_marker_ver_solid,nil,630-((250-(hsi_v_dots*100))*0.708),nil,nil)
		img_move (img_localiser_marker_ver,nil,630-((250-(hsi_v_dots*100))*0.708),nil,nil)  --615

	
--------------------------------------------------------------------------------------------------------------------------
--HORIZONTAL--------------------------------------------------------------------------------------------------	
 
    -- Should we show the solid horizontal navigation indicator?			
	if hsi_h_signal == 1 and (hsi_h_dots < 2.48 and hsi_h_dots > -2.48) and radaltitude < arm_radaltitude then
		--visible(img_localiser_marker_hor_solid, blinkon_hor)						--show blinking solid horizontal diamond
		visible(img_localiser_marker_hor, false)									--hide open horizontal diamond
		if diamond_blink == 1 and radaltitude < arm_radaltitude then
			--timer_start(3000,nil, blinkoff_hor)										--start 3sec timer
			visible(img_localiser_marker_hor_solid, false)
			--visible(img_localiser_scale_ver_amber, false)
			--visible(img_localiser_scale_hor_amber, false)
			--visible(img_localiser_scale_ver, false)							--hide white vertical scale
			--visible(img_localiser_scale_hor, false)							--hide white horizontal scale
		elseif diamond_blink == 0 and radaltitude < arm_radaltitude then
			visible(img_localiser_marker_hor_solid, true)
			--visible(img_localiser_scale_ver_amber, true)
			--visible(img_localiser_scale_hor_amber, true)
			--visible(img_localiser_scale_ver, false)							--hide white vertical scale
			--visible(img_localiser_scale_hor, false)							--hide white horizontal scale
		--else
			--visible(img_localiser_marker_hor_solid, true)
		end
	elseif hsi_h_signal == 1 and (hsi_h_dots < 2.48 and hsi_h_dots > -2.48) and radaltitude > arm_radaltitude then
		visible(img_localiser_marker_hor_solid, true)								--show solid horizontal diamond
		visible(img_localiser_marker_hor, false)									--hide open horizontal diamond
	end
			
	
	-- Should we show the open horizontal navigation indicator?
	if hsi_h_signal==1 and (hsi_h_dots >= 2.48 or hsi_h_dots <= -2.48) then
		visible(img_localiser_marker_hor, true)
		visible(img_localiser_marker_hor_solid,false)
	else
		visible(img_localiser_marker_hor, false)
	end

    -- Now move the horizontal navigation indicator (magenta solid diamond)
    img_move (img_localiser_marker_hor_solid,550-((250-(hsi_h_dots*100))*0.708),nil,nil,nil)   --540
	img_move (img_localiser_marker_hor,550-((250-(hsi_h_dots*100))*0.708),nil,nil,nil)		--540
	
-----------------------------------------------------------------------------------------------------------------	
	
	--NPS and ANP -- Navigation Performance Scales and Actual Navigation Performance
	if (pfdmode == 2 or pfdmode == 0) and hor_dsp_flag == 0 then --hor_nps_marker ~= 0 then
		visible (img_vnav_hor_bar, true)
		visible (img_nps_markerh, true)								--horizontal ANP
		mark_hor = 375 + (hor_nps_marker * -51.5)
		mark_hor = var_cap(mark_hor,250,510)
		img_move (img_nps_markerh, mark_hor, nil, nil, nil)
		visible(img_localiser_scale_hor, false)
		--visible(img_localiser_scale_hor_amber,false)
		visible(img_localiser_marker_hor, false)
		visible(img_localiser_marker_hor_solid, false)
	end

	if pfdmode == 2 and td_distance == 0 then
		visible (img_vnav_vert_bar, true)
		visible (img_nps_markerv, true)								--vertical ANP
		visible(img_localiser_scale_ver, false)
		--visible(img_localiser_scale_ver_amber, false)
		visible(img_localiser_marker_ver_solid,false)
		visible(img_localiser_marker_ver,false)
		mark_ver = 323 + ((400-ver_nps_marker)*0.3)
--print(mark_ver)
		mark_ver = var_cap(mark_ver, 320, 580)
		--if ver_nps_marker > 400 then
			--img_move (img_nps_markerv, nil, 323, nil, nil)
		--else
			img_move (img_nps_markerv,nil,(mark_ver), nil, nil)
		--end
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

--function new_data(hsi_v_signal, hsi_h_signal, hsi_v_dots, hsi_h_dots, pfdmode, pfd_alt_mode, td_distance, pullup, hor_nps_marker, 
--ver_nps_marker, autopilot_on, ft_flag, gs_flag, hor_dsp_flag, vert_dsp_flag, diamond_blink, radaltitude)
xpl_dataref_subscribe("sim/cockpit2/radios/indicators/hsi_display_vertical_pilot", "INT", 					--hsi_v_signal
					  "sim/cockpit2/radios/indicators/hsi_display_horizontal_pilot", "INT",					--hsi_h_signal
					  --"laminar/B738/PFD/v_dots_pilot", "INT",												--hsi_v_signal
					  --"laminar/B738/PFD/h_dots_pilot", "INT",												--hsi_h_signal
					  "sim/cockpit2/radios/indicators/hsi_vdef_dots_pilot", "FLOAT",						--hsi_v_dots 
					  "sim/cockpit2/radios/indicators/hsi_hdef_dots_pilot", "FLOAT",						--hsi_h_dots 
					  "laminar/B738/autopilot/pfd_mode", "INT",												--pfdmode
					  "laminar/B738/autopilot/pfd_alt_mode_arm", "INT",										--pfd_alt_mode
					  "laminar/B738/fms/vnav_td_dist", "FLOAT",												--td_distance
					  "laminar/b738/alert/pfd_pull_up", "FLOAT",											--pullup
					  "laminar/B738/autopilot/gps_horizont", "FLOAT",										--hor_nps_marker
					  "laminar/B738/fms/vnav_err_pfd", "FLOAT",												--ver_nps_marker
					  "laminar/B738/autopilot/cmd_a_status", "INT",											--autopilot_on
					  "laminar/radios/pilot/nav_flag_ft", "INT",											--ft_flag
					  "laminar/radios/pilot/nav_flag_gs", "INT",											--gs_flag
					  "laminar/radios/pilot/nav_horz_dsp", "INT",											--hor_dsp_flag
					  "laminar/radios/pilot/nav_vert_dsp", "INT",											--vert_dsp_flag
					  "laminar/B738/autopilot/ils_pointer_disable", "INT",									--diamond_blink
					  --"laminar/B738/autopilot/blink", "INT",												--diamond_blink
					  "sim/cockpit2/autopilot/glideslope_status", "INT",									--gs_status
					  "laminar/B738/autopilot/autoland_status", "INT",										--autoland_status
					  "sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "FLOAT", new_data)	--radaltitude
--"sim/cockpit2/autopilot/glideslope_status"
--"laminar/B738/autopilot/autoland_status"					  
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
--[[
function reset_flag(on_ground)
	if on_ground == 1 then 
		timer_flag = 0
	end
end
xpl_dataref_subscribe("sim/flightmodel/failures/onground_any", "INT", reset_flag)			--on_ground
]]


--Timers
--[[	
vert_timer = timer_start(0,300, function()
	blinkon_ver = not blinkon_ver
	if blink_flag_ver == 1 then visible(img_localiser_marker_ver_solid, true) end	--diamond should stay visible after blinking
end)


hor_timer = timer_start(0,300, function()
	blinkon_hor = not blinkon_hor
	if blink_flag_hor == 1 then visible(img_localiser_marker_hor_solid, true) end	--diamond should stay visible after blinking
end)


function blinkoff_vert()							
	blink_flag_ver = 1
	visible(img_localiser_marker_ver_solid, true)
	timer_stop(vert_timer)
end


function blinkoff_hor()							
	blink_flag_hor = 1
	visible(img_localiser_marker_hor_solid, true)
	timer_stop(hor_timer)
end
]]
end
