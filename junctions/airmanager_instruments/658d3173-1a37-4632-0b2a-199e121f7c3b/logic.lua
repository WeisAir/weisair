--====================================================================================
-- Airbus A320 FlightFactor FCU instrument for Air Manager
-- Author:   Alexander Hildmann
-- Date: September 9 2019
-- Last tested:   with Windows 10, Xplane (11.35r1) and
-- FlightFactor A320 Ultimate(0.10.8-2305) 
-- IMPORTANT!!!!
-- Specific FFA320 datarefs are used, these datarefs where added starting version 0.94 
-- Please read the FFA320 documentation for more info regarding datarefs
-- Some datarefs used in this instrument must be added to the file:
-- X-Plane 11/aircraft/FlightFactor A320 ultimate/data/publish.txt (create file if not exist)
-- Paste content of add2publish.txt file (included in this instrument, resource directory) 
-- into publish.txt
--====================================================================================
--Images ----------------------------------------------------------------------- 
  local backplate_img           = img_add ("a320_fcu_panel.png",  0, 0, 1024, 360)
  local Speed_base_img          = img_add ("SPD_base.png", 110, 155, 90,90)
  local Speed_pushed_img        = img_add ("SPD_pushed.png", 124, 169, 60, 60)
  local Speed_img               = img_add ("SPD.png",  124, 169, 60, 60)
  local Speed_pulled_img        = img_add ("SPD_pulled.png",  124, 169, 60, 60)
  local HDG_base_img            = img_add ("HDG_base.png", 266, 155, 90,90)
  local HDG_pushed_img          = img_add ("HDG_pushed.png", 280, 169, 60, 60)
  local HDG_img                 = img_add ("HDG.png", 280, 169, 60, 60)
  local HDG_pulled_img          = img_add ("HDG_pulled.png", 280, 169, 60, 60)
  local ALT_100_img             = img_add ("ALT_100.png", 659, 155, 90,90)  
  local ALT_1000_img            = img_add ("ALT_1000.png", 659, 155, 90, 90) 
  local ALT_pushed_img          = img_add ("ALT_pushed.png", 675, 169, 60, 60)
  local ALT_img                 = img_add ("ALT.png", 675, 169, 60, 60)
  local ALT_pulled_img          = img_add ("ALT_pulled.png", 675, 169, 60, 60)
  local VS_base_img             = img_add ("SPD_base.png", 861, 155, 90, 90)
  local VS_pushed_img           = img_add ("SPD_pushed.png", 876, 169, 60, 60)
  local VS_img                  = img_add ("SPD.png", 876, 169, 60, 60)
  local VS_pulled_img           = img_add ("SPD_pulled.png", 876, 169, 60, 60)
  local SPD_managed_img         = img_add ("managed.png", 210, 63, 20, 20)
  local HDG_managed_img         = img_add ("managed.png", 357, 63, 20, 20)
  local ALT_managed_img         = img_add ("managed.png", 755, 63, 20, 20) 
  
  visible(Speed_img, true) 
  visible(Speed_pushed_img, false)
  visible(Speed_pulled_img, false)
  visible(HDG_img, true) 
  visible(HDG_pushed_img, false)
  visible(HDG_pulled_img, false)
  visible (ALT_img, true) 
  visible(ALT_pushed_img, false)
  visible(ALT_pulled_img, false)
  visible(VS_img, true) 
  visible(VS_pushed_img, false)
  visible(VS_pulled_img, false)
  visible (SPD_managed_img, false)
  visible (HDG_managed_img, false)
  visible (ALT_managed_img, false)
