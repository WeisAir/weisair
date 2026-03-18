--[[
    Title:           FCU Autopilot for FlyByWire Airbus A320 (Air Manager instrument)
    Author:          Yves Levesque adapted for MSFS 2020
    Contributors:    Alexander Hildmann created for FlightFactor A320 on Xplane
   IMPORTANT:       To use "Illumination mode", Illumination Pedestal Captain instrument is needed.
                     Push/Pull implementation:
                       - If you press and instantly release a knob, its considered a push, if you press and hold a bit longer (timeframe is defined in variable pupu_threshold = 500 ms) its considered to be a pull.
                       - There are invisible buttons below knobs to trigger  pull.
    Changes:         2021-11-03   v.1.3   Corrected Managed Altitude Variable
                     2021-12-15   v 2.1   Add Illunination Mode
                     2022-02-19: Correct Power and Illumination
                     2023-02-12  YL  Change msfs_variable_write to msfs_rpn()
                     2023-11-04  YL add dials panel hardware support
                     2024-12-21  YL  v3.0 Adapt to MSFS2024
                     2025-06-06  YL v3.0.3 Correct for A32NX Stable version v13.0  
  ======================================================================= --]]
 prop_knobster = user_prop_add_boolean("Knobster",true,"Knobster used?")

-- local FBW_A32NX_Version ="Stable";
-- si_variable_subscribe( "FBW_A32NX_Version", "STRING", function(val)if val== "Development" then FBW_A32NX_Version = val else FBW_A32NX_Version = "Stable" end end)


--Images -----------------------------------------------------------------------
   local backplate_img           = img_add_fullscreen ("a320_fcu_panel.png") -- (1024,360)
   local night_overlay_img       = img_add_fullscreen("a320_fcu_panel_night.png")
   local text_overlay_img        = img_add_fullscreen("a320_fcu_panel_text.png")
   local text_overlay_y_img      = img_add_fullscreen("a320_fcu_panel_text_yellow.png")

   local Speed_base_img          = img_add ("SPD_base.png",110,155,90,90)
   local Speed_pushed_img        = img_add ("SPD_pushed.png",124,169,60,60); visible(Speed_pushed_img,false)
   local Speed_img               = img_add ("SPD.png",  124,169,60,60)     ; visible(Speed_img,true)
   local Speed_pulled_img        = img_add ("SPD_pulled.png",124,169,60,60); visible(Speed_pulled_img,false)
   local HDG_base_img            = img_add ("HDG_base.png",266,155,90,90)
   local HDG_pushed_img          = img_add ("HDG_pushed.png",280,169,60,60); visible(HDG_pushed_img,false)
   local HDG_img                 = img_add ("HDG.png",280,169,60,60)       ; visible(HDG_img,true)
   local HDG_pulled_img          = img_add ("HDG_pulled.png",280,169,60,60); visible(HDG_pulled_img,false)
   local ALT_100_img             = img_add ("ALT_100.png",659,155,90,90)
   local ALT_1000_img            = img_add ("ALT_1000.png",659,155,90,90)
   local ALT_pushed_img          = img_add ("ALT_pushed.png",675,169,60,60); visible(ALT_pushed_img,false)
   local ALT_img                 = img_add ("ALT.png",675,169,60,60)       ; visible(ALT_img,true)
   local ALT_pulled_img          = img_add ("ALT_pulled.png",675,169,60,60); visible(ALT_pulled_img,false)
   local VS_base_img             = img_add ("SPD_base.png",861,155,90,90)
   local VS_pushed_img           = img_add ("SPD_pushed.png",876,169,60,60); visible(VS_pushed_img,false)
   local VS_img                  = img_add ("SPD.png",876,169,60,60)       ; visible(VS_img,true)
   local VS_pulled_img           = img_add ("SPD_pulled.png",876,169,60,60); visible(VS_pulled_img,false)
   
   local SPD_managed_img         = img_add ("managed.png",210,67,15,15)    ; visible(SPD_managed_img,false)
   local HDG_managed_img         = img_add ("managed.png",360,67,15,15)    ; visible(HDG_managed_img,false)
   local ALT_managed_img         = img_add ("managed.png",770,67,15,15)    ; visible(ALT_managed_img,false)
   local brakets_img             = img_add ("brakets.png",700,29,130,20)   ; visible(brakets_img,false)
