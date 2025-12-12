-- ATR 72-500 airspeed indicator by flyatr
-- remove the bezel by clicking in the top left corner of the instrument

-- config storage 
speedgauge_config = persist_add("show_bezel","INT",1)

-- global variables
local gbl_flaps = 0
local cfg_show_bezel = persist_get(speedgauge_config)        -- load the bezel setting

-- Add images --
img_no_bezel = img_add_fullscreen("black.png")
img_bezel = img_add_fullscreen("background.png")
visible(img_bezel, cfg_show_bezel == 1)
visible(img_no_bezel, cfg_show_bezel == 0)

img_add("markings.png",31,31,270,270)
img_off = img_add("off.png",196,190,37,19)
img_needle = img_add("needle.png",155,0,20,330)
img_barberneedle = img_add("barber_needle.png",155,0,20,330)
img_add("center.png",135,135,60,60)
img_bug = img_add("speedbug.png",150,0,30,330)
img_bug_green = img_add("bug_green.png",155,0,20,330)
img_bug_yellow = img_add("bug_yellow.png",155,0,20,330)
img_bug_white = img_add("bug_white.png",155,0,20,330)
img_bug_red = img_add("bug_red.png",155,0,20,330)

function getAngle(speed) --three diffeerent areas on the scale
    if speed==nil then
        return 0
    end
    angle=0
    if speed <= 70 then
        angle = 0.6 * speed - 30
    elseif speed > 70 and speed <= 250 then
        angle = 1.4 * speed - 86
    else 
        angle = 0.43 * speed + 157,33
    end
    return var_cap(angle, 0, 328)    --max angle
end

-- initial bugs position
rotate(img_bug_green,getAngle(70))
rotate(img_bug_yellow,getAngle(75))
rotate(img_bug_white,getAngle(80))
rotate(img_bug_red,getAngle(85))

function new_fsx_data(fsx_airspeed, fsx_battery, fsx_ias_var, fsx_barber_pole, fsx_weight, fsx_ground, fsx_flaps)
    rotate(img_bug,getAngle(fsx_ias_var))        --adjustable speed bug
    if fsx_battery then
        rotate(img_needle, getAngle(fsx_airspeed))
        rotate(img_barberneedle, getAngle(fsx_barber_pole))
        visible(img_off, false)
    else  --Battery off
        visible(img_off, true)
        rotate(img_needle, 0)
        rotate(img_barberneedle, 0)
    end
  
    if gbl_flaps ~= fsx_flaps then                            -- flaps changed
        setBugs(fsx_weight, gbl_flaps, fsx_flaps, fsx_ground)    -- set speed bugs
        gbl_flaps = fsx_flaps                                      -- copy data to globals
    end
  
end

function bezel_config()                -- remove the bezel by clicking in the top left corner of the instrument
    if cfg_show_bezel == 1 then
        cfg_show_bezel = 0
        visible(img_bezel,false)
        visible(img_no_bezel, true)
        visible(spd_dial, false)
    else
        cfg_show_bezel = 1
        visible(img_bezel, true)
        visible(img_no_bezel, false)
        visible(spd_dial, true)
    end
    persist_put(speedgauge_config, cfg_show_bezel)    -- save setting
end
switch_add(nil,nil,0,0,80,80,bezel_config)
 
function dial_it(direction)  --speedbug knob
    if direction == 1 then
        fsx_event("AP_SPD_VAR_INC")
        fs2020_event("AP_SPD_VAR_INC")
        xpl_command("sim/autopilot/airspeed_up")
    elseif direction == -1 then
        fsx_event("AP_SPD_VAR_DEC")
        fs2020_event("AP_SPD_VAR_DEC")
        xpl_command("sim/autopilot/airspeed_down")
    end
end
spd_dial = dial_add("speedbug_knob.png",254,254,71,71,dial_it)
visible(spd_dial,fif(cfg_show_bezel==1,true,false))
dial_click_rotate(spd_dial, 20)

function setBugs(weight,old_flaps,flaps,on_ground)
    
    takeoff = (on_ground and old_flaps == 0 and flaps == 1)         -- flaps set from 0 to 1 while on ground
    go_around = (not on_ground and old_flaps == 2 and flaps == 1)   -- flaps set from 2 to 1 while airborne 
    approach = (not on_ground and (old_flaps - flaps == -1))        -- flaps set from 0/1 to 1/2 while airborne: approach
    
    -- bug settings based on speed reference cards Czech airlines
    weight_metric = weight * 0.453592
    scale = var_cap(var_round(weight_metric/1000,0)-14,1,20)
    yellow_bug = math.floor(0.298 * scale^2 - 1.821 * scale + 106.1) + 1
    white_bug = math.floor(3.595 * scale + 110,6) + 1
    red_bug = math.floor(4.143 * scale + 132.1)
    
    if takeoff or go_around then                      -- set bugs to takeoff speeds
        green_bug = math.floor(4.37 * scale + 138)
    elseif approach then                              -- set bugs to approach speeds
        green_bug = math.floor(0.238 * scale^2 + 0.357 * scale + 93.57)
        yellow_bug = yellow_bug + 5
    end
    
    rotate(img_bug_green,getAngle(green_bug))
    rotate(img_bug_yellow,getAngle(yellow_bug))
    rotate(img_bug_white,getAngle(white_bug))
    rotate(img_bug_red,getAngle(red_bug))
    
end

function new_xpl_data(airspeed, battery, ias_var, barber_pole, weight, ground, flaps)

    battery = battery == 1
    weight = weight * 2.20462262
    ground = ground == 1
    flaps = flaps * 100
    
    new_fsx_data(airspeed, battery, ias_var, barber_pole, weight, ground, flaps)

end

-- Data subscribe --
fsx_variable_subscribe("AIRSPEED INDICATED", "Knots", 
                       "ELECTRICAL MASTER BATTERY", "BOOLEAN", 
                       "AUTOPILOT AIRSPEED HOLD VAR", "Knots",
                       "AIRSPEED BARBER POLE", "Knots",
                       "TOTAL WEIGHT", "Pounds",
                       "SIM ON GROUND", "BOOLEAN",
                       "FLAPS HANDLE INDEX", "Number", new_fsx_data) 
fs2020_variable_subscribe("AIRSPEED INDICATED", "Knots", 
                          "ELECTRICAL MASTER BATTERY", "BOOLEAN", 
                          "AUTOPILOT AIRSPEED HOLD VAR", "Knots",
                          "AIRSPEED BARBER POLE", "Knots",
                          "TOTAL WEIGHT", "Pounds",
                          "SIM ON GROUND", "BOOLEAN",
                          "FLAPS HANDLE INDEX", "Number", new_fsx_data)                        
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT",
                      "sim/cockpit/electrical/battery_on", "INT",
                      "sim/cockpit/autopilot/airspeed", "FLOAT", 
                      "sim/aircraft/view/acf_Vne", "FLOAT",
                      "sim/flightmodel/weight/m_total", "FLOAT",
                      "sim/flightmodel/failures/onground_any", "INT",
                      "sim/flightmodel2/controls/flap_handle_deploy_ratio", "FLOAT", new_xpl_data)