--Text ------------------------------------------------
  SPEED_d_txt       = txt_add("", "font:digital-7-mono.ttf; size:45; color: orange; halign:left;", 115,50, 150, 50)
  LATERAL_d_txt     = txt_add("", "font:digital-7-mono.ttf; size:45; color: orange; halign:left;", 272,50, 150, 50)
  ALTITUDE_d_txt    = txt_add("", "font:digital-7-mono.ttf; size:45; color: orange; halign:left;", 625,50, 130, 50)
  VERTSPEED_d_txt   = txt_add("", "font:digital-7-mono.ttf; size:45; color: orange; halign:left;", 805,50, 150, 50)
  SPD1_txt          = txt_add("", "font:arimo_regular.ttf; size:20; color: white; halign:left;", 100,25, 60, 20)
  MACH1_txt         = txt_add("", "font:arimo_regular.ttf; size:20; color:  white; halign:left;", 170,25, 80, 20)
  HDG2_txt          = txt_add("", "font:arimo_regular.ttf; size:20; color:  white; halign:left;", 270,25, 80, 20)
  TRK2_txt          = txt_add("", "font:arimo_regular.ttf; size:20; color:  white; halign:left;", 320,25, 80, 20)
  LAT2_txt          = txt_add("LAT", "font:arimo_regular.ttf; size:20; color:  white; halign:left;", 365,25, 80, 20)
  HDG3_txt          = txt_add("", "font:arimo_regular.ttf; size:16; color:  white; halign:left;", 470,55, 60, 20)
  TRK3_txt          = txt_add("", "font:arimo_regular.ttf; size:16; color:  white; halign:left;", 470,80, 60, 20)
  VS3_txt           = txt_add("", "font:arimo_regular.ttf; size:16; color:  white; halign:left;", 528,55, 60, 20) 
  FPA3_txt          = txt_add("", "font:arimo_regular.ttf; size:16; color:  white; halign:left;", 527,80, 60, 20)
  ALT4_txt          = txt_add("ALT", "font:arimo_regular.ttf; size:20; color:  white; halign:left;", 645,25,60, 20)
  LVLCH5_txt        = txt_add("LVL/CH", "font:arimo_regular.ttf; size:20; color:  white; halign:left;", 735,25, 120, 20)
  VS6_txt           = txt_add("", "font:arimo_regular.ttf; size:20; color:  white; halign:left;", 839,25, 60, 20)
  FPA7_txt          = txt_add("", "font:arimo_regular.ttf; size:20; color:  white; halign:left;", 880,25, 60, 20)
--Xplane -----------------------------------------------  
  local SPDMACH_ffdref       = "a320/Panel/FCU_Mach"
  local SpeedIsMach_ffdref   = "a320/Aircraft/FMGS/FCU1/SpeedIsMach"
  local HDGVS_ffdref         = "a320/Panel/FCU_Mode"
  local HDGVS_Mode_ffdref    = "a320/Aircraft/FMGS/FCU1/Mode"
  local METRIC_ffdref        = "a320/Panel/FCU_Metric"
  local Speed_ffdref         = "a320/Panel/FCU_Speed"
  local SpeedMode_ffdref     = "a320/Panel/FCU_SpeedMode"   
  local Lateral_ffdref       = "a320/Panel/FCU_Lateral"
  local LateralMode_ffdref   = "a320/Panel/FCU_LateralMode"
  local AltitStep_ffdref     = "a320/Panel/FCU_AltitudeStep" 
  local Altitude_ffdref      = "a320/Panel/FCU_Altitude"
  local AltitudeMode_ffdref  = "a320/Panel/FCU_AltitudeMode"
  local Vertical_ffdref      = "a320/Panel/FCU_Vertical"
  local VerticalMode_ffdref  = "a320/Panel/FCU_VerticalMode"
  local LOC_ffdref           = "a320/Panel/FCU_Localizer"
  local AP1_ffdref           = "a320/Panel/FCU_AutoPilot1"    
  local AP2_ffdref           = "a320/Panel/FCU_AutoPilot2"    
  local ATHR_ffdref          = "a320/Panel/FCU_AutoThrust"
  local EXPED_ffdref         = "a320/Panel/FCU_Expedite"
  local APPR_ffdref          = "a320/Panel/FCU_Approach"
  local SPD1                 =  "a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit1/State"  --Add to publish.txt
  local SPD2                 =  "a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit2/State"  --Add to publish.txt
  local SPD3                 =  "a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit3/State"  --Add to publish.txt
  local SPD4                 =  "a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit4/State"  --Add to publish.txt
  local SPD5                 =  "a320/Aircraft/Cockpit/Panel/FCU_SpeedDigit5/State"  --Add to publish.txt
  local LAD1                 =  "a320/Aircraft/Cockpit/Panel/FCU_LateralDigit1/State"  --Add to publish.txt
  local LAD2                 =  "a320/Aircraft/Cockpit/Panel/FCU_LateralDigit2/State"  --Add to publish.txt
  local LAD3                 =  "a320/Aircraft/Cockpit/Panel/FCU_LateralDigit3/State"  --Add to publish.txt
  local LAD4                 =  "a320/Aircraft/Cockpit/Panel/FCU_LateralDigit4/State"  --Add to publish.txt
  local ALD1                 =  "a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit1/State"  --Add to publish.txt
  local ALD2                 =  "a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit2/State"  --Add to publish.txt
  local ALD3                 =  "a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit3/State"  --Add to publish.txt
  local ALD4                 =  "a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit4/State"  --Add to publish.txt
  local ALD5                 =  "a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit5/State"  --Add to publish.txt
  local ALD6                 =  "a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit6/State"  --Add to publish.txt
  local VED1                 =  "a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit1/State"  --Add to publish.txt
  local VED2                 =  "a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit2/State"  --Add to publish.txt
  local VED3                 =  "a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit3/State"  --Add to publish.txt
  local VED4                 =  "a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit4/State"  --Add to publish.txt
  local VED5                 =  "a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit5/State"  --Add to publish.txt
  local VED6                 =  "a320/Aircraft/Cockpit/Panel/FCU_VerticalDigit6/State"  --Add to publish.txt
  local LocalizerLi_ffdref   =  "a320/Aircraft/Cockpit/Panel/FCU_LocalizerLight/State"   --Add to publish.txt
  local AutoPilotLi1_ffdref  =  "a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight1/State"     --Add to publish.txt
  local AutoPilotLi2_ffdref  =  "a320/Aircraft/Cockpit/Panel/FCU_AutoPilotLight2/State"     --Add to publish.txt
  local AutoThrustLi_ffdref  =  "a320/Aircraft/Cockpit/Panel/FCU_AutoThrustLight/State"  --Add to publish.txt
  local ExpediteLi_ffdref    =  "a320/Aircraft/Cockpit/Panel/FCU_ExpediteLight/State"    --Add to publish.txt
  local ApproachLi_ffdref    =  "a320/Aircraft/Cockpit/Panel/FCU_ApproachLight/State"    --Add to publish.txt
