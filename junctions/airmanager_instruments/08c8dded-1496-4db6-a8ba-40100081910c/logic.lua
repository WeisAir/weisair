-- COMM / NAV STACK MADE BY SIM INNOVATIONS --

-- GLOVAL VARIABLES AND PERSISTENCE
local gbl_power        = false
local gbl_pnl_off_1    = false
local gbl_pnl_off_2    = false
local gbl_adf_swap    = 0

prs_scrc_com1 = persist_add("scrs_com1", "INT", 1)
prs_scrc_com2 = persist_add("scrs_com2", "INT", 2)

-- ADD IMAGES
img_add_fullscreen("black.png")
img_add("com1_background.png", 2, 2, nil, nil)
img_add("com2_background.png", 1025, 2, nil, nil)
img_add("nav1_background.png", 2, 502, nil, nil)
img_add("nav2_background.png", 1025, 502, nil, nil)
img_add("adf_background.png", 2, 1002, nil, nil)
img_add("transponder_background.png", 1025, 1002, nil, nil)

img_scrc_light_com1_1 = img_add("light.png", 325, 240, nil, nil)
img_scrc_light_com1_2 = img_add("light.png", 467, 240, nil, nil)
img_scrc_light_com2_1 = img_add("light.png", 1348, 240, nil, nil)
img_scrc_light_com2_2 = img_add("light.png", 1490, 240, nil, nil)
visible(img_scrc_light_com1_1, false)
visible(img_scrc_light_com1_2, false)
visible(img_scrc_light_com2_1, false)
visible(img_scrc_light_com2_2, false)

img_add("linked_off.png", 477, 20, nil, nil)
img_com12_linked_left = img_add("linked_on.png", 477, 20, nil, nil)
visible(img_com12_linked_left, false)

img_add("linked_off.png", 1497, 20, nil, nil)
img_com12_linked_right = img_add("linked_on.png", 1497, 20, nil, nil)
visible(img_com12_linked_right, false)

img_adf_actv = img_add("adf_light.png", 128, 1120, nil, nil)
img_ant_actv = img_add("adf_ant_light.png", 128, 1156, nil, nil)
img_adf_stby = img_add("adf_light.png", 606, 1120, nil, nil)
img_ant_stby = img_add("adf_ant_light.png", 606, 1156, nil, nil)
visible(img_adf_actv, false)
visible(img_ant_actv, false)
visible(img_adf_stby, false)
visible(img_ant_stby, false)

img_atc1 = img_add("atc_1.png", 1420, 1141, nil, nil)
img_xpdr_fail = img_add("xpdr_fail.png", 1528, 1027, nil, nil)
visible(img_atc1, false)
visible(img_xpdr_fail, false)

-- ADD TEXT
txt_com1_actv = txt_add(" ", "size:80px; color: #f2700d; halign:left;", 110, 118, 350, 110)
txt_com1_stby = txt_add(" ", "size:80px; color: #f2700d; halign:left;", 588, 118, 350, 110)

txt_com2_actv = txt_add(" ", "size:80px; color: #f2700d; halign:left;", 1133, 118, 350, 110)
txt_com2_stby = txt_add(" ", "size:80px; color: #f2700d; halign:left;", 1611, 118, 350, 110)

txt_nav1_actv = txt_add(" ", "size:80px; color: #f2700d; halign:left;", 110, 618, 350, 110)
txt_nav1_stby = txt_add(" ", "size:80px; color: #f2700d; halign:left;", 588, 618, 350, 110)

txt_nav2_actv = txt_add(" ", "size:80px; color: #f2700d; halign:left;", 1133, 618, 350, 110)
txt_nav2_stby = txt_add(" ", "size:80px; color: #f2700d; halign:left;", 1611, 618, 350, 110)

txt_adf_actv = txt_add(" ", "size:80px; color: #f2700d; halign:right;", 58, 1118, 350, 110)
txt_adf_stby = txt_add(" ", "size:80px; color: #f2700d; halign:right;", 536, 1118, 350, 110)

txt_xpdr_frq = txt_add(" ", "size:102px; color: #e6e6ff; halign:right;", 1420, 1176, 220, 125)

-- BUTTONS, SWITCHES AND DIALS CALLBACKS --
function callback_pnl_off1()

    -- TURN OFF PANEL 1
    gbl_pnl_off_1 = not gbl_pnl_off_1
    
end