-- Text ------------------------------------------------------------------------------------------------------------
   local SPEED_d_txt             = txt_add("", "font:wwDigital.ttf;size:55;color:orange;halign:left;",115,46,150,50)
   local LATERAL_d_txt           = txt_add("", "font:wwDigital.ttf;size:55;color:orange;halign:left;",272,46,150,50)
   local ALTITUDE_d_txt          = txt_add("", "font:wwDigital.ttf;size:55;color:orange;halign:left;",625,46,135,50)
   local VERTSPEED_d_txt         = txt_add("", "font:wwDigital.ttf;size:55;color:orange;halign:left;",805,46,200,50)
   local SPD_MACH_txt            = txt_add("", "font:arimo_bold.ttf;size:20;color:orange;halign:left;",112,25,110,20)
   local HDG_TRK_txt             = txt_add("", "font:arimo_bold.ttf;size:20;color:orange;halign:left;",270,25,140,20)
   local HDG_VS_txt              = txt_add("", "font:arimo_bold.ttf;size:20;color:orange;halign:left;",460,55,160,20)
   local TRK_FPA_txt             = txt_add("", "font:arimo_bold.ttf;size:20;color:orange;halign:left;",465,80,160,20)
   local ALT_txt                 = txt_add("", "font:arimo_bold.ttf;size:20;color:orange;halign:left;",645,25,60,20)
   local LVL_CH_txt              = txt_add("", "font:arimo_bold.ttf;size:18;color:orange;halign:left;",736,25,120,20)
   local VS_FPA_txt              = txt_add("", "font:arimo_bold.ttf;size:20;color:orange;halign:left;",840,25,150,20)
   local display_group           = group_add(SPEED_d_txt,LATERAL_d_txt,ALTITUDE_d_txt,VERTSPEED_d_txt,SPD_MACH_txt,HDG_TRK_txt,HDG_VS_txt,TRK_FPA_txt,ALT_txt,LVL_CH_txt,VS_FPA_txt)
   local display2_group          = group_add(SPD_managed_img,HDG_managed_img,ALT_managed_img,brakets_img)
   local knob1_group             = group_add(Speed_base_img,Speed_pushed_img,Speed_img,Speed_pulled_img,HDG_base_img,HDG_pushed_img,HDG_img,HDG_pulled_img)
   local knob2_group             = group_add(ALT_100_img,ALT_1000_img,ALT_pushed_img,ALT_img,ALT_pulled_img,VS_base_img,VS_pushed_img,VS_img,VS_pulled_img)


--INITIALIZE --------------------------------------------------------------------------
  local power             = 0
  local Illumination_mode
  local Speed_inc         = 0.0
  local Heading_inc       = 0.0
  local ALT_inc           = 0.0
  local ALT_inc_step      = 100
  local ALTType           = 0
  local VS_inc            = 0.0
  local mach_mode         = false
   local metric_alt        = 0
  local loc_mode          = false
  local appr_mode         = false
  local FPA_mode_active   = false
  local VS_value          =0
  local altitude_increment = 1000
  local current_heading    = 0
  local pupu_threshold   = 500 -- time in milliseconds to distinguish between push and pull
  local hw_led_intensity   = 0.1

--========================================================================
--  Buttons LOC, AP1, AP2, ATHR, EXPED, APPR
--========================================================================


