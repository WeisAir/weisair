--[[
    Title:           Illumination panel Captain for FlyByWire Airbus A320 (Air Manager instrument)
    Author:          Yves Levesque adapted for MSFS 2020
    Contributors:    Alexander Hildmann created for FlightFactor A320 on Xplane
    IMPORTANT:       To use "Illumination mode", Illumination Pedestal Captain instrument is needed.
    Changes:         2021-12-15   v 2.1   Add Illunination Mode
                     2022-02-19: Correct Power and Illumination
                     2024-12-21  YL  v3.0 Adapt to MSFS2024
   ======================================================================= --]]
   -- IMAGES/TEXT
   local backplane_img           = img_add_fullscreen("a320_illumination_panel.png") --468, 440
   local night_overlay_img       = img_add_fullscreen("a320_illumination_panel_night.png")
   local text_overlay_img        = img_add_fullscreen("a320_illumination_panel_text.png")
   local text_overlay_y_img      = img_add_fullscreen("a320_illumination_panel_text_yellow.png")
   local FrontGPWS1_Alert_img    = img_add ("ko_rd_top_back.png",347,48,71,71); visible (FrontGPWS1_Alert_img, false)
   local FrontGPWS1_Mode5_img    = img_add ("ko_or_bot_back.png",347,48,71,70); visible (FrontGPWS1_Mode5_img, false)
   local GPWS_p_img              = img_add ("ko_gpwss_gs_but_push.png", 347,48,71,71)
   local GPWS_r_img              = img_add ("ko_gpwss_gs_but_push.png", 347,48,71,71); visible (GPWS_r_img, false)
   local Chrono_p_img            = img_add ("Chrono_p.png", 206, 183, 60, 60)
   local Chrono_img              = img_add ("Chrono.png", 206, 183, 60, 60)
   local CF_light_BRT_img        = img_add ("on.png",     213, 305, 45, 100);  visible (CF_light_BRT_img, false)
   local CF_light_DIM_img        = img_add ("center.png",     213, 305, 45, 100);  visible (CF_light_DIM_img , false)
   local CF_light_OFF_img        = img_add ("off.png",     211, 305, 45, 100)
   local PFD_Light_img           = img_add ("light_knob.png",       44, 162, 95, 95)
   local ND_Light_img            = img_add ("light_knob.png",      331, 162, 95, 95)
   local Loudspeaker_img         = img_add ("light_knob.png",       44, 306, 95, 95)
   local knob_group              = group_add(PFD_Light_img,ND_Light_img,Loudspeaker_img)
---------------------------------------------------------------------------------------------------------------------------
-- INIT -------------------------------------------------------------------------------
   local rotatel         = 0
   local interior_volume = 0.0
   local FrontPFD_L      = 0.0
   local FrontND_L       = 0.0
   local FrontConsoleL   = 0.0
   local CF_light        = 0.0
-- =============================================================================
-- 1. Front GPWS:   to be tested!!!!!!
   -- function FrontGPWS_L_cb (GPWS_stat)
     -- if GPWS_stat >= 0.5 then visible(GPWS_p_img, true) ; visible(GPWS_r_img, false)
     -- else                     visible(GPWS_p_img, false) ; visible(GPWS_r_img, true) end
   -- end
   -- variable_subscribe("XPLANE", FrontGPWS_L_ffdref, "FLOAT", FrontGPWS_L_cb)

   -- function FrontGPWS_L_p_cb() xpl_command(FrontGPWS_L_ffcmd, 1)  end
   -- function FrontGPWS_L_r_cb() xpl_command(FrontGPWS_L_ffcmd, 0)  end
   -- FrontGPWS_L_button = button_add(nil, nil, 339, 41, 82, 82, FrontGPWS_L_p_cb , FrontGPWS_L_r_cb)

   -- function FrontGPWS1_Alert_cb (GPWSA_stat)
     -- if GPWSA_stat >= 0.5 then  visible(FrontGPWS1_Alert_img,true)
     -- else                       visible(FrontGPWS1_Alert_img,false) end
   -- end
   -- variable_subscribe("XPLANE", FrontGPWS1_Alert_ffdref, "FLOAT", FrontGPWS1_Alert_cb)

   -- function FrontGPWS1_Mode5_cb (GPWSM_stat)
     -- if GPWSM_stat >= 0.5 then  visible(FrontGPWS1_Mode5_img, true)
     -- else                       visible(FrontGPWS1_Mode5_img, false) end
   -- end
   --variable_subscribe("XPLANE", FrontGPWS1_Mode5_ffdref, "FLOAT", FrontGPWS1_Mode5_cb)
-- ================================================================
-- 2. PFD Display brightness
   function FrontPFD_L_cb (val) img_rotate(PFD_Light_img,val*2.70 -220);   end
    msfs_variable_subscribe("LIGHT POTENTIOMETER:88","Percent", FrontPFD_L_cb)

   function PFD_cb (dir)
     if dir > 0 then    msfs_event("LIGHT_POTENTIOMETER_INC",88)
     else msfs_event("LIGHT_POTENTIOMETER_DEC",88)   end
    
   end
   PFD_dial = dial_add(nil, 44, 162, 95, 95, PFD_cb)