--INITIALIZE --------------------------------------------------------------------------    
  local Speed_inc       = 0.0
  local Heading_inc     = 0.0  
  local ALT_inc         = 0.0
  local ALTType         = 0
  local VS_inc          = 0.0
--================================================================
-- 1.0 Speed/Mach
--================================================================
  function SPDMACH_p_cb()
    xpl_dataref_write(SPDMACH_ffdref, "FLOAT", 1.0)
  end
  function SPDMACH_r_cb()
    xpl_dataref_write(SPDMACH_ffdref, "FLOAT", 0.0)
  end
  SPDMACH_button = button_add("SPDMACH.png", "SPDMACH_p.png",28, 122, 45, 45, SPDMACH_p_cb, SPDMACH_r_cb)                  

  function SpeedIsMach_cb (SpeedIsMach)
    if SpeedIsMach == 0.0 then
      txt_set(SPD1_txt, "SPD")             
      txt_set(MACH1_txt, "")      
    else
      txt_set(SPD1_txt, "")             
      txt_set(MACH1_txt, "MACH")
    end    
  end  
  variable_subscribe("XPLANE", SpeedIsMach_ffdref, "FLOAT", SpeedIsMach_cb)
--================================================================
-- 1.1 Speed
--================================================================
  function read_speed_digits_cb (ad1,ad2,ad3,ad4,ad5)
    if ad1 == 0.0 then
     ad1 = ""
    elseif ad1 == 13.0 then
     ad1 = "-"
    else
      ad1 = ad1 - 1.0
      ad1 = var_format(ad1,0) 
    end
    if ad2 == 0.0 then
     ad2 = ""
    elseif ad2 == 15 then
     ad2 = "."
    end
    if ad3 == 0.0 then
     ad3 = ""
    elseif ad3 == 13.0 then
     ad3 = "-"
    else
      ad3 = ad3 - 1.0
      ad3 = var_format(ad3,0) 
    end
    if ad4 == 0.0 then
     ad4 = ""
    elseif ad4 == 13.0 then
     ad4 = "-"
    else
      ad4 = ad4 - 1.0
      ad4 = var_format(ad4,0) 
    end
    if ad5 == 0.0 then
      visible (SPD_managed_img, false)
    elseif ad5 == 16.0 then
      visible (SPD_managed_img, true)
    end
    txt_set(SPEED_d_txt,  ad1 .. ad2 .. ad3 .. ad4)    
  end  
  variable_subscribe("XPLANE", SPD1, "FLOAT", "XPLANE", SPD2, "FLOAT", "XPLANE", SPD3, "FLOAT", "XPLANE",
                     SPD4, "FLOAT", "XPLANE", SPD5, "FLOAT", read_speed_digits_cb) 

  function read_speed_cb(speedinc)
    Speed_inc = speedinc 
  end
  variable_subscribe("XPLANE", Speed_ffdref, "FLOAT", read_speed_cb)  
  
  function turn_Speed_cb (direction1)
    if direction1 > 0 then
      Speed_inc = Speed_inc + 1
      img_rotate(Speed_img, Speed_inc)      
    else
      Speed_inc = Speed_inc  - 1
      img_rotate(Speed_img, Speed_inc)
    end
    xpl_dataref_write(Speed_ffdref, "FLOAT", Speed_inc)
  end
  dial_id1 = dial_add( nil, 184, 155, 40, 90, turn_Speed_cb)
  
  function SpeedPush_p_cb()
       xpl_dataref_write(SpeedMode_ffdref, "FLOAT", 1.0 )
    visible(Speed_img, false) 
    visible(Speed_pushed_img, true)
    visible(Speed_pulled_img, false)
  end
  function SpeedPush_r_cb()
       xpl_dataref_write(SpeedMode_ffdref, "FLOAT", 0.0)
    visible(Speed_img, true) 
    visible(Speed_pushed_img, false)
    visible(Speed_pulled_img, false)
  end                                       
  SpeedPush_button = button_add(Nil, Nil,  124, 155, 60, 60, SpeedPush_p_cb, SpeedPush_r_cb)
  mouse_setting(SpeedPush_button, "CURSOR", "hand_cursor.png")  
  
  function Speedpull_p_cb()
       xpl_dataref_write(SpeedMode_ffdref, "FLOAT", -1.0)
    visible(Speed_img, false) 
    visible(Speed_pushed_img, false)
    visible(Speed_pulled_img, true)    
  end
  function Speedpull_r_cb()
       xpl_dataref_write(SpeedMode_ffdref, "FLOAT", 0.0)
    visible(Speed_img, true) 
    visible(Speed_pushed_img, false)
    visible(Speed_pulled_img, false)
  end
  Speedpull_button = button_add(Nil, Nil,  124, 205, 60, 60, Speedpull_p_cb, Speedpull_r_cb) 
  mouse_setting(Speedpull_button, "CURSOR", "grab_cursor.png")
