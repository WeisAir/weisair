---------------------------------------------
--  Sim Innovations - All rights reserved  --
--       Robinson R22 Warning lights       --
---------------------------------------------
-- img_add_fullscreen("zwart.png")
-- Clutch
txt_add("CLUTCH", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 12, 232, 120, 120)
img_clutch_on  = img_add("warning_light_on.png", -10, 0, 166, 266, "visible:false")
img_clutch_off = img_add("warning_light_off.png", -10, 0, 166, 266)
-- MR Temp
txt_add("MR", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 171, 232, 120, 120)
txt_add("TEMP", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 171, 258, 120, 120)
img_mr_temp_on  = img_add("warning_light_on.png", 148, 0, 166, 266, "visible:false")
img_mr_temp_off = img_add("warning_light_off.png", 148, 0, 166, 266)
-- MR Chip
txt_add("MR", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 331, 232, 120, 120)
txt_add("CHIP", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 331, 258, 120, 120)
img_mr_chip_on  = img_add("warning_light_on.png", 308, 0, 166, 266, "visible:false")
img_mr_chip_off = img_add("warning_light_off.png", 308, 0, 166, 266)
-- Carbon monixide
txt_add("CARBON", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 452, 232, 200, 120)
txt_add("MONOXIDE", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 452, 258, 200, 120)
img_co_on  = img_add("warning_light_on.png", 468, 0, 166, 266, "visible:false")
img_co_off = img_add("warning_light_off.png", 468, 0, 166, 266)
-- Starter on
txt_add("STARTER", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 611, 232, 200, 120)
txt_add("ON", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 651, 258, 120, 120)
img_starter_on  = img_add("warning_light_on.png", 628, 0, 166, 266, "visible:false")
img_starter_off = img_add("warning_light_off.png", 628, 0, 166, 266)
-- TR chip
txt_add("TR", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 771, 232, 200, 120)
txt_add("CHIP", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 811, 258, 120, 120)
img_tr_chip_on  = img_add("warning_light_on.png", 788, 0, 166, 266, "visible:false")
img_tr_chip_off = img_add("warning_light_off.png", 788, 0, 166, 266)
-- Low fuel
txt_add("LOW", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 971, 232, 120, 120)
txt_add("FUEL", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 971, 258, 120, 120)
img_low_fuel_on  = img_add("warning_light_on.png", 948, 0, 166, 266, "visible:false")
img_low_fuel_off = img_add("warning_light_off.png", 948, 0, 166, 266)
-- Low RPM
txt_add("LOW", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 1130, 232, 120, 120)
txt_add("RPM", "font: arimo_bold.ttf; size:30; color: white; halign:center;", 1130, 258, 120, 120)
img_low_rpm_on  = img_add("warning_light_on.png", 1108, 0, 166, 266, "visible:false")
img_low_rpm_off = img_add("warning_light_off.png", 1108, 0, 166, 266)

xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts", "FLOAT[6]", 
                      "sim/cockpit2/switches/clutch_ratio", "FLOAT", 
                      "laminar/r22/annunciator_mr_temp", "FLOAT", 
                      "laminar/r22/annunciator_mr_chip", "FLOAT", 
                      "laminar/r22/annunciator_carbon_monox", "FLOAT",
                      "laminar/r22/annunciator_starter", "FLOAT", 
                      "laminar/r22/annunciator_tr_chip", "FLOAT", 
                      "laminar/r22/annunciator_low_fuel", "FLOAT",
                      "laminar/r22/annunciator_low_rpm", "FLOAT", function(bus_volts, clutch, mr_temp, mr_chip, co_warn, starter, tr_chip, low_fuel, low_rpm)

    local power = bus_volts[1] >= 8
    
    -- Clutch
    visible(img_clutch_on, power and (clutch > 0 and clutch < 1) )
    visible(img_clutch_off, clutch == 0 or clutch == 1 or not power)
    
    -- MR temp
    visible(img_mr_temp_on, power and mr_temp > 0)
    visible(img_mr_temp_off, mr_temp == 0 or not power)
    
    -- MR temp
    visible(img_mr_chip_on, power and mr_chip > 0)
    visible(img_mr_chip_off, mr_chip == 0 or not power)
    
    -- Carbon monixide
    visible(img_co_on, power and co_warn > 0)
    visible(img_co_off, co_warn == 0 or not power)
    
    -- Starter on
    visible(img_starter_on, power and starter > 0)
    visible(img_starter_off, starter == 0 or not power)
    
    -- TR chip
    visible(img_tr_chip_on, power and tr_chip > 0)
    visible(img_tr_chip_off, tr_chip == 0 or not power)
    
    -- Low fuel
    visible(img_low_fuel_on, power and low_fuel > 0)
    visible(img_low_fuel_off, low_fuel == 0 or not power)
    
    -- Low RPM
    visible(img_low_rpm_on, power and low_rpm > 0)
    visible(img_low_rpm_off, low_rpm == 0 or not power)

end)