--========================================================================
-- Buttons LOC, AP1, AP2, ATHR, EXPED, APPR  status lights
--========================================================================
   local LOC_li_img          = img_add("ko2_gn_top_back.png",280,293,65,45)
   local AP1_li_img          = img_add("ko_gn_top_back.png",426,186,65,65)
   local AP2_li_img          = img_add("ko_gn_top_back.png",528,186,65,65)
   local ATHR_li_img         = img_add("ko_gn_top_back.png",478,275,65,65)
   local EXPED_li_img        = img_add("ko2_gn_top_back.png",666, 293,65,45)
   local APPR_li_img         = img_add("ko2_gn_top_back.png",875,293,65,45)
   local LOC_bli_img          = img_add("ko2_wt_bot_back.png",280,293,65,45)
   local AP1_bli_img          = img_add("ko_wt_bot_back.png",426,186,65,64)
   local AP2_bli_img          = img_add("ko_wt_bot_back.png",528,186,65,64)
   local ATHR_bli_img         = img_add("ko_wt_bot_back.png",478,275,65,64)
   local EXPED_bli_img        = img_add("ko2_wt_bot_back.png",666, 293,65,45)
   local APPR_bli_img         = img_add("ko2_wt_bot_back.png",875,293,65,45)
   local LOC_byli_img          = img_add("ko2_or_bot_back.png",280,293,65,45)
   local AP1_byli_img          = img_add("ko_or_bot_back.png",426,186,65,64)
   local AP2_byli_img          = img_add("ko_or_bot_back.png",528,186,65,64)
   local ATHR_byli_img         = img_add("ko_or_bot_back.png",478,275,65,64)
   local EXPED_byli_img        = img_add("ko2_or_bot_back.png",666, 293,65,45)
   local APPR_byli_img         = img_add("ko2_or_bot_back.png",875,293,65,45)
   backlite1_group        = group_add(LOC_li_img,AP1_li_img,AP2_li_img,ATHR_li_img,EXPED_li_img,APPR_li_img)
   backlite2_group        = group_add(LOC_bli_img,AP1_bli_img,AP2_bli_img,ATHR_bli_img,EXPED_bli_img,APPR_bli_img)
   backlite2y_group       = group_add(LOC_byli_img,AP1_byli_img,AP2_byli_img,ATHR_byli_img,EXPED_byli_img,APPR_byli_img)
   visible (backlite1_group, false)
   
    function LOC_p_cb()
        msfs_event("A32NX.FCU_LOC_PUSH")
    end
    LOC_button = button_add("ko2_stripes_loc_but_rel.png","ko2_stripes_loc_but_push.png",280,293,65,45,LOC_p_cb,LOC_r_cb)

    function AP1_p_cb(position)
     msfs_event("A32NX.FCU_AP_1_PUSH")
    end
    AP1_button = button_add("ko_stripes_AP1_but_rel.png","ko_stripes_AP1_but_push.png",426,186,65,65,AP1_p_cb,AP1_r_cb)

    function AP2_p_cb()
      msfs_event("A32NX.FCU_AP_2_PUSH")
    end
    AP2_button = button_add("ko_stripes_AP2_but_rel.png","ko_stripes_AP2_but_push.png",528,186,65,65,AP2_p_cb,AP2_r_cb)

    function ATHR_p_cb(position)
    msfs_event("A32NX.FCU_ATHR_PUSH",position)
    end
    ATHR_button = button_add("ko_stripes_Athr_but_rel.png","ko_stripes_Athr_but_push.png",478,275,65,65,ATHR_p_cb,ATHR_r_cb)

    function EXPED_p_cb()
        msfs_event("A32NX.FCU_EXPED_PUSH")
    end
    EXPED_button = button_add("ko2_stripes_exped_but_rel.png","ko2_stripes_exped_but_push.png",666, 293,65,45,EXPED_p_cb,EXPED_r_cb)

    function APPR_p_cb(position)
        msfs_event("A32NX.FCU_APPR_PUSH")
    end
    APPR_button = button_add("ko2_stripes_appr_but_rel.png", "ko2_stripes_appr_but_push.png",875,293,65,45,APPR_p_cb,APPR_r_cb)

    function METRIC_p_cb()
        msfs_rpn(math.abs( metric_alt -1).." (>L:A32NX_METRIC_ALT_TOGGLE, enum)")
    end
    METRIC_button = button_add("SPDMACH.png", "SPDMACH_p.png",778, 122, 45, 45, METRIC_p_cb)



  function LOC_li_cb (var_stable, var_dev)
--     if FBW_A32NX_Version=="Development" then
       visible(LOC_li_img,var_dev == 1)
--     else
--      visible(LOC_li_img,var_stable == 1)
    -- end 
  end
  msfs_variable_subscribe("L:A32NX_FCU_LOC_MODE_ACTIVE","enum","L:A32NX_FCU_LOC_LIGHT_ON","enum",LOC_li_cb)

   function APPR_li_cb (var_stable, var_dev)
