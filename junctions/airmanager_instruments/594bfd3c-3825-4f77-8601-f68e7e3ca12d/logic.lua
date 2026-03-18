--[[
    Title:           EFIS Captain for FlyByWire Airbus A320 (Air Manager instrument)
    Author:          Yves Levesque adapted for MSFS 2020
    Contributors:    Alexander Hildmann created for FlightFactor A320 on Xplane
   IMPORTANT:       To use "Illumination mode", Illumination Pedestal Captain instrument is needed.
                    - Push/Pull implementation:
                      If you press and instantly release the button its considered a push, if you press and hold a bit
                      longer (timeframe is defined in variable pupu_threshold = 500 ms) its considered to be a pull.
                      An addition pull button was added below so you have the choice what to use.
                      Additional buttons can be used for pull if you dont like the pull timer way.
    Changes:          2021-11-24. Changes variables for the new FBW Custom FMS. Thanks to Herbert Puukka
                      2021-12-15   v 2.1   Add Illunination Mode
                      2022-02-19: Correct Power and Illumination
                      2023-02-12  YL  Change msfs_variable_write to msfs_rpn()
                      2023-11-04  YL add dials panel hardware support
                      2024-12-19  YL correct many buttons and dials.
                      2024-12-20  YL restructure Baro management
                      2024-12-21  YL  v3.0 Adapt to MSFS2024
                      2025-01-02  YL  Add stable/development version support
                      2025-06-06  YL v3.0.3 Correct for A32NX Stable version v13.0
 ======================================================================= --]]
   
local prop_knobster = user_prop_add_boolean("Knobster",true,"Knobster used?")
local prop_hardware = user_prop_add_boolean("Hardware",false,"Hardware used?")

--local FBW_A32NX_Version ="xx";
--si_variable_subscribe( "FBW_A32NX_Version", "STRING", function(val) print ("si: "..val); if val== "Development" then FBW_A32NX_Version = val else FBW_A32NX_Version = "Stable" end end)

---- IMAGES & TEXT -------------------------------------------------    
   local backplate_img           = img_add_fullscreen("efis_panel.png") -- (620,360)
   local night_overlay_img       = img_add_fullscreen("efis_panel_night.png")
   local text_overlay_img        = img_add_fullscreen("efis_panel_text.png")
   local text_overlay_y_img      = img_add_fullscreen("efis_panel_text_yellow.png")

   local NavMode_knob_base_img  = img_add ("efis_knob_base.png", 273,160,90,90)
   local NavMode_knob_img       = img_add ("efis_knob.png",      295,165,35,75)
   local Range_knob_Base_img    = img_add ("efis_knob_base.png", 468,160,90,90)
   local Range_knob_img         = img_add ("efis_knob.png",      492,165,35,75)
   local inHg_img               = img_add ("inHg.png",            64,175,90,90)
   local hPa_img                = img_add ("hPa.png",             64,175,90,90)
   local StdPull_img            = img_add ("StdPull.png",         61,170,100,100)
   local StdPull_pushed_img     = img_add ("StdPull_pushed.png",  61,170,100,100)
   local StdPull_pulled_img     = img_add ("StdPull_pulled.png",  61,170,100,100)
   local QNH_txt                = txt_add("", "font:arimo_bold.ttf; size:18; color:orange; halign:left;",58,77,150,20)
   local BARO_val_txt           = txt_add("", "font:wwDigital.ttf; size:55; color:orange; halign:left;",52,87,150,50)
   local StdPull_group          = group_add(StdPull_img,StdPull_pushed_img,StdPull_pulled_img)
   visible(StdPull_group,false);  visible(StdPull_img,true)
   local knob_group             = group_add(NavMode_knob_base_img,NavMode_knob_img,Range_knob_Base_img,Range_knob_img)
   local display_group          = group_add(QNH_txt,BARO_val_txt)
    

--Initialize--------------------------------------------------------------------------  
  local BaroSTD              = false
  local BaroModeval          = 0
  local BaroModStd           = 0
  local BaroType             = 0
  local BaroHg               = true
  local NavRangeswpos        = 0.0
  local EFIS_Baroval_inc     = 0
  local StdPull_img_degree   = 0
  local pupu_threshold       = 500 -- time in milliseconds to distinguish between push and pull
  local option               = 0
  local power             = 0
  local Illumination_mode
  
  visible(StdPull_img, true) 
  visible(StdPull_pushed_img, false)
  visible(StdPull_pulled_img, false) 



  