function callback_pnl_off2()

    -- TURN OFF PANEL 2
    gbl_pnl_off_2 = not gbl_pnl_off_2
    
end

function callback_trf_com1()

    -- TRANSFER FREQUENCIES ON COM 1 PANEL
    if persist_get(prs_scrc_com1) == 1 and not gbl_pnl_off_1 then
        xpl_command("sim/radios/com1_standy_flip")
        fsx_event("COM_STBY_RADIO_SWAP")
        fs2020_event("COM_STBY_RADIO_SWAP")
    elseif persist_get(prs_scrc_com1) == 2 and not gbl_pnl_off_1 then
        xpl_command("sim/radios/com2_standy_flip")
        fsx_event("COM2_RADIO_SWAP")
        fs2020_event("COM2_RADIO_SWAP")
    end

end

function callback_trf_com2()
    
    -- TRANSFER FREQUENCIES ON COM 2 PANEL
    if persist_get(prs_scrc_com2) == 1 and not gbl_pnl_off_2 then
        xpl_command("sim/radios/com1_standy_flip")
        fsx_event("COM_STBY_RADIO_SWAP")
        fs2020_event("COM_STBY_RADIO_SWAP")
    elseif persist_get(prs_scrc_com2) == 2 and not gbl_pnl_off_2 then
        xpl_command("sim/radios/com2_standy_flip")
        fsx_event("COM2_RADIO_SWAP")
        fs2020_event("COM2_RADIO_SWAP")
    end

end

function callback_vhf1_com1()

    -- SWITCH BETWEEN VHF1 AND VHF 2 ON THE COM 1 PANEL
    if not gbl_pnl_off_1 and gbl_power then
        persist_put(prs_scrc_com1, 1)
    end

end

function callback_vhf2_com1()

    -- SWITCH BETWEEN VHF1 AND VHF 2 ON THE COM 1 PANEL
    if not gbl_pnl_off_1 and gbl_power then
        persist_put(prs_scrc_com1, 2)
    end

end

function callback_vhf1_com2()

    -- SWITCH BETWEEN VHF1 AND VHF 2 ON THE COM 1 PANEL
    if not gbl_pnl_off_2 and gbl_power then
        persist_put(prs_scrc_com2, 1)
    end

end

function callback_vhf2_com2()

    -- SWITCH BETWEEN VHF1 AND VHF 2 ON THE COM 1 PANEL
    if not gbl_pnl_off_2 and gbl_power then
        persist_put(prs_scrc_com2, 2)
    end

end

function callback_com1_big(direction)
    
    -- COM1 BIG DIAL
    if (not gbl_pnl_off_1 and persist_get(prs_scrc_com1) == 1) and direction == 1 then
        xpl_command("sim/radios/stby_com1_coarse_up")
        fsx_event("COM_RADIO_WHOLE_INC")
        fs2020_event("COM_RADIO_WHOLE_INC")
    elseif (not gbl_pnl_off_1 and persist_get(prs_scrc_com1) == 1) and direction == -1 then
        xpl_command("sim/radios/stby_com1_coarse_down")
        fsx_event("COM_RADIO_WHOLE_DEC")
        fs2020_event("COM_RADIO_WHOLE_DEC")
    elseif (not gbl_pnl_off_1 and persist_get(prs_scrc_com1) == 2) and direction == 1 then
        xpl_command("sim/radios/stby_com2_coarse_up")
        fsx_event("COM2_RADIO_WHOLE_DEC")
        fs2020_event("COM2_RADIO_WHOLE_DEC")
    elseif (not gbl_pnl_off_1 and persist_get(prs_scrc_com1) == 2) and direction == -1 then
        xpl_command("sim/radios/stby_com2_coarse_down")
        fsx_event("COM2_RADIO_WHOLE_INC")
        fs2020_event("COM2_RADIO_WHOLE_INC")
    end
    
end