--    if FBW_A32NX_Version=="Development" then
       visible(APPR_li_img,var_dev == 1)
--     else
--      visible(APPR_li_img,var_stable == 1)
    -- end
  end
  msfs_variable_subscribe("L:A32NX_FCU_APPR_MODE_ACTIVE","enum","L:A32NX_FCU_APPR_LIGHT_ON","enum",APPR_li_cb)

   function AP1_li_cb (light_on)
      visible(AP1_li_img,light_on == 1)
  end
 msfs_variable_subscribe("L:A32NX_AUTOPILOT_1_ACTIVE","enum", AP1_li_cb)

  function AP2_li_cb (light_on)
      visible(AP2_li_img,light_on == 1)
  end
  msfs_variable_subscribe("L:A32NX_AUTOPILOT_2_ACTIVE","enum", AP2_li_cb)

  function ATHR_li_cb (light_on)
      visible(ATHR_li_img,light_on >= 1)
  end
  msfs_variable_subscribe("L:A32NX_AUTOTHRUST_STATUS","enum",ATHR_li_cb)

  function EXPED_li_cb (light_on)
      visible(EXPED_li_img,light_on == 1)
  end
msfs_variable_subscribe("L:A32NX_FMA_EXPEDITE_MODE","enum",EXPED_li_cb)

   function METRIC_ALT_CB_cb (metric)
        metric_alt   = metric
  end

msfs_variable_subscribe("L:A32NX_METRIC_ALT_TOGGLE","enum",METRIC_ALT_CB_cb)


--SPEED-------------------------------------------------


function mcp_spd_chg(spd_knot, spd_mach, in_Mach, managed, dashes)
    if managed ==1   then
         visible (SPD_managed_img, true)
    else
         visible (SPD_managed_img, false)
    end

    if dashes == 1 then
        txt_set(SPEED_d_txt,"---")
    else
        if in_Mach then
            speed_bug = string.format("%01.2f", spd_knot)

        else
            speed_bug = string.format("%03.0f",var_round(spd_knot,0))
        end
        txt_set(SPEED_d_txt, speed_bug)    end

        if in_Mach then
            txt_set(SPD_MACH_txt, "          MACH")
        else
            txt_set(SPD_MACH_txt, "SPD")

        end

end
msfs_variable_subscribe("L:A32NX_AUTOPILOT_SPEED_SELECTED", "Knots",
                "AUTOPILOT MACH HOLD VAR", "Number",
                "AUTOPILOT MANAGED SPEED IN MACH" ,"Bool",
                "L:A32NX_FCU_SPD_MANAGED_DOT", "enum",
                "L:A32NX_FCU_SPD_MANAGED_DASHES", "enum",
                mcp_spd_chg)

--Speed Knob---
  function turn_Speed_cb (direction)

    if mach_mode == true then
        spd_event="AP_MACH_VAR_"
    else
        spd_event="AP_SPD_VAR_"
    end

    if direction > 0 then
        Speed_inc = Speed_inc + 2
        img_rotate(Speed_img, Speed_inc)
         msfs_event("A32NX.FCU_SPD_INC")
    else
        Speed_inc = Speed_inc  - 2
        img_rotate(Speed_img, Speed_inc)
       msfs_event("A32NX.FCU_SPD_DEC")

    end
  end
  dial_speed = dial_add( nil, 109, 155, 90, 90, 3, turn_Speed_cb)


--Speed Button ------
function SPDpush_timer_cb()
    visible(Speed_img, true)
    visible(Speed_pushed_img, false)
    visible(Speed_pulled_img, false)
end

function timer_SPD_cb()
    --if the  timer has not been cancelled, trigger the long push event
    visible(Speed_img, false)
    visible(Speed_pushed_img, false)
    visible(Speed_pulled_img, true)
    msfs_event("A32NX.FCU_SPD_PULL")
    SPDpush_timer = timer_start(pupu_threshold, SPDpush_timer_cb)
end


function SPDpush_p_cb()
    timer_SPD = timer_start(500, timer_SPD_cb)
end

