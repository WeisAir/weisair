local gbl_mode = 0
local gbl_busv = 0
local gbl_ident = false
math.randomseed( os.time() )

function new_mode(position, direction)
    
    desired_mode = position + direction
    
    if desired_mode == 0 then
        xpl_command("sim/transponder/transponder_off")
        msfs_variable_write("TRANSPONDER STATE:1", "ENUM", 0)
    elseif desired_mode == 1 then
        xpl_command("sim/transponder/transponder_standby")
        msfs_variable_write("TRANSPONDER STATE:1", "ENUM", 1)
    elseif desired_mode == 2 then
        xpl_command("sim/transponder/transponder_on")
        msfs_variable_write("TRANSPONDER STATE:1", "ENUM", 3)
    elseif desired_mode == 3 then
        xpl_command("sim/transponder/transponder_alt")
        msfs_variable_write("TRANSPONDER STATE:1", "ENUM", 4)
    elseif desired_mode == 4 then
        xpl_command("sim/transponder/transponder_test")
        msfs_variable_write("TRANSPONDER STATE:1", "ENUM", 2)
    end

end

function new_sqwk1000(sqwk1000)

    if sqwk1000 == 1 then
        xpl_command("sim/transponder/transponder_thousands_up")
        fsx_event("XPNDR_1000_INC")
        msfs_event("XPNDR_1000_INC")
    elseif sqwk1000 == -1 then
        xpl_command("sim/transponder/transponder_thousands_down")
        fsx_event("XPNDR_1000_DEC")
        msfs_event("XPNDR_1000_DEC")
    end

end

function new_sqwk100(sqwk100)

    if sqwk100 == 1 then
        xpl_command("sim/transponder/transponder_hundreds_up")
        fsx_event("XPNDR_100_INC")
        msfs_event("XPNDR_100_INC")
    elseif sqwk100 == -1 then
        xpl_command("sim/transponder/transponder_hundreds_down")
        fsx_event("XPNDR_100_DEC")
        msfs_event("XPNDR_100_DEC")
    end

end

function new_sqwk10(sqwk10)

    if sqwk10 == 1 then
        xpl_command("sim/transponder/transponder_tens_up")
        fsx_event("XPNDR_10_INC")
        msfs_event("XPNDR_10_INC")
    elseif sqwk10 == -1 then
        xpl_command("sim/transponder/transponder_tens_down")
        fsx_event("XPNDR_10_DEC")
        msfs_event("XPNDR_10_DEC")
    end

end

function new_sqwk1(sqwk1)

    if sqwk1 == 1 then
        xpl_command("sim/transponder/transponder_ones_up")
        fsx_event("XPNDR_1_INC")
        msfs_event("XPNDR_1_INC")
    elseif sqwk1 == -1 then
        xpl_command("sim/transponder/transponder_ones_down")
        fsx_event("XPNDR_1_DEC")
        msfs_event("XPNDR_1_DEC")
    end

end

function new_ident()

    xpl_command("sim/transponder/transponder_ident")
    msfs_event("XPNDR_IDENT_ON")
    if (gbl_mode >= 3 or gbl_mode == 1) and gbl_busv >= 8 then
        gbl_ident = true
        ident_timer = timer_start(13000, function() gbl_ident = false end)
    end

end

-- Add images in Z-order --
img_add_fullscreen("BKKT76A.png")
img_ident = img_add("light.png", 160, 54, 46, 22)

-- Set default visibility --
opacity(img_ident, 0)

-- Add text in Z-order --
txt_code_1000 = txt_add("7", " font:arimo_bold.ttf; size:30px; color: #DCDCDC; halign: center;", 188, 33, 200, 200)
txt_code_100 = txt_add("0", " font:arimo_bold.ttf; size:30px; color: #DCDCDC; halign: center;", 298, 33, 200, 200)
txt_code_10 = txt_add("0", " font:arimo_bold.ttf; size:30px; color: #DCDCDC; halign: center;", 411, 33, 200, 200)
txt_code_1 = txt_add("0", " font:arimo_bold.ttf; size:30px; color: #DCDCDC; halign: center;", 523, 33, 200, 200)