function callback_com1_small(direction)

    -- COM1 SMALL DIAL
    if (not gbl_pnl_off_1 and persist_get(prs_scrc_com1) == 1) and direction == 1 then
        xpl_command("sim/radios/stby_com1_fine_up_833")
        fsx_event("COM_RADIO_FRACT_INC")
        fs2020_event("COM_RADIO_FRACT_INC")
    elseif (not gbl_pnl_off_1 and persist_get(prs_scrc_com1) == 1) and direction == -1 then
        xpl_command("sim/radios/stby_com1_fine_down_833")
        fsx_event("COM_RADIO_FRACT_DEC")
        fs2020_event("COM_RADIO_FRACT_DEC")
    elseif (not gbl_pnl_off_1 and persist_get(prs_scrc_com1) == 2) and direction == 1 then
        xpl_command("sim/radios/stby_com2_fine_up_833")
        fsx_event("COM2_RADIO_FRACT_INC")
        fs2020_event("COM2_RADIO_FRACT_INC")
    elseif (not gbl_pnl_off_1 and persist_get(prs_scrc_com1) == 2) and direction == -1 then
        xpl_command("sim/radios/stby_com2_fine_down_833")
        fsx_event("COM2_RADIO_FRACT_DEC")
        fs2020_event("COM2_RADIO_FRACT_DEC")
    end

end

function callback_com2_big(direction)
    
    -- COM2 BIG DIAL
    if (not gbl_pnl_off_2 and persist_get(prs_scrc_com2) == 1) and direction == 1 then
        xpl_command("sim/radios/stby_com1_coarse_up")
        fsx_event("COM_RADIO_WHOLE_INC")
        fs2020_event("COM_RADIO_WHOLE_INC")
    elseif (not gbl_pnl_off_2 and persist_get(prs_scrc_com2) == 1) and direction == -1 then
        xpl_command("sim/radios/stby_com1_coarse_down")
        fsx_event("COM_RADIO_WHOLE_DEC")
        fs2020_event("COM_RADIO_WHOLE_DEC")
    elseif (not gbl_pnl_off_2 and persist_get(prs_scrc_com2) == 2) and direction == 1 then
        xpl_command("sim/radios/stby_com2_coarse_up")
        fsx_event("COM2_RADIO_WHOLE_DEC")
        fs2020_event("COM2_RADIO_WHOLE_DEC")
    elseif (not gbl_pnl_off_2 and persist_get(prs_scrc_com2) == 2) and direction == -1 then
        xpl_command("sim/radios/stby_com2_coarse_down")
        fsx_event("COM2_RADIO_WHOLE_INC")
        fs2020_event("COM2_RADIO_WHOLE_INC")
    end
    
end

function callback_com2_small(direction)

    -- COM2 SMALL DIAL
    if (not gbl_pnl_off_2 and persist_get(prs_scrc_com2) == 1) and direction == 1 then
        xpl_command("sim/radios/stby_com1_fine_up_833")
        fsx_event("COM_RADIO_FRACT_INC")
        fs2020_event("COM_RADIO_FRACT_INC")
    elseif (not gbl_pnl_off_2 and persist_get(prs_scrc_com2) == 1) and direction == -1 then
        xpl_command("sim/radios/stby_com1_fine_down_833")
        fsx_event("COM_RADIO_FRACT_DEC")
        fs2020_event("COM_RADIO_FRACT_DEC")
    elseif (not gbl_pnl_off_2 and persist_get(prs_scrc_com2) == 2) and direction == 1 then
        xpl_command("sim/radios/stby_com2_fine_up_833")
        fsx_event("COM2_RADIO_FRACT_INC")
        fs2020_event("COM2_RADIO_FRACT_INC")
    elseif (not gbl_pnl_off_2 and persist_get(prs_scrc_com2) == 2) and direction == -1 then
        xpl_command("sim/radios/stby_com2_fine_down_833")
        fsx_event("COM2_RADIO_FRACT_DEC")
        fs2020_event("COM2_RADIO_FRACT_DEC")
    end

end

function callback_nav1_big(direction)

    -- NAV1 BIG DIAL
    if direction == 1 then
        xpl_command("sim/radios/stby_nav1_coarse_up")
        fsx_event("NAV1_RADIO_WHOLE_INC")
        fs2020_event("NAV1_RADIO_WHOLE_INC")
    elseif direction == -1 then
        xpl_command("sim/radios/stby_nav1_coarse_down")
        fsx_event("NAV1_RADIO_WHOLE_DEC")
        fs2020_event("NAV1_RADIO_WHOLE_DEC")
    end

end

function callback_nav1_small(direction)

    -- NAV1 SMALL DIAL
    if direction == 1 then
        xpl_command("sim/radios/stby_nav1_fine_up")
        fsx_event("NAV1_RADIO_FRACT_INC")
        fs2020_event("NAV1_RADIO_FRACT_INC")
    elseif direction == -1 then
        xpl_command("sim/radios/stby_nav1_fine_down")
        fsx_event("NAV1_RADIO_FRACT_DEC")
        fs2020_event("NAV1_RADIO_FRACT_DEC")
    end