function SPDpush_r_cb()
    if  timer_running (timer_SPD) then  -- if the timer is still running, then it is a short push
        timer_stop(timer_SPD)
        SPDpush_timer = timer_start(pupu_threshold, SPDpush_timer_cb)
        visible(Speed_img,false)
        visible(Speed_pushed_img,true)
        visible(Speed_pulled_img,false)
        msfs_event("A32NX.FCU_SPD_PUSH")
     end
end
 SPDpush_button = button_add(Nil, Nil,  124, 170, 60, 60, SPDpush_p_cb, SPDpush_r_cb)
 mouse_setting(SPDpush_button, "CURSOR", "grab_cursor.png")

   function SpeedPull_p_cb()
    visible(Speed_img, false)
    visible(Speed_pushed_img, false)
    visible(Speed_pulled_img, true)
    msfs_event("A32NX.FCU_SPD_PULL")

   end
   function SpeedPull_r_cb()
    visible(Speed_img, true)
    visible(Speed_pushed_img, false)
    visible(Speed_pulled_img, false)

   end
   SpeedPull_button = button_add(nil, nil,100,260,110,33,SpeedPull_p_cb,SpeedPull_r_cb)
   mouse_setting(SpeedPull_button,"CURSOR","grab_cursor.png")

--HEADING ------------------------------------------------

--Heading Display---

function mcp_hdg_chg(mcp_hdg, managed, dashes)


    if managed == 1 then
        visible (HDG_managed_img, true)
    else
        visible (HDG_managed_img, false)
    end
    if dashes == 1 then
        txt_set(LATERAL_d_txt,"---")
    else
        txt_set(LATERAL_d_txt,string.format("%03.0f", mcp_hdg))
    end
 end
msfs_variable_subscribe("L:A32NX_AUTOPILOT_HEADING_SELECTED", "number",
                          "L:A32NX_FCU_HDG_MANAGED_DOT", "enum",
                          "L:A32NX_FCU_HDG_MANAGED_DASHES", "enum",
                          mcp_hdg_chg)


--Heading Knob---
function turn_Heading_cb (direction)
    if direction > 0 then
        Heading_inc = Heading_inc + 2
        img_rotate(HDG_img, Heading_inc)
    msfs_event("A32NX.FCU_HDG_INC")

    else
         Heading_inc = Heading_inc - 2
         img_rotate(HDG_img, Heading_inc)
         msfs_event("A32NX.FCU_HDG_DEC")
    end
 end
 dial_heading = dial_add(Nil, 267, 155, 90, 90, 3, turn_Heading_cb)

--Heading Push Button
function HDGpush_timer_cb()
    visible(HDG_img, true)
    visible(HDG_pushed_img, false)
    visible(HDG_pulled_img, false)
end

function timer_hdg_cb()
    --if the  timer has not been cancelled, trigger the long push event
    visible(HDG_img, false)
    visible(HDG_pushed_img, false)
    visible(HDG_pulled_img, true)
    msfs_event("A32NX.FCU_HDG_PULL")
    HDGpush_timer = timer_start(pupu_threshold, HDGpush_timer_cb)

end


function HDGpush_p_cb()
    timer_hdg = timer_start(500, timer_hdg_cb)
end

function HDGpush_r_cb()
    if  timer_running (timer_hdg) then  -- if the timer is still running, then it is a short push
        timer_stop(timer_hdg)
        HDGpush_timer = timer_start(pupu_threshold, HDGpush_timer_cb)
        visible(HDG_img, false)
        visible(HDG_pushed_img, true)
        visible(HDG_pulled_img, false)
    msfs_event("A32NX.FCU_HDG_PUSH")
    end
end

HDGpush_button = button_add(Nil, Nil,  282, 170, 60, 60, HDGpush_p_cb, HDGpush_r_cb)
mouse_setting(HDGpush_button, "CURSOR", "grab_cursor.png")

   function HDGPull_p_cb()
    visible(HDG_img, false)
    visible(HDG_pushed_img, false)
    visible(HDG_pulled_img, true)
    msfs_event("A32NX.FCU_HDG_PULL")

   end

   function HDGPull_r_cb()
    visible(HDG_img, true)
    visible(HDG_pushed_img, false)
    visible(HDG_pulled_img, false)

   end
   HDGPull_button = button_add(nil, nil,255,260,110,27,HDGPull_p_cb,HDGPull_r_cb)
   mouse_setting(HDGPull_button,"CURSOR","grab_cursor.png")


