img_add("back_plate.png", 30, 0, 225, nil)
arrow = img_add("flap_arrow.png", 103,0,132,580)
img_add_fullscreen("mount_plate.png")

function move_flaps(flap_pos)
    move(arrow, nil, flap_pos * 265, nil, nil)
end

xpl_dataref_subscribe("sim/flightmodel2/controls/flap1_deploy_ratio", "FLOAT", move_flaps)
fsx_variable_subscribe("FLAPS HANDLE PERCENT", "Percent", function(flaps_pos)
    move_flaps(flaps_pos / 100)
end)
fs2020_variable_subscribe("FLAPS HANDLE PERCENT", "Percent", function(flaps_pos)
    move_flaps(flaps_pos / 100)
end)