end

function callback_nav2_big(direction)

    -- NAV2 BIG DIAL
    if direction == 1 then
        xpl_command("sim/radios/stby_nav2_coarse_up")
        fsx_event("NAV2_RADIO_WHOLE_INC")
        fs2020_event("NAV2_RADIO_WHOLE_INC")
    elseif direction == -1 then
        xpl_command("sim/radios/stby_nav2_coarse_down")
        fsx_event("NAV2_RADIO_WHOLE_DEC")
        fs2020_event("NAV2_RADIO_WHOLE_DEC")
    end

end

function callback_nav2_small(direction)

    -- NAV2 SMALL DIAL
    if direction == 1 then
        xpl_command("sim/radios/stby_nav2_fine_up")
        fsx_event("NAV2_RADIO_FRACT_INC")
        fs2020_event("NAV2_RADIO_FRACT_INC")
    elseif direction == -1 then
        xpl_command("sim/radios/stby_nav2_fine_down")
        fsx_event("NAV2_RADIO_FRACT_DEC")
        fs2020_event("NAV2_RADIO_FRACT_DEC")
    end

end

function callback_trf_nav1()

    -- TRANSFER FREQUENCIES ON NAV 1 PANEL
    xpl_command("sim/radios/nav1_standy_flip")
    fsx_event("NAV1_RADIO_SWAP")
    fs2020_event("NAV1_RADIO_SWAP")
    
end

function callback_trf_nav2()

    -- TRANSFER FREQUENCIES ON NAV 2 PANEL
    xpl_command("sim/radios/nav2_standy_flip")
    fsx_event("NAV2_RADIO_SWAP")
    fs2020_event("NAV2_RADIO_SWAP")
    
end

function callback_trf_adf1()

    -- TRANSFER FREQUENCIES ON ADF 1 PANEL
    xpl_command("sim/radios/adf1_standy_flip")
    
    if gbl_adf_swap == 0 then
        fsx_event("PMDG 737NGX:EVT_ADF_TRANSFER_SWITCH", 0)
        gbl_adf_swap = 1
    elseif gbl_adf_swap == 1 then
        fsx_event("PMDG 737NGX:EVT_ADF_TRANSFER_SWITCH", 1)
        gbl_adf_swap = 0
    end
    
end

function callback_adf_mode(position, direction)

    xpl_dataref_write("sim/cockpit2/radios/actuators/adf1_power", "INT", position + direction)
    
end

function callback_adf1_big(direction)

    -- ADF1 BIG DIAL (100)
    if direction == 1 then
        xpl_command("sim/radios/stby_adf1_hundreds_up")
        fsx_event("ADF_100_INC")
        fs2020_event("ADF_100_INC")
    elseif direction == -1 then
        xpl_command("sim/radios/stby_adf1_hundreds_down")
        fsx_event("ADF_100_DEC")
        fs2020_event("ADF_100_DEC")
    end

end

function callback_adf1_small(direction)

    -- ADF1 SMALL DIAL (10)
    if direction == 1 then
        xpl_command("sim/radios/stby_adf1_tens_up")
        fsx_event("ADF_10_INC")
        fs2020_event("ADF_10_INC")
    elseif direction == -1 then
        xpl_command("sim/radios/stby_adf1_tens_down")
        fsx_event("ADF_10_DEC")
        fs2020_event("ADF_10_DEC")
    end

end

function callback_adf1_tiny(direction)

    -- ADF1 TINY DIAL (1)
    if direction == 1 then
        xpl_command("sim/radios/stby_adf1_ones_up")
        fsx_event("ADF_1_INC")
        fs2020_event("ADF_1_INC")
    elseif direction == -1 then
        xpl_command("sim/radios/stby_adf1_ones_down")
        fsx_event("ADF_1_DEC")
        fs2020_event("ADF_1_DEC")
    end

end

function callback_xpndr_big_left(direction)

    -- TRANSPONDER 1000
    if direction == 1 then
        xpl_command("sim/transponder/transponder_thousands_up")
        fsx_event("XPNDR_1000_INC")
        fs2020_event("XPNDR_1000_INC")
    elseif direction == -1 then
        xpl_command("sim/transponder/transponder_thousands_down")
        fsx_event("XPNDR_1000_DEC")
        fs2020_event("XPNDR_1000_DEC")
    end