--=================================================================== 
-- 1.1 Baro display
--===================================================================     
function read_baroval_cb (value,valueMode, mode, KohlMB, KohlHG, baroMode, HPASelector)
    if FBW_A32NX_Version =="Stable" then
--         if baroMode == 2 then
--              txt_set(BARO_val_txt, " Std")
--              txt_set(QNH_txt, "")
--              BaroSTD = true
--         else 
             BaroSTD=false
            BaroModeval = baroMode
            if HPASelector == 0 then
                txt_set(BARO_val_txt, string.format("%05.02f",KohlHG)   )  
                visible(inHg_img, true)
                visible(hPa_img, false)
            else
                txt_set(BARO_val_txt, string.format("%04.00f",var_round(KohlMB,0)))  
                visible(inHg_img, false)
                visible(hPa_img,true)
            end
            BaroType = HPASelector
            if baroMode      == 0 then
                txt_set(QNH_txt, "QFE")
            else
                txt_set(QNH_txt, "                QNH")
            end
            
--        end  
    
    else -- Version Development
        if valueMode == 0 then
            txt_set(BARO_val_txt, " Std")
        elseif valueMode == 1 then
            txt_set(BARO_val_txt, string.format("%04.00f",value)) 
            visible(inHg_img, false)
            visible(hPa_img, true)
        elseif valueMode == 2 then
            txt_set(BARO_val_txt, string.format("%05.02f",value))
            visible(inHg_img, true)
            visible(hPa_img, false)
        end 
        
        if mode == 2 then
            txt_set(QNH_txt, "QFE")
        elseif mode == 1 then
            txt_set(QNH_txt, "                QNH")
        else    
            txt_set(QNH_txt, "")
        end
    end    
end
msfs_variable_subscribe(  "L:A32NX_FCU_EFIS_L_DISPLAY_BARO_VALUE", "num", 
                           "L:A32NX_FCU_EFIS_L_DISPLAY_BARO_VALUE_MODE", "num",                  
                           "L:A32NX_FCU_EFIS_L_DISPLAY_BARO_MODE", "enum",
                            "KOHLSMAN SETTING MB:1", "Millibars",
                            "KOHLSMAN SETTING HG:1", "inHg",
                            "L:XMLVAR_Baro1_Mode", "enum",
                            "L:XMLVAR_Baro_Selector_HPA_1", "enum",
                           read_baroval_cb)   
                     
--===================================================================  
-- 1.0 Barotype inHg or hPa 
--===================================================================   
 
  
function BaroTypeDial_cb(direction)
print(direction)
--     if FBW_A32NX_Version =="Stable" then
--        if direction == 1 then
--             msfs_rpn("1 (>L:XMLVAR_Baro_SELECTOR_HPA_1, enum)")
--         else
--             msfs_rpn("0 (>L:XMLVAR_Baro_SELECTOR_HPA_1, enum)")
--         end 
--     else
        if direction == 1 then
            msfs_rpn("0 (>L:A32NX_FCU_EFIS_L_BARO_IS_INHG, enum)")
        else
            msfs_rpn("1 (>L:A32NX_FCU_EFIS_L_BARO_IS_INHG, enum)")
        end 
--    end
end
--- to use the outer dial with the knobster to turn
if user_prop_get(prop_knobster) then BaroTypeL_dial = dial_add(nil,45,182,130,75,  BaroTypeDial_cb) end
function BaroTypeL_but_p_cb()
--    if FBW_A32NX_Version =="Stable" then
--      if  BaroType == 0 then  BaroType = 1 else BaroType = 0 end
--      msfs_rpn(BaroType.." (>L:XMLVAR_Baro_SELECTOR_HPA_1, enum)")
--   else
      msfs_rpn("(L:A32NX_FCU_EFIS_L_BARO_IS_INHG, bool) ! (>L:A32NX_FCU_EFIS_L_BARO_IS_INHG)")
--   end
end
 
BaroTypeL_button = button_add(nil,nil,45,150,130,30,BaroTypeL_but_p_cb)
mouse_setting(BaroTypeL_button,"CURSOR","right_left_icon.png")

