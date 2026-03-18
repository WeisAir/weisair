--===================================================================================
-- Airbus A320 FlightFactor EFIS instrument for Air Manager
-- Author:   Alexander Hildmann
-- Date: September 6 2019
-- Last tested:   with Windows 10, Xplane (11.35r1) and
-- FlightFactor A320 Ultimate(0.10.8-2305) 
-- IMPORTANT!!!!
-- Specific FFA320 datarefs are used, these datarefs where added starting version 0.94 
-- Please read the FFA320 documentation for more info regarding datarefs
-- Some datarefs used in this instrument must be added to the file:
-- X-Plane 11/aircraft/FlightFactor A320 ultimate/data/publish.txt (create file if not exist)
-- Paste content of add2publish.txt file (included in this instrument, resource directory) into publish.txt
--====================================================================================
--Images -------------------------------------------------	
  local backplate_img          = img_add ("efis_panel.png",  0, 0,620, 360)
  local NavMode_knob_base_img  = img_add ("efis_knob_base.png", 268, 155, 100, 100)
  local NavMode_knob_img       = img_add ("efis_knob.png", 293, 160, 40, 80)
  local Range_knob_Base_img    = img_add ("efis_knob_base.png", 465, 155, 100, 100)
  local Range_knob_img         = img_add ("efis_knob.png", 489, 160, 40, 80)
  local VORL_l_switch_img      = img_add ("vor_l.png", 265, 280, 100, 45)
  local VORL_r_switch_img      = img_add ("vor_r.png", 265, 280, 100, 45) 
  local VORL_c_switch_img      = img_add ("vor_c.png", 265, 280, 100, 45) 
  local VORR_l_switch_img      = img_add ("vor_l.png", 460, 280, 100, 45)
  local VORR_r_switch_img      = img_add ("vor_r.png", 460, 280, 100, 45) 
  local VORR_c_switch_img      = img_add ("vor_c.png", 460, 280, 100, 45) 
  local inHg_img               = img_add ("inHg.png", 64, 175, 90, 90)  
  local hPa_img                = img_add ("hPa.png", 64, 175, 90, 90) 
  local StdPull_img            = img_add ("StdPull.png", 61, 170, 100, 100) 
  local StdPull_pushed_img     = img_add ("StdPull_pushed.png", 61, 170, 100, 100) 
  local StdPull_pulled_img     = img_add ("StdPull_pulled.png", 61, 170, 100, 100) 
  
  visible(StdPull_img, true) 
  visible(StdPull_pushed_img, false)
  visible(StdPull_pulled_img, false) 
 
  BARO_txt                   = txt_add("", "font:arimo_bold.ttf ; size:16; color:white; halign:left;", 58,77, 50, 20)
  QNH_txt                    = txt_add("", "font:arimo_bold.ttf ; size:16; color:white; halign:left;", 130,77, 50, 20)
  BARO_val_txt               = txt_add("1023", "font:digital-7-mono.ttf ; size:45; color:orange; halign:left;", 52,95, 150, 50)