end

function callback_xpndr_small_left(direction)

    -- TRANSPONDER 100
    if direction == 1 then
        xpl_command("sim/transponder/transponder_hundreds_up")
        fsx_event("XPNDR_100_INC")
        fs2020_event("XPNDR_100_INC")
    elseif direction == -1 then
        xpl_command("sim/transponder/transponder_hundreds_down")
        fsx_event("XPNDR_100_DEC")
        fs2020_event("XPNDR_100_DEC")
    end

end

function callback_xpndr_big_right(direction)

    -- TRANSPONDER 10
    if direction == 1 then
        xpl_command("sim/transponder/transponder_tens_up")
        fsx_event("XPNDR_10_INC")
        fs2020_event("XPNDR_10_INC")
    elseif direction == -1 then
        xpl_command("sim/transponder/transponder_tens_down")
        fsx_event("XPNDR_10_DEC")
        fs2020_event("XPNDR_10_DEC")
    end

end

function callback_xpndr_small_right(direction)

    -- TRANSPONDER 1
    if direction == 1 then
        xpl_command("sim/transponder/transponder_ones_up")
        fsx_event("XPNDR_1_INC")
        fs2020_event("XPNDR_1_INC")
    elseif direction == -1 then
        xpl_command("sim/transponder/transponder_ones_down")
        fsx_event("XPNDR_1_DEC")
        fs2020_event("XPNDR_1_DEC")
    end

end

function callback_ident()

    -- TRANSPONDER IDENT
    xpl_command("sim/transponder/transponder_ident")
    -- fsx_event("") No FSX event for ident
    
end

function callback_xpdr_mode(position, direction)

    -- TRANSPONDER MODE
    if direction == 1 then
        xpl_command("sim/transponder/transponder_up")
    elseif direction == -1 then
        xpl_command("sim/transponder/transponder_dn")
    end
    
end