--=============================================
-- 1.3 Set Baro value
--============================================= 
   function setBaroMode ()

    if BaroSTD == true then
         msfs_rpn("2 (>L:XMLVAR_Baro1_Mode, enum)")
    else    
        
        if BaroModeval      == 1 then
            msfs_rpn("1 (>L:XMLVAR_Baro1_Mode, enum)")
        else
            msfs_rpn("0 (>L:XMLVAR_Baro1_Mode, enum)")
        end
    end  
    
  end 
function turn_baroval_cb (dir)
    if dir > 0 then
      --if FBW_A32NX_Version =="Stable" then msfs_event("KOHLSMAN_INC")  else 
      msfs_event("A32NX.FCU_EFIS_L_BARO_INC")
       --end
      StdPull_img_degree = StdPull_img_degree +3
      img_rotate(StdPull_img, StdPull_img_degree)
    else
     -- if FBW_A32NX_Version =="Stable" then msfs_event("KOHLSMAN_DEC")  else 
      msfs_event("A32NX.FCU_EFIS_L_BARO_DEC") 
      --end
      StdPull_img_degree = StdPull_img_degree -3
      img_rotate(StdPull_img, StdPull_img_degree)
    end
end
dial_id1 = dial_add( nil, 85, 190, 60, 60, 4, turn_baroval_cb)
  
function BARO_timer_cb()
   --if the  timer has not been cancelled, it is a long push equivalent to a pull.
    --if FBW_A32NX_Version =="Stable" then BaroSTD = true setBaroMode() else
     msfs_event("A32NX.FCU_EFIS_L_BARO_PULL")
     -- end
    visible(StdPull_group,false); visible(StdPull_pulled_img,true)
   end

function Baropush_p_cb()
--when push, start the timer
    BARO_timer = timer_start(pupu_threshold, BARO_timer_cb)
end
  
function Baropush_r_cb()
--if the timer is running, it is a short push
    if  timer_running (BARO_timer) then
        timer_stop(BARO_timer)
        
--         if FBW_A32NX_Version =="Stable" then   
--             if BaroSTD == false then
--                 BaroModeval = math.abs(BaroModeval-1)
--             else
--                 BaroSTD = false
--             end
--             setBaroMode()
--        else
         msfs_event("A32NX.FCU_EFIS_L_BARO_PUSH")
--        end 
         
         visible(StdPull_group,false);visible(StdPull_pushed_img,true)
    end
    timer_start(500, BARO_501_cb)
end
Baropush_button = button_add(Nil, Nil,  95, 205, 30, 30, Baropush_p_cb, Baropush_r_cb)
mouse_setting(Baropush_button , "CURSOR", "hand_cursor.png")  

function BARO_501_cb() 
    visible(StdPull_group,false);visible(StdPull_img,true)
end


-- Additional choice to pull ------
function BaroPull_add_p_cb()
    --if FBW_A32NX_Version =="Stable" then BaroSTD = true setBaroMode() else 
    msfs_event("A32NX.FCU_EFIS_L_BARO_PULL") 
  --  end
    visible(StdPull_group,false);
    visible(StdPull_pulled_img,true)
end
   
function BaroPull_add_r_cb() visible(StdPull_group,false);visible(StdPull_img,true) end
   
   
BaroPull_add_button = button_add(nil,nil,45,260,130,24,BaroPull_add_p_cb,BaroPull_add_r_cb)
mouse_setting(BaroPull_add_button,"CURSOR","grab_cursor.png")

         
--============================================================================                   
-- 1.4 Navmode and Navrange
--============================================================================
function NavModeL_cb (val1,val2)
    --if FBW_A32NX_Version =="Stable" then NavModeL_var = val1 else 
    NavModeL_var = val2 
    --end 
     rotate (NavMode_knob_img, (NavModeL_var * 45) -90, "LINEAR" ,0.05)
    NavModeswpos=NavModeL_var
end
msfs_variable_subscribe("L:A32NX_EFIS_L_ND_MODE", "enum","L:A32NX_FCU_EFIS_L_EFIS_MODE", "enum",NavModeL_cb)


   
function NavModeL_turn_cb (dir)
       if dir == 1 then   -- turned dial clockwise towards ON
      NavModeswpos = NavModeswpos + 1.0
