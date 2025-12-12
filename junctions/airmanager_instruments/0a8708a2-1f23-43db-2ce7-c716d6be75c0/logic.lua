--  DHC-4 Caribou VOR/ILS
local obs_set = 0
local av_state = 0
local gs_state = 0
local loc_state = 0
local deltatf = 0
local mod_obs = 0
img_add("background.png",87, 140, 320, 320)
gs_flag = img_add("GS_tape.png",303, 252, 42, 40)
loc_flag = img_add("loc_tape.png",195, 362.5, 42, 40)
tofrom_dy = img_add("to_from.png", 150,216, 40, 168)
tofrom_nt = img_add("to_from_nt.png", 150,216, 40, 168)
face_dy = img_add("face_dy.png",90, 140, 320, 320)
face_nt = img_add("face_nt.png",90, 140, 320, 320, "visible:false")
gs_dy = img_add("gs.png", -230,0, 600, 600)
gs_nt = img_add("gs_nt.png", -230, 0, 600, 600, "visible:false")
loc_dy = img_add("loc.png", -50, -180, 600, 600)
loc_nt = img_add("loc_nt.png", -50, -180, 600, 600, "visible:false")
azimuth_dy = img_add("azimuth.png", 20, 70, 460, 460)
azimuth_nt = img_add("azimuth_nt.png", 20, 70, 460, 460, "visible:false")
bezel_dy = img_add("bezel.png", 0, 0, 500, 560)
bezel_nt = img_add("bezel_nt.png", 0, 0, 500, 560,"visible:false")

group_night = group_add(face_nt, bezel_nt, azimuth_nt, gs_nt, loc_nt, tofrom_nt)
group_day   = group_add(face_dy, bezel_dy, azimuth_dy, gs_dy, loc_dy, tofrom_dy)

function pwr_lt_state_callback(pwr_on, tofrom, CDI_GS, pnl_lts)
	
	av_state = pwr_on
	visible(group_night, pnl_lts[1] >= .2)
    visible(group_day, pnl_lts[1] < .2)
	if tofrom == 0 or av_state == 0 then deltatf = 0
	elseif tofrom == 1 then deltatf = -41
	elseif tofrom == 2 then deltatf = 41
	end

	move( tofrom_dy, nil, (216 + deltatf), nil, nil, "LINEAR", .2)
	move( tofrom_nt, nil, (216 + deltatf), nil, nil, "LINEAR", .2)	
	if CDI_GS == 0 and av_state == 1 then gs_state = 1
	else gs_state = 0
	end
	if tofrom > 0 and av_state == 1 then loc_state = 1
	else loc_state = 0
	end
	move( gs_flag, nil, (252 + (gs_state* -19)), nil, nil, "LINEAR", .2)
	move( loc_flag, nil, (362.5 + (loc_state* -19)), nil, nil, "LINEAR", .2)		
end

xpl_dataref_subscribe("sim/cockpit/electrical/avionics_on", "INT",
"sim/cockpit2/radios/indicators/nav1_flag_from_to_pilot", "INT",
"sim/cockpit2/radios/indicators/nav1_flag_glideslope_mech", "INT",
"sim/cockpit2/switches/instrument_brightness_ratio","FLOAT[32]", pwr_lt_state_callback)

function cdi_deflect_callback(h_def, v_def)
	h_def = var_cap(h_def, -5, 5)
	v_def = var_cap(v_def, -5, 5)
	if loc_state == 1 then loc_ang = -math.deg(math.atan(h_def * 24.4/180))
	else loc_ang = 0
	end
	if gs_state == 1 then gs_ang = math.deg(math.atan(v_def * 25/180))
	else gs_ang = 0
	end
	rotate(loc_dy, loc_ang)
	rotate(loc_nt, loc_ang)
	rotate(gs_dy, gs_ang)
	rotate(gs_nt, gs_ang)		
end


xpl_dataref_subscribe("sim/cockpit2/radios/indicators/nav1_hdef_dots_pilot", "FLOAT",
"sim/cockpit2/radios/indicators/nav1_vdef_dots_pilot", "FLOAT", cdi_deflect_callback)

function obs_deg(deg_mag)
		obs_set = math.abs(deg_mag)
		rotate(azimuth_nt, obs_set*-1)
		rotate(azimuth_dy, obs_set*-1)
end

xpl_dataref_subscribe("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot", "FLOAT", obs_deg)


function knob_direction_callback(direction)
	if direction ==1 then
	mod_obs = obs_set +1
	xpl_dataref_write("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot", "FLOAT",mod_obs)
	elseif direction ==-1 then 
	mod_obs = obs_set -1
	xpl_dataref_write("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot", "FLOAT",mod_obs)
	end
end
		   
obs_knob = dial_add("knob.png",410,462,80,80,knob_direction_callback)