-- SET THE FREQUENCIES --
function set_frequencies_xpl(bus_volts, avionics_on, com1_actv, com1_stby, com2_actv, com2_stby, nav1_actv, nav1_stby, nav2_actv, nav2_stby, adf_actv, adf_stby, adf_mode, xpdr_code, xpdr_mode, xpdr_fail, local_time)
    
    -- GLOBAL POWER
    gbl_power = fif((bus_volts[1] > 10 or bus_volts[2] > 10) and avionics_on, true, false)
    
    -- COM FREQUENCIES
    com1_actv = string.format("%06.03f", com1_actv / 1000)
    com1_stby = string.format("%06.03f", com1_stby / 1000)
    com2_actv = string.format("%06.03f", com2_actv / 1000)
    com2_stby = string.format("%06.03f", com2_stby / 1000)
    
    -- COM 1
    visible(txt_com1_actv, gbl_power and not gbl_pnl_off_1)
    visible(txt_com1_stby, gbl_power and not gbl_pnl_off_1)
    
    if persist_get(prs_scrc_com1) == 1 then
        txt_set(txt_com1_actv, com1_actv)
        txt_set(txt_com1_stby, com1_stby)
    elseif persist_get(prs_scrc_com1) == 2 then
        txt_set(txt_com1_actv, com2_actv)
        txt_set(txt_com1_stby, com2_stby)
    end
    
    visible(img_scrc_light_com1_1, (persist_get(prs_scrc_com1) == 1 and not gbl_pnl_off_1) and gbl_power)
    visible(img_scrc_light_com1_2, (persist_get(prs_scrc_com1) == 2 and not gbl_pnl_off_1) and gbl_power)
    
    visible(img_com12_linked_left, (persist_get(prs_scrc_com1) == persist_get(prs_scrc_com2)) and (not gbl_pnl_off_1 and not gbl_pnl_off_2) and gbl_power)
    
    -- COM 2
    visible(txt_com2_actv, gbl_power and not gbl_pnl_off_2)
    visible(txt_com2_stby, gbl_power and not gbl_pnl_off_2)
    
    if persist_get(prs_scrc_com2) == 1 then
        txt_set(txt_com2_actv, com1_actv)
        txt_set(txt_com2_stby, com1_stby)
    elseif persist_get(prs_scrc_com2) == 2 then
        txt_set(txt_com2_actv, com2_actv)
        txt_set(txt_com2_stby, com2_stby)
    end
    
    visible(img_scrc_light_com2_1, (persist_get(prs_scrc_com2) == 1 and not gbl_pnl_off_2) and gbl_power)
    visible(img_scrc_light_com2_2, (persist_get(prs_scrc_com2) == 2 and not gbl_pnl_off_2) and gbl_power)
    
    visible(img_com12_linked_right, (persist_get(prs_scrc_com2) == persist_get(prs_scrc_com1))  and (not gbl_pnl_off_2 and not gbl_pnl_off_1) and gbl_power)
    
    -- NAV 1
    visible(txt_nav1_actv, gbl_power)
    visible(txt_nav1_stby, gbl_power)
    
    txt_set(txt_nav1_actv, string.format("%06.03f", nav1_actv / 100) )
    txt_set(txt_nav1_stby, string.format("%06.03f", nav1_stby / 100) )

    -- NAV 2
    visible(txt_nav2_actv, gbl_power)
    visible(txt_nav2_stby, gbl_power)
    
    txt_set(txt_nav2_actv, string.format("%06.03f", nav2_actv / 100) )
    txt_set(txt_nav2_stby, string.format("%06.03f", nav2_stby / 100) )
    
    -- ADF
    visible(txt_adf_actv, gbl_power and adf_mode > 0)
    visible(txt_adf_stby, gbl_power and adf_mode > 0)
    visible(img_adf_actv, gbl_power and adf_mode > 1)
    visible(img_ant_actv, gbl_power and adf_mode == 1)
    visible(img_adf_stby, gbl_power and adf_mode > 1)
    visible(img_ant_stby, gbl_power and adf_mode == 1)
    
    txt_set(txt_adf_actv, string.format("%05.01f", adf_actv) )
    txt_set(txt_adf_stby, string.format("%05.01f", adf_stby) )
    
    switch_set_position(swt_adf_mode, adf_mode)
    
    -- XPDR
    visible(txt_xpdr_frq, gbl_power and xpdr_mode > 0)
    visible(img_atc1, gbl_power and xpdr_mode > 0)
    visible(img_xpdr_fail, gbl_power and xpdr_fail)
    
    txt_set(txt_xpdr_frq, string.format("%04.0f", xpdr_code) )
    switch_set_position(swt_xpdr_mode, xpdr_mode)

end

function set_frequencies_fsx(bus_volts, avionics_on, com1_actv, com1_stby, com2_actv, com2_stby, nav1_actv, nav1_stby, nav2_actv, nav2_stby, adf_actv, adf_stby, adf_mode, xpdr_code, xpdr_mode, xpdr_fail, local_time)

    set_frequencies_xpl({bus_volts, bus_volts}, avionics_on, com1_actv, com1_stby, com2_actv, com2_stby, nav1_actv / 10, nav1_stby / 10, nav2_actv / 10, nav2_stby / 10, adf_actv, adf_stby, 2, xpdr_code, 3, xpdr_fail, local_time)

end

-- BUTTONS, SWITCHES, AND DIALS
but_pnl_off1 = button_add("off_up.png", "off_dn.png", 160,244,90,50, callback_pnl_off1)
but_pnl_off2 = button_add("off_up.png", "off_dn.png", 1184,244,90,50, callback_pnl_off2)

but_trf_com1 = button_add("swap_up.png", "swap_dn.png", 456, 126, 108, 68, callback_trf_com1)
but_trf_com2 = button_add("swap_up.png", "swap_dn.png", 1480, 126, 108, 68, callback_trf_com2)

but_vhf1_com1 = button_add("VHF1_up.png", "VHF1_dn.png", 320, 284, 100, 60, callback_vhf1_com1)
but_vhf2_com1 = button_add("VHF2_up.png", "VHF2_dn.png", 462, 284, 100, 60, callback_vhf2_com1)

but_vhf1_com2 = button_add("VHF1_up.png", "VHF1_dn.png", 1343, 284, 100, 60, callback_vhf1_com2)
but_vhf2_com2 = button_add("VHF2_up.png", "VHF2_dn.png", 1485, 284, 100, 60, callback_vhf2_com2)

