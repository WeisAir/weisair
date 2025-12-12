-- Garmin GTX327 Transponder--
--For use with X-Plane and Dreamfoil Schweizer 300CBi only--


img_add("black_background.png", 160, 0, 424, 128)
img_backlight = img_add("screen_backlight.png", 160, 0, 424, 128)
img_add_fullscreen("GTX327.png")
img_reply_icon = img_add("reply_icon.png", 189, 84, 20, 20)
txt_ident = txt_add(" ", "font:OpenSans-ExtraBold.ttf; size:20px; color: black;", 190, 25, 200, 200)
txt_code_d1 = txt_add(" ", "font:inconsolata_bold.ttf; size:85px; color: black; halign: center;", 172, 31, 200, 200)
txt_code_d2 = txt_add(" ", "font:inconsolata_bold.ttf; size:85px; color: black; halign: center;", 217, 31, 200, 100)
txt_code_d3 = txt_add(" ", "font:inconsolata_bold.ttf; size:85px; color: black; halign: center;", 263, 31, 200, 100)
txt_code_d4 = txt_add(" ", "font:inconsolata_bold.ttf; size:85px; color: black; halign: center;", 308, 31, 200, 100)
txt_fl = txt_add(" ", "font:OpenSans-ExtraBold.ttf; size:25px; color: black; halign: left;", 450, 70, 200, 200)
txt_fl_digit = txt_add(" ", "font:inconsolata_bold.ttf; size:35px; color: black; halign: left;", 480, 65, 200, 200)
txt_ck_d1 = txt_add(" ", "font:inconsolata_bold.ttf; size:32px; color: black; halign: center;", 436, 64, 17, 40)
txt_ck_d2 = txt_add(" ", "font:inconsolata_bold.ttf; size:32px; color: black; halign: center;", 454, 64, 17, 40)
txt_ck_d3 = txt_add(" ", "font:inconsolata_bold.ttf; size:32px; color: black; halign: center;", 480, 64, 17, 40)
txt_ck_d4 = txt_add(" ", "font:inconsolata_bold.ttf; size:32px; color: black; halign: center;", 498, 64, 17, 40)
txt_ck_d5 = txt_add(" ", "font:inconsolata_bold.ttf; size:32px; color: black; halign: center;", 524, 64, 17, 40)
txt_ck_d6 = txt_add(" ", "font:inconsolata_bold.ttf; size:32px; color: black; halign: center;", 542, 64, 17, 40)
txt_txpdr_mode = txt_add(" ", "font:OpenSans-ExtraBold.ttf; size:25px; color: black; halign: left;", 190, 56, 200, 200)
txt_txpdr_function = txt_add(" ", "font:OpenSans-ExtraBold.ttf; size:22px; color: black; halign: center;", 398, 40, 200, 100)
txt_timer_spacer_1 = txt_add(" ", "font:inconsolata_bold.ttf; size:32px; color: black; halign: center;", 376, 62, 200, 100)
txt_timer_spacer_2 = txt_add(" ", "font:inconsolata_bold.ttf; size:32px; color: black; halign: center;", 420, 62, 200, 100)
img_d2_cursor_active = img_add("cursor_active.png", 294, 35, 44, 62)
img_d2_cursor_dash = img_add("cursor_dash.png", 294, 35, 44, 62)
img_d3_cursor_active = img_add("cursor_active.png", 340, 35, 44, 62)
img_d3_cursor_dash = img_add("cursor_dash.png", 340, 35, 44, 62)
img_d4_cursor_active = img_add("cursor_active.png", 386, 35, 44, 62)
img_d4_cursor_dash = img_add("cursor_dash.png", 386, 35, 44, 62)
img_ck1_cursor_active = img_add("cursor_active.png", 436, 66, 16, 22)
img_ck1_cursor_dash = img_add("cursor_dash.png", 436, 66, 16, 22)
img_ck2_cursor_active = img_add("cursor_active.png", 454, 66, 16, 22)
img_ck2_cursor_dash = img_add("cursor_dash.png", 454, 66, 16, 22)
img_ck3_cursor_active = img_add("cursor_active.png", 480, 66, 16, 22)
img_ck3_cursor_dash = img_add("cursor_dash.png", 480, 66, 16, 22)
img_ck4_cursor_active = img_add("cursor_active.png", 498, 66, 16, 22)
img_ck4_cursor_dash = img_add("cursor_dash.png", 498, 66, 16, 22)
img_ck5_cursor_active = img_add("cursor_active.png", 524, 66, 16, 22)
img_ck5_cursor_dash = img_add("cursor_dash.png", 524, 66, 16, 22)
img_ck6_cursor_active = img_add("cursor_active.png", 542, 66, 16, 22)
img_ck6_cursor_dash = img_add("cursor_dash.png", 542, 66, 16, 22)
img_start_test = img_add_fullscreen("start_up_test.png")

