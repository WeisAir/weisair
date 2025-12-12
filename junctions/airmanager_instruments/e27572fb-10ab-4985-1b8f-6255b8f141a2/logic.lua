
----------------------------------------------------------
img_add  ("warn_off.png",0,0,100,100)

--Warning Select
local WARN_value = 0  

function WARN_Engage()
        xpl_command("sim/annunciator/clear_master_warning","FLOAT")
end
WARN_ENG = button_add(nil, nil, 0, 0, 100, 100, WARN_Engage)

--Warning Light
img_warn_indicator = img_add("warn_on.png", 0, 0, 100, 100, "visible:false")

function light_warn(sw_on)
    if sw_on >= 0.1 then					    
        visible(img_warn_indicator, true)
    else
        visible(img_warn_indicator, false)
    end
end     
xpl_dataref_subscribe("sim/cockpit/warnings/master_warning_on", "FLOAT", light_warn)

--[[
img_add  ("warn_off.png",0,0,100,100)

--Caution Select    
function callback_Caution()
    fs2020_rpn("(L:FSS_EXX_MASTER_WARN_L_BTN) ! (>L:FSS_EXX_MASTER_WARN_L_BTN)")
   --sound_play(click_snd)
end
button_add(nil,nil, 0,0,100,100, callback_Caution)
---
local img_push_on = img_add("warn_on.png", 0, 0, 100, 100)

visible(img_push_on, false)

function check_caution_and_flash(caution_state, flash_state)
    if (caution_state == 1 and flash_state == 1) then
        visible(img_push_on, true)  
    else
        visible(img_push_on, false) 
    end
end


fs2020_variable_subscribe("L:FSS_EXX_MASTER_WARN", "Number", 
                           "L:FSS_EXX_MASTER_FLASH_WARN", "Number", 
                           check_caution_and_flash)

--- ANNUN BUTTON TEST
local img_push_on = img_add("warn_on.png", 0, 0, 100, 100)

visible(img_push_on, false)


function check_cpl_anun_test(anun_test_state)
    if (anun_test_state == 1) then
        visible(img_push_on, true)  
    else
        visible(img_push_on, false) 
    end
end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_CPL_ANUNTEST_BTN", "Number", 
                           check_cpl_anun_test)
--]]