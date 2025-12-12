------------ VIDEO STREAM ----------
frame_prop = user_prop_add_boolean("Show display frame", true, "draw a frame around the display")
if user_prop_get(frame_prop) == true then
    background = img_add_fullscreen("display_frame.png")
    video_stream_id = video_stream_add("xpl/gauges[1]", 13, 9, 845, 574, 1145, 11, 888, 605)
else
    video_stream_id = video_stream_add("xpl/gauges[1]", 0, 0, 873, 593, 1150, 11, 873, 593)
end

-------- DEFINE TOUCH ZONES CALLBACKS -------------

function touch_spot_menu_1_cb() xpl_command("laminar/B738/tab/menu1") end
function touch_spot_menu_2_cb() xpl_command("laminar/B738/tab/menu2") end
function touch_spot_menu_3_cb() xpl_command("laminar/B738/tab/menu3") end
function touch_spot_menu_4_cb() xpl_command("laminar/B738/tab/menu4") end
function touch_spot_menu_5_cb() xpl_command("laminar/B738/tab/menu5") end
function touch_spot_menu_6_cb() xpl_command("laminar/B738/tab/menu6") end
function touch_spot_menu_7_cb() xpl_command("laminar/B738/tab/menu7") end
function touch_spot_menu_8_cb() xpl_command("laminar/B738/tab/menu8") end

function touch_spot_right_cb() xpl_command("laminar/B738/tab/right") end
function touch_spot_left_cb() xpl_command("laminar/B738/tab/left") end 

function touch_spot_back_cb() xpl_command("laminar/B738/tab/back") end 
function touch_spot_home_cb() xpl_command("laminar/B738/tab/home") end
function touch_spot_credits_cb() xpl_command("laminar/B738/tab/spec") end

function touch_spot_info_cb()    xpl_command("laminar/B738/tab/info")  end

function touch_spot_line_0_cb() xpl_command("laminar/B738/tab/line0") end
function touch_spot_line_1_cb() xpl_command("laminar/B738/tab/line1") end
function touch_spot_line_2_cb() xpl_command("laminar/B738/tab/line2") end
function touch_spot_line_3_cb() xpl_command("laminar/B738/tab/line3") end
function touch_spot_line_4_cb() xpl_command("laminar/B738/tab/line4") end
function touch_spot_line_5_cb() xpl_command("laminar/B738/tab/line5") end
function touch_spot_line_6_cb() xpl_command("laminar/B738/tab/line6") end
function touch_spot_line_7_cb() xpl_command("laminar/B738/tab/line7") end
function touch_spot_line_8_cb() xpl_command("laminar/B738/tab/line8") end
function touch_spot_line_9_cb() xpl_command("laminar/B738/tab/line9") end

function touch_spot_numpad_clear_cb() xpl_command("laminar/B738/tab/numpad_clr") end
function touch_spot_numpad_close_cb() xpl_command("laminar/B738/tab/numpad_close") end
function touch_spot_numpad_minus_cb() xpl_command("laminar/B738/tab/numpad_minus") end
function touch_spot_numpad_7_cb() xpl_command("laminar/B738/tab/numpad_7") end
function touch_spot_numpad_8_cb() xpl_command("laminar/B738/tab/numpad_8") end
function touch_spot_numpad_9_cb() xpl_command("laminar/B738/tab/numpad_9") end
function touch_spot_numpad_4_cb() xpl_command("laminar/B738/tab/numpad_4") end
function touch_spot_numpad_5_cb() xpl_command("laminar/B738/tab/numpad_5") end
function touch_spot_numpad_6_cb() xpl_command("laminar/B738/tab/numpad_6") end
function touch_spot_numpad_1_cb() xpl_command("laminar/B738/tab/numpad_1") end
function touch_spot_numpad_2_cb() xpl_command("laminar/B738/tab/numpad_2") end
function touch_spot_numpad_3_cb() xpl_command("laminar/B738/tab/numpad_3") end
function touch_spot_numpad_0_cb() xpl_command("laminar/B738/tab/numpad_0") end
function touch_spot_numpad_comma_cb() xpl_command("laminar/B738/tab/numpad_comma") end
function touch_spot_numpad_enter_cb() xpl_command("laminar/B738/tab/numpad_enter") end

function touch_spot_perf_1_cb() xpl_command("laminar/B738/tab/perf1") end 
function touch_spot_perf_2_cb() xpl_command("laminar/B738/tab/perf2") end 
function touch_spot_perf_3_cb() xpl_command("laminar/B738/tab/perf3") end 
function touch_spot_perf_4_cb() xpl_command("laminar/B738/tab/perf4") end 
function touch_spot_perf_5_cb() xpl_command("laminar/B738/tab/perf5") end 
function touch_spot_perf_6_cb() xpl_command("laminar/B738/tab/perf6") end 
function touch_spot_perf_7_cb() xpl_command("laminar/B738/tab/perf7") end 
function touch_spot_perf_8_cb() xpl_command("laminar/B738/tab/perf8") end 
function touch_spot_perf_9_cb() xpl_command("laminar/B738/tab/perf9") end 
function touch_spot_perf_10_cb() xpl_command("laminar/B738/tab/perf10") end
function touch_spot_perf_11_cb() xpl_command("laminar/B738/tab/perf11") end
function touch_spot_perf_12_cb() xpl_command("laminar/B738/tab/perf12") end
function touch_spot_perf_13_cb() xpl_command("laminar/B738/tab/perf13") end
function touch_spot_perf_14_cb() xpl_command("laminar/B738/tab/perf14") end
function touch_spot_perf_15_cb() xpl_command("laminar/B738/tab/perf15") end
function touch_spot_perf_16_cb() xpl_command("laminar/B738/tab/perf16") end