--=============================================
-- 1.2 Heading
--=============================================
  function read_heading_digits_cb (lad1,lad2,lad3,lad4)
    if lad1 == 0.0 then
     lad1 = ""
    elseif lad1 == 13.0 then
     lad1 = "-"
    else
      lad1 = lad1 - 1.0
      lad1 = var_format(lad1,0) 
    end
    if lad2 == 0.0 then
     lad2 = ""
    elseif lad2 == 13.0 then
     lad2 = "-"
    else
      lad2 = lad2 - 1.0
      lad2 = var_format(lad2,0) 
    end
    if lad3 == 0.0 then
     lad3 = ""
    elseif lad3 == 13.0 then
     lad3 = "-"
    else
      lad3 = lad3 - 1.0
      lad3 = var_format(lad3,0) 
    end
    if lad4 == 0.0 then
      visible (HDG_managed_img, false)
    elseif lad4 == 16.0 then
      visible (HDG_managed_img, true)      
    end
    txt_set(LATERAL_d_txt,  lad1 .. lad2 .. lad3)
  end  
  variable_subscribe("XPLANE", LAD1, "FLOAT", "XPLANE", LAD2, "FLOAT", "XPLANE", LAD3, "FLOAT", "XPLANE",
                     LAD4, "FLOAT", read_heading_digits_cb)
-----------------------------------------------------------                     
  function read_heading_cb(headinginc)
    Heading_inc = headinginc 
  end
  variable_subscribe("XPLANE", Lateral_ffdref, "FLOAT", read_heading_cb)   
