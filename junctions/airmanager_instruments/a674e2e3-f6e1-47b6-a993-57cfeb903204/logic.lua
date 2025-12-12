-- DHC-6 Twin Otter for RWDesign DHC-6 300 V2 on Xplane by blackflyjim
-- VOR/ILS
--user property for selecting Vor 1 or 2
--select vor/ils 1 = left 2 = right
prop_navside = user_prop_add_integer("navside", 1, 2, 2, "select which nav VOR/ILS signal this gauge reads")
local navside = user_prop_get(prop_navside)
local obs_set = 0
local av_state = 0
local gs_state = 0
local loc_state = 0
local deltatf = 0
local mod_obs = 0

img_add_fullscreen("background.png")
gs_flag_dy = img_add("GS_flag.png",146, 200, 48, 25)
gs_flag_nt = img_add("GS_flag_nt.png",146, 200, 48, 25)
loc_flag_dy = img_add("nav_flag.png",275, 146, 25, 48)
loc_flag_nt = img_add("nav_flag_nt.png",275, 146, 25, 48)
tofrom_dy = img_add("to_from.png", 320, 84, 40, 222)
tofrom_nt = img_add("to_from_nt.png",320, 84, 40, 222)
face_dy = img_add_fullscreen("scale_dy.png")
face_nt = img_add_fullscreen("scale_nt.png")
gs_dy = img_add("GS_dy.png", 50, 242, 410, 16)
gs_nt = img_add("GS_nt.png",  50, 242, 410, 16)
loc_dy = img_add("loc_dy.png", 242, 50, 16, 410)
loc_nt = img_add("loc_nt.png",  242, 50, 16, 410)
mask_shadow2 = img_add_fullscreen("mask_shadow_inner.png")
azimuth_dy = img_add("azimuth_dy.png", 32, 32,436, 436)
azimuth_nt = img_add("azimuth_nt.png", 32, 32, 436, 436)
mask_shadow = img_add_fullscreen("mask_shadow.png")
bezel_dy = img_add_fullscreen("bezel_dy.png")
bezel_nt = img_add_fullscreen("bezel_nt.png")

light_group = group_add(gs_flag_nt, loc_flag_nt, tofrom_nt,face_nt, gs_nt, loc_nt, mask_shadow2, azimuth_nt, mask_shadow, bezel_nt)

function nav_state_callback(pwr_on, tofrom1, tofrom2, CDI_GS1, CDI_GS2, Nav_cond1, Nav_cond2, light_cond)
-- establish if there is power to DC bus (RWDesign DHC-6 has no avionics master)
	if  pwr_on >22 then av_state = 1
	end

-- establish signal condition predicated on nav side selected 1 or 2 as well as power condition and panel lighting
	if navside == 1 then 
	TF_flag =tofrom1 
	GS_flag = CDI_GS1
	N_flag = (Nav_cond1)
	elseif navside == 2 then 
	TF_flag = tofrom2 
	GS_flag = CDI_GS2
	N_flag =  (Nav_cond2)
	end
-- RWDesign twin otter uses custom dataref for panel lighting and DC power--
-- substitute the following xpl datarefs for generic instrument
	opacity(light_group, light_cond)
	opacity(mask_shadow, (1 - light_cond))
	
	if TF_flag == 0 or av_state == 0 then deltatf = 0
	elseif TF_flag == 1 then deltatf = 33
	elseif TF_flag == 2 then deltatf = 75
	end
	move( tofrom_dy, nil, (84 + deltatf), nil, nil, "LINEAR", .2)
	move( tofrom_nt, nil, (84 + deltatf), nil, nil, "LINEAR", .2)	
	
	if GS_flag == 0 and av_state == 1 then gs_state = 1
	else gs_state = 0
	end
	if N_flag == 1 and av_state == 1 then loc_state = 1
	else loc_state = 0
	end
	move( gs_flag_dy, nil, (200 + (gs_state* 25)), nil, nil, "LINEAR", .2)
	move( gs_flag_nt, nil, (200 + (gs_state* 25)), nil, nil, "LINEAR", .2)	
	move( loc_flag_dy,  (275 + (loc_state* 25)), nil, nil, nil, "LINEAR", .2)	
	move( loc_flag_nt,  (275 + (loc_state* 25)), nil, nil, nil, "LINEAR", .2)		
