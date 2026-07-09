img_add_fullscreen("trim_backdrop.png")
img_aileron = img_add("trim_aileron.png",92,36,80,80)
img_rudder = img_add("trim_rudder.png",216,42,80,80)
img_elevator = img_add("trim_elevator.png",340,35,80,80)

function PT_trim(aileron,rudder,elevator)
    rotate(img_aileron, aileron*60)
    rotate(img_rudder, rudder*60)
    rotate(img_elevator, elevator*60)
end

function PT_trim_FSX(elevator, aileron, rudder)

    elevator = elevator / 100
    aileron = aileron / 100
    rudder = rudder / 100
    
    PT_trim(aileron, rudder, elevator)

end

xpl_dataref_subscribe("sim/cockpit2/controls/aileron_trim", "FLOAT",
                      "sim/cockpit2/controls/rudder_trim", "FLOAT",
                      "sim/cockpit2/controls/elevator_trim", "FLOAT", PT_trim)
fsx_variable_subscribe("ELEVATOR TRIM PCT", "Percent",
                       "AILERON TRIM PCT", "Percent",
                       "RUDDER TRIM PCT", "Percent", PT_trim_FSX)
msfs_variable_subscribe("ELEVATOR TRIM PCT", "Percent",
                          "AILERON TRIM PCT", "Percent",
                          "RUDDER TRIM PCT", "Percent", PT_trim_FSX)                       