---------------------------------------- 
  function turn_Heading_cb (direction2)
    if direction2 > 0 then
      Heading_inc = Heading_inc + 1
      img_rotate(HDG_img, Heading_inc)
    else
      Heading_inc = Heading_inc - 1
      img_rotate(HDG_img, Heading_inc)
    end
    xpl_dataref_write(Lateral_ffdref, "FLOAT", Heading_inc)
  end
  dial_id2 = dial_add(Nil, 340, 155, 40, 90, turn_Heading_cb)
 
  function HDGPush_p_cb()
       xpl_dataref_write(LateralMode_ffdref, "FLOAT", 1.0 )
    visible(HDG_img, false) 
    visible(HDG_pushed_img, true)
    visible(HDG_pulled_img, false)
  end
  function HDGPush_r_cb()
       xpl_dataref_write(LateralMode_ffdref, "FLOAT", 0.0)
    visible(HDG_img, true) 
    visible(HDG_pushed_img, false)
    visible(HDG_pulled_img, false)
  end
  HDGPush_button = button_add(Nil, Nil,  280, 155, 60, 60, HDGPush_p_cb, HDGPush_r_cb)
  mouse_setting(HDGPush_button, "CURSOR", "hand_cursor.png")  

  function HDGpull_p_cb()
       xpl_dataref_write(LateralMode_ffdref, "FLOAT", -1.0)
    visible(HDG_img, false) 
    visible(HDG_pushed_img, false)
    visible(HDG_pulled_img, true)    
  end
  function HDGpull_r_cb()
       xpl_dataref_write(LateralMode_ffdref, "FLOAT", 0.0)
    visible(HDG_img, true) 
    visible(HDG_pushed_img, false)
    visible(HDG_pulled_img, false)
  end
  HDGpull_button = button_add(Nil, Nil,  280, 205, 60, 60, HDGpull_p_cb, HDGpull_r_cb) 
  mouse_setting(HDGpull_button, "CURSOR", "grab_cursor.png")
--=============================================
-- 1.3 Altitude
--=============================================
  function read_altitude_digits_cb (ald1,ald2,ald3,ald4,ald5,ald6)
    if ald1 == 0.0 then
     ald1 = ""
    elseif ald1 == 13.0 then
     ald1 = "-"
    else
      ald1 = ald1 - 1.0
      ald1 = var_format(ald1,0) 
    end
    if ald2 == 0.0 then
     ald2 = ""
    elseif ald2 == 13.0 then
     ald2 = "-"
    else
      ald2 = ald2 - 1.0
      ald2 = var_format(ald2,0) 
    end
    if ald3 == 0.0 then
     ald3 = ""
    elseif ald3 == 13.0 then
     ald3 = "-"
    else
      ald3 = ald3 - 1.0
      ald3 = var_format(ald3,0) 
    end
    if ald4 == 0.0 then
     ald4 = ""
    elseif ald4 == 13.0 then
     ald4 = "-"
    else
      ald4 = ald4 - 1.0
      ald4 = var_format(ald4,0) 
    end
    if ald5 == 0.0 then
     ald5 = ""
    elseif ald5 == 13.0 then
     ald5 = "-"
    else
      ald5 = ald5 - 1.0
      ald5 = var_format(ald5,0) 
    end
    if ald6 == 0.0 then
      visible (ALT_managed_img, false)
    elseif ald6 == 16.0 then
      visible (ALT_managed_img, true)      
    end
    txt_set(ALTITUDE_d_txt,  ald1 .. ald2 .. ald3 .. ald4 .. ald5)    
  end  
  
  variable_subscribe("XPLANE", ALD1, "FLOAT", "XPLANE", ALD2, "FLOAT", "XPLANE", ALD3, "FLOAT", "XPLANE",
                     ALD4, "FLOAT", "XPLANE", ALD5, "FLOAT", "XPLANE", ALD6, "FLOAT", read_altitude_digits_cb)

  function read_altitude_cb(altitudeinc)
    ALT_inc = altitudeinc 
  end
  variable_subscribe("XPLANE", Altitude_ffdref, "FLOAT", read_altitude_cb)                     

  function turn_Altitude_cb (direction3)
    if direction3 > 0 then
      ALT_inc =  ALT_inc + 1
      img_rotate(ALT_img, ALT_inc)
    else
      ALT_inc =  ALT_inc - 1
      img_rotate(ALT_img, ALT_inc)
    end
    xpl_dataref_write(Altitude_ffdref, "FLOAT",  ALT_inc)
  end
  dial_id3 = dial_add(nil, 729, 155, 40, 90, turn_Altitude_cb) 
  
  function ALTPush_p_cb()
       xpl_dataref_write(AltitudeMode_ffdref, "FLOAT", 1.0 )
    visible(ALT_img, false) 
    visible(ALT_pushed_img, true)
    visible(ALT_pulled_img, false)
  end
  function ALTPush_r_cb()
       xpl_dataref_write(AltitudeMode_ffdref, "FLOAT", 0.0)
    visible(ALT_img, true) 
    visible(ALT_pushed_img, false)
    visible(ALT_pulled_img, false)
  end
  ALTPush_button = button_add(Nil, Nil,  675, 165, 60, 50, ALTPush_p_cb, ALTPush_r_cb)
  mouse_setting(ALTPush_button, "CURSOR", "hand_cursor.png")  

  function ALTpull_p_cb()
       xpl_dataref_write(AltitudeMode_ffdref, "FLOAT", -1.0)
    visible(ALT_img, false) 
    visible(ALT_pushed_img, false)
    visible(ALT_pulled_img, true)    
  end
  function ALTpull_r_cb()
       xpl_dataref_write(AltitudeMode_ffdref, "FLOAT", 0.0)
    visible(ALT_img, true) 
    visible(ALT_pushed_img, false)
    visible(ALT_pulled_img, false)
  end
  ALTpull_button = button_add(Nil, Nil,  675, 205, 60, 60, ALTpull_p_cb, ALTpull_r_cb) 
  mouse_setting(ALTpull_button, "CURSOR", "grab_cursor.png")

   function ALTType_cb (ALTType_var)
    if  ALTType_var == 0.0 then
      ALTType = 0
      visible(ALT_100_img, true)
      visible(ALT_1000_img, false)
    else
      ALTType = 1
      visible(ALT_100_img, false)
      visible(ALT_1000_img, true)
    end
  end
  variable_subscribe("XPLANE", AltitStep_ffdref, "FLOAT", ALTType_cb)  
  
  function ALTType_p_cb()
       if  ALTType == 0 then
      xpl_dataref_write(AltitStep_ffdref, "FLOAT", 1.0)
    else
      xpl_dataref_write(AltitStep_ffdref, "FLOAT", 0.0)
    end
  end
  ALTType_button = button_add(Nil, Nil,  669, 125, 90, 30, ALTType_p_cb) 
  mouse_setting(ALTType_button , "CURSOR", "right_left_icon.png") 