dial_com1_big = dial_add("big_dial.png", 779, 258, 212, 212, callback_com1_big)
dial_click_rotate(dial_com1_big, 10)
dial_com1_small = dial_add("small_dial.png", 821, 300, 128, 128, callback_com1_small)
dial_click_rotate(dial_com1_small, 15)
mouse_setting(dial_com1_small , "CURSOR_LEFT", "small_cursor_ccw.png")
mouse_setting(dial_com1_small , "CURSOR_RIGHT", "small_cursor_cw.png")

dial_com2_big = dial_add("big_dial.png", 1803, 258, 212, 212, callback_com2_big)
dial_click_rotate(dial_com2_big, 10)
dial_com2_small = dial_add("small_dial.png", 1845, 300, 128, 128, callback_com2_small)
dial_click_rotate(dial_com2_small, 15)
mouse_setting(dial_com2_small , "CURSOR_LEFT", "small_cursor_ccw.png")
mouse_setting(dial_com2_small , "CURSOR_RIGHT", "small_cursor_cw.png")

but_trf_nav1 = button_add("swap_up.png", "swap_dn.png", 456, 628, 108, 68, callback_trf_nav1)
but_trf_nav2 = button_add("swap_up.png", "swap_dn.png", 1480, 628, 108, 68, callback_trf_nav2)

dial_nav1_big = dial_add("big_dial.png", 779, 758, 212, 212, callback_nav1_big)
dial_click_rotate(dial_nav1_big, 10)
dial_nav1_small = dial_add("small_dial.png", 821, 800, 128, 128, callback_nav1_small)
dial_click_rotate(dial_nav1_small, 15)
mouse_setting(dial_nav1_small , "CURSOR_LEFT", "small_cursor_ccw.png")
mouse_setting(dial_nav1_small , "CURSOR_RIGHT", "small_cursor_cw.png")

dial_nav2_big = dial_add("big_dial.png", 1803, 758, 212, 212, callback_nav2_big)
dial_click_rotate(dial_nav2_big, 10)
dial_nav2_small = dial_add("small_dial.png", 1845, 800, 128, 128, callback_nav2_small)
dial_click_rotate(dial_nav2_small, 15)
mouse_setting(dial_nav2_small , "CURSOR_LEFT", "small_cursor_ccw.png")
mouse_setting(dial_nav2_small , "CURSOR_RIGHT", "small_cursor_cw.png")

swt_adf_mode = switch_add("adf_off.png", "adf_ant.png", "adf_on.png", "adf_tone.png", "adf_test.png", 283, 1298, 192, 192, callback_adf_mode)
but_trf_adf1 = button_add("swap_up.png", "swap_dn.png", 456, 1128, 108, 68, callback_trf_adf1)
dial_adf1_big = dial_add("big_dial.png", 699, 1258, 212, 212, callback_adf1_big)
dial_click_rotate(dial_adf1_big, 10)

dial_adf1_small = dial_add("small_dial.png", 741, 1300, 128, 128, callback_adf1_small)
dial_click_rotate(dial_adf1_small, 15)
mouse_setting(dial_adf1_small , "CURSOR_LEFT", "small_cursor_ccw.png")
mouse_setting(dial_adf1_small , "CURSOR_RIGHT", "small_cursor_cw.png")

dial_adf1_tiny = dial_add("tiny_dial.png", 766, 1324, 80, 80, callback_adf1_tiny)
dial_click_rotate(dial_adf1_tiny, 15)
mouse_setting(dial_adf1_tiny , "CURSOR_LEFT", "ctr_cursor_ccw.png")
mouse_setting(dial_adf1_tiny , "CURSOR_RIGHT", "ctr_cursor_cw.png")

dial_xpndr_big_left = dial_add("transponder_dial_big.png", 1279, 1294, 170, 170, callback_xpndr_big_left)
dial_click_rotate(dial_xpndr_big_left, 12)
dial_xpndr_small_left = dial_add("transponder_dial_small.png", 1314, 1329, 100, 100, callback_xpndr_small_left)
dial_click_rotate(dial_xpndr_small_left, 15)
mouse_setting(dial_xpndr_small_left , "CURSOR_LEFT", "small_cursor_ccw.png")
mouse_setting(dial_xpndr_small_left , "CURSOR_RIGHT", "small_cursor_cw.png")

