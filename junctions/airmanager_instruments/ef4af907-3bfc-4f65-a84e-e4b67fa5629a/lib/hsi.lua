-- HSI LIBRARY --
-- TO DO TO DO TO DO TO DO TO DO TO DO  --
-- TO DO TO DO TO DO TO DO TO DO TO DO     --

-- Global variables --
local gbl_blink_500 = false

function lib_hsi_init()

img_vnav_dots_white	= img_add("vnav_dots_white.png", 536, 258, 30, 240)
img_vnav_dots_amber	= img_add("vnav_dots_amber.png", 536, 258, 30, 240)
img_vnav_indc_ior	= img_add("ind_ver_ior.png", 545, 363, 20, 30)
img_vnav_indc_oor	= img_add("ind_ver_oor.png", 545, 363, 20, 30)
img_hnav_dots_white	= img_add("lnav_dots_white.png", 230, 589, 240, 30)
img_hnav_dots_amber	= img_add("lnav_dots_amber.png", 230, 589, 240, 30)
img_hnav_indc_ior	= img_add("ind_hor_ior.png", 335, 591, 30, 20)
img_hnav_indc_oor	= img_add("ind_hor_oor.png", 335, 591, 30, 20)

-- img_ILS_ind = img_add("ILS.png", 164, 142, 48, 28)
end

-- Now do something with the images we've just added
function new_data(hsi_v_signal, hsi_h_signal, hsi_v_dots, hsi_h_dots, backcourse_on, radaltitude)

	-- Convert integers to booleans
	hsi_v_signal = hsi_v_signal == 1
	hsi_h_signal = hsi_h_signal == 1

    -- Should we show the vertical navigation indicators?
    -- visible(img_ILS_ind, hsi_v_signal)
    visible(img_vnav_dots_white, hsi_v_signal)
	visible(img_vnav_dots_amber, hsi_v_signal and (hsi_v_dots >= 2.48 or hsi_v_dots <= -2.48) and backcourse_on == 0)
	
    visible(img_vnav_indc_ior, hsi_v_signal and (hsi_v_dots < 2.48 and hsi_v_dots > -2.48) and backcourse_on == 0)
	if hsi_v_signal and (hsi_v_dots >= 2.48 or hsi_v_dots <= -2.48) and backcourse_on == 0 and radaltitude > 1000 then
		visible(img_vnav_indc_oor, true)
	elseif hsi_v_signal and (hsi_v_dots >= 2.48 or hsi_v_dots <= -2.48) and backcourse_on == 0 and radaltitude < 1000 then
		visible(img_vnav_indc_oor, gbl_blink_500)
	else
		visible(img_vnav_indc_oor, false)
	end
    
    -- Now move the vertical navigation indicator (magenta hollow diamond)
    move(img_vnav_indc_ior, nil, hsi_v_dots * 56.2 + 363, nil, nil)
	move(img_vnav_indc_oor, nil, hsi_v_dots * 56.2 + 363, nil, nil)
    
    -- Should we show the horizontal navigation indicator?
    visible(img_hnav_indc_ior, hsi_h_signal and hsi_h_dots < 2.48 and hsi_h_dots > -2.48)
	-- Make the HNAV/LNAV out of range indicator blink when the localizer is armed but not captured beneath 1000 FT AGL
	if hsi_h_signal and (hsi_h_dots >= 2.48 or hsi_h_dots <= -2.48) then
		visible(img_hnav_indc_oor, true)
	elseif hsi_h_signal and radaltitude < 1000 then
		visible(img_hnav_indc_oor, gbl_blink_500)
	else
		visible(img_hnav_indc_oor, false)
	end
	visible(img_hnav_dots_white, hsi_h_signal)
	visible(img_hnav_dots_amber, hsi_h_signal and radaltitude < 1000 and (hsi_h_dots >= 2.48 or hsi_h_dots <= -2.48) )

    -- Now move the horizontal navigation indicator (magenta solid diamond)
    move(img_hnav_indc_ior, hsi_h_dots * 56.2 + 335, nil, nil, nil)
	move(img_hnav_indc_oor, hsi_h_dots * 56.2 + 335, nil, nil, nil)
	
end

function blink_500_callback()

	gbl_blink_500 = not gbl_blink_500

end

-- Timers
timer_start(0, 500, blink_500_callback)

-- Data subscribe
xpl_dataref_subscribe("sim/cockpit2/radios/indicators/hsi_display_vertical_pilot", "INT", 
					  "sim/cockpit2/radios/indicators/hsi_display_horizontal_pilot", "INT", 
					  "sim/cockpit2/radios/indicators/hsi_vdef_dots_pilot", "FLOAT", 
					  "sim/cockpit2/radios/indicators/hsi_hdef_dots_pilot", "FLOAT", 
					  "sim/cockpit/autopilot/backcourse_on", "INT", 
					  "sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot", "FLOAT", new_data)