--XPLANE -----------------------------------------------  
  local NavRangeL_ffdref     = "a320/Panel/EFIS_NavRangeL"
  local NavModeL_ffdref      = "a320/Panel/EFIS_NavModeL"
  local abf1                 = "a320/Aircraft/Cockpit/Panel/EFIS_BaroDigit1L/State" --Add to publish.txt
  local abf2                 = "a320/Aircraft/Cockpit/Panel/EFIS_BaroDigit2L/State" --Add to publish.txt
  local abf3                 = "a320/Aircraft/Cockpit/Panel/EFIS_BaroDigit3L/State" --Add to publish.txt
  local abf4                 = "a320/Aircraft/Cockpit/Panel/EFIS_BaroDigit4L/State" --Add to publish.txt
  local abf5                 = "a320/Aircraft/Cockpit/Panel/EFIS_BaroDigit5L/State" --Add to publish.txt
  local BaroModeL_ffdref     = "a320/Panel/EFIS_BaroModeL"
  local BaroMode2L_ffdref    = "a320/Aircraft/FMGS/FCU1/BaroModeL"                  --Add to publish.txt
  local BaroTypeL_ffdref     = "a320/Panel/EFIS_BaroTypeL"
  local CSTR_ffdref          = "a320/Panel/EFIS_NavType1L"
  local WPT_ffdref           = "a320/Panel/EFIS_NavType2L"
  local VORD_ffdref          = "a320/Panel/EFIS_NavType3L" 
  local NDB_ffdref           = "a320/Panel/EFIS_NavType4L" 
  local ARPT_ffdref          = "a320/Panel/EFIS_NavType5L" 
  local FD_ffdref            = "a320/Panel/EFIS_FlightDirL"
  local LS_ffdref            = "a320/Panel/EFIS_LandSysL" 
  local EFIS_Baro_ffdref     = "a320/Panel/EFIS_BaroL"
  local NavReciver1L_ffdref  = "a320/Panel/EFIS_NavReciver1L" 
  local NavReciver2L_ffdref  = "a320/Panel/EFIS_NavReciver2L" 
  local CSTR_li_ffdref       = "a320/Aircraft/Cockpit/Panel/EFIS_NavTypeLight1L/State" --Add to publish.txt
  local WPT_li_ffdref        = "a320/Aircraft/Cockpit/Panel/EFIS_NavTypeLight2L/State" --Add to publish.txt
  local VORD_li_ffdref       = "a320/Aircraft/Cockpit/Panel/EFIS_NavTypeLight3L/State" --Add to publish.txt
  local NDB_li_ffdref        = "a320/Aircraft/Cockpit/Panel/EFIS_NavTypeLight4L/State" --Add to publish.txt
  local ARPT_li_ffdref       = "a320/Aircraft/Cockpit/Panel/EFIS_NavTypeLight5L/State" --Add to publish.txt
  local FD_li_ffdref         = "a320/Aircraft/Cockpit/Panel/EFIS_FlightDirLightL/State" --Add to publish.txt
  local LS_li_ffdref         = "a320/Aircraft/Cockpit/Panel/EFIS_LandSysLightL/State" --Add to publish.txt
--Initialize--------------------------------------------------------------------------  
  local BaroModeval          = 0
  local BaroModStd           = 0
  local BaroType             = 0
  local NavModeswpos         = 0.0
  local NavRangeswpos        = 0.0
  local NavReciver1Lpos      = 0.0
  local NavReciver2Lpos      = 0.0
  local EFIS_Baroval_inc     = 0
  local StdPull_img_degree   = 0
--===================================================================  
-- 1.0 Barotype inHg or hPa 
--===================================================================   
  function BaroTypeL_cb (BaroTypeL_var)
    if  BaroTypeL_var == 0.0 then
      BaroType = 0
	  visible(inHg_img, true)
	  visible(hPa_img, false)
	else
	  BaroType = 1
	  visible(inHg_img, false)
	  visible(hPa_img, true)
	end
  end
  variable_subscribe("XPLANE", BaroTypeL_ffdref, "FLOAT", BaroTypeL_cb )  
  
  function BaroTypeL_p_cb()
   	if  BaroType == 0 then
      xpl_dataref_write(BaroTypeL_ffdref, "FLOAT", 1.0)
	else
	  xpl_dataref_write(BaroTypeL_ffdref, "FLOAT", 0.0)
	end
  end
  BaroTypeL_button = button_add(Nil, Nil,  65, 170, 90, 20, BaroTypeL_p_cb) 
  mouse_setting(BaroTypeL_button , "CURSOR", "right_left_icon.png") 
