img_add_fullscreen("com_nav_radio.png")

com1txt = txt_add("---.--", "size:48px; color: firebrick; halign: center;", 35, 24, 200, 60)
com2txt = txt_add("---.--", "size:48px; color: firebrick; halign: center;", 35, 86, 200, 60)
nav1txt = txt_add("---.--", "size:48px; color: firebrick; halign: center;", 260, 24, 200, 60)
nav2txt = txt_add("---.--", "size:48px; color: firebrick; halign: center;", 260, 86, 200, 60)

function PT_radio(com1,com2,nav1,nav2)    
  txt_set(com1txt, string.format("%.02f", com1/100) )
  txt_set(com2txt, string.format("%.02f", com2/100) )
  txt_set(nav1txt, string.format("%.02f", nav1/100) )
  txt_set(nav2txt, string.format("%.02f", nav2/100) )
end

function PT_radio_FSX(com1,com2,nav1,nav2)
    PT_radio(com1*100+0.01,com2*100+0.01,nav1*100+0.01,nav2*100+0.01)
end

xpl_dataref_subscribe("sim/cockpit2/radios/actuators/com1_frequency_hz", "INT",
                      "sim/cockpit2/radios/actuators/com2_frequency_hz", "INT",
                      "sim/cockpit2/radios/actuators/nav1_frequency_hz", "INT",
                      "sim/cockpit2/radios/actuators/nav2_frequency_hz", "INT", PT_radio)
fsx_variable_subscribe("COM ACTIVE FREQUENCY:1", "Mhz",
                       "COM ACTIVE FREQUENCY:2", "Mhz",
                       "NAV ACTIVE FREQUENCY:1", "Mhz",
                       "NAV ACTIVE FREQUENCY:2", "Mhz", PT_radio_FSX)
msfs_variable_subscribe("COM ACTIVE FREQUENCY:1", "Mhz",
                          "COM ACTIVE FREQUENCY:2", "Mhz",
                          "NAV ACTIVE FREQUENCY:1", "Mhz",
                          "NAV ACTIVE FREQUENCY:2", "Mhz", PT_radio_FSX)                       