-------- ADD TOUCH ZONES -----------

touch_spot = "button_helper.png"
--touch_spot = ""

menu_layer = layer_add(1, function()
    touch_spot_menu_1 = button_add(touch_spot, touch_spot, 80, 95, 165, 140,	touch_spot_menu_1_cb)
    touch_spot_menu_2 = button_add(touch_spot, touch_spot, 262, 95, 165, 140,	touch_spot_menu_2_cb)
    touch_spot_menu_3 = button_add(touch_spot, touch_spot, 444, 95, 165, 140,	touch_spot_menu_3_cb)
    touch_spot_menu_4 = button_add(touch_spot, touch_spot, 622, 95, 165, 140,	touch_spot_menu_4_cb)
    touch_spot_menu_5 = button_add(touch_spot, touch_spot, 80, 255, 165, 140,	touch_spot_menu_5_cb)
    touch_spot_menu_6 = button_add(touch_spot, touch_spot, 262, 255, 165, 140,	touch_spot_menu_6_cb)
    touch_spot_menu_7 = button_add(touch_spot, touch_spot, 444, 255, 165, 140,	touch_spot_menu_7_cb)
    touch_spot_menu_8 = button_add(touch_spot, touch_spot, 622, 255, 165, 140,	touch_spot_menu_8_cb)
end)

nav_layer = layer_add(1, function()
    touch_spot_right = button_add(touch_spot, touch_spot, 810, 200, 40, 80,		touch_spot_right_cb)
    touch_spot_left = button_add(touch_spot, touch_spot, 30, 200, 40, 80,		touch_spot_left_cb)
end)

footer_layer = layer_add(1, function()
    touch_spot_back = button_add(touch_spot, touch_spot, 80, 510, 165, 60,		touch_spot_back_cb)
    touch_spot_home = button_add(touch_spot, touch_spot, 340, 510, 165, 60,		touch_spot_home_cb)
    touch_spot_credits = button_add(touch_spot, touch_spot, 550, 510, 295, 60,	touch_spot_credits_cb)
end)
        
header_layer = layer_add(1, function()
    touch_spot_info = button_add(touch_spot, touch_spot, 810, 10, 40, 30,touch_spot_info_cb)
end)

lines_layer = layer_add(1, function ()
    touch_spot_line_0 = button_add(touch_spot, touch_spot, 80, 53, 710, 35,		touch_spot_line_0_cb)
    touch_spot_line_1 = button_add(touch_spot, touch_spot, 80, 115, 710, 35,	touch_spot_line_1_cb)
    touch_spot_line_2 = button_add(touch_spot, touch_spot, 80, 157, 710, 35,	touch_spot_line_2_cb)
    touch_spot_line_3 = button_add(touch_spot, touch_spot, 80, 199, 710, 35,	touch_spot_line_3_cb)
    touch_spot_line_4 = button_add(touch_spot, touch_spot, 80, 242, 710, 35,	touch_spot_line_4_cb)
    touch_spot_line_5 = button_add(touch_spot, touch_spot, 80, 284, 710, 35,	touch_spot_line_5_cb)
    touch_spot_line_6 = button_add(touch_spot, touch_spot, 80, 326, 710, 35,	touch_spot_line_6_cb)
    touch_spot_line_7 = button_add(touch_spot, touch_spot, 80, 368, 710, 35,	touch_spot_line_7_cb)
    touch_spot_line_8 = button_add(touch_spot, touch_spot, 80, 410, 710, 35,	touch_spot_line_8_cb)
    touch_spot_line_9 = button_add(touch_spot, touch_spot, 80, 452, 710, 35,	touch_spot_line_9_cb)
end)