dial_xpndr_big_right = dial_add("transponder_dial_big.png", 1615, 1294, 170, 170, callback_xpndr_big_right)
dial_click_rotate(dial_xpndr_big_right, 12)
dial_xpndr_small_right = dial_add("transponder_dial_small.png", 1650, 1329, 100, 100, callback_xpndr_small_right)
dial_click_rotate(dial_xpndr_small_right, 15)
mouse_setting(dial_xpndr_small_right , "CURSOR_LEFT", "small_cursor_ccw.png")
mouse_setting(dial_xpndr_small_right , "CURSOR_RIGHT", "small_cursor_cw.png")

but_ident = button_add("ident_button_up.png", "ident_button_dn.png", 1506, 1389, 58, 58, callback_ident)

swt_xpdr_mode = switch_add("xpdr_off.png", "xpdr_stby.png", "xpdr_on.png", "xpdr_alt.png", 1737, 1078, 160, 160, callback_xpdr_mode)

-- SUBSCRIBE TO DATA FROM THE SIMULATOR
xpl_dataref_subscribe("sim/cockpit2/electrical/bus_volts", "FLOAT[4]",
                      "sim/cockpit/electrical/avionics_on", "INT",
                      "sim/cockpit2/radios/actuators/com1_frequency_hz_833", "INT",
                      "sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833", "INT",
                      "sim/cockpit2/radios/actuators/com2_frequency_hz_833", "INT",
                      "sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833", "INT",
                      "sim/cockpit/radios/nav1_freq_hz", "INT",
                      "sim/cockpit/radios/nav1_stdby_freq_hz", "INT",
                      "sim/cockpit/radios/nav2_freq_hz", "INT",
                      "sim/cockpit/radios/nav2_stdby_freq_hz", "INT",
                      "sim/cockpit/radios/adf1_freq_hz", "INT",
                      "sim/cockpit/radios/adf1_stdby_freq_hz", "INT",
                      "sim/cockpit2/radios/actuators/adf1_power", "INT",
                      "sim/cockpit/radios/transponder_code", "INT", 
                      "sim/cockpit/radios/transponder_mode", "INT", 
                      "sim/operation/failures/rel_xpndr", "INT", 
                      "sim/time/local_time_sec", "FLOAT", set_frequencies_xpl)
fsx_variable_subscribe("ELECTRICAL MAIN BUS VOLTAGE", "Volts",
                       "CIRCUIT AVIONICS ON", "Bool",
                       "COM ACTIVE FREQUENCY:1", "KHz",
                       "COM STANDBY FREQUENCY:1", "KHz",
                       "COM ACTIVE FREQUENCY:2", "KHz",
                       "COM STANDBY FREQUENCY:2", "KHz",
                       "NAV ACTIVE FREQUENCY:1", "KHz",
                       "NAV STANDBY FREQUENCY:1", "KHz",
                       "NAV ACTIVE FREQUENCY:2", "KHz",
                       "NAV STANDBY FREQUENCY:2", "KHz",
                       "ADF ACTIVE FREQUENCY:1", "KHz",
                       "ADF STANDBY FREQUENCY:1", "KHz",
                       "ADF AVAILABLE", "Bool",
                       "TRANSPONDER CODE:1", "Hz",
                       "TRANSPONDER AVAILABLE", "Bool",
                       "PARTIAL PANEL TRANSPONDER", "Enum",
                       "LOCAL TIME", "Seconds", set_frequencies_fsx)        
fs2020_variable_subscribe("ELECTRICAL MAIN BUS VOLTAGE", "Volts",
                          "CIRCUIT AVIONICS ON", "Bool",
                          "COM ACTIVE FREQUENCY:1", "KHz",
                          "COM STANDBY FREQUENCY:1", "KHz",
                          "COM ACTIVE FREQUENCY:2", "KHz",
                          "COM STANDBY FREQUENCY:2", "KHz",
                          "NAV ACTIVE FREQUENCY:1", "KHz",
                          "NAV STANDBY FREQUENCY:1", "KHz",
                          "NAV ACTIVE FREQUENCY:2", "KHz",
                          "NAV STANDBY FREQUENCY:2", "KHz",
                          "ADF ACTIVE FREQUENCY:1", "KHz",
                          "ADF STANDBY FREQUENCY:1", "KHz",
                          "ADF AVAILABLE", "Bool",
                          "TRANSPONDER CODE:1", "Hz",
                          "TRANSPONDER AVAILABLE", "Bool",
                          "PARTIAL PANEL TRANSPONDER", "Enum",
                          "LOCAL TIME", "Seconds", set_frequencies_fsx)                           