--=================================================================== 
-- 1.1 Baro display
--===================================================================     
  function read_baroval_cb (ad1,ad2,ad3,ad4,ad5)
    if ad1 == 0.0 then
   	 ad1 = " "
	elseif ad1 == 17.0 then
	  BaroModStd = 1
	else
	  BaroModStd = 0
	  ad1 = ad1 - 1.0
	  ad1 = var_format(ad1,0) 
	end
	if ad2 == 0.0 then
	 ad2 = " "
	else
	  ad2 = ad2 - 1.0
	  ad2 = var_format(ad2,0) 
	end
	if ad3 == 15.0 then
	 ad3 = "."
	else
	  ad3 = ""	 
	end
	if ad4 == 0.0 then
	 ad4 = " "
	else
	  ad4 = ad4 - 1.0
	  ad4 = var_format(ad4,0) 
	end	
	if ad5 == 0.0 then
	 ad5 = " "
	else
	  ad5 = ad5 - 1.0
	  ad5 = var_format(ad5,0) 
	end
	if BaroModStd == 1 then
	 txt_set(BARO_val_txt, " Std ")
	 txt_set(BARO_txt, "")
	 txt_set(QNH_txt, "")
	else	
	  txt_set(BARO_val_txt,  ad1 .. ad2 .. ad3 .. ad4 .. ad5)	  
    end	  
  end  
  variable_subscribe("XPLANE", abf1, "FLOAT", "XPLANE", abf2, "FLOAT", "XPLANE", abf3, "FLOAT", "XPLANE",
                     abf4, "FLOAT", "XPLANE", abf5, "FLOAT", read_baroval_cb)
					 
--=============================================
-- 1.2 Read Baromode
--============================================= 
  function BaroModeL_cb (BaroModeL_var)
    if  BaroModeL_var      == 0.0 then
	  BaroModeval = 0
	elseif BaroModeL_var   == 1.0 then
	  BaroModeval = 1
	elseif  BaroModeL_var  == -1.0 then
	  BaroModeval = -1
	end
  end
  variable_subscribe("XPLANE", BaroModeL_ffdref, "FLOAT", BaroModeL_cb )
  
  function BaroMode2L_cb (BaroMode2L_var)
    if  BaroMode2L_var      == 1.0 then
	  txt_set(BARO_txt, "QFE")
	  txt_set(QNH_txt, "")
	else
	  txt_set(BARO_txt, "")
	  txt_set(QNH_txt, "QNH")
	end
  end
  variable_subscribe("XPLANE", BaroMode2L_ffdref, "FLOAT", BaroMode2L_cb )
--=============================================
-- 1.3 Set Baro value
--============================================= 
  function turn_baroval_cb (directiono)
    if directiono > 0 then
      EFIS_Baroval_inc = EFIS_Baroval_inc + 1
	  StdPull_img_degree = StdPull_img_degree +1
	  img_rotate(StdPull_img, StdPull_img_degree)
	else
      EFIS_Baroval_inc = EFIS_Baroval_inc - 1
	  StdPull_img_degree = StdPull_img_degree -1
	  img_rotate(StdPull_img, StdPull_img_degree)
	end
	xpl_dataref_write(EFIS_Baro_ffdref, "FLOAT", EFIS_Baroval_inc)
  end
  dial_id1 = dial_add( nil, 140, 205, 30, 50, turn_baroval_cb)
  
  function Baropush_p_cb()
   	xpl_dataref_write(BaroModeL_ffdref, "FLOAT", 1.0 )
	visible(StdPull_img, false) 
    visible(StdPull_pushed_img, true)
    visible(StdPull_pulled_img, false)
  end
  function Baropush_r_cb()
   	xpl_dataref_write(BaroModeL_ffdref, "FLOAT", 0.0)
	visible(StdPull_img, true) 
    visible(StdPull_pushed_img, false)
    visible(StdPull_pulled_img, false)
  end
  Baropush_button = button_add(Nil, Nil,  85, 205, 50, 25, Baropush_p_cb, Baropush_r_cb)
  mouse_setting(Baropush_button , "CURSOR", "hand_cursor.png")  

  function Baropull_p_cb()
   	xpl_dataref_write(BaroModeL_ffdref, "FLOAT", -1.0)
	visible(StdPull_img, false) 
    visible(StdPull_pushed_img, false)
    visible(StdPull_pulled_img, true)
  end
  function Baropull_r_cb()
   	xpl_dataref_write(BaroModeL_ffdref, "FLOAT", 0.0)
	visible(StdPull_img, true) 
    visible(StdPull_pushed_img, false)
    visible(StdPull_pulled_img, false)
  end
  Baropull_button = button_add(Nil, Nil,  85, 230, 50, 25, Baropull_p_cb, Baropull_r_cb ) 
  mouse_setting(Baropull_button , "CURSOR", "grab_cursor.png")
				 
