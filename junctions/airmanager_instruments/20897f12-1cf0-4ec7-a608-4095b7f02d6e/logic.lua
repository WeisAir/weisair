img_add_fullscreen("adf_xpn_radio.png")

adf1txt = txt_add("---", "size:48px; color: firebrick; halign: right;", 47, 25, 150, 60)
adf2txt = txt_add("---", "size:48px; color: firebrick; halign: right;", 47, 87, 150, 60)
xpntxt = txt_add("----", "size:48px; color: firebrick; halign: right;", 266, 25, 150, 60)

function PT_radio(adf1,adf2,transponder)
    
    if adf1 == 0 then
        txt_set(adf1txt, "---")
    else
        txt_set(adf1txt, string.format("%.0f", adf1))
    end
    
    if adf2 == 0 then
        txt_set(adf2txt, "---")
    else
        txt_set(adf2txt, string.format("%.0f", adf2))
    end

    txt_set(xpntxt, string.format("%.0f", transponder) )
end

function PT_radio_FSX(adf1,adf2,transponder)
    
    adf1 = adf1/1000
    adf2 = adf2/1000
    
    PT_radio(adf1, adf2, transponder)

end

xpl_dataref_subscribe("sim/cockpit2/radios/actuators/adf1_frequency_hz", "INT",
                      "sim/cockpit2/radios/actuators/adf2_frequency_hz", "INT",
                      "sim/cockpit/radios/transponder_code", "INT", PT_radio)
fsx_variable_subscribe("ADF ACTIVE FREQUENCY:1", "Hz",
                       "ADF ACTIVE FREQUENCY:2", "Hz",
                       "TRANSPONDER CODE:1", "number", PT_radio_FSX)
msfs_variable_subscribe("ADF ACTIVE FREQUENCY:1", "Hz",
                          "ADF ACTIVE FREQUENCY:2", "Hz",
                          "TRANSPONDER CODE:1", "number", PT_radio_FSX)                       