-- Set default visibility --
visible (img_backlight, false)
visible(img_start_test, false)
visible(img_reply_icon, false)
visible(img_d2_cursor_active, false)
visible(img_d2_cursor_dash, false)
visible(img_d3_cursor_active, false)
visible(img_d3_cursor_dash, false)
visible(img_d4_cursor_active, false)
visible(img_d4_cursor_dash, false)
visible(img_ck1_cursor_active, false)
visible(img_ck1_cursor_dash, false)
visible(img_ck2_cursor_active, false)
visible(img_ck2_cursor_dash, false)
visible(img_ck3_cursor_active, false)
visible(img_ck3_cursor_dash, false)
visible(img_ck4_cursor_active, false)
visible(img_ck4_cursor_dash, false)
visible(img_ck5_cursor_active, false)
visible(img_ck5_cursor_dash, false)
visible(img_ck6_cursor_active, false)
visible(img_ck6_cursor_dash, false)

    
-- Functions --

function start_screen(test)

    if test == 1 then
    visible(img_start_test, true)
    elseif test == 0 then
    visible(img_start_test, false)
    end
    
end
xpl_dataref_subscribe ("GTX327/Starting", "FLOAT", start_screen)



function transponder_data(id_light, d1, d2, d3, d4, ident, mode)

    if id_light == 1 and mode >= 2 then
    visible(img_reply_icon, true)
    else
    visible(img_reply_icon, false)
    end


    if ident == 1 and mode >= 1 then
        txt_set(txt_ident, "IDENT")
    else
        txt_set(txt_ident, " ")
    end
    
    
    if mode >= 1 then
    visible (img_backlight, true)
    else
    visible (img_backlight, false)
    end
    
    
    if mode >= 1 and d1 <=9 then
    txt_set(txt_code_d1, string.format("%.0f", d1))
    else
    txt_set(txt_code_d1, " ")
    end
    
    
    if     mode >= 1 and d2 <=9 then
        txt_set(txt_code_d2, string.format("%.0f", d2))
        visible(img_d2_cursor_active, false)
        visible(img_d2_cursor_dash, false)
    elseif 
        mode >=1 and d2 == 10 then
        visible(img_d2_cursor_active, true)
        visible(img_d2_cursor_dash, false)
        txt_set(txt_code_d2, " ")
    elseif 
        mode >=1 and d2 == 11 then
        visible(img_d2_cursor_dash, true)
        visible(img_d2_cursor_active, false)        
        txt_set(txt_code_d2, " ")
    else
        visible(img_d2_cursor_active, false)
        visible(img_d2_cursor_dash, false)
        txt_set(txt_code_d2, " ")
    end
    
    
    if     mode >= 1 and d3 <=9 then
        txt_set(txt_code_d3, string.format("%.0f", d3))
        visible(img_d3_cursor_active, false)
        visible(img_d3_cursor_dash, false)
    elseif 
        mode >=1 and d3 == 10 then
        visible(img_d3_cursor_active, true)
        visible(img_d3_cursor_dash, false)
        txt_set(txt_code_d3, " ")
    elseif 
        mode >=1 and d3 == 11 then
        visible(img_d3_cursor_dash, true)
        visible(img_d3_cursor_active, false)        
        txt_set(txt_code_d3, " ")
    else
        visible(img_d3_cursor_active, false)
        visible(img_d3_cursor_dash, false)
        txt_set(txt_code_d3, " ")
    end
        
    if     mode >= 1 and d4 <=9 then
        txt_set(txt_code_d4, string.format("%.0f", d4))
        visible(img_d4_cursor_active, false)
        visible(img_d4_cursor_dash, false)
    elseif 
        mode >=1 and d4 == 10 then
        visible(img_d4_cursor_active, true)
        visible(img_d4_cursor_dash, false)
        txt_set(txt_code_d4, " ")
    elseif 
        mode >=1 and d4 == 11 then
        visible(img_d4_cursor_dash, true)
        visible(img_d4_cursor_active, false)        
        txt_set(txt_code_d4, " ")
    else
        visible(img_d4_cursor_active, false)
        visible(img_d4_cursor_dash, false)
        txt_set(txt_code_d4, " ")
    end
    
    
    if mode == 0 then
        txt_set(txt_txpdr_mode, " ")
    elseif mode == 1 then
        txt_set(txt_txpdr_mode, "STBY")
    elseif mode == 2 then
        txt_set(txt_txpdr_mode, "ON")
    elseif mode == 3 then
        txt_set(txt_txpdr_mode, "ALT")
    elseif mode == 4 then
        txt_set(txt_txpdr_mode, "TST")
    end
        