--============================================================================					 
-- 1.4 Navmode and Navrange
--============================================================================
  function NavModeL_cb (NavModeL_var)
    if  NavModeL_var == 0.0 then
	  rotate(NavMode_knob_img, -90 )
      NavModeswpos = 0.0	  
	elseif NavModeL_var == 1.0 then
	  NavModeswpos = 1.0
	  rotate(NavMode_knob_img, -45 )	  
	elseif  NavModeL_var == 2.0 then
	  NavModeswpos = 2.0
	  rotate(NavMode_knob_img, 0 )
	elseif  NavModeL_var == 3.0 then
	  NavModeswpos = 3.0
	  rotate(NavMode_knob_img, 45 )
	elseif  NavModeL_var == 4.0 then
	  NavModeswpos = 4.0
	  rotate(NavMode_knob_img, 90 )
	end
  end
  variable_subscribe("XPLANE", NavModeL_ffdref, "FLOAT", NavModeL_cb )
  
  function NavModeL_turn_cb (dir)
    if dir == 1 then   -- turned dial clockwise towards ON
	  NavModeswpos = NavModeswpos + 1.0
      xpl_dataref_write(NavModeL_ffdref, "FLOAT", NavModeswpos)
    else
      NavModeswpos = NavModeswpos - 1.0
      xpl_dataref_write(NavModeL_ffdref, "FLOAT", NavModeswpos)
    end  
  end    
  NavModeL_dial = dial_add( nil, 270, 160, 86, 86, NavModeL_turn_cb)
 
  function NavRangeL_cb (NavRangeL_var) --
    if  NavRangeL_var == 0.0 then
	  NavRangeswpos = 0.0
	  rotate(Range_knob_img, -85 ) 
	elseif  NavRangeL_var == 1.0 then
	  NavRangeswpos = 1.0
	  rotate(Range_knob_img, -48 )
	elseif  NavRangeL_var == 2.0 then
	  NavRangeswpos = 2.0
	  rotate(Range_knob_img, 0 )
	elseif  NavRangeL_var == 3.0 then
	  NavRangeswpos = 3.0
	  rotate(Range_knob_img, 45 )
	elseif  NavRangeL_var == 4.0 then
	  NavRangeswpos = 4.0
	  rotate(Range_knob_img, 88 )
	elseif  NavRangeL_var == 5.0 then
	  NavRangeswpos = 5.0
	  rotate(Range_knob_img, 133 )
	end
  end
  variable_subscribe("XPLANE", NavRangeL_ffdref, "FLOAT", NavRangeL_cb )
  
  function NavRangeL_turn_cb (dir1)
    if dir1 == 1 then   -- turned dial clockwise towards ON
	  NavRangeswpos = NavRangeswpos + 1.0
      xpl_dataref_write(NavRangeL_ffdref, "FLOAT", NavRangeswpos)
    else
      NavRangeswpos = NavRangeswpos - 1.0
      xpl_dataref_write(NavRangeL_ffdref, "FLOAT", NavRangeswpos)
    end  
  end    
  NavRangeL_dial = dial_add( nil, 466, 160, 86, 86, NavRangeL_turn_cb)