--=============================================
-- 1.4 Vertical Speed 
--=============================================
  function read_VS_digits_cb (ved1,ved2,ved3,ved4,ved5,ved6)
    if ved1 == 11.0 then
     ved1 = "+"
    elseif ved1 == 12.0 then
     ved1 = "-"
    end
    if ved2 == 0.0 then
     ved2 = ""
    elseif ved2 == 13.0 then
     ved2 = "-"
    else
      ved2 = ved2 - 1.0
      ved2 = var_format(ved2,0) 
    end
    if ved3 == 0.0 then
     ved3 = ""
    elseif ved3 == 15.0 then
     ved3 = "."
    end
    if ved4 == 0.0 then
     ved4 = ""
    elseif ved4 == 13.0 then
     ved4 = "-"
    else
      ved4 = ved4 - 1.0
      ved4 = var_format(ved4,0) 
    end
    if ved5 == 0.0 then
     ved5 = ""
    elseif ved5 == 13.0 then
     ved5 = "-"
    elseif ved5 == 14.0 then
      ved5 = "o"
    end
    if ved6 == 0.0 then
     ved6 = ""
    elseif ved6 == 13.0 then
     ved6 = "-"
    elseif ved6 == 14.0 then
      ved6 = "o"
    end
    txt_set(VERTSPEED_d_txt,  ved1 .. ved2 .. ved3 .. ved4 .. ved5 .. ved6 )    
  end  
  variable_subscribe("XPLANE", VED1, "FLOAT", "XPLANE", VED2, "FLOAT", "XPLANE", VED3, "FLOAT", "XPLANE",
                     VED4, "FLOAT", "XPLANE", VED5, "FLOAT", "XPLANE", VED6, "FLOAT", read_VS_digits_cb) 
                 
  function read_VS_cb(vsinc)
    VS_inc = vsinc 
  end
  variable_subscribe("XPLANE", Vertical_ffdref, "FLOAT", read_VS_cb)
  
 function turn_VS_cb (direction3)
    if direction3 > 0 then
      VS_inc = VS_inc + 1
      img_rotate(VS_img, VS_inc)
    else
      VS_inc = VS_inc - 1
      img_rotate(VS_img, VS_inc)
    end
    xpl_dataref_write(Vertical_ffdref, "FLOAT", VS_inc)
  end
  dial_id4 = dial_add(Nil, 936, 155, 40, 90, turn_VS_cb)
  
  function VSPush_p_cb()
       xpl_dataref_write(VerticalMode_ffdref, "FLOAT", 1.0 )
    visible(VS_img, false) 
    visible(VS_pushed_img, true)
    visible(VS_pulled_img, false)
  end
  function VSPush_r_cb()
       xpl_dataref_write(VerticalMode_ffdref, "FLOAT", 0.0)
    visible(VS_img, true) 
    visible(VS_pushed_img, false)
    visible(VS_pulled_img, false)
  end
  VSPush_button = button_add(Nil, Nil,  876, 155, 60, 60, VSPush_p_cb, VSPush_r_cb)
  mouse_setting(VSPush_button, "CURSOR", "hand_cursor.png")  

  function VSpull_p_cb()
       xpl_dataref_write(VerticalMode_ffdref, "FLOAT", -1.0)
    visible(VS_img, false) 
    visible(VS_pushed_img, false)
    visible(VS_pulled_img, true)    
  end
  function VSpull_r_cb()
       xpl_dataref_write(VerticalMode_ffdref, "FLOAT", 0.0)
    visible(VS_img, true) 
    visible(VS_pushed_img, false)
    visible(VS_pulled_img, false)
  end
  VSpull_button = button_add(Nil, Nil,  876, 205, 60, 60, VSpull_p_cb, VSpull_r_cb) 
  mouse_setting(VSpull_button, "CURSOR", "grab_cursor.png")