--         if FBW_A32NX_Version =="Stable" then
--             msfs_rpn("(L:A32NX_EFIS_L_ND_MODE, ENUM) 1 + 4 min (>L:A32NX_EFIS_L_ND_MODE)")  
--         else
            msfs_rpn("(L:A32NX_FCU_EFIS_L_EFIS_MODE, ENUM) 1 + 4 min (>L:A32NX_FCU_EFIS_L_EFIS_MODE)")  
        -- end
    else
      NavModeswpos = NavModeswpos - 1.0
      NavModeswpos = NavModeswpos + 1.0
--         if FBW_A32NX_Version =="Stable" then
--             msfs_rpn("(L:A32NX_EFIS_L_ND_MODE, ENUM)  1 - 0 max (>L:A32NX_EFIS_L_ND_MODE)")  
--         else
            msfs_rpn("(L:A32NX_FCU_EFIS_L_EFIS_MODE, ENUM)  1 - 0 max (>L:A32NX_FCU_EFIS_L_EFIS_MODE)")  
        -- end
    end 
        
    if  NavModeswpos <0 then NavModeswpos = 0 end
    if  NavModeswpos > 4 then NavModeswpos = 4 end
       
end   
NavModeL_dial = dial_add( nil, 270, 160, 86, 86, NavModeL_turn_cb)
  
function NavRangeL_cb (val1,val2) 
    --if FBW_A32NX_Version =="Stable" then NavRangeL_var = val1 else
      NavRangeL_var = val2 
      --end 
    rotate (Range_knob_img, (NavRangeL_var * 45) -90, "LINEAR" ,0.05)
    NavRangeswpos = NavRangeL_var
end
msfs_variable_subscribe("L:A32NX_EFIS_L_ND_RANGE", "enum","L:A32NX_FCU_EFIS_L_EFIS_RANGE", "enum",NavRangeL_cb)
 
function NavRangeL_turn_cb (dir1)
    if dir1 == 1 then   -- turned dial clockwise towards ON
      NavRangeswpos = NavRangeswpos + 1
     else
      NavRangeswpos = NavRangeswpos - 1
    end  
    if  NavRangeswpos <0 then NavRangeswpos = 0 end
    if  NavRangeswpos > 5 then NavRangeswpos = 5 end
--     if FBW_A32NX_Version =="Stable" then msfs_rpn(NavRangeswpos.." (>L:A32NX_EFIS_L_ND_RANGE, enum)")
--     else    
      msfs_rpn(NavRangeswpos.." (>L:A32NX_FCU_EFIS_L_EFIS_RANGE, enum)")
    -- end
end    
NavRangeL_dial = dial_add( nil, 466, 160, 86, 86, NavRangeL_turn_cb)

 
    
--=============================================================================
-- 1.7 EFIS button lights
--============================================================================= 
CSTR_li_img   = img_add("ko2_gn_top_back.png",222,45,65,45)
WPT_li_img    = img_add("ko2_gn_top_back.png",297,45,65,45)
VORD_li_img   = img_add("ko2_gn_top_back.png",372,45,65,45)
NDB_li_img    = img_add("ko2_gn_top_back.png",447,45,65,45)
ARPT_li_img   = img_add("ko2_gn_top_back.png", 521,45,65,45)
FD_li_img     = img_add("ko2_gn_top_back.png",35,290,65,45)
LS_li_img     = img_add("ko2_gn_top_back.png",115,290,65,45)
CSTR_bli_img   = img_add("ko2_wt_bot_back.png",222,45,65,45)
WPT_bli_img    = img_add("ko2_wt_bot_back.png",297,45,65,45)
VORD_bli_img   = img_add("ko2_wt_bot_back.png",372,45,65,45)
NDB_bli_img    = img_add("ko2_wt_bot_back.png",447,45,65,45)
ARPT_bli_img   = img_add("ko2_wt_bot_back.png", 521,45,65,45)
FD_bli_img     = img_add("ko2_wt_bot_back.png",35,290,65,45)
LS_bli_img     = img_add("ko2_wt_bot_back.png",115,290,65,45)
CSTR_byli_img   = img_add("ko2_or_bot_back.png",222,45,65,45)
WPT_byli_img    = img_add("ko2_or_bot_back.png",297,45,65,45)
VORD_byli_img   = img_add("ko2_or_bot_back.png",372,45,65,45)
NDB_byli_img    = img_add("ko2_or_bot_back.png",447,45,65,45)
ARPT_byli_img   = img_add("ko2_or_bot_back.png", 521,45,65,45)
FD_byli_img     = img_add("ko2_or_bot_back.png",35,290,65,45)
LS_byli_img     = img_add("ko2_or_bot_back.png",115,290,65,45)
backlite1_group   = group_add(CSTR_li_img,WPT_li_img,VORD_li_img,NDB_li_img,ARPT_li_img,FD_li_img,LS_li_img)
backlite2_group   = group_add(CSTR_bli_img,WPT_bli_img,VORD_bli_img,NDB_bli_img,ARPT_bli_img,FD_bli_img,LS_bli_img)
backlite2y_group  = group_add(CSTR_byli_img,WPT_byli_img,VORD_byli_img,NDB_byli_img,ARPT_byli_img,FD_byli_img,LS_byli_img)
visible(backlite1_group, false)
   