--ALTITUDE-----------------------------------------------------
--Altitude Display---
function mcp_alt_chg (alt_value, managed)
    txt_set(ALTITUDE_d_txt,string.format("%05.0f",alt_value))
    if managed == 1 then
        visible (ALT_managed_img, true)
    else
        visible (ALT_managed_img, false)
    end

    end
msfs_variable_subscribe("AUTOPILOT ALTITUDE LOCK VAR:3", "Feet",
              "L:A32NX_FCU_ALT_MANAGED", "enum",
            mcp_alt_chg)


-- Altitude increment knob
  function turn_alt_inc_cb(direction)
--   if FBW_A32NX_Version == "Stable" then
--     if direction == 1 then
--          msfs_rpn("1000 (>L:XMLVAR_Autopilot_Altitude_Increment, Number)")
--     else
--          msfs_rpn("100 (>L:XMLVAR_Autopilot_Altitude_Increment, Number)")
--     end
--   else 
    if direction == 1 then
         msfs_rpn("(>B:AUTOPILOT_Altitude_Increment_THOUSAND)")
    else
         msfs_rpn("(>B:AUTOPILOT_Altitude_Increment_HUNDRED)")
    end
  -- end    
 
 end

function ALTType_p_cb()
--     if FBW_A32NX_Version == "Stable" then
--         if ALT_inc_step == 100 then
--              msfs_rpn("1000 (>L:XMLVAR_Autopilot_Altitude_Increment, Number)")
--         else
--              msfs_rpn("100 (>L:XMLVAR_Autopilot_Altitude_Increment, Number)")
--         end
--     else   
        msfs_rpn("(>B:AUTOPILOT_Altitude_Increment_Toggle)") 
    -- end     
            
        
    end
   ALTType_button = button_add(nil, nil,650,120,110,35,ALTType_p_cb)
   mouse_setting(ALTType_button , "CURSOR", "right_left_icon.png")

  if user_prop_get(prop_knobster) then dial_alt_inc = dial_add(nil, 660, 155, 90, 90,  turn_alt_inc_cb)  end

function altitude_increment_cb(val_stable,val_dev)
      altitude_increment = val_stable
      ALT_inc_step       = val_stable
          if val_dev == 1 -- and FBW_A32NX_Version == "Development")  
         -- or (val_stable == 1000 and FBW_A32NX_Version == "Stable")
           then
             visible(ALT_100_img, false)
             visible(ALT_1000_img, true)
         else
            visible(ALT_100_img, true)
            visible(ALT_1000_img, false)
         end

 end

 msfs_variable_subscribe("L:XMLVAR_Autopilot_Altitude_Increment", "Number","L:A32NX_FCU_ALT_INCREMENT_1000", "Number", altitude_increment_cb)


--Altitude Knob---
function turn_Altitude_cb (direction)
    if direction > 0 then
        ALT_inc =  ALT_inc + 2
        img_rotate(ALT_img, ALT_inc)
        msfs_event("A32NX.FCU_ALT_INC",0)
    else
        ALT_inc =  ALT_inc - 2
        img_rotate(ALT_img, ALT_inc)
        msfs_event("A32NX.FCU_ALT_DEC",0)
    end
end
dial_alt = dial_add(nil, 675, 170, 60, 60, turn_Altitude_cb)

--Altitude Push-Pull button

function ALTpush_timer_cb()
    visible(ALT_img, true)
    visible(ALT_pushed_img, false)
    visible(ALT_pulled_img, false)
end

function timer_ALT_cb()
    --if the  timer has not been cancelled, trigger the long push event
    visible(ALT_img, false)
    visible(ALT_pushed_img, false)
    visible(ALT_pulled_img, true)
    msfs_event("A32NX.FCU_ALT_PULL")
    ALTpush_timer = timer_start(pupu_threshold, ALTpush_timer_cb)
end


function ALTpush_p_cb()
    timer_ALT = timer_start(500, timer_ALT_cb)