end

-- substitute the following xpl datarefs for generic instrument
--"sim/cockpit2/switches/instrument_brightness_ratio","FLOAT[32]" and use light_cond[1] in function and
--	sim/cockpit/electrical/avionics_on instead of dc volts

xpl_dataref_subscribe("TO/PANEL/IND_DC_VOLTS_ACTUAL", "FLOAT",
"sim/cockpit2/radios/indicators/nav1_flag_from_to_pilot", "INT",
"sim/cockpit2/radios/indicators/nav2_flag_from_to_pilot", "INT",
"sim/cockpit2/radios/indicators/nav1_flag_glideslope_mech", "INT",
"sim/cockpit2/radios/indicators/nav2_flag_glideslope_mech", "INT",
"sim/cockpit2/radios/indicators/nav1_display_horizontal", "INT",
"sim/cockpit2/radios/indicators/nav2_display_horizontal", "INT",
"TO/OVERHEAD/PLT_GAUGE_LIGHT","FLOAT", nav_state_callback)

function cdi_deflect_callback(h_def1, h_def2, v_def1, v_def2)
	if navside ==1 then
	h_def = var_cap(h_def1, -5, 5)
	v_def = var_cap(v_def1, -5, 5)
	elseif navside ==2 then
	h_def = var_cap(h_def2, -5, 5)
	v_def = var_cap(v_def2, -5, 5)
	end

-- move loc bar or centre depending on power and nav signal
	if loc_state == 0 then h_def =0
	end
	move(loc_dy,(h_def * 23+242), nil, nil, nil, "LINEAR", .05)
	move(loc_nt,(h_def * 23+242), nil, nil, nil, "LINEAR", .05)	

-- move gs bar or centre depending on power and nav signal
	if gs_state == 0 then v_def = 0
	end
	move(gs_dy, nil,(v_def * 23 + 242), nil, nil, "LINEAR", .05)	
	move(gs_nt, nil,(v_def * 23 + 242), nil, nil, "LINEAR", .05)		

end


xpl_dataref_subscribe("sim/cockpit2/radios/indicators/nav1_hdef_dots_pilot", "FLOAT",
"sim/cockpit2/radios/indicators/nav2_hdef_dots_pilot", "FLOAT",
"sim/cockpit2/radios/indicators/nav1_vdef_dots_pilot", "FLOAT",
"sim/cockpit2/radios/indicators/nav2_vdef_dots_pilot", "FLOAT", cdi_deflect_callback)

-- get obs selection from sim
function obs_deg(deg_mag1, deg_mag2)
		if navside ==1 then obs_set = deg_mag1
		else obs_set = deg_mag2
		end
		rotate(azimuth_nt, obs_set*-1)
		rotate(azimuth_dy, obs_set*-1)
end

xpl_dataref_subscribe("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot", "FLOAT",
"sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot", "FLOAT", obs_deg)

-- obs dial control predicated on nav side selected 1 or 2
function knob_direction_callback(direction)
	if navside ==1 then 	
		if direction ==1 then
		mod_obs = obs_set +1
		if mod_obs == 360 then mod_obs = 0 end
		xpl_dataref_write("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot", "FLOAT",mod_obs)
		elseif direction ==-1 then 
		mod_obs = obs_set -1
		if mod_obs == 0 then mod_obs = 360 end	
		xpl_dataref_write("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot", "FLOAT",mod_obs)
		end
	elseif navside ==2 then 
		if direction ==1 then
		mod_obs = obs_set +1
		if mod_obs == 360 then mod_obs = 0 end
		xpl_dataref_write("sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot", "FLOAT",mod_obs)
		elseif direction ==-1 then 
		mod_obs = obs_set -1
		if mod_obs == 0 then mod_obs = 360 end	
		xpl_dataref_write("sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot", "FLOAT",mod_obs)
		end
	end
end
		   
obs_knob = dial_add("knob.png",20.5, 407, 69, 69,knob_direction_callback)

