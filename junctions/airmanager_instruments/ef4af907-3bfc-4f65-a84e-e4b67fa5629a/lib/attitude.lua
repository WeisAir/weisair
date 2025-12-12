-- ATTITUDE LIBRARY --
-- TO DO TO DO TO DO TO DO TO DO TO DO  --
-- Box and text color of the radio altitude (page 66)
-- TO DO TO DO TO DO TO DO TO DO TO DO  --

-- Global variables
local gbl_above2500 = false
local gbl_10seconds = 0

-- Images
img_horz_back = img_add("horizonback.png", -401, -372, 1500, 1500)
img_horz_numb = img_add("horizon_ind.png", 249, -372, 200, 1500)
viewport_rect(img_horz_numb, 0, 230, 800, 350)

img_slip_ind_norm = img_add("slip_indicator.png", 333, 220, 32, 10)
img_slip_ind_warn = img_add("slip_indicator_warn.png", 333, 220, 32, 10)
img_bank_ind_norm = img_add("bank_indicator.png", 332, 197, 34, 22)
img_bank_ind_warn = img_add("bank indicator_warn.png", 332, 197, 34, 22)

img_o_marker = img_add("o_marker.png", 482, 194, 46, 46)
img_m_marker = img_add("m_marker.png", 482, 194, 46, 46)
img_i_marker = img_add("i_marker.png", 482, 194, 46, 46)

function lib_fd_tape_init()
img_fd_vnav = img_add("flight_director.png", 346, 267, 6, 222)
img_fd_hnav = img_add("flight_director.png", 238, 375, 222, 6)
img_fpv = img_add("flight_path_vector.png", 314, 354, 70, 37)
end



-- Functions
function attitude_callback(roll, pitch, slip, marker_inner, marker_middle, marker_outer, FD_bank, FD_pitch, AC_bank, AC_pitch, MCP_FDSw, fpv_visible, fpv_pitch, fpv_roll)

	-- Invert the roll rate
	roll = roll * -1
						   
    -- Roll the horizon (electric gyro)
    rotate(img_horz_back, roll)
    rotate(img_horz_numb, roll)
    
    -- Move the horizon pitch, background and numbers seperately (electric gyro)
    pitch = var_cap(pitch, -40, 40)
    radial = math.rad(roll)
    
    x = -(math.sin(radial) * pitch * 8.1)
    y = (math.cos(radial) * pitch * 8.1)

    move(img_horz_back, x - 401, y - 372, nil, nil)
    move(img_horz_numb, x + 249, y - 372, nil, nil)
	
	-- From 35 degrees the bank and slip indicators will turn yellow and a warning will sound: "Bank angle! Bank angle!"	
	visible(img_slip_ind_norm, math.abs(roll) < 35 and math.abs(slip) < 25)
	visible(img_slip_ind_warn, math.abs(roll) >= 35 or math.abs(slip) >= 25)
	visible(img_bank_ind_norm, math.abs(roll) < 35)
	visible(img_bank_ind_warn, math.abs(roll) >= 35)
	
	xbank, ybank = geo_rotate_coordinates(roll, 180)
	
	rotate(img_bank_ind_norm, roll)
	move(img_bank_ind_norm, xbank + 332, 377 + ybank, nil, nil)
	rotate(img_bank_ind_warn, roll)
	move(img_bank_ind_warn, xbank + 332, 377 + ybank, nil, nil)
	
	-- Here we add the slip part to the roll
	xslip, yslip = geo_rotate_coordinates(roll, 163)
	roll_rad = math.rad(roll)

    x = slip * math.cos(roll_rad)
	y = slip * math.sin(roll_rad)
	-- Now move and rotate the slip indicator
	rotate(img_slip_ind_norm, roll)
	move(img_slip_ind_norm, xslip + x + 333, 383 + y + yslip, nil, nil)
	rotate(img_slip_ind_warn, roll)
	move(img_slip_ind_warn, xslip + x + 333, 383 + y + yslip, nil, nil)
	
    -- Marker beacon indicators
    visible(img_o_marker, marker_outer == 1)
    visible(img_m_marker, marker_middle == 1)
    visible(img_i_marker, marker_inner == 1)
	
	-- Move flight director bank
	visible(img_fd_vnav, MCP_FDSw == 1)
	move(img_fd_vnav, 346 + ((AC_bank - FD_bank) * 1.05), nil, nil, nil)
	
	-- Move flight director pitch
	visible(img_fd_hnav, MCP_FDSw == 1)
	move(img_fd_hnav, nil, 375 + (FD_pitch * -10.5), nil, nil)
	
	-- Flight Path Vector
	visible(img_fpv, fpv_visible == 1)

	move(img_fpv, 314 + (fpv_roll * -8.1), 354 + ((fpv_pitch + pitch) * 10.5), nil, nil)

end

-- Variable subscribe
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/roll_AHARS_deg_pilot", "FLOAT", 
					  "sim/cockpit2/gauges/indicators/pitch_AHARS_deg_pilot", "FLOAT",
					  "sim/cockpit2/gauges/indicators/slip_deg", "FLOAT", 
					  "sim/cockpit/misc/inner_marker_lit", "INT", 
					  "sim/cockpit/misc/middle_marker_lit", "INT", 
					  "sim/cockpit/misc/outer_marker_lit", "INT", 
					  "sim/cockpit/autopilot/flight_director_roll", "FLOAT",
					  "x737/systems/afds/AP_A_pitch", "FLOAT",
					  "sim/cockpit2/gauges/indicators/roll_AHARS_deg_pilo", "FLOAT",
					  "sim/cockpit2/gauges/indicators/pitch_AHARS_deg_pilot", "FLOAT",
					  "x737/systems/afds/fdA_status", "INT", 
					  "x737/systems/afds/AP_A_FPV_is_visible", "INT", 
					  "x737/systems/afds/AP_A_FPV_pitch", "FLOAT", 
					  "x737/systems/afds/AP_A_FPV_roll", "FLOAT", attitude_callback)