end


function transponder_counter ( fnct, flash, fl_1, fl_2, fl_3, ck1, ck2, ck3, ck4, ck5, ck6, txmode)

    if txmode == 0 then
        txt_set(txt_txpdr_function, " ")
    elseif txmode >= 1 and fnct == 0 then
        txt_set(txt_txpdr_function, "PRESSURE ALT")
    elseif txmode >= 1 and fnct == 1 then
        txt_set(txt_txpdr_function, "FLIGHT TIME")
    elseif txmode >= 1 and fnct == 2 then
        txt_set(txt_txpdr_function, "COUNT UP")    
    elseif txmode >= 1 and fnct == 3 then
        txt_set(txt_txpdr_function, "COUNT DOWN")        
    elseif txmode >= 1 and fnct == 4 then
        txt_set(txt_txpdr_function, "EXPIRED")
    end

    if txmode == 0 then
        txt_set(txt_fl, " ")
        txt_set (txt_fl_digit, " ")
    elseif txmode >=1 and fnct == 0 then
        txt_set (txt_fl, "FL")
        txt_set (txt_fl_digit, string.format ("%.0f" .. "%.0f" .. "%.0f" , fl_1, fl_2, fl_3)) 
    elseif txmode >= 1 and fnct > 0 then
        txt_set(txt_fl, " ")
        txt_set (txt_fl_digit, " ")
    end
        
    if txmode >= 1 and fnct >=1 and flash ==0 then
        txt_set (txt_timer_spacer_1, ":")
        txt_set (txt_timer_spacer_2, ":")
    else
        txt_set (txt_timer_spacer_1, " ")
        txt_set (txt_timer_spacer_2, " ")
    end
    
    if txmode >= 1 and fnct >= 1 and flash == 0 and ck1 <=9 then
        txt_set(txt_ck_d1, string.format("%.0f", ck1))
        visible(img_ck1_cursor_active, false)
        visible(img_ck1_cursor_dash, false)
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck1 == 10 then
        visible(img_ck1_cursor_active, true)
        visible(img_ck1_cursor_dash, false)
        txt_set(txt_ck_d1, " ")
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck1 == 11 then
        visible(img_ck1_cursor_dash, true)
        visible(img_ck1_cursor_active, false)        
        txt_set(txt_ck_d1, " ")
    else
        visible(img_ck1_cursor_active, false)
        visible(img_ck1_cursor_dash, false)
        txt_set(txt_ck_d1, " ")
    end
    
    if txmode >= 1 and fnct >= 1 and flash == 0 and ck2 <=9 then
        txt_set(txt_ck_d2, string.format("%.0f", ck2))
        visible(img_ck2_cursor_active, false)
        visible(img_ck2_cursor_dash, false)
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck2 == 10 then
        visible(img_ck2_cursor_active, true)
        visible(img_ck2_cursor_dash, false)
        txt_set(txt_ck_d2, " ")
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck2 == 11 then
        visible(img_ck2_cursor_dash, true)
        visible(img_ck2_cursor_active, false)        
        txt_set(txt_ck_d2, " ")
    else
        visible(img_ck2_cursor_active, false)
        visible(img_ck2_cursor_dash, false)
        txt_set(txt_ck_d2, " ")
    end
        
    if txmode >= 1 and fnct >= 1 and flash == 0 and ck3 <=9 then
        txt_set(txt_ck_d3, string.format("%.0f", ck3))
        visible(img_ck3_cursor_active, false)
        visible(img_ck3_cursor_dash, false)
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck3 == 10 then
        visible(img_ck3_cursor_active, true)
        visible(img_ck3_cursor_dash, false)
        txt_set(txt_ck_d3, " ")
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck3 == 11 then
        visible(img_ck3_cursor_dash, true)
        visible(img_ck3_cursor_active, false)        
        txt_set(txt_ck_d3, " ")
    else
        visible(img_ck3_cursor_active, false)
        visible(img_ck3_cursor_dash, false)
        txt_set(txt_ck_d3, " ")
    end
        
    if txmode >= 1 and fnct >= 1 and flash == 0 and ck4 <=9 then
        txt_set(txt_ck_d4, string.format("%.0f", ck4))
        visible(img_ck4_cursor_active, false)
        visible(img_ck4_cursor_dash, false)
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck4 == 10 then
        visible(img_ck4_cursor_active, true)
        visible(img_ck4_cursor_dash, false)
        txt_set(txt_ck_d4, " ")
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck4 == 11 then
        visible(img_ck4_cursor_dash, true)
        visible(img_ck4_cursor_active, false)        
        txt_set(txt_ck_d4, " ")
    else
        visible(img_ck4_cursor_active, false)
        visible(img_ck4_cursor_dash, false)
        txt_set(txt_ck_d4, " ")
    end
    
    if txmode >= 1 and fnct >= 1 and flash == 0 and ck5 <=9 then
        txt_set(txt_ck_d5, string.format("%.0f", ck5))
        visible(img_ck5_cursor_active, false)
        visible(img_ck5_cursor_dash, false)
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck5 == 10 then
        visible(img_ck5_cursor_active, true)
        visible(img_ck5_cursor_dash, false)
        txt_set(txt_ck_d5, " ")
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck5 == 11 then
        visible(img_ck5_cursor_dash, true)
        visible(img_ck5_cursor_active, false)        
        txt_set(txt_ck_d5, " ")
    else
        visible(img_ck5_cursor_active, false)
        visible(img_ck5_cursor_dash, false)
        txt_set(txt_ck_d5, " ")
    end
    
    if txmode >= 1 and fnct >= 1 and flash == 0 and ck6 <=9 then
        txt_set(txt_ck_d6, string.format("%.0f", ck6))
        visible(img_ck6_cursor_active, false)
        visible(img_ck6_cursor_dash, false)
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck6 == 10 then
        visible(img_ck6_cursor_active, true)
        visible(img_ck6_cursor_dash, false)
        txt_set(txt_ck_d6, " ")
    elseif txmode >=1 and fnct >=1 and flash == 0 and ck6 == 11 then
        visible(img_ck6_cursor_dash, true)
        visible(img_ck6_cursor_active, false)        
        txt_set(txt_ck_d6, " ")
    else
        visible(img_ck6_cursor_active, false)
        visible(img_ck6_cursor_dash, false)
        txt_set(txt_ck_d6, " ")
    end
    
