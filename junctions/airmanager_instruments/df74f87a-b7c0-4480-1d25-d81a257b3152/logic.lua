img_add_fullscreen("background.png")
img_low_volt  = img_add("low_volt.png", 22, 20, 216, 88, "visible:false")
img_door_warn = img_add("door_warn.png", 270, 20, 216, 88, "visible:false")
img_lalt_out  = img_add("l_alt_out.png", 22, 114, 216, 88, "visible:false")
img_ralt_out  = img_add("r_alt_out.png", 270, 114, 216, 88, "visible:false")
img_cabin_alt = img_add("cabin_alt.png", 22, 209, 216, 88, "visible:false")
img_hyd_press = img_add("hyd_press.png", 270, 209, 216, 88, "visible:false")
img_lhyd_flow = img_add("l_hyd_flow.png", 22, 304, 216, 88, "visible:false")
img_rhyd_flow = img_add("r_hyd_flow.png", 270, 304, 216, 88, "visible:false")
img_windshld  = img_add("windshield.png", 23, 398, 216, 88, "visible:false")
img_srf_deice = img_add("surf_deice.png", 271, 398, 216, 88, "visible:false")
img_courts_lt = img_add("courtesy_lt.png", 24, 491, 216, 88, "visible:false")
img_htr_ovht  = img_add("heater_ovht.png", 272, 491, 216, 88, "visible:false")

xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts", "FLOAT[6]", 
                      "sim/cockpit/warnings/annunciator_test_pressed", "INT",
                      "sim/cockpit2/annunciators/cabin_door_open", "INT",
                      "sim/cockpit/warnings/annunciators/generator_off", "INT[8]",
                      "sim/cockpit2/pressurization/indicators/cabin_altitude_ft", "FLOAT",
                      "sim/flightmodel2/gear/deploy_ratio", "FLOAT[10]",
                      "sim/cockpit2/engine/indicators/prop_speed_rpm", "FLOAT[8]",
                      "sim/cockpit2/hydraulics/indicators/hydraulic_pressure_1", "FLOAT",
                      "sim/cockpit2/hydraulics/indicators/hydraulic_pressure_2", "FLOAT",
                      "sim/cockpit/switches/anti_ice_window_heat", "INT",
                      "sim/cockpit2/ice/ice_surface_boot_on", "INT",
                      "sim/cockpit/electrical/cockpit_lights_on", "INT",
                      "sim/operation/failures/rel_HVAC", "INT",
                      function(bus_volts, test, door_open, alt_off, cabin_alt, gear_deploy, prop_rpm, hyd_press1, hyd_press2, windshield_ht, surf_deice, cp_lt_on, hvac)
    local power = bus_volts[1] >= 8
    
    visible(img_low_volt, power and (test == 1 or bus_volts[1] < 24) )
    visible(img_door_warn, power and (test == 1 or door_open == 1) )
    visible(img_lalt_out, power and (test == 1 or alt_off[1] == 1) )
    visible(img_ralt_out, power and (test == 1 or alt_off[2] == 1) )
    visible(img_cabin_alt, power and (test == 1 or cabin_alt > 10000) )
    local gear_ratio = gear_deploy[1] + gear_deploy[2] + gear_deploy[3]
    visible(img_hyd_press, power and (test == 1 or (gear_ratio > 0 and gear_ratio < 3)) )
    visible(img_lhyd_flow, power and (test == 1 or (prop_rpm[1] > 1000 and hyd_press1 < 350)) )
    visible(img_rhyd_flow, power and (test == 1 or (prop_rpm[2] > 1000 and hyd_press2 < 350)) )
    visible(img_windshld, power and (test == 1 or windshield_ht == 1) )
    visible(img_srf_deice, power and (test == 1 or surf_deice == 1) )
    visible(img_courts_lt, power and (test == 1 or cp_lt_on == 1) )
    visible(img_htr_ovht, power and (test == 1 or hvac == 6) )
    
end)