-------------------------------------------------------------------------------
 
  
 --=============================================================================
-- 1.6 EFIS buttons controlled via instrument
--=============================================================================
-- FD_button = button_add("ko2_stripes_fd_but_rel.png","ko2_stripes_fd_but_push.png",35,290,65,45,function() msfs_event("A32NX.FCU_EFIS_L_FD_PUSH")end)
-- msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_FD_LIGHT_ON", "enum", function(val) visible(FD_li_img, val) end) 

-- LS_button = button_add("ko2_stripes_ls_but_rel.png","ko2_stripes_ls_but_push.png",115,290,65,45,function() msfs_event("A32NX.FCU_EFIS_L_LS_PUSH")end)  
-- msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_LS_LIGHT_ON", "enum", function(val) visible(LS_li_img, val) end) 

-- CSTR_button = button_add("ko2_stripes_cstr_but_rel.png","ko2_stripes_cstr_but_push.png",221,45,65,45,function() msfs_event("A32NX.FCU_EFIS_L_CSTR_PUSH")end)
-- msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_CSTR_LIGHT_ON", "enum", function(val) visible(CSTR_li_img, val) end) 

-- WPT_button = button_add("ko2_stripes_wpt_but_rel.png","ko2_stripes_wpt_but_push.png",297,45,65,45,function() msfs_event("A32NX.FCU_EFIS_L_WPT_PUSH")end)
-- msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_WPT_LIGHT_ON", "enum", function(val) visible(WPT_li_img, val) end) 
 
-- VORD_button = button_add("ko2_stripes_vord_but_rel.png","ko2_stripes_vord_but_push.png",372,45,65,45,function() msfs_event("A32NX.FCU_EFIS_L_VORD_PUSH")end)
-- msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_VORD_LIGHT_ON", "enum", function(val) visible(VORD_li_img, val) end) 
  
-- NDB_button = button_add("ko2_stripes_ndb_but_rel.png","ko2_stripes_ndb_but_push.png",446,45,65,45,function() msfs_event("A32NX.FCU_EFIS_L_NDB_PUSH")end)
-- msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_NDB_LIGHT_ON", "enum", function(val) visible(NDB_li_img, val) end) 

-- ARPT_button = button_add("ko2_stripes_arpt_but_rel.png","ko2_stripes_arpt_but_push.png",521,45,65,45,function() msfs_event("A32NX.FCU_EFIS_L_ARPT_PUSH")end)
-- msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_ARPT_LIGHT_ON", "enum", function(val) visible(ARPT_li_img, val) end) 
  
 function FD_li_cb (stat)
        visible(FD_li_img, stat)
  end
  msfs_variable_subscribe("AUTOPILOT FLIGHT DIRECTOR ACTIVE:1", "Bool",FD_li_cb)

  function LS_li_cb (stat)
      visible(LS_li_img, stat)
  end
   msfs_variable_subscribe("L:BTN_LS_1_FILTER_ACTIVE", "enum",LS_li_cb)
   
   
  function option_cb (value) 
      option = value
      visible(CSTR_li_img, false)
      visible(WPT_li_img, false)
      visible(VORD_li_img, false)
      visible(NDB_li_img, false)
      visible(ARPT_li_img, false)
      if option == 1 then
           visible(CSTR_li_img, true)
      elseif option == 4 then
           visible(WPT_li_img, true)
      elseif option == 2 then
           visible(VORD_li_img, true)
      elseif option == 8 then
           visible(NDB_li_img, true)
      elseif option == 16 then
           visible(ARPT_li_img, true)
      end
  end
  msfs_variable_subscribe("L:A32NX_EFIS_L_OPTION", "enum", option_cb) 
  
msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_FD_LIGHT_ON", "enum", function(val) visible(FD_li_img, val) end) 
msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_LS_LIGHT_ON", "enum", function(val) visible(LS_li_img, val) end) 
msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_CSTR_LIGHT_ON", "enum", function(val) visible(CSTR_li_img, val) end) 
msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_WPT_LIGHT_ON", "enum", function(val) visible(WPT_li_img, val) end) 
msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_VORD_LIGHT_ON", "enum", function(val) visible(VORD_li_img, val) end) 
msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_NDB_LIGHT_ON", "enum", function(val) visible(NDB_li_img, val) end) 
msfs_variable_subscribe("L:A32NX_FCU_EFIS_L_ARPT_LIGHT_ON", "enum", function(val) visible(ARPT_li_img, val) end) 

  
function FD_p_cb()
--     if FBW_A32NX_Version =="Stable" then 
--         msfs_event("TOGGLE_FLIGHT_DIRECTOR")   
--     else
        msfs_event("A32NX.FCU_EFIS_L_FD_PUSH")
    -- end
end
FD_button = button_add("ko2_stripes_fd_but_rel.png","ko2_stripes_fd_but_push.png",35,290,65,45,FD_p_cb)

function LS_p_cb()
--     if FBW_A32NX_Version =="Stable" then 
--          msfs_event("H:A320_Neo_PFD_BTN_LS_1")
--          msfs_event("H:A320_Neo_MFD_BTN_LS_1")
--     else
        msfs_event("A32NX.FCU_EFIS_L_LS_PUSH")
    -- end  
end
LS_button = button_add("ko2_stripes_ls_but_rel.png","ko2_stripes_ls_but_push.png",115,290,65,45,LS_p_cb)  

function CSTR_p_cb()
--     if FBW_A32NX_Version =="Stable" then 
--          if option == 1 then
--             msfs_rpn("0 (>L:A32NX_EFIS_L_OPTION, enum)")         
--         else 
--             msfs_rpn("1 (>L:A32NX_EFIS_L_OPTION, enum)")
--         end
--     else
        msfs_event("A32NX.FCU_EFIS_L_CSTR_PUSH")
--    end
  end
CSTR_button = button_add("ko2_stripes_cstr_but_rel.png","ko2_stripes_cstr_but_push.png",221,45,65,45,CSTR_p_cb,CSTR_r_cb)
 
function WPT_p_cb()
--      if FBW_A32NX_Version =="Stable" then 
--         if option == 4 then
--             msfs_rpn("0 (>L:A32NX_EFIS_L_OPTION, enum)")         
--         else 
--             msfs_rpn("4 (>L:A32NX_EFIS_L_OPTION, enum)")
--         end
     -- else
        msfs_event("A32NX.FCU_EFIS_L_WPT_PUSH")
     -- end
end
WPT_button = button_add("ko2_stripes_wpt_but_rel.png","ko2_stripes_wpt_but_push.png",297,45,65,45,WPT_p_cb, WPT_r_cb)
  
function VORD_p_cb()
--     if FBW_A32NX_Version =="Stable" then 
--          if option == 2 then
--             msfs_rpn("0 (>L:A32NX_EFIS_L_OPTION, enum)")         
--         else 
--             msfs_rpn("2 (>L:A32NX_EFIS_L_OPTION, enum)")
--         end
--      else
        msfs_event("A32NX.FCU_EFIS_L_VORD_PUSH")
    -- end
end
VORD_button = button_add("ko2_stripes_vord_but_rel.png","ko2_stripes_vord_but_push.png",372,45,65,45,VORD_p_cb,VORD_r_cb)
  