end



-- Bus subscribe --
xpl_dataref_subscribe("sim/cockpit/radios/transponder_light", "INT",
                      "GTX327/CodeD1", "FLOAT",
                      "GTX327/CodeD2", "FLOAT",
                      "GTX327/CodeD3", "FLOAT",
                      "GTX327/CodeD4", "FLOAT",
                      "sim/cockpit/radios/transponder_id", "INT",
                      "sim/cockpit/radios/transponder_mode", "INT", transponder_data)
                       
                       
xpl_dataref_subscribe("GTX327/Function", "FLOAT",
                      "GTX327/CK_FLASH", "FLOAT",
                      "GTX327/FL_D1", "FLOAT",
                      "GTX327/FL_D2", "FLOAT",
                      "GTX327/FL_D3", "FLOAT",
                      "GTX327/CK_D1", "FLOAT",
                      "GTX327/CK_D2", "FLOAT",
                      "GTX327/CK_D3", "FLOAT",
                      "GTX327/CK_D4", "FLOAT",
                      "GTX327/CK_D5", "FLOAT",
                      "GTX327/CK_D6", "FLOAT", 
                      "sim/cockpit/radios/transponder_mode", "INT", transponder_counter)



--Buttons

function on()
    xpl_command("GTX327/On")
end
button_add(nil, "button_2_press.png", 102, 8, 30, 30, on, nil)

