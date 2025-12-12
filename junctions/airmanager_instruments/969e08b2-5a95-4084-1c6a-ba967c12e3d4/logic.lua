img_add_fullscreen("cirrus_switch_background.png")

function set_bat1(position)
xpl_command("sim/electrical/battery_1_toggle")
end

bat1_sw = switch_add( "tog_off.png" , "tog_on.png", 80,64,68,125, set_bat1)

function set_bat2(position)
xpl_command("sim/electrical/battery_2_toggle")
end

bat2_sw = switch_add( "tog_off.png" , "tog_on.png", 151,64,68,125, set_bat2)

function battries_change(bat)
switch_set_position(bat1_sw, bat[1])
switch_set_position(bat2_sw, bat[2])
end

xpl_dataref_subscribe("sim/cockpit/electrical/battery_array_on", "INT[8]", battries_change)

function set_gen1(position)
xpl_command("sim/electrical/generator_1_toggle")
end

gen1_sw = switch_add( "tog_off.png" , "tog_on.png", 223,64,68,125, set_gen1)

function set_gen2(position)
xpl_command("sim/electrical/generator_2_toggle")
end

gen2_sw = switch_add( "tog_off.png" , "tog_on.png", 294,64,68,125, set_gen2)


function generators_change(gen)
switch_set_position(gen1_sw, gen[1])
switch_set_position(gen2_sw, gen[2])
end

xpl_dataref_subscribe("sim/cockpit/electrical/generator_on", "INT[8]", generators_change)

function set_strb(position)
xpl_command("sim/lights/strobe_lights_toggle")

end


strb_sw = switch_add( "tog_off.png" , "tog_on.png", 367,64,68,125, set_strb)

function set_land(position)
xpl_command("sim/lights/landing_lights_toggle")

end

land_sw = switch_add( "tog_off.png" , "tog_on.png", 439,64,68,125, set_land)

function set_nav(position)
xpl_command("sim/lights/nav_lights_toggle")
end

nav_sw = switch_add( "tog_off.png" , "tog_on.png", 509,64,68,125, set_nav)

function set_lights( strobe, land, nav)
switch_set_position(strb_sw, strobe)
switch_set_position(land_sw, land)
switch_set_position(nav_sw, nav)
end

xpl_dataref_subscribe("sim/cockpit2/switches/strobe_lights_on","INT", "sim/cockpit2/switches/landing_lights_on", "INT","sim/cockpit2/switches/navigation_lights_on","INT" , set_lights)

function set_moxy(position)
    xpl_command("sim/operation/slider_20")
end

moxy_sw = switch_add( "tog_off.png" , "tog_on.png", 584,64,68,125, set_moxy)

function set_bair(position)
    xpl_command("sim/operation/slider_21")
end

bair_sw = switch_add( "tog_off.png" , "tog_on.png", 667,64,68,125, set_bair)

function set_prob(position)
    xpl_command("sim/ice/pitot_heat0_tog")
end

prob_sw = switch_add( "tog_off.png" , "tog_on.png", 748,64,68,125, set_prob)

function probe_change(prob)
    switch_set_position(prob_sw, prob)
end

xpl_dataref_subscribe("sim/cockpit/switches/pitot_heat_on","INT", probe_change)

function set_engai(position)
    position = math.abs( position - 1)
    xpl_dataref_write("sim/cockpit/switches/anti_ice_inlet_heat","INT", position)
end

engai_sw = switch_add( "tog_off.png" , "tog_on.png", 842,64,68,125, set_engai)

function engai_change(ai)
    switch_set_position(engai_sw, ai)
end

xpl_dataref_subscribe("sim/cockpit/switches/anti_ice_inlet_heat","INT", engai_change)

--sim/cockpit/switches/anti_ice_inlet_heat

function set_wingai(position)
    xpl_command("sim/ice/wing_heat_tog")
end

wingai_sw = switch_add( "tog_off.png" , "tog_on.png", 912,64,68,125, set_wingai)

function wingai_change(wi)
    switch_set_position(wingai_sw, wi)
end

xpl_dataref_subscribe("sim/cockpit/switches/anti_ice_surf_heat","INT", wingai_change)
--sim/cockpit/switches/anti_ice_surf_boot

function set_windon(position)
    xpl_command("sim/ice/window_heat_tog")
end

windon_sw = switch_add( "tog_off.png" , "tog_on.png", 983,64,68,125, set_windon)

function windon_change(wo)
    switch_set_position(windon_sw, wo)
end

xpl_dataref_subscribe("sim/cockpit2/ice/ice_window_heat_on","INT", windon_change)

function set_windhi(position)
    xpl_command("sim/operation/slider_23")
end

windhi_sw = switch_add( "tog_off.png" , "tog_on.png", 1067,64,68,125, set_windhi)

function set_windmax(position)
    xpl_command("sim/operation/slider_22")
end

windmax_sw = switch_add( "tog_off.png" , "tog_on.png", 1146,64,68,125, set_windmax)

function set_panel_lights(direction)
end

dial_add( "light_knob.png", 1300,87,82,82, set_panel_lights)

xpl_dataref_subscribe("sim/cockpit2/switches/custom_slider_on", "INT[24]", function(switch)
    switch_set_position(moxy_sw, switch[20])
    switch_set_position(bair_sw, switch[21])
    switch_set_position(windmax_sw, switch[22])
    switch_set_position(windhi_sw, switch[23])
end)