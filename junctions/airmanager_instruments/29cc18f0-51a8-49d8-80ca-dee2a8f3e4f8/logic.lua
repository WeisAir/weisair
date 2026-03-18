--====================================================================================
-- Airbus A320 FlightFactor ECAM instrument for Air Manager
-- Author:   Alexander Hildmann
-- Date: September 9 2019
-- Last tested:   with Windows 10, Xplane (11.35r1) and
-- FlightFactor A320 Ultimate(0.10.8-2305) 
-- IMPORTANT!!!!
-- Specific FFA320 datarefs are used, these datarefs where added starting version 0.94 
-- Please read the FFA320 documentation for more info regarding datarefs
-- Some datarefs used in this instrument must be added to the file:
-- X-Plane 11/aircraft/FlightFactor A320 ultimate/data/publish.txt (create file if not exist)
-- Paste content of add2publish.txt file (included in this instrument, resource directory) into publish.txt
-- Known Errors:
-- FFA320 variables for the button lights are working but not properly. The problem is reported to FlightFactor.
-- If problem is fixed in the future, ButtonLightx/State should be used instead of ButtonLightx/Power.
--====================================================================================
--Images -------------------------------------------------
  local backplate_img           = img_add ("a320_ecam_panel.png",  0, 0, 888, 300)
  local emer_but_img            = img_add ("EMER.png",  555, 20, 60, 45)
  local emer_but_p_img          = img_add ("EMER_p.png",  555, 20, 60, 45)
  local emer_cover_closed_img   = img_add ("emer_cover_closed.png",  540, 15, 85, 55)
  local emer_cover_open_img     = img_add ("emer_cover_open.png",  540, 15, 85, 55)
  local ecam_knob_uper_img      = img_add ("ecam_knob.png",  92, 59, 90, 90)
  local ecam_knob_lower_img     = img_add ("ecam_knob.png",  92, 185, 90, 90)
  
  visible(emer_cover_closed_img, true)
  visible(emer_cover_open_img, false)
  visible(emer_but_img, true)
  visible(emer_but_p_img, false)
  
--Xplane  ------------------------------------------------- 
  local CancProt_ffdref = "a320/Pedestal/ECAM_CancProt" 
  local TOCONFIG_ffdref = "a320/Pedestal/ECAM_Button1"
  local EMER_CAN_ffdref = "a320/Pedestal/ECAM_Button2"
  local ENG_ffdref 		= "a320/Pedestal/ECAM_Button3"
  local BLEED_ffdref 	= "a320/Pedestal/ECAM_Button4"
  local PRESS_ffdref 	= "a320/Pedestal/ECAM_Button5"
  local ELEC_ffdref 	= "a320/Pedestal/ECAM_Button6"
  local HYD_ffdref 		= "a320/Pedestal/ECAM_Button7"
  local FUEL_ffdref		= "a320/Pedestal/ECAM_Button8"
  local APU_ffdref 		= "a320/Pedestal/ECAM_Button9"
  local COND_ffdref		= "a320/Pedestal/ECAM_Button10"
  local DOOR_ffdref 	= "a320/Pedestal/ECAM_Button11"
  local WHEEL_ffdref	= "a320/Pedestal/ECAM_Button12"
  local FCTL_ffdref 	= "a320/Pedestal/ECAM_Button13"
  local ALL_ffdref 		= "a320/Pedestal/ECAM_Button14"
  local CLRL_ffdref 	= "a320/Pedestal/ECAM_Button15"
  local STS_ffdref 		= "a320/Pedestal/ECAM_Button16"
  local RCL_ffdref 		= "a320/Pedestal/ECAM_Button17"
  local CLRR_ffdref 	= "a320/Pedestal/ECAM_Button18"
  local ENG_li_ffdref   = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight1/Power" --Add to publish.txt
  local BLEED_li_ffdref = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight2/Power" --Add to publish.txt
  local PRESS_li_ffdref = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight3/Power" --Add to publish.txt
  local ELEC_li_ffdref  = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight4/Power" --Add to publish.txt
  local HYD_li_ffdref   = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight5/Power" --Add to publish.txt
  local FUEL_li_ffdref  = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight6/Power" --Add to publish.txt
  local APU_li_ffdref   = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight7/Power" --Add to publish.txt
  local COND_li_ffdref  = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight8/Power" --Add to publish.txt
  local DOOR_li_ffdref  = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight9/Power" --Add to publish.txt
  local WHEEL_li_ffdref = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight10/Power" --Add to publish.txt
  local FCTL_li_ffdref  = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight11/Power" --Add to publish.txt
  local STS_li_ffdref   = "a320/Aircraft/Cockpit/Pedestal/ECAM_ButtonLight13/Power" --Add to publish.txt