numpad_layer = layer_add(1, function ()
    touch_spot_numpad_clear = button_add(touch_spot, touch_spot, 454, 104, 30, 30,	touch_spot_numpad_clear_cb)
    touch_spot_numpad_close = button_add(touch_spot, touch_spot, 488, 104, 30, 30,	touch_spot_numpad_close_cb)
    touch_spot_numpad_minus = button_add(touch_spot, touch_spot, 348, 150, 25, 25,	touch_spot_numpad_minus_cb)
    touch_spot_numpad_7 = button_add(touch_spot, touch_spot, 360, 189, 40, 40,		touch_spot_numpad_7_cb)
    touch_spot_numpad_8 = button_add(touch_spot, touch_spot, 412, 189, 40, 40,		touch_spot_numpad_8_cb)
    touch_spot_numpad_9 = button_add(touch_spot, touch_spot, 464, 189, 40, 40,		touch_spot_numpad_9_cb)
    touch_spot_numpad_4 = button_add(touch_spot, touch_spot, 360, 238, 40, 40,		touch_spot_numpad_4_cb)
    touch_spot_numpad_5 = button_add(touch_spot, touch_spot, 412, 238, 40, 40,		touch_spot_numpad_5_cb)
    touch_spot_numpad_6 = button_add(touch_spot, touch_spot, 464, 238, 40, 40,		touch_spot_numpad_6_cb)
    touch_spot_numpad_1 = button_add(touch_spot, touch_spot, 360, 288, 40, 40,		touch_spot_numpad_1_cb)
    touch_spot_numpad_2 = button_add(touch_spot, touch_spot, 412, 288, 40, 40,		touch_spot_numpad_2_cb)
    touch_spot_numpad_3 = button_add(touch_spot, touch_spot, 464, 288, 40, 40,		touch_spot_numpad_3_cb)
    touch_spot_numpad_0 = button_add(touch_spot, touch_spot, 360, 337, 40, 40,		touch_spot_numpad_0_cb)
    touch_spot_numpad_comma = button_add(touch_spot, touch_spot, 412, 337, 40, 40,	touch_spot_numpad_comma_cb)
    touch_spot_numpad_enter = button_add(touch_spot, touch_spot, 464, 337, 40, 40,	touch_spot_numpad_enter_cb)
end)

perf_layer = layer_add(1, function ()
    touch_spot_perf_1 = button_add(touch_spot, touch_spot, 80, 115, 350, 35,	touch_spot_perf_1_cb)
    touch_spot_perf_2 = button_add(touch_spot, touch_spot, 80, 157, 350, 35,	touch_spot_perf_2_cb)
    touch_spot_perf_3 = button_add(touch_spot, touch_spot, 80, 199, 350, 35,	touch_spot_perf_3_cb)
    touch_spot_perf_4 = button_add(touch_spot, touch_spot, 80, 241, 350, 35,	touch_spot_perf_4_cb)
    touch_spot_perf_5 = button_add(touch_spot, touch_spot, 80, 283, 350, 35,	touch_spot_perf_5_cb)
    touch_spot_perf_6 = button_add(touch_spot, touch_spot, 80, 325, 350, 35,	touch_spot_perf_6_cb)
    touch_spot_perf_7 = button_add(touch_spot, touch_spot, 80, 367, 350, 35,	touch_spot_perf_7_cb)
    touch_spot_perf_8 = button_add(touch_spot, touch_spot, 310, 409, 220, 35,	touch_spot_perf_8_cb)
    touch_spot_perf_9 = button_add(touch_spot, touch_spot, 450, 115, 350, 35,	touch_spot_perf_9_cb)
    touch_spot_perf_10 = button_add(touch_spot, touch_spot, 450, 157, 350, 35,	touch_spot_perf_10_cb)
    touch_spot_perf_11 = button_add(touch_spot, touch_spot, 450, 199, 350, 35,	touch_spot_perf_11_cb)
    touch_spot_perf_12 = button_add(touch_spot, touch_spot, 450, 241, 350, 35,	touch_spot_perf_12_cb)
    touch_spot_perf_13 = button_add(touch_spot, touch_spot, 450, 283, 350, 35,	touch_spot_perf_13_cb)
    touch_spot_perf_14 = button_add(touch_spot, touch_spot, 450, 325, 350, 35,	touch_spot_perf_14_cb)
    touch_spot_perf_15 = button_add(touch_spot, touch_spot, 450, 367, 350, 35,	touch_spot_perf_15_cb)
    touch_spot_perf_16 = button_add(touch_spot, touch_spot, 600, 409, 220, 35,	touch_spot_perf_16_cb)
end)

visible(menu_layer, false)
visible(lines_layer, false)
visible(numpad_layer, false)
visible(perf_layer, false)
visible(nav_layer,true)

opacity(menu_layer, 0.4)
opacity(lines_layer, 0.4)
opacity(numpad_layer, 0.4)
opacity(perf_layer, 0.4)
opacity(nav_layer,0.4)

 function efb_interaction(menu_page, numpad_is_active,pagination)
             
            if(menu_page == 0.0) 
                then
                    visible(menu_layer, false) 
                    visible(lines_layer, true) 
                else 
                    visible(menu_layer, true) 
                    visible(lines_layer, false)             
            end
                        
            if(pagination == 0.0) 
            then 
                visible(nav_layer, false) 
            else 
                visible(nav_layer, true) 
            end
            
            if(numpad_is_active == 1.0) 
                then 
                    visible(numpad_layer, true)
                    visible(lines_layer, false)  
                else 
                    visible(numpad_layer, false) 
                    --visible(lines_layer, true) 
                end
 end

 xpl_dataref_subscribe(
 "laminar/B738/tab/menu_page", "DOUBLE",  -- menu number (if it is 0.0 means you are in a "non-tile" menue)
  "laminar/B738/tab/numpad_act","DOUBLE", -- is numpad active
  "laminar/B738/tab/arrows_enable","DOUBLE", -- pagination available
 efb_interaction)