-- =============================================================================
-- 3. Exchange PFD and ND:
   -- function FrontXFR_stat_cb (ChronoL_stat)
     -- if ChronoL_stat >= 0.5 then visible(Chrono_img, false) ;  visible(Chrono_p_img, true)
     -- else                        visible(Chrono_p_img, false) ; visible(Chrono_img, true) end
   -- end
   -- variable_subscribe("XPLANE", FrontXFR_ffdref, "FLOAT", FrontXFR_stat_cb)

   -- function FrontXFR_p_cb()  xpl_command(FrontXFR_ffcmd, 1) end
   -- function FrontXFR_r_cb()  xpl_command(FrontXFR_ffcmd, 0) end
   -- ChronoL_button = button_add(nil, nil, 206, 183, 60, 60, FrontXFR_p_cb , FrontXFR_r_cb)
-- ================================================================
-- 4. ND Display brightness
   function FrontND_L_cb (val)  img_rotate(ND_Light_img,val * 2.70 -220) end
    msfs_variable_subscribe("LIGHT POTENTIOMETER:89","Percent", FrontND_L_cb)

   function ND_cb (dir)
     if dir > 0 then    msfs_event("LIGHT_POTENTIOMETER_INC",89)
     else             msfs_event("LIGHT_POTENTIOMETER_DEC",89)   end
   end
   ND_dial = dial_add(nil, 331, 162, 95, 95, ND_cb)
-- ================================================================
-- 5. Interior volume using xplane variable not FF variable !!
   --function LOUD_L_cb (val) rotatel = (val - 0.86)/0.0039 ; img_rotate(Loudspeaker_img, rotatel) end
   --variable_subscribe("XPLANE", interior_volume_dref, "FLOAT", LOUD_L_cb)
  --function LOUD_cb (dirl)
    -- if dirl > 0 then rotatel = rotatel + 2
    -- else            rotatel = rotatel - 2   end
    -- rotatel = var_cap(rotatel, -220, 35) ; interior_volume = 0.86 + rotatel * 0.0039
    -- xpl_dataref_write(interior_volume_dref, "FLOAT", interior_volume)
    -- img_rotate(Loudspeaker_img, rotatel)
  -- end
   --Loud_dial = dial_add(nil, 44, 306, 95, 95, LOUD_cb)
-- ==========================================================================
-- 6. Console Floor light switch
   function CF_light_cb (CF_lightval)
     if  CF_lightval == 0.0 then
       CF_light = 0.0
       visible(CF_light_BRT_img,false); visible(CF_light_DIM_img,false); visible(CF_light_OFF_img,true)
     elseif CF_lightval == 50 then
       CF_light = 1.0
       visible(CF_light_BRT_img,false) ; visible(CF_light_DIM_img,true) ; visible(CF_light_OFF_img,false)
     elseif CF_lightval == 100 then
       CF_light = 2.0
       visible(CF_light_BRT_img,true) ; visible(CF_light_DIM_img,false) ; visible(CF_light_OFF_img,false)
     end
     switch_set_position(CF_light_switch, CF_light)
   end
    msfs_variable_subscribe("LIGHT POTENTIOMETER:8","Percent", CF_light_cb)

   function CF_light_turn_cb (position, direction)
     if direction == 1 and position == 1 then
        msfs_event("LIGHT_POTENTIOMETER_8_SET",100)
     elseif  position == 0 then
        msfs_event("LIGHT_POTENTIOMETER_8_SET",50)
     elseif  position == 2 then
        msfs_event("LIGHT_POTENTIOMETER_8_SET",50)
     elseif direction ~= 1 and position == 1 then
        msfs_event("LIGHT_POTENTIOMETER_8_SET",0)
     end
   end
   CF_light_switch = switch_add(nil, nil , nil, 213, 305, 45, 100,'VERTICAL', CF_light_turn_cb)
   switch_set_position(CF_light_switch, CF_light)

-- ==========================================================================
-- 7. Illumination Mode
   function Illumination_mode_cb(Illumination_mode_val)
     if Illumination_mode_val[1] == 1.0 then
       opacity(night_overlay_img, 1 - Illumination_mode_val[6] * 0.037)
       opacity(knob_group,var_cap(Illumination_mode_val[6] * 0.037,0.5,1.0))
       var1  = var_cap(Illumination_mode_val[5] * 0.031 + 0.3, 0.3, 1.0); var1y = var_cap(Illumination_mode_val[5] * 0.25 - 5.75, 0.0, 1.0)
       opacity(text_overlay_img, var1); opacity(text_overlay_y_img, var1y)
     else
        opacity(night_overlay_img,0.0); opacity(text_overlay_img,1.0); opacity(text_overlay_y_img,0.0); opacity(knob_group,1.0)
     end
   end
   si_variable_subscribe("Illumination_mode","FLOAT[10]", Illumination_mode_cb)