--=============================================================
-- 1.5 HDG,TRK/VS,VPA
--============================================================= 
  function HDGVS_p_cb()
    xpl_dataref_write(HDGVS_ffdref, "FLOAT", 1.0)
  end
  function HDGVS_r_cb()
    xpl_dataref_write(HDGVS_ffdref, "FLOAT", 0.0)
  end
  HDGVS_button = button_add("SPDMACH.png", "SPDMACH_p.png",489, 122, 45, 45, HDGVS_p_cb, HDGVS_r_cb)
  
  function HDGVS_Mode_cb (HDGVS_Mode)
    if HDGVS_Mode == 0.0 then
      txt_set(HDG2_txt, "HDG")         
      txt_set(TRK2_txt, "")         
      txt_set(HDG3_txt, "HDG")         
      txt_set(TRK3_txt, "")
      txt_set(VS3_txt, "V/S") 
      txt_set(FPA3_txt, "")
      txt_set(VS6_txt, "V/S") 
      txt_set(FPA7_txt, "")
    else
      txt_set(HDG2_txt, "")         
      txt_set(TRK2_txt, "TRK")         
      txt_set(HDG3_txt, "")         
      txt_set(TRK3_txt, "TRK")
      txt_set(VS3_txt, "") 
      txt_set(FPA3_txt, "FPA")
      txt_set(VS6_txt, "") 
      txt_set(FPA7_txt, "FPA")
    end    
  end  
  variable_subscribe("XPLANE", HDGVS_Mode_ffdref, "FLOAT", HDGVS_Mode_cb)
--========================================================================
-- 1.6 Metric
--========================================================================
  function METRIC_p_cb()
    xpl_dataref_write(METRIC_ffdref, "FLOAT", 1.0)
  end
  function METRIC_r_cb()
    xpl_dataref_write(METRIC_ffdref, "FLOAT", 0.0)
  end
  METRIC_button = button_add("SPDMACH.png", "SPDMACH_p.png",778, 122, 45, 45, METRIC_p_cb, METRIC_r_cb)