function NDB_p_cb()
--      if FBW_A32NX_Version =="Stable" then 
--         if option == 8 then
--             msfs_rpn("0 (>L:A32NX_EFIS_L_OPTION, enum)")         
--         else 
--             msfs_rpn("8 (>L:A32NX_EFIS_L_OPTION, enum)")
--         end
--     else
        msfs_event("A32NX.FCU_EFIS_L_NDB_PUSH")
    -- end
end
NDB_button = button_add("ko2_stripes_ndb_but_rel.png","ko2_stripes_ndb_but_push.png",446,45,65,45,NDB_p_cb,NDB_r_cb)
 
function ARPT_p_cb()
--     if FBW_A32NX_Version =="Stable" then 
--          if option == 16 then
--             msfs_rpn("0 (>L:A32NX_EFIS_L_OPTION, enum)")         
--         else 
--             msfs_rpn("16 (>L:A32NX_EFIS_L_OPTION, enum)")
--         end
--     else
        msfs_event("A32NX.FCU_EFIS_L_ARPT_PUSH")
--    end
end
ARPT_button = button_add("ko2_stripes_arpt_but_rel.png","ko2_stripes_arpt_but_push.png",521,45,65,45,ARPT_p_cb,ARPT_r_cb)
    
--==========================================================================
-- 1.7 Nav source ADF,VOR
--==========================================================================
function NavReciver1L_cb (val1,val2)
-- if FBW_A32NX_Version =="Stable" then NavReciver1val = val1 else
  NavReciver1val = val2
--   end 
 if     NavReciver1val == 0.0 then  switch_set_position(NavReciver1L_sw, 1)
 elseif NavReciver1val == 1.0 then  switch_set_position(NavReciver1L_sw, 0)
 elseif NavReciver1val == 2.0 then  switch_set_position(NavReciver1L_sw, 2) end
end
msfs_variable_subscribe("L:A32NX_EFIS_L_NAVAID_1_MODE", "enum","L:A32NX_FCU_EFIS_L_NAVAID_1_MODE", "enum",NavReciver1L_cb)

function NavReciver1L_sw_cb (pos,dir)
    if dir == 1 then   -- turned dial clockwise towards ON
        if pos == 0 then
            new_pos = 0 
        elseif pos == 1 then
            new_pos = 2
        end
    else
        if pos == 2 then
            new_pos = 0 
        elseif pos == 1 then
            new_pos = 1
        end
    end 
--     if FBW_A32NX_Version =="Stable" then   msfs_rpn(new_pos.." (>L:A32NX_EFIS_L_NAVAID_1_MODE, enum)") else
      msfs_rpn(new_pos.." (>L:A32NX_FCU_EFIS_L_NAVAID_1_MODE, enum)")
--      end
end    
NavReciver1L_sw   = switch_add("vor_l.png","vor_c.png","vor_r.png",265,280,100,45,NavReciver1L_sw_cb)
mouse_setting(NavReciver1L_sw , "CURSOR_LEFT", "left_icon.png")
mouse_setting(NavReciver1L_sw , "CURSOR_RIGHT", "right_icon.png")
  
function NavReciver2L_cb  (val1,val2)
     --if FBW_A32NX_Version =="Stable" then NavReciver2val = val1 else 
     NavReciver2val = val2 
    -- end 
    if     NavReciver2val == 0.0 then  switch_set_position(NavReciver2L_sw, 1)
    elseif NavReciver2val == 1.0 then  switch_set_position(NavReciver2L_sw, 0)
    elseif NavReciver2val == 2.0 then  switch_set_position(NavReciver2L_sw, 2) 
    end
end
msfs_variable_subscribe("L:A32NX_EFIS_L_NAVAID_2_MODE", "enum","L:A32NX_FCU_EFIS_L_NAVAID_2_MODE", "enum",NavReciver2L_cb)
  
function NavReciver2L_sw_cb (pos, dir)
    if dir == 1 then   -- turned dial clockwise towards ON
        if pos == 0 then
            new_pos = 0 
        elseif pos == 1 then
            new_pos = 2
        end
    else
        if pos == 2 then
            new_pos = 0 
        elseif pos == 1 then
            new_pos = 1
        end
    end 
     
    -- if FBW_A32NX_Version =="Stable" then   msfs_rpn(new_pos.." (>L:A32NX_EFIS_L_NAVAID_2_MODE, enum)") else 
     msfs_rpn(new_pos.." (>L:A32NX_FCU_EFIS_L_NAVAID_2_MODE, enum)")
     --end
