img_autopilot_off = img_add("autopilot_backdrop.png",0,0,512,512)
img_mask = {}
dx = {60,120,210,300,390,60,130,220,300,390,60,120,160,230,300,365}
dy = {50,50,50,50,50,110,110,110,110,110,160,160,160,160,160,160}
dw = {80,80,80,80,80,80,80,80,80,80,60,40,70,70,70,100}
dh = {30,30,30,30,30,30,30,30,30,30,30,40,50,50,50,50}

for i = 1, 16 do
    img_mask[i] = img_add("autopilot_backdrop.png",0,-256,512,512)
    viewport_rect(img_mask[i], dx[i], dy[i], dw[i], dh[i])
    visible(img_mask[i], false)
end

function PT_liteup(nav, armgs, armhnav, armbc, alt, ap, hdg, capgs, caphnav, capbc, toga, hnav_armed, inner, outer, middle, trim, APstate)

 -- FD
    visible(img_mask[1], ap >= 1)
 -- NAV
    visible(img_mask[2], nav > 0 and caphnav == 0)
 -- ARM
    visible(img_mask[3], hnav_armed == 1)
 -- ALT
    visible(img_mask[4], (APstate >> 14) & 1)
 -- AP
    visible(img_mask[5], ap == 2)
 -- HDG
    visible(img_mask[6], (APstate >> 1) & 1)
 -- APR
    visible(img_mask[7], caphnav >= 1)
 -- CPLD (Active mode for NAV, APPR and BC)
    visible(img_mask[8], capgs == 2 or armhnav == 2 or armbc == 2)
 -- GS
    visible(img_mask[9], armgs == 2)
 -- GA
    visible(img_mask[10], toga == 2)
 -- BC
    visible(img_mask[11], armbc >= 1)
 -- Outer marker
    visible(img_mask[14], outer > 0)
 -- Middle marker
    visible(img_mask[15], middle > 0)
 -- Inner marker
    visible(img_mask[13], inner > 0)
 -- Trim
    visible(img_mask[16], trim > 0)

    -- INOP  if nav > 0 then visible(img_mask[12], true) else visible(img_mask[12], false) end
end

function FSX_autopilot(fd, nav, alt, ap, hdg, apr, bc, gs, toga)

 -- FD
    visible(img_mask[1], fd == true)
 -- NAV
    visible(img_mask[2], nav == true)
 -- ARM (No ARMED modes in FSX, only active)
 --  visible(img_mask[3], armgs == 1 or armhnav == 1 or armbc == 1)
 -- ALT
    visible(img_mask[4], alt == true)
 -- AP
    visible(img_mask[5], ap == true)
 -- HDG
    visible(img_mask[6], hdg == true)
 -- APR
    visible(img_mask[7], apr == true)
 -- CPLD (Active mode for NAV, APPR and BC)
    visible(img_mask[8], nav == true or apr == true or bc == true)
 -- GS
    visible(img_mask[9], gs == true)
 -- GA
    visible(img_mask[10], toga == true)
 -- BC
    visible(img_mask[11], bc == true)
 -- Outer marker
    visible(img_mask[14], marker == 1)
 -- Middle marker
    visible(img_mask[15], marker == 2)
 -- Inner marker
    visible(img_mask[13], marker == 3)
 -- Trim
    visible(img_mask[16], elac == true or fac == true or sec == true)

    -- INOP  if nav > 0 then visible(img_mask[12], true) else visible(img_mask[12], false) end
end

xpl_dataref_subscribe("sim/cockpit2/autopilot/nav_status", "INT",
                      "sim/cockpit2/autopilot/glideslope_status", "INT",
                      "sim/cockpit2/autopilot/nav_status", "INT",
                      "sim/cockpit2/autopilot/backcourse_status", "INT",
                      "sim/cockpit2/autopilot/altitude_mode", "INT",
                      "sim/cockpit/autopilot/autopilot_mode", "INT", 
                      "sim/cockpit2/autopilot/heading_mode", "INT",
                      "sim/cockpit2/autopilot/glideslope_status", "INT",
                      "sim/cockpit2/autopilot/approach_status", "INT",
                      "sim/cockpit2/autopilot/backcourse_status", "INT",
                      "sim/cockpit2/autopilot/TOGA_status", "INT",
                      "sim/cockpit2/autopilot/hnav_armed", "INT",
                      "sim/cockpit/misc/inner_marker_lit", "INT",
                      "sim/cockpit/misc/outer_marker_lit", "INT",
                      "sim/cockpit/misc/middle_marker_lit", "INT",
                      "sim/cockpit/warnings/annunciators/autopilot_trim_fail", "INT",
                      "sim/cockpit/autopilot/autopilot_state", "INT", PT_liteup)
fsx_variable_subscribe("AUTOPILOT FLIGHT DIRECTOR ACTIVE", "Bool",
                       "AUTOPILOT NAV1 LOCK", "Bool",
                       "AUTOPILOT ALTITUDE LOCK", "Bool",
                       "AUTOPILOT MASTER", "Bool",
                       "AUTOPILOT HEADING LOCK", "Bool",
                       "AUTOPILOT APPROACH HOLD", "Bool",
                       "AUTOPILOT BACKCOURSE HOLD", "Bool",
                       "AUTOPILOT GLIDESLOPE HOLD", "Bool",
                       "AUTOPILOT TAKEOFF POWER ACTIVE", "Bool",
                       "MARKER BEACON STATE", "Enum", FSX_autopilot)
msfs_variable_subscribe("AUTOPILOT FLIGHT DIRECTOR ACTIVE", "Bool",
                          "AUTOPILOT NAV1 LOCK", "Bool",
                          "AUTOPILOT ALTITUDE LOCK", "Bool",
                          "AUTOPILOT MASTER", "Bool",
                          "AUTOPILOT HEADING LOCK", "Bool",
                          "AUTOPILOT APPROACH HOLD", "Bool",
                          "AUTOPILOT BACKCOURSE HOLD", "Bool",
                          "AUTOPILOT GLIDESLOPE HOLD", "Bool",
                          "AUTOPILOT TAKEOFF POWER ACTIVE", "Bool",
                          "MARKER BEACON STATE", "Enum", FSX_autopilot)