--========================================================================
-- 1.7 Buttons LOC, AP1, AP2, ATHR, EXPED, APPR
--======================================================================== 
  function LOC_p_cb()
    xpl_dataref_write(LOC_ffdref, "FLOAT", 1.0)
  end
  function LOC_r_cb()
    xpl_dataref_write(LOC_ffdref, "FLOAT", 0.0)
  end
  LOC_button = button_add("LOC.png", "LOC_p.png",  280, 295, 60, 45, LOC_p_cb, LOC_r_cb) 
  
  function AP1_p_cb()
    xpl_dataref_write(AP1_ffdref, "FLOAT", 1.0)
  end
  function AP1_r_cb()
    xpl_dataref_write(AP1_ffdref, "FLOAT", 0.0)
  end
  AP1_button = button_add("AP1.png", "AP1_p.png",  430, 190, 60, 60, AP1_p_cb, AP1_r_cb) 
 
  function AP2_p_cb()
    xpl_dataref_write(AP2_ffdref, "FLOAT", 1.0)
  end
  function AP2_r_cb()
    xpl_dataref_write(AP2_ffdref, "FLOAT", 0.0)
  end
  AP2_button = button_add("AP2.png", "AP2_p.png",  530, 190, 60, 60, AP2_p_cb, AP2_r_cb) 
  
  function ATHR_p_cb()
    xpl_dataref_write(ATHR_ffdref, "FLOAT", 1.0)
  end
  function ATHR_r_cb()
    xpl_dataref_write(ATHR_ffdref, "FLOAT", 0.0)
  end
  ATHR_button = button_add("ATHR.png", "ATHR_p.png",  480, 275, 60, 60, ATHR_p_cb, ATHR_r_cb) 
  
  function EXPED_p_cb()
    xpl_dataref_write(EXPED_ffdref, "FLOAT", 1.0)
  end
  function EXPED_r_cb()
    xpl_dataref_write(EXPED_ffdref, "FLOAT", 0.0)
  end
  EXPED_button = button_add("EXPED.png", "EXPED_p.png",  674, 295, 60, 45, EXPED_p_cb, EXPED_r_cb) 
  
  function APPR_p_cb()
    xpl_dataref_write(APPR_ffdref, "FLOAT", 1.0)
  end
  function APPR_r_cb()
    xpl_dataref_write(APPR_ffdref, "FLOAT", 0.0)
  end
  APPR_button = button_add("APPR.png", "APPR_p.png",  880, 295, 60, 45, APPR_p_cb, APPR_r_cb) 
--========================================================================
-- 1.8 Buttons LOC, AP1, AP2, ATHR, EXPED, APPR  status lights
--======================================================================== 
  local LOC_li_img          = img_add ("ON_stripes.png", 295, 305, 30, 7)
  local AP1_li_img          = img_add ("ON_stripes.png", 445, 205, 30, 7)
  local AP2_li_img            = img_add ("ON_stripes.png", 545, 205, 30, 7) 
  local ATHR_li_img           = img_add ("ON_stripes.png", 495, 290, 30, 7)      
  local EXPED_li_img           = img_add ("ON_stripes.png", 690, 305, 30, 7)    
  local APPR_li_img          = img_add ("ON_stripes.png", 895, 305, 30, 7)
  
  function LOC_li_cb (light_on1)
    if light_on1 >= 0.5 then
      visible(LOC_li_img,true)
    else
      visible(LOC_li_img,false)   
    end    
  end   
  variable_subscribe("XPLANE",LocalizerLi_ffdref, "FLOAT", LOC_li_cb)
  
   function AP1_li_cb (light_on2)
    if light_on2 >= 0.5 then
      visible(AP1_li_img,true)
    else
      visible(AP1_li_img,false)   
    end    
  end  
  variable_subscribe("XPLANE",AutoPilotLi1_ffdref, "FLOAT", AP1_li_cb) 
  
  function AP2_li_cb (light_on3)
    if light_on3 >= 0.5 then
      visible(AP2_li_img,true)
    else
      visible(AP2_li_img,false)   
    end    
  end  
  variable_subscribe("XPLANE",AutoPilotLi2_ffdref, "FLOAT", AP2_li_cb)
  
  function ATHR_li_cb (light_on4)
    if light_on4 >= 0.5 then
      visible(ATHR_li_img,true)
    else
      visible(ATHR_li_img,false)   
    end    
  end  
  variable_subscribe("XPLANE",    AutoThrustLi_ffdref, "FLOAT", ATHR_li_cb) 
 
  function EXPED_li_cb (light_on5)
    if light_on5 >= 0.5 then
      visible(EXPED_li_img,true)
    else
      visible(EXPED_li_img,false)   
    end    
  end  
  variable_subscribe("XPLANE",    ExpediteLi_ffdref, "FLOAT", EXPED_li_cb) 
  
  function APPR_li_cb (light_on6)
    if light_on6 >= 0.5 then
      visible(APPR_li_img,true)
    else
      visible(APPR_li_img,false)   
    end    
  end  
  variable_subscribe("XPLANE",    ApproachLi_ffdref, "FLOAT", APPR_li_cb)  