fs2020_variable_subscribe("ELECTRICAL MAIN BUS VOLTAGE", "Volts",
                          "ANNUNCIATOR SWITCH", "Bool",
                          "EXIT OPEN:1", "Percent",
                          "GENERAL ENG GENERATOR ACTIVE:1", "Bool",
                          "GENERAL ENG GENERATOR ACTIVE:2", "Bool",
                          "PRESSURIZATION CABIN ALTITUDE", "Feet",
                          "GEAR LEFT POSITION", "Percent",
                          "GEAR CENTER POSITION", "Percent",
                          "GEAR RIGHT POSITION", "Percent",
                          "PROP RPM:1", "RPM",
                          "PROP RPM:2", "RPM",
                          "ENG HYDRAULIC PRESSURE:1", "PSI",
                          "ENG HYDRAULIC PRESSURE:2", "PSI",
                          "STRUCTURAL DEICE SWITCH", "Bool",
                          "LIGHT CABIN ON", "Bool",
                          "PARTIAL PANEL ELECTRICAL", "Enum",
                          function(bus_volts, test, door_open, alt_status_1, alt_status_r, cabin_alt, gear_deploy_l, gear_deploy_c, gear_deploy_r, 
                                   prop_rpm_l, prop_rpm_r, hyd_press1, hyd_press2, surf_deice, cp_lt_on, electrical_failure)

    local power = bus_volts >= 8
    
    visible(img_low_volt, power and (test or bus_volts < 24) )
    visible(img_door_warn, power and (test or door_open > 0) )
    visible(img_lalt_out, power and (test or not alt_status_1) )
    visible(img_ralt_out, power and (test or not alt_status_r) )
    visible(img_cabin_alt, power and (test or cabin_alt > 10000) )
    local gear_ratio = gear_deploy_l + gear_deploy_c + gear_deploy_r
    visible(img_hyd_press, power and (test or (gear_ratio > 0 and gear_ratio < 300)) )
    visible(img_lhyd_flow, power and (test or (prop_rpm_l > 1000 and hyd_press1 < 350)) )
    visible(img_rhyd_flow, power and (test or (prop_rpm_r > 1000 and hyd_press2 < 350)) )
    visible(img_windshld, power and test)
    visible(img_srf_deice, power and (test or surf_deice) )
    visible(img_courts_lt, power and (test or cp_lt_on) )
    visible(img_htr_ovht, power and (test or electrical_failure == 1) )
    
end)

fsx_variable_subscribe("ELECTRICAL MAIN BUS VOLTAGE", "Volts",
                       "ANNUNCIATOR SWITCH", "Bool",
                       "EXIT OPEN:1", "Percent",
                       "GENERAL ENG GENERATOR ACTIVE:1", "Bool",
                       "GENERAL ENG GENERATOR ACTIVE:2", "Bool",
                       "PRESSURIZATION CABIN ALTITUDE", "Feet",
                       "GEAR LEFT POSITION", "Percent",
                       "GEAR CENTER POSITION", "Percent",
                       "GEAR RIGHT POSITION", "Percent",
                       "PROP RPM:1", "RPM",
                       "PROP RPM:2", "RPM",
                       "ENG HYDRAULIC PRESSURE:1", "PSI",
                       "ENG HYDRAULIC PRESSURE:2", "PSI",
                       "STRUCTURAL DEICE SWITCH", "Bool",
                       "LIGHT CABIN ON", "Bool",
                       "PARTIAL PANEL ELECTRICAL", "Enum",
                       function(bus_volts, test, door_open, alt_status_1, alt_status_r, cabin_alt, gear_deploy_l, gear_deploy_c, gear_deploy_r, 
                                prop_rpm_l, prop_rpm_r, hyd_press1, hyd_press2, surf_deice, cp_lt_on, electrical_failure)

    local power = bus_volts >= 8
    
    visible(img_low_volt, power and (test or bus_volts < 24) )
    visible(img_door_warn, power and (test or door_open > 0) )
    visible(img_lalt_out, power and (test or not alt_status_1) )
    visible(img_ralt_out, power and (test or not alt_status_r) )
    visible(img_cabin_alt, power and (test or cabin_alt > 10000) )
    local gear_ratio = gear_deploy_l + gear_deploy_c + gear_deploy_r
    visible(img_hyd_press, power and (test or (gear_ratio > 0 and gear_ratio < 300)) )
    visible(img_lhyd_flow, power and (test or (prop_rpm_l > 1000 and hyd_press1 < 350)) )
    visible(img_rhyd_flow, power and (test or (prop_rpm_r > 1000 and hyd_press2 < 350)) )
    visible(img_windshld, power and test)
    visible(img_srf_deice, power and (test or surf_deice) )
    visible(img_courts_lt, power and (test or cp_lt_on) )
    visible(img_htr_ovht, power and (test or electrical_failure == 1) )
    
end)