--=============================================================================
-- 1.5 EFIS buttons controlled via instrument
--=============================================================================
  function FD_p_cb()
    xpl_dataref_write(FD_ffdref, "FLOAT", 1.0)
  end
  function FD_r_cb()
    xpl_dataref_write(FD_ffdref, "FLOAT", 0.0)
  end
  FD_button = button_add("FD.png", "FD_p.png",  40, 290, 60, 50, FD_p_cb, FD_r_cb)

  function LS_p_cb()
    xpl_dataref_write(LS_ffdref, "FLOAT", 1.0)
  end
  function LS_r_cb()
    xpl_dataref_write(LS_ffdref, "FLOAT", 0.0)
  end
  LS_button = button_add("LS.png", "LS_p.png",  120, 290, 60, 50, LS_p_cb, LS_r_cb)   
  function CSTR_p_cb()
    xpl_dataref_write(CSTR_ffdref, "FLOAT", 1.0)
  end
  function CSTR_r_cb()
    xpl_dataref_write(CSTR_ffdref, "FLOAT", 0.0)
  end
  CSTR_button = button_add("CSTR.png", "CSTR_p.png", 225, 45, 60, 50, CSTR_p_cb, CSTR_r_cb)
 
  function WPT_p_cb()
    xpl_dataref_write(WPT_ffdref, "FLOAT", 1.0)
  end
  function WPT_r_cb()
    xpl_dataref_write(WPT_ffdref, "FLOAT", 0.0)
  end
  WPT_button = button_add("WPT.png", "WPT_p.png", 300, 45, 60, 50, WPT_p_cb, WPT_r_cb)
  
  function VORD_p_cb()
   xpl_dataref_write(VORD_ffdref, "FLOAT", 1.0)
  end
  function VORD_r_cb()
    xpl_dataref_write(VORD_ffdref, "FLOAT", 0.0)
  end
  VORD_button = button_add("VORD.png", "VORD_p.png", 375, 45, 60, 50, VORD_p_cb, VORD_r_cb)
  
  function NDB_p_cb()
    xpl_dataref_write(NDB_ffdref, "FLOAT", 1.0)
  end
  function NDB_r_cb()
    xpl_dataref_write(NDB_ffdref, "FLOAT", 0.0)
  end
  NDB_button = button_add("NDB.png", "NDB_p.png",  450, 45, 60, 50, NDB_p_cb, NDB_r_cb)
 
  function ARPT_p_cb()
    xpl_dataref_write(ARPT_ffdref, "FLOAT", 1.0)
  end
  function ARPT_r_cb()
    xpl_dataref_write(ARPT_ffdref, "FLOAT", 0.0)
  end
  ARPT_button = button_add("ARPT.png", "ARPT_p.png",  525, 45, 60, 50, ARPT_p_cb, ARPT_r_cb)