end

function ALTpush_r_cb()
    if  timer_running (timer_ALT) then  -- if the timer is still running, then it is a short push
        timer_stop(timer_ALT)
        ALTpush_timer = timer_start(pupu_threshold, ALTpush_timer_cb)
        visible(ALT_img, false)
        visible(ALT_pushed_img, true)
        visible(ALT_pulled_img, false)
        msfs_event("A32NX.FCU_ALT_PUSH")
    end
end

 ALTpush_button = button_add(Nil, Nil,  685, 180, 40, 40, ALTpush_p_cb, ALTpush_r_cb)
 mouse_setting(ALTpush_button, "CURSOR", "grab_cursor.png")

   function ALTPull_p_cb()
        visible(ALT_img, false)
        visible(ALT_pushed_img, false)
        visible(ALT_pulled_img, true)
        msfs_event("A32NX.FCU_ALT_PULL")
   end

   function ALTPull_r_cb()
        visible(ALT_img, true)
        visible(ALT_pushed_img, false)
        visible(ALT_pulled_img, false)
   end
   ALTPull_button = button_add(nil, nil,650,260,110,27,ALTPull_p_cb,ALTPull_r_cb)
   mouse_setting(ALTPull_button,"CURSOR","grab_cursor.png")


--VERTICAL SPEED------------------------------------------------
--VS Display---
function mcp_vvi_chg(mcp_vvi, mcp_fpa, fpa_active, managed)
    FPA_mode_active = fpa_active
    if fpa_active == 0 then
        if managed == 1 then
            txt_set(VERTSPEED_d_txt,"-----")
        else
            txt_set(VERTSPEED_d_txt,string.format("%+04.0f",mcp_vvi))
        end
      txt_set(HDG_TRK_txt, "HDG         LAT"); txt_set(HDG_VS_txt,  "HDG     V/S")
      txt_set(TRK_FPA_txt,""); txt_set(VS_FPA_txt,  "V/S")
    else
       txt_set(HDG_TRK_txt, "       TRK  LAT"); txt_set(HDG_VS_txt,"")
       txt_set(TRK_FPA_txt, "TRK     FPA"); txt_set(VS_FPA_txt,  "           FPA")
        if managed == 1 then
            txt_set(VERTSPEED_d_txt,"-----")
        else
             txt_set(VERTSPEED_d_txt,string.format("%+01.1f",mcp_fpa))
       end
    end

end

msfs_variable_subscribe(
              "L:A32NX_AUTOPILOT_VS_SELECTED", "Feet/minute",
              "L:A32NX_AUTOPILOT_FPA_SELECTED", "Feet/minute",
             "L:A32NX_TRK_FPA_MODE_ACTIVE", "enum",
              "L:A32NX_FCU_VS_MANAGED", "enum",
                         mcp_vvi_chg)

--VS Knob---

function turn_VS_cb (direction)
    if direction > 0 then
        img_rotate(VS_img, VS_inc)
        VS_inc = VS_inc + 2

        if FPA_mode_active == 1 then
            msfs_event("H:A320_Neo_FCU_VS_INC_FPA")
        else
            --msfs_event("H:A320_Neo_FCU_VS_INC_VS")
            msfs_event("A32NX.FCU_VS_INC")
        end
    else
        img_rotate(VS_img, VS_inc)
        VS_inc = VS_inc - 2
        if FPA_mode_active ==1 then
            msfs_event("H:A320_Neo_FCU_VS_DEC_FPA")
        else
            --msfs_event("H:A320_Neo_FCU_VS_DEC_VS")
            msfs_event("A32NX.FCU_VS_DEC")
        end
    end
end
dial_VS = dial_add(Nil, 860, 155, 90, 90, 1, turn_VS_cb)

--VS Push-Pull button

function VSpush_timer_cb()
    visible(VS_img, true)
    visible(VS_pushed_img, false)
    visible(VS_pulled_img, false)
end

function timer_VS_cb()
    --if the  timer has not been cancelled, trigger the long push (PULL) event
    visible(VS_img, false)
    visible(VS_pushed_img, false)
    visible(VS_pulled_img, true)
    msfs_event("A32NX.FCU_VS_PULL")
    VSpush_timer = timer_start(pupu_threshold, VSpush_timer_cb)