end

NavReciver2L_sw   = switch_add("vor_l.png","vor_c.png","vor_r.png",460,280,100,45,NavReciver2L_sw_cb)
mouse_setting(NavReciver2L_sw , "CURSOR_LEFT", "left_icon.png")
mouse_setting(NavReciver2L_sw , "CURSOR_RIGHT", "right_icon.png")
    
   
    
-- --******HARDWARE********************************
-- if user_prop_get(prop_hardware) then
 -- --**************************Dials panel hardware***************************
 
-- --Dial 6 encoder Hardware (Baro)
-- hw_dial_add("ARDUINO_MEGA2560_A_D27", "ARDUINO_MEGA2560_A_D25", "TYPE_1_DETENT_PER_PULSE" ,5, function (direction) turn_baroval_cb(direction) end)
-- --Dial 6 encoder switch Hardware
-- hw_button_add("ARDUINO_MEGA2560_A_D29",  Baropush_r_cb, Baropush_p_cb) -- bug: push and release callback are reversed.

-- --Dial 4 encoder Hardware (Mode)
-- hw_dial_add("ARDUINO_MEGA2560_A_D44", "ARDUINO_MEGA2560_A_D42", "TYPE_1_DETENT_PER_PULSE" ,1, function (direction) NavModeL_turn_cb(direction) end)
-- --Dial 4 encoder switch Hardware
-- --hw_button_add("ARDUINO_MEGA2560_A_D46",  Baropush_r_cb, Baropush_p_cb) -- bug: push and release callback are reversed.

 -- --Dial 5 encoder Hardware (Range
-- hw_dial_add("ARDUINO_MEGA2560_A_D50", "ARDUINO_MEGA2560_A_D48", "TYPE_1_DETENT_PER_PULSE" ,1, function (direction) NavRangeL_turn_cb(direction) end)
-- --Dial 4 encoder switch Hardware
-- --hw_button_add("ARDUINO_MEGA2560_A_D52",  Baropush_r_cb, Baropush_p_cb) -- bug: push and release callback are reversed.

-- end

  
-- 10. Illumination Mode
function Illumination_mode_cb(Illumination_mode_val)
 Illumination_mode = Illumination_mode_val
 var1  = var_cap(Illumination_mode_val[5] * 0.031 + 0.3, 0.3, 1.0); var1y = var_cap(Illumination_mode_val[5] * 0.25 - 5.75, 0.0, 1.0)
 if Illumination_mode_val[1] == 1.0 then
   opacity(night_overlay_img, 1 - Illumination_mode_val[6] * 0.037)
   opacity(text_overlay_img, var1); opacity(text_overlay_y_img, var1y); opacity(display_group, var1)
   opacity(backlite1_group, var1); opacity(backlite2_group, var1); opacity(backlite2y_group, var1y)
   opacity(knob_group,var_cap(Illumination_mode_val[6] * 0.037,0.5,1.0)); opacity(StdPull_group,var_cap(Illumination_mode_val[6] * 0.037,0.7,1.0))
 else
   opacity(night_overlay_img,0.0); opacity(text_overlay_img,1.0); opacity(text_overlay_y_img,0.0); opacity(knob_group,1.0); opacity(StdPull_group,1.0)
   opacity(backlite1_group,1.0);opacity(backlite2_group,1.0);opacity(backlite2y_group,0.0);opacity(display_group,1.0)
 end
     
 if power == 0 then
    opacity(backlite1_group,0); opacity(backlite2y_group,0);opacity(display_group,0)
 end

end
si_variable_subscribe("Illumination_mode","FLOAT[10]", Illumination_mode_cb)
   
 --Power management----------------------------------------------------
function power_cb (powered)
  power = powered
  if Illumination_mode ~= nil then Illumination_mode_cb(Illumination_mode) end
end
msfs_variable_subscribe( "L:A32NX_ELEC_DC_ESS_SHED_BUS_IS_POWERED","enum", power_cb)

 
