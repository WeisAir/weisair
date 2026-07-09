img_anun_off = img_add("anunciator_off_backdrop.png",0,0,512,256)
img_mask = {}
dx = {0,170,340,0,170,340,0}
dy = {0,0,0,51,51,51,102}
dw = {170,170,170,170,170,170,170}
dh = {51,51,51,51,51,51,51}

for i = 1, 7 do
    img_mask[i] = img_add("anunciator_lite_backdrop.png",0,0,512,256)
    viewport_rect(img_mask[i], dx[i], dy[i], dw[i], dh[i])
    visible(img_mask[i], false)
end

function PT_liteup(gear, door, pitot, brakes, battery, gen, start, inHg, flaps)

    visible(img_mask[1], gear == 1 and battery == 1)
    visible(img_mask[2], gen[1] > 0 and battery == 1)
    visible(img_mask[3], gen[2] > 0 and battery == 1)
    visible(img_mask[4], (start[1] == 4 or start[2] == 4) and battery == 1)
    visible(img_mask[5], door > 0 and battery == 1)
    visible(img_mask[6], pitot == 0 and battery == 1)
    visible(img_mask[7], brakes > 0 and battery == 1)
    
end

function PT_liteup_fsx(retractable, gear_left, gear_right, gear_center, door, pitot, brakes, battery, gen1, gen2, starter1, starter2, inHg1, inHg2, flaps)

    -- Gear warning is on when the gear is up and the manifold pressure of either engine 1 or 2 is below 13 inHg and the flaps are in approach position, or gear is up and flaps are fully extended
    gear_up = fif(gear_left < 100 and gear_right < 100 and gear_center < 100, true, false)
    
    if (gear_up and (inHg1 < 13 or inHg2 < 13) and flaps > 40 and retractable) or (gear_up and flaps == 100 and retractable) then
        gear = 1
    else
        gear = 0
    end    

    -- Convert boolean to integer    
    pitot    = fif(pitot, 0, 1)
    brakes   = fif(brakes, 1, 0)
    battery  = fif(battery, 1, 0)
    gen1     = fif(gen1, 0, 1)
    gen2     = fif(gen2, 0, 1)
    starter1 = fif(starter1, 4, 0)
    starter2 = fif(starter2, 4, 0)    

    -- Send all the FSX data to the X-Plane function
    PT_liteup(gear, door, pitot, brakes, battery, {gen1, gen2}, {starter1, starter2})
    
end

-- Bus subscribe
xpl_dataref_subscribe("sim/cockpit2/annunciators/gear_warning", "INT", 
                      "sim/cockpit/warnings/annunciators/cabin_door_open", "INT",
                      "sim/cockpit2/annunciators/pitot_heat", "INT",
                      "sim/cockpit2/controls/parking_brake_ratio", "FLOAT",
                      "sim/cockpit/electrical/battery_on", "INT",
                      "sim/cockpit/warnings/annunciators/generator_off", "INT[8]", 
                      "sim/cockpit2/engine/actuators/ignition_key", "INT[8]", PT_liteup)

fsx_variable_subscribe("IS GEAR RETRACTABLE", "Bool",
                       "GEAR LEFT POSITION", "Percent",
                       "GEAR RIGHT POSITION", "Percent",
                       "GEAR CENTER POSITION", "Percent",
                       "EXIT OPEN:1", "Percent",
                       "PITOT HEAT", "Bool",
                       "BRAKE PARKING INDICATOR", "Bool",
                       "ELECTRICAL MASTER BATTERY", "Bool",
                       "GENERAL ENG MASTER ALTERNATOR:1", "Bool",
                       "GENERAL ENG MASTER ALTERNATOR:2", "Bool",
                       "GENERAL ENG STARTER:1", "Bool",
                       "GENERAL ENG STARTER:2", "Bool",
                       "ENG MANIFOLD PRESSURE:1", "inHg", 
                       "ENG MANIFOLD PRESSURE:2", "inHg", 
                       "FLAPS HANDLE PERCENT", "Percent", PT_liteup_fsx)
                       
msfs_variable_subscribe("IS GEAR RETRACTABLE", "Bool",
                          "GEAR LEFT POSITION", "Percent",
                          "GEAR RIGHT POSITION", "Percent",
                          "GEAR CENTER POSITION", "Percent",
                          "EXIT OPEN:1", "Percent",
                          "PITOT HEAT", "Bool",
                          "BRAKE PARKING INDICATOR", "Bool",
                          "ELECTRICAL MASTER BATTERY", "Bool",
                          "GENERAL ENG MASTER ALTERNATOR:1", "Bool",
                          "GENERAL ENG MASTER ALTERNATOR:2", "Bool",
                          "GENERAL ENG STARTER:1", "Bool",
                          "GENERAL ENG STARTER:2", "Bool",
                          "ENG MANIFOLD PRESSURE:1", "inHg", 
                          "ENG MANIFOLD PRESSURE:2", "inHg", 
                          "FLAPS HANDLE PERCENT", "Percent", PT_liteup_fsx)                       