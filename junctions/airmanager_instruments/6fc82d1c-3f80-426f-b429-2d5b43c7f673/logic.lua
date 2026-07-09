-- DIAL FUNCTIONS --
function new_obs(obsset)

    if obsset == -1 then
        xpl_command("sim/radios/obs_HSI_down")
        fsx_event("VOR1_OBI_DEC")
        msfs_event("VOR1_OBI_DEC")
    elseif obsset == 1 then
        xpl_command("sim/radios/obs_HSI_up")
        fsx_event("VOR1_OBI_INC")
        msfs_event("VOR1_OBI_INC")
    end

end

function new_heading(headingset)

    if headingset == -1 then
        xpl_command("sim/autopilot/heading_down")
        fsx_event("HEADING_BUG_DEC")
        msfs_event("HEADING_BUG_DEC")
    elseif headingset == 1 then
        xpl_command("sim/autopilot/heading_up")
        fsx_event("HEADING_BUG_INC")
        msfs_event("HEADING_BUG_INC")
    end
    
end

img_add_fullscreen("hsi_outer_frame.png")

img_rose        = img_add("hsi_rose.png", 56, 56, 400, 400)
img_bug         = img_add("bughsi.png", 221, 56, 70, 400)
img_center      = img_add("hsi_center.png", 131, 131, 250, 250)
img_center_to   = img_add("hsi_center_to.png", 131, 131, 250, 250, "visible:false")
img_center_from = img_add("hsi_center_from.png", 131, 131, 250, 250, "visible:false")
img_neddle      = img_add("hsi_neddle.png", 231, 56, 50, 400)
img_cntr_ndl    = img_add("hsi_center_neddle.png",0,0,512,512)

img_add("hsi_plane.png", 226, 226, 60, 60)

img_add("glideslope_active.png", 21, 96, 470, 320)
img_hdg_flag = img_add("hsi_hdg_flag.png", 279, 42, 113, 63)
img_nav_flag = img_add("hsi_nav_flag.png", 121, 42, 113, 63)
img_glideslope_markers = img_add("glideslope_markers.png",0, 120, 512, 64)

img_add("hsi_lubber_line.png", 241, 19, 30, 150)
img_add_fullscreen("hsi_inner_frame.png")

function PT_hsi(heading, crs, hdef, vdef, fromto, gs_flag, ap_heading, bus_volts)
  
    rotate(img_rose, -heading)
    
    dh = hdef * 36 * math.cos((-heading+crs)*math.pi/180)
    dv = hdef * 36 * math.sin((-heading+crs)*math.pi/180)
    dm = vdef * 36

    visible(img_center_to, fromto == 1)
    visible(img_center_from, fromto == 2)
    
    rotate(img_center, (-heading + crs)%360, "LOG", 0.08, "FASTEST")
    rotate(img_center_to, (-heading + crs)%360, "LOG", 0.08, "FASTEST")
    rotate(img_center_from, (-heading + crs)%360, "LOG", 0.08, "FASTEST")
    
    rotate(img_neddle, (-heading + crs)%360, "LOG", 0.08, "FASTEST")
    rotate(img_cntr_ndl, (-heading + crs)%360, "LOG", 0.08, "FASTEST")

    move(img_cntr_ndl, dh, dv, nil, nil, "LOG", 0.08)

    if gs_flag == 0 and bus_volts[1] >= 8 then
        move(img_glideslope_markers, nil, dm + 224 , nil, nil, "LOG", 0.05)
    else
        move(img_glideslope_markers, nil, 120 , nil, nil, "LOG", 0.05)
    end
    
    -- Rotate heading bug
    rotate(img_bug, ap_heading - heading)

    -- HDG flag when vacuum is too low for gyrocompass
    visible(img_hdg_flag, bus_volts[1] < 8)
    
    -- NAV flag when no valid VOR or localizer
    visible(img_nav_flag, fromto == 0)
    
end

function PT_hsi_FSX(heading, crs, hdef, vdef, fromto, has_gs, ap_heading, bus_volts)

    local gs_flag = fif(has_gs, 0, 1)    
    local vertical = 2.5 / 119 * vdef
    local horizontal = 2.5 / 127 * hdef

    PT_hsi(heading, crs, horizontal, vertical, fromto, gs_flag, ap_heading, {bus_volts})

end

-- DIAL ADD --
dial_OBS = dial_add("dialhsi.png", 10, 400, 104, 104, 5, new_obs)
hw_dial_add("OBS heading", 5, new_obs)
dial_BUG = dial_add("headingbug.png", 398, 400, 104, 104, 5, new_heading)
hw_dial_add("Autopilot heading", 5, new_heading)

dial_click_rotate(dial_OBS, 5)
dial_click_rotate(dial_BUG, 5)

fsx_variable_subscribe("PLANE HEADING DEGREES GYRO", "Degrees",
                       "NAV OBS:1", "Degrees",
                       "NAV CDI:1", "Number",
                       "NAV GSI:1", "Number",
                       "NAV TOFROM:1", "Enum", 
                       "NAV HAS GLIDE SLOPE:1", "Bool", 
                       "AUTOPILOT HEADING LOCK DIR", "Degrees",
                       "ELECTRICAL MAIN BUS VOLTAGE:1", "Volts", PT_hsi_FSX)
fs2020_variable_subscribe("PLANE HEADING DEGREES GYRO", "Degrees",
                          "NAV OBS:1", "Degrees",
                          "NAV CDI:1", "Number",
                          "NAV GSI:1", "Number",
                          "NAV TOFROM:1", "Enum", 
                          "NAV HAS GLIDE SLOPE:1", "Bool", 
                          "AUTOPILOT HEADING LOCK DIR", "Degrees",
                          "ELECTRICAL MAIN BUS VOLTAGE:1", "Volts", PT_hsi_FSX)
fs2024_variable_subscribe("PLANE HEADING DEGREES GYRO", "Degrees",
                          "NAV OBS:1", "Degrees",
                          "NAV CDI:1", "Number",
                          "NAV GSI:1", "Number",
                          "NAV TOFROM:1", "Enum", 
                          "NAV HAS GLIDE SLOPE:1", "Bool", 
                          "AUTOPILOT HEADING LOCK DIR", "Degrees",
                          "ELECTRICAL BUS VOLTAGE:1", "Volts", PT_hsi_FSX)
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot", "FLOAT",
                      "sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot", "FLOAT",
                      "sim/cockpit2/radios/indicators/hsi_hdef_dots_pilot", "FLOAT",
                      "sim/cockpit2/radios/indicators/hsi_vdef_dots_pilot", "FLOAT",
                      "sim/cockpit2/radios/indicators/hsi_flag_from_to_pilot", "INT",
                      "sim/cockpit2/radios/indicators/hsi_flag_glideslope_pilot_mech", "INT",
                      "sim/cockpit2/autopilot/heading_dial_deg_mag_pilot", "FLOAT", 
                      "sim/cockpit2/electrical/bus_volts", "FLOAT[6]", PT_hsi)
                     