function new_transponder(code, mode, brightness)
    
    -- Transponder code
    txt_set(txt_code_1000, math.floor(code / 1000))
    txt_set(txt_code_100, math.floor(code % 1000 / 100))
    txt_set(txt_code_10, math.floor(code % 1000 % 100 / 10))
    txt_set(txt_code_1, math.floor(code % 10))

    -- Transponder light
    opacity(img_ident, brightness)
    
    -- Set switch state
    switch_set_position(switch_mode, mode)

end

function new_transponder_FSX(code, bus_volts)

    new_transponder(code, 3, 0)
    
    gbl_mode = 3
    gbl_busv = bus_volts

end

function new_transponder_F2020(code, mode, ident, bus_volts)

    gbl_mode = mode
    gbl_busv = bus_volts

    -- Transponder code
    txt_set(txt_code_1000, math.floor(code / 1000))
    txt_set(txt_code_100, math.floor(code % 1000 / 100))
    txt_set(txt_code_10, math.floor(code % 1000 % 100 / 10))
    txt_set(txt_code_1, math.floor(code % 10))
    
    -- Transponder light
    if ident then
        opacity(img_ident, 1, "LOG", 0.08)
    else
        opacity(img_ident, 0, "LOG", 0.08)
    end

    -- Set switch state
    if mode == 0 then -- OFF
        switch_set_position(switch_mode, 0)
    elseif mode == 1 then -- STANDBY
        switch_set_position(switch_mode, 1)
    elseif mode == 2 then -- TEST
        switch_set_position(switch_mode, 4)
    elseif mode == 3 then -- ON
        switch_set_position(switch_mode, 2)
    elseif mode == 4 then -- ALT
        switch_set_position(switch_mode, 3)
    end

end

timer_start(nil, 250, function(count)

    -- Transponder light
    if (fsx_connected() or p3d_connected()) and gbl_busv >= 8 then
        if gbl_mode >= 3 and not gbl_ident then
            if count%10 == math.random(0,9) then
                opacity(img_ident, 1, "LOG", 0.2)
            else
                opacity(img_ident, 0, "LOG", 0.2)
            end
        elseif gbl_mode == 2 and not gbl_ident then
            opacity(img_ident, 1, "LOG", 0.2)
        elseif (gbl_mode >= 3 or gbl_mode == 1) and gbl_ident then
            opacity(img_ident, 1, "LOG", 0.2)
        else
            opacity(img_ident, 0, "LOG", 0.2)
            timer_stop(ident_timer)
            gbl_ident = false
        end
    end
end)

-- Switches, buttons and dials --
switch_mode = switch_add("BKKT76Amode1.png","BKKT76Amode2.png","BKKT76Amode3.png","BKKT76Amode4.png","BKKT76Amode5.png",56,62,50,50, new_mode)

dial_sqwk1000 = dial_add("BKKT76Asetbutsmall.png", 262, 65, 50, 50, new_sqwk1000)
dial_sqwk100 = dial_add("BKKT76Asetbutsmall.png", 374, 65, 50, 50, new_sqwk100)
dial_sqwk10 = dial_add("BKKT76Asetbutsmall.png", 486, 65, 50, 50, new_sqwk10)
dial_sqwk1 = dial_add("BKKT76Asetbutsmall.png", 598, 65, 50, 50, new_sqwk1)

ident = button_add("identbutton.png", "identbutton.png", 160, 113, 46, 22, new_ident)

-- Bus subscribe --
xpl_dataref_subscribe("sim/cockpit/radios/transponder_code", "INT",
                      "sim/cockpit/radios/transponder_mode", "INT", 
                      "sim/cockpit/radios/transponder_brightness", "FLOAT", new_transponder)
fsx_variable_subscribe("TRANSPONDER CODE:1", "Hz",
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_transponder_FSX)
fs2020_variable_subscribe("TRANSPONDER CODE:1", "Hz",
                          "TRANSPONDER STATE:1", "ENUM",
                          "TRANSPONDER IDENT:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE:1", "Volts", new_transponder_F2020)
fs2024_variable_subscribe("TRANSPONDER CODE:1", "Hz",
                          "TRANSPONDER STATE:1", "ENUM",
                          "TRANSPONDER IDENT:1", "Bool",
                          "ELECTRICAL BUS VOLTAGE:1", "Volts", new_transponder_F2020)