--Initialize  
   local emer_cover_open = 0 
   local rotate1 = 90
   local rotate2 = 90
--=============================================================================
-- 1.0 ECAM buttons
--=============================================================================
  function TOCONFIG_p_cb()
    xpl_dataref_write(TOCONFIG_ffdref, "FLOAT", 1.0)
  end
  function TOCONFIG_r_cb()
    xpl_dataref_write(TOCONFIG_ffdref, "FLOAT", 0.0)
  end
  TOCONFIG_button = button_add("TO.png", "TO_p.png", 335, 20, 60, 45, TOCONFIG_p_cb , TOCONFIG_r_cb)
  
  function EMER_CAN_p_cb()
    if emer_cover_open == 1 then
      xpl_dataref_write(EMER_CAN_ffdref, "FLOAT", 1.0)
	  visible(emer_but_img, false)
      visible(emer_but_p_img, true)
	end  
  end
  function EMER_CAN_r_cb()
    if emer_cover_open == 1 then
      xpl_dataref_write(EMER_CAN_ffdref, "FLOAT", 0.0)
      visible(emer_but_img, true)
      visible(emer_but_p_img, false)
	end  
  end
  EMER_CAN_button = button_add(nil, nil, 555, 20, 60, 45, EMER_CAN_p_cb, EMER_CAN_r_cb  )
 
  function CancProt_cb(CancProt_stat)
    if CancProt_stat >= 0.5 then
	  visible(emer_cover_closed_img, false)
      visible(emer_cover_open_img, true)
	  emer_cover_open = 1
	else
	  visible(emer_cover_closed_img, true)
      visible(emer_cover_open_img, false)
	  emer_cover_open = 0
    end	  
  end
  variable_subscribe("XPLANE", CancProt_ffdref, "FLOAT", CancProt_cb )
 
  function EMER_CAN_protect_open_cb()
    xpl_dataref_write(CancProt_ffdref, "FLOAT", 1.0)
  end
  EMER_CAN_protect_open_button = button_add(nil, nil, 555, 15, 55, 20, EMER_CAN_protect_open_cb )
  mouse_setting(EMER_CAN_protect_open_button , "CURSOR", "prot_cap_open.png")
   
  function EMER_CAN_protect_close_cb()
    xpl_dataref_write(CancProt_ffdref, "FLOAT", 0.0)	
  end
  EMER_CAN_protect_close_button = button_add(nil, nil, 540, 15, 20, 20, EMER_CAN_protect_close_cb )
  mouse_setting(EMER_CAN_protect_close_button , "CURSOR", "prot_cap_close.png")