--=============================================================================
-- 1.6 EFIS button lights
--============================================================================= 
  function CSTR_li_cb (CSTR_li_stat)
    if CSTR_li_stat >= 1.0 then
	  visible(CSTR_li_img, true)
    else 
	  visible(CSTR_li_img, false) 
    end	  
  end
  variable_subscribe("XPLANE", CSTR_li_ffdref, "FLOAT", CSTR_li_cb )
  
  function WPT_li_cb (WPT_li_stat)
    if WPT_li_stat >= 1.0 then
	  visible(WPT_li_img, true)
    else 
	  visible(WPT_li_img, false)	  
    end	  
  end
  variable_subscribe("XPLANE", WPT_li_ffdref, "FLOAT", WPT_li_cb )

  function VORD_li_cb (VORD_li_stat)
    if VORD_li_stat >= 1.0 then
	  visible(VORD_li_img, true)
    else 
	  visible(VORD_li_img, false)	  
    end	  
  end
  variable_subscribe("XPLANE", VORD_li_ffdref, "FLOAT", VORD_li_cb )
  
  function NDB_li_cb (NDB_li_stat)
    if NDB_li_stat >= 1.0 then
	  visible(NDB_li_img, true)
    else 
	  visible(NDB_li_img, false)	  
    end	 
  end
  variable_subscribe("XPLANE", NDB_li_ffdref, "FLOAT", NDB_li_cb )

  function ARPT_li_cb (ARPT_li_stat)
    if ARPT_li_stat >= 1.0 then
	  visible(ARPT_li_img, true)
   	else 
	  visible(ARPT_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", ARPT_li_ffdref, "FLOAT", ARPT_li_cb )
 
  function FD_li_cb (FD_li_stat)
    if FD_li_stat >= 1.0 then
	  visible(FD_li_img, true)
    else 
	  visible(FD_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", FD_li_ffdref, "FLOAT", FD_li_cb )
 
  function LS_li_cb (LS_li_stat)
    if LS_li_stat >= 1.0 then
	  visible(LS_li_img, true)
    else 
	  visible(LS_li_img, false)	  
    end	  
  end
  variable_subscribe("XPLANE", LS_li_ffdref, "FLOAT", LS_li_cb )
-------------------------------------------------------------------------------
  CSTR_li_img   = img_add("ON_stripes.png" , 240, 53, 30 , 7) 
  WPT_li_img    = img_add("ON_stripes.png" , 316, 53,30 , 7) 
  VORD_li_img   = img_add("ON_stripes.png" , 391, 53, 30 , 7) 
  NDB_li_img    = img_add("ON_stripes.png" , 467, 53, 30 , 7) 
  ARPT_li_img   = img_add("ON_stripes.png" , 541, 53, 30 , 7) 
  FD_li_img     = img_add("ON_stripes.png" , 55, 299, 30 , 7) 
  LS_li_img     = img_add("ON_stripes.png" , 135, 299, 30 , 7) 
--==========================================================================
-- 1.7 Nav source ADF,VOR
--==========================================================================
  function NavReciver1L_cb (NavReciver1val)
    if  NavReciver1val == 0.0 then
      NavReciver1Lpos = 0.0	
	  visible(VORL_l_switch_img, true)
	  visible(VORL_c_switch_img, false)
	  visible(VORL_r_switch_img, false)
    elseif NavReciver1val == 1.0 then
	  NavReciver1Lpos = 1.0
	  visible(VORL_l_switch_img, false) 
	  visible(VORL_c_switch_img, true)
	  visible(VORL_r_switch_img, false)
    elseif NavReciver1val == 2.0 then
	  NavReciver1Lpos = 2.0
	  visible(VORL_l_switch_img, false) 
	  visible(VORL_c_switch_img, false)
	  visible(VORL_r_switch_img, true)	  
	end
  end
  variable_subscribe("XPLANE", NavReciver1L_ffdref, "FLOAT", NavReciver1L_cb ) 
  
  function NavReciver1L_turn_cb (dir)
    if dir == 1 then   -- turned dial clockwise towards ON
	  NavReciver1Lpos = NavReciver1Lpos + 1.0
      xpl_dataref_write(NavReciver1L_ffdref, "FLOAT", NavReciver1Lpos)
    else
      NavReciver1Lpos = NavReciver1Lpos - 1.0
      xpl_dataref_write(NavReciver1L_ffdref, "FLOAT", NavReciver1Lpos)
    end  
  end    
  NavReciver1L_dial = dial_add( nil, 265, 280, 100, 45, NavReciver1L_turn_cb)
  mouse_setting(NavReciver1L_dial , "CURSOR_LEFT", "left_icon.png")
  mouse_setting(NavReciver1L_dial , "CURSOR_RIGHT", "right_icon.png")
  
  function NavReciver2L_cb (NavReciver2val)
    if  NavReciver2val == 0.0 then
      NavReciver2Lpos = 0.0	
	  visible(VORR_l_switch_img, true)
	  visible(VORR_c_switch_img, false)
	  visible(VORR_r_switch_img, false)
    elseif NavReciver2val == 1.0 then
	  NavReciver2Lpos = 1.0
	  visible(VORR_l_switch_img, false) 
	  visible(VORR_c_switch_img, true)
	  visible(VORR_r_switch_img, false)
    elseif NavReciver2val == 2.0 then
	  NavReciver2Lpos = 2.0
	  visible(VORR_l_switch_img, false) 
	  visible(VORR_c_switch_img, false)
	  visible(VORR_r_switch_img, true)	  
	end
  end
  variable_subscribe("XPLANE", NavReciver2L_ffdref, "FLOAT", NavReciver2L_cb )
  
  function NavReciver2L_turn_cb (dir1)
    if dir1 == 1 then   -- turned dial clockwise towards ON
	  NavReciver2Lpos = NavReciver2Lpos + 1.0
      xpl_dataref_write(NavReciver2L_ffdref, "FLOAT", NavReciver2Lpos)
    else
      NavReciver2Lpos = NavReciver2Lpos - 1.0
      xpl_dataref_write(NavReciver2L_ffdref, "FLOAT", NavReciver2Lpos)
    end  
  end    
  NavReciver2L_dial = dial_add( nil, 460, 280, 100, 45, NavReciver2L_turn_cb)
  mouse_setting(NavReciver2L_dial , "CURSOR_LEFT", "left_icon.png")
  mouse_setting(NavReciver2L_dial , "CURSOR_RIGHT", "right_icon.png")  