end


function VSpush_p_cb()
    timer_VS = timer_start(500, timer_VS_cb)
end

function VSpush_r_cb()
    if  timer_running (timer_VS) then  -- if the timer is still running, then it is a short push
        timer_stop(timer_VS)
        VSpush_timer = timer_start(pupu_threshold, VSpush_timer_cb)
        visible(VS_img, false)
        visible(VS_pushed_img, true)
        visible(VS_pulled_img, false)
        msfs_event("A32NX.FCU_VS_PUSH")
    end
end

 VSpush_button = button_add(Nil, Nil,  885, 180, 40, 40, VSpush_p_cb, VSpush_r_cb)
 mouse_setting(VSpush_button, "CURSOR", "grab_cursor.png")

function VSPull_p_cb()
    visible(VS_img, false)
    visible(VS_pushed_img, false)
    visible(VS_pulled_img, true)
    msfs_event("A32NX.FCU_VS_PULL")
end

function VSPull_r_cb()
    visible(VS_img, true)
    visible(VS_pushed_img, false)
    visible(VS_pulled_img, false)
end
VSPull_button = button_add(nil,nil,850,260,110,27,VSPull_p_cb,VSPull_r_cb)
mouse_setting(VSPull_button,"CURSOR","grab_cursor.png")

--================================================================
-- 1.0 Speed/Mach
--================================================================
  function SPDMACH_p_cb()
    msfs_event("A32NX.FCU_SPD_MACH_TOGGLE_PUSH")
  end
   SPDMACH_button = button_add("SPDMACH.png", "SPDMACH_p.png",28, 122, 45, 45, SPDMACH_p_cb)


--=============================================================
-- 1.5 HDG,TRK/VS,FPA
--=============================================================

 function HDGVS_p_cb()
    msfs_rpn(math.abs(FPA_mode_active -1).." (>L:A32NX_TRK_FPA_MODE_ACTIVE, enum)")
 end

 HDGVS_button = button_add("SPDMACH.png", "SPDMACH_p.png",489, 122, 45, 45, HDGVS_p_cb)





-- ========================================================================
-- 11. Illumination Mode
   function Illumination_mode_cb(Illumination_mode_val)
     Illumination_mode = Illumination_mode_val
     var1  = var_cap(Illumination_mode_val[5] * 0.031 + 0.3, 0.3, 1.0); var1y = var_cap(Illumination_mode_val[5] * 0.25 - 5.75, 0.0, 1.0)
     if Illumination_mode_val[1] == 1.0  then
       opacity(night_overlay_img, 1 - Illumination_mode_val[6] * 0.037)
       opacity(knob1_group, var_cap(Illumination_mode_val[6] * 0.037,0.5,1.0))
       opacity(knob2_group, var_cap(Illumination_mode_val[6] * 0.037,0.5,1.0))
       opacity(text_overlay_img, var1); opacity(text_overlay_y_img, var1y)
       opacity(backlite1_group, var1);  opacity(backlite2_group, var1);  opacity(backlite2y_group, var1y )
       opacity(display_group, var1); opacity(display2_group, var1)
     else
        opacity(night_overlay_img,0.0); opacity(text_overlay_img,1.0); opacity(text_overlay_y_img,0.0)
        opacity(backlite1_group,1.0); opacity(backlite2_group,1.0); opacity(backlite2y_group,0.0)
        opacity(display_group,1.0); opacity(display2_group,1.0)
     end
     
    
     if power == 0 then
        opacity(backlite1_group,0);opacity(backlite2y_group,0);opacity(display_group,0)
     end
   end
   si_variable_subscribe("Illumination_mode","FLOAT[10]", Illumination_mode_cb)

-- ========================================================================

--=============================================================
  --Power management----------------------------------------------------
--=============================================================
   function power_cb (powered)
      power = powered
      if Illumination_mode ~= nil then Illumination_mode_cb(Illumination_mode) end
  end
 msfs_variable_subscribe( "L:A32NX_ELEC_DC_ESS_SHED_BUS_IS_POWERED","enum", power_cb)