function off()
    xpl_command("GTX327/Off")
end
button_add(nil, "button_2_press.png", 138, 76, 30, 30, off, nil)

function stby()
    xpl_command("GTX327/Stdby")
end
button_add(nil, "button_2_press.png", 66, 76, 30, 30, stby, nil)

function alt()
    xpl_command("GTX327/Alt")
end
button_add(nil, "button_2_press.png", 102, 50, 30, 30, alt, nil)

function ident()
    xpl_command("GTX327/Ident")
end
button_add(nil, "button_1_press.png", 15, 28, 46, 34, ident, nil)

--set code to 1200 or 1500
function vfr()
    xpl_command("GTX327/Vfr")
end
button_add(nil, "button_2_press.png", 15, 72, 30, 30, vfr, nil)

function zero()
    xpl_command("GTX327/0")
end
button_add(nil, "button_1_press.png", 18, 129, 46, 34, zero, nil)

function one()
    xpl_command("GTX327/1")
end
button_add(nil, "button_1_press.png", 82, 129, 46, 34, one, nil)

function two()
    xpl_command("GTX327/2")
end
button_add(nil, "button_1_press.png", 144, 129, 46, 34, two, nil)

function three()
    xpl_command("GTX327/3")
end
button_add(nil, "button_1_press.png", 206, 129, 46, 34, three, nil)

function four()
    xpl_command("GTX327/4")
end
button_add(nil, "button_1_press.png", 268, 129, 46, 34, four, nil)

function five()
    xpl_command("GTX327/5")
end
button_add(nil, "button_1_press.png", 344, 129, 46, 34, five, nil)

function six()
    xpl_command("GTX327/6")
end
button_add(nil, "button_1_press.png", 406, 129, 46, 34, six, nil)

function seven()
    xpl_command("GTX327/7")
end
button_add(nil, "button_1_press.png", 468, 129, 46, 34, seven, nil)

function eight()
    xpl_command("GTX327/8")
end
button_add(nil, "button_1_press.png", 574, 129, 46, 34, eight, nil)

function nine()
    xpl_command("GTX327/9")
end
button_add(nil, "button_1_press.png", 632, 129, 46, 34, nine, nil)

function func()
    xpl_command("GTX327/Func")
end
button_add(nil, "button_1_press.png", 576, 28, 46, 34, func, nil)

function crsr()
    xpl_command("GTX327/CRSR")
end
button_add(nil, "button_1_press.png", 634, 28, 46, 34, crsr, nil)

function start_stop()
    xpl_command("GTX327/StartStop")
end
button_add(nil, "button_1_press.png", 576, 72, 46, 34, start_stop, nil)

function clr()
    xpl_command("GTX327/CLR")
end
button_add(nil, "button_1_press.png", 634, 72, 46, 34, clr, nil)