--------------------------------------------------------------------------------
  function ENG_p_cb()
    xpl_dataref_write(ENG_ffdref, "FLOAT", 1.0)
  end
  function ENG_r_cb()
    xpl_dataref_write(ENG_ffdref, "FLOAT", 0.0)
  end
  ENG_button = button_add("ENG.png", "ENG_p.png", 260, 95, 60, 45, ENG_p_cb, ENG_r_cb )

  function BLEED_p_cb()
    xpl_dataref_write(BLEED_ffdref, "FLOAT", 1.0)
  end
  function BLEED_r_cb()
    xpl_dataref_write(BLEED_ffdref, "FLOAT", 0.0)
  end
  BLEED_button = button_add("BLEED.png", "BLEED_p.png", 335, 95, 60, 45, BLEED_p_cb, BLEED_r_cb )
  
  function PRESS_p_cb()
    xpl_dataref_write(PRESS_ffdref, "FLOAT", 1.0)
  end
  function PRESS_r_cb()
    xpl_dataref_write(PRESS_ffdref, "FLOAT", 0.0)
  end
  PRESS_button = button_add("PRESS.png", "PRESS_p.png", 410, 95, 60, 45, PRESS_p_cb, PRESS_r_cb)

  function ELEC_p_cb()
    xpl_dataref_write(ELEC_ffdref, "FLOAT", 1.0)
  end
  function ELEC_r_cb()
    xpl_dataref_write(ELEC_ffdref, "FLOAT", 0.0)
  end
  ELEC_button = button_add("ELEC.png", "ELEC_p.png", 485, 95, 60, 45, ELEC_p_cb, ELEC_r_cb )
  
  function HYD_p_cb()
    xpl_dataref_write(HYD_ffdref, "FLOAT", 1.0)
  end
  function HYD_r_cb()
    xpl_dataref_write(HYD_ffdref, "FLOAT", 0.0)
  end
  HYD_button = button_add("HYD.png", "HYD_p.png", 560, 95, 60, 45, HYD_p_cb , HYD_r_cb)

  function FUEL_p_cb()
    xpl_dataref_write(FUEL_ffdref, "FLOAT", 1.0)
  end
  function FUEL_r_cb()
    xpl_dataref_write(FUEL_ffdref, "FLOAT", 0.0)
  end
  FUEL_button = button_add("FUEL.png", "FUEL_p.png", 635, 95, 60, 45, FUEL_p_cb, FUEL_r_cb )
-----------------------------------------------------------------------
  function APU_pressed_cb()
    xpl_dataref_write(APU_ffdref, "FLOAT", 1.0)
  end
  APU_button = button_add("APU.png","APU_p.png", 260, 160, 60, 45, APU_pressed_cb )
 
  function COND_p_cb()
    xpl_dataref_write(COND_ffdref, "FLOAT", 1.0)
  end
  function COND_r_cb()
    xpl_dataref_write(COND_ffdref, "FLOAT", 0.0)
  end
  COND_button = button_add("COND.png","COND_p.png", 335, 160, 60, 45, COND_p_cb , COND_r_cb)
  
  function DOOR_pressed_cb()
    xpl_dataref_write(DOOR_ffdref, "FLOAT", 1.0)
  end
  DOOR_button = button_add("DOOR.png", "DOOR_p.png", 410, 160, 60, 45, DOOR_pressed_cb )

  function WHEEL_p_cb()
    xpl_dataref_write(WHEEL_ffdref, "FLOAT", 1.0)
  end
  function WHEEL_r_cb()
    xpl_dataref_write(WHEEL_ffdref, "FLOAT", 0.0)
  end
  WHEEL_button = button_add("WHEEL.png", "WHEEL_p.png", 485, 160, 60, 45, WHEEL_p_cb, WHEEL_r_cb )

  function FCTL_p_cb()
    xpl_dataref_write(FCTL_ffdref, "FLOAT", 1.0)
  end
  function FCTL_r_cb()
    xpl_dataref_write(FCTL_ffdref, "FLOAT", 0.0)
  end
  FCTL_button = button_add("FCTL.png", "FCTL_p.png", 560, 160, 60, 45, FCTL_p_cb, FCTL_r_cb )

  function ALL_p_cb()
    xpl_dataref_write(ALL_ffdref, "FLOAT", 1.0)
  end
  function ALL_r_cb()
    xpl_dataref_write(ALL_ffdref, "FLOAT", 0.0)
  end
  ALL_button = button_add("ALL.png","ALL_p.png", 635, 160, 60, 45, ALL_p_cb, ALL_r_cb )
----------------------------------------------------------------------  
  function CLRL_p_cb()
    xpl_dataref_write(CLRL_ffdref, "FLOAT", 1.0)
  end
  function CLRL_r_cb()
    xpl_dataref_write(CLRL_ffdref, "FLOAT", 0.0)
  end
  CLRL_button = button_add("CLR.png", "CLR_p.png", 260, 225, 60, 45, CLRL_p_cb , CLRL_r_cb )

  function STS_p_cb()
    xpl_dataref_write(STS_ffdref, "FLOAT", 1.0)
  end
  function STS_r_cb()
    xpl_dataref_write(STS_ffdref, "FLOAT", 0.0)
  end
  STS_button = button_add("STS.png", "STS_p.png", 410, 225, 60, 45, STS_p_cb, STS_r_cb )
  
  function RCL_p_cb()
    xpl_dataref_write(RCL_ffdref, "FLOAT", 1.0)
  end
  function RCL_r_cb()
    xpl_dataref_write(RCL_ffdref, "FLOAT", 0.0)
  end
  RCL_button = button_add("RCL.png","RCL_p.png", 485, 225, 60, 45, RCL_p_cb, RCL_r_cb )
  
  function CLRR_p_cb()
    xpl_dataref_write(CLRL_ffdref, "FLOAT", 1.0)
  end
  function CLRR_r_cb()
    xpl_dataref_write(CLRL_ffdref, "FLOAT", 0.0)
  end
  CLRR_button = button_add("CLR.png", "CLR_p.png", 635, 225, 60, 45, CLRR_p_cb, CLRR_r_cb )
-----------------------------------------------------------------------------------------
--=============================================================================
-- 1.1 ECAM lights 
--=============================================================================
  function ENG_li_cb (ENG_li_stat)
    if ENG_li_stat >= 0.5 then
	  visible(ENG_li_img, true)
	else
      visible(ENG_li_img, false)	
    end	  
  end
  variable_subscribe("XPLANE", ENG_li_ffdref, "FLOAT", ENG_li_cb )
  
  function BLEED_li_cb (BLEED_li_stat)
    if BLEED_li_stat >= 0.5 then
	  visible(BLEED_li_img, true)
	else
	  visible(BLEED_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", BLEED_li_ffdref, "FLOAT", BLEED_li_cb )
  
   function PRESS_li_cb (PRESS_li_stat)
    if PRESS_li_stat >= 0.5 then
	  visible(PRESS_li_img, true)
    else
	  visible(PRESS_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", PRESS_li_ffdref, "FLOAT", PRESS_li_cb )
  
  function ELEC_li_cb (ELEC_li_stat)
    if ELEC_li_stat >= 0.5 then
	  visible(ELEC_li_img, true)
    else
	  visible(ELEC_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", ELEC_li_ffdref, "FLOAT", ELEC_li_cb )
  
  function HYD_li_cb (HYD_li_stat)
    if HYD_li_stat >= 0.5 then
	  visible(HYD_li_img, true)
	else
	  visible(HYD_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", HYD_li_ffdref, "FLOAT", HYD_li_cb )
  
  function FUEL_li_cb (FUEL_li_stat)
    if FUEL_li_stat >= 0.5 then
	  visible(FUEL_li_img, true)
	else
	  visible(FUEL_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", FUEL_li_ffdref, "FLOAT", FUEL_li_cb )
  
  function APU_li_cb (APU_li_stat)
    if APU_li_stat >= 0.5 then
	  visible(APU_li_img, true)
	else
	  visible(APU_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", APU_li_ffdref, "FLOAT", APU_li_cb )
  
  function COND_li_cb (COND_li_stat)
    if COND_li_stat >= 0.5 then
	  visible(COND_li_img, true)
	else
	  visible(COND_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", COND_li_ffdref, "FLOAT", COND_li_cb )
  
  function DOOR_li_cb (DOOR_li_stat)
    if DOOR_li_stat >= 0.5 then
	  visible(DOOR_li_img, true)
	else
	  visible(DOOR_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", DOOR_li_ffdref, "FLOAT", DOOR_li_cb )
  
  function WHEEL_li_cb (WHEEL_li_stat)
    if WHEEL_li_stat >= 0.5 then
	  visible(WHEEL_li_img, true)
	else
	  visible(WHEEL_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", WHEEL_li_ffdref, "FLOAT", WHEEL_li_cb )
  
  function FCTL_li_cb (FCTL_li_stat)
    if FCTL_li_stat >= 0.5 then
	  visible(FCTL_li_img, true)
	else
	  visible(FCTL_li_img, false)
    end	  
  end
  variable_subscribe("XPLANE", FCTL_li_ffdref, "FLOAT", FCTL_li_cb )
  
  function STS_li_cb (STS_li_stat)
    if STS_li_stat >= 0.5 then
	  visible(STS_li_img, true)
	else 
      visible(STS_li_img, false)	
    end	  
  end
  variable_subscribe("XPLANE", STS_li_ffdref, "FLOAT", STS_li_cb )
--================================================================  
-- 1.2 ECAM upper/lower display brightness dummy  
--================================================================  
 function turn_upper_cb (directionu)    
    if directionu > 0 then
      rotate1 = rotate1 + 1
    else
      rotate1 = rotate1 - 1
    end
    img_rotate(ecam_knob_uper_img, rotate1)
  end
 -- dial_id = dial_add(nil, 92, 59, 90, 90, turn_upper_cb)
  
  function turn_lower_cb (directionl)    
    if directionl > 0 then
      rotate2 = rotate2 + 1
    else
      rotate2 = rotate2 - 1
    end
    img_rotate(ecam_knob_lower_img, rotate2)
  end
  --dial_id = dial_add(nil, 92, 185, 90, 90, turn_lower_cb) 
-----------------------------------------------------------------  
  ENG_li_img      = img_add("ON_stripes.png" , 275, 105, 30, 7) 
  BLEED_li_img    = img_add("ON_stripes.png" , 350, 105, 30, 7) 
  PRESS_li_img    = img_add("ON_stripes.png" , 425, 105, 30, 7) 
  ELEC_li_img     = img_add("ON_stripes.png" , 500, 105, 30, 7) 
  HYD_li_img      = img_add("ON_stripes.png" , 575, 105, 30, 7) 
  FUEL_li_img     = img_add("ON_stripes.png" , 650, 105, 30, 7) 
  APU_li_img      = img_add("ON_stripes.png" , 275, 170, 30, 7) 
  COND_li_img     = img_add("ON_stripes.png" , 350, 170, 30, 7) 
  DOOR_li_img     = img_add("ON_stripes.png" , 425, 170, 30, 7) 
  WHEEL_li_img    = img_add("ON_stripes.png" , 500, 170, 30, 7) 
  FCTL_li_img     = img_add("ON_stripes.png" , 575, 170, 30, 7) 
  STS_li_img      = img_add("ON_stripes.png" , 425, 235, 30, 7) 
 
--=============================================================================
-- 1.3 Reset ECAM ligths
--=============================================================================
  function reset_ECAM_lights_cb()
    visible(ENG_li_img,false)
    visible(BLEED_li_img,false)
    visible(PRESS_li_img,false)
    visible(ELEC_li_img,false)
    visible(HYD_li_img,false) 
    visible(FUEL_li_img,false)
    visible(APU_li_img,false) 
    visible(COND_li_img,false)
    visible(DOOR_li_img,false)
    visible(WHEEL_li_img,false) 
    visible(FCTL_li_img,false) 
    visible(STS_li_img,false) 
  end
--------------------------------------------------  
  reset_ECAM_lights_cb()

