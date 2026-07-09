img_horizon = img_add_fullscreen("macnfly_vacuum_horizon.png")
img_fd_horizontal = img_add_fullscreen("fd_horizontal.png")
img_fd_vertical = img_add_fullscreen("fd_vertical.png")
img_ring = img_add_fullscreen("macnfly_vacuum_ring.png")
img_add_fullscreen("macnfly_vacuum_vacuum.png")
img_slip_back = img_add("side_slip_backdrop.png",166,382,180,50)
img_slip_ball = img_add("side_slip_ball.png",166,381,180,50)
img_slip_glass = img_add("side_slip_glass.png",166,382,180,50)

function PT_atitude(roll, pitch, slip, APmode, FDpitch, FDroll)    

    -- roll outer ring
    rotate(img_ring, roll *-1)
        
    -- roll horizon
    rotate(img_horizon  , roll * -1)
    
    -- move horizon pitch
    pitch = var_cap(pitch,-30,30)
    radial = math.rad(roll * -1)
    x = -(math.sin(radial) * pitch * 3)
    y = (math.cos(radial) * pitch * 3)
    move(img_horizon, x, y, nil, nil)
    
    -- move slip ball
    slip = slip * 10
    slip = var_cap(slip,-60,60)
    move(img_slip_ball, 166 - slip, nil, nil, nil)
    
    -- Flight director
    -- Horizontal (pitch):
    if APmode < 1 then
        move(img_fd_horizontal, nil, 120, nil, nil)
    else
        move(img_fd_horizontal, nil, (FDpitch - pitch) * -3, nil, nil)
    end

    -- Vertical (roll):
    if APmode < 1 then
        move(img_fd_vertical, -120, nil, nil, nil)
    else
        move(img_fd_vertical, (FDroll - roll) * 3, nil, nil, nil)
    end
    
end

function new_attitude_fsx(roll, pitch, slip, APmode, FDpitch, FDroll)
    
    -- Convert boolean to INT
    APmode = fif(APmode, 1, 0)
    
    PT_atitude(roll *-1, pitch * -1, slip * -1, APmode, FDpitch * -1, FDroll * -1)

end

function new_attitude_fs2020(roll, pitch, slip, APmode, FDpitch, FDroll)
    
    -- Convert boolean to INT
    APmode = fif(APmode, 1, 0)
    
    PT_atitude(roll *-1, pitch * -1, slip * -7.5, APmode, FDpitch * -1, FDroll * -1)

end

xpl_dataref_subscribe("sim/flightmodel/position/phi", "FLOAT",
                      "sim/flightmodel/position/theta", "FLOAT", 
                      "sim/cockpit2/gauges/indicators/slip_deg", "FLOAT",
                      "sim/cockpit/autopilot/autopilot_mode", "INT", 
                      "sim/cockpit2/autopilot/flight_director_pitch_deg", "FLOAT", 
                      "sim/cockpit2/autopilot/flight_director_roll_deg", "FLOAT", PT_atitude)
fsx_variable_subscribe("ATTITUDE INDICATOR BANK DEGREES", "Degrees",
                       "ATTITUDE INDICATOR PITCH DEGREES", "Degrees",
                       "TURN COORDINATOR BALL", "Position",
                       "AUTOPILOT FLIGHT DIRECTOR ACTIVE", "Bool", 
                       "AUTOPILOT FLIGHT DIRECTOR PITCH", "degrees", 
                       "AUTOPILOT FLIGHT DIRECTOR BANK", "degrees", new_attitude_fsx)
msfs_variable_subscribe("ATTITUDE INDICATOR BANK DEGREES", "Degrees",
                          "ATTITUDE INDICATOR PITCH DEGREES", "Degrees",
                          "TURN COORDINATOR BALL", "Position",
                          "AUTOPILOT FLIGHT DIRECTOR ACTIVE", "Bool", 
                          "AUTOPILOT FLIGHT DIRECTOR PITCH", "degrees", 
                          "AUTOPILOT FLIGHT DIRECTOR BANK", "degrees", new_attitude_fs2020)                       