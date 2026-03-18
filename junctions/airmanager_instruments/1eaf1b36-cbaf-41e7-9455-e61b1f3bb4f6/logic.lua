--[[
    Title:           Autoland Captain side for FlyByWire Airbus A320 (Air Manager instrument)
    Author:          Yves Levesque adapted for MSFS 2020
    Contributors:    Alexander Hildmann created for FlightFactor A320 on Xplane
    IMPORTANT:       To use "Illumination mode", Illumination Pedestal Captain instrument is needed                     
    Changes:         2021-12-21: Changed Light to Illumination Mode
                     2022-02-06: Corrected button animation (AH)  
                     2022-02-25:  Added compact mode (YL)
                     2023-01-11: Correct Master Warning and MAster Caution variable write
                     2023-02-12  YL  Change msfs_variable_write to msfs_rpn()
                     2024-12-21  YL  v3.0 Adapt to MSFS2024
    ======================================================================= --]]
-- IMAGES/TEXT
   compact_user      =  user_prop_get(user_prop_add_boolean("Compact Panel", false, "Use Compact panel (149x380)"))
   local backplate_img 
   local night_overlay_img
   local text_overlay_img
   local text_overlay_y_img
  
   if compact_user then
       backplate_img           = img_add("a320_autoland_panel_compact.png",0,0, 128, 326) 
       night_overlay_img       = img_add("a320_autoland_panel_compact_night.png", 0,0, 128, 326)
       text_overlay_img        = img_add("a320_autoland_panel_compact_text.png", 0,0, 128, 326)
       text_overlay_y_img      = img_add("a320_autoland_panel_compact_text_yellow.png", 0,0, 128, 326)
   else
       backplate_img           = img_add_fullscreen("a320_autoland_panel.png") --440,326
       night_overlay_img       = img_add_fullscreen("a320_autoland_panel_night.png")
       text_overlay_img        = img_add_fullscreen("a320_autoland_panel_text.png")
       text_overlay_y_img      = img_add_fullscreen("a320_autoland_panel_text_yellow.png")
   end

   local MastCautL_img           = img_add ("ko_or_all_back.png",159,203,71,71); visible(MastCautL_img,false)
   local MastCautL_p_img         = img_add ("ko_master_caut_but_push.png",159,204,71,71); visible(MastCautL_p_img,false)
   local MastCautL_r_img         = img_add ("ko_master_caut_but_rel.png",159,204,71,71)
   local MastWarnL_img           = img_add ("ko_redr_all_back.png",161,94,70,70); visible(MastWarnL_img,false)
   local MastWarnL_p_img         = img_add ("ko_master_warn_but_push.png",161,94,71,71); visible(MastWarnL_p_img,false)
   local MastWarnL_r_img         = img_add ("ko_master_warn_but_rel.png",161,94,71,71)
   local Autoland_img            = img_add ("ko_redr_all_back.png",31,205,71,71);  visible(Autoland_img, false)
   local Autoland_p_img          = img_add ("ko_autoland_but_push.png",33,206,71,71)
   local Chrono_p_img            = img_add ("Chrono_p.png",321,101,60,60)  visible(Chrono_p_img, false)
   local Chrono_img              = img_add ("Chrono.png",321,101,60,60)
   local SidestickL_act_t_img    = img_add ("ko_grey_top_back.png",317,204,70,70); visible(SidestickL_act_t_img,false)
   local SidestickL_act_b_img    = img_add ("ko_gn_bot_back.png",317,204,70,70)visible(SidestickL_act_b_img,false)
   local SidestickL_p_img        = img_add ("ko_arrowR_Capt_but_push.png",317,204,71,71); visible(SidestickL_p_img,false)
   local SidestickL_r_img        = img_add ("ko_arrowR_Capt_but_rel.png",317,204,71,71)
   backlite1_group               = group_add(MastCautL_img,MastWarnL_img,Autoland_img,SidestickL_act_t_img,SidestickL_act_b_img)

   -- INIT
   local chrono_push  = 0
    
-- =============================================================================
-- 1.0 Autoland: Not sure if this is working !!!!
   msfs_variable_subscribe( "L:A32NX_AUTOPILOT_AUTOLAND_WARNING", "enum",  function(stat) visible(Autoland_img, stat > 0.5) end)
-- =============================================================================
-- 1.1 Master Caution:
    msfs_variable_subscribe( "L:A32NX_MASTER_CAUTION", "enum",     function(stat) visible(MastCautL_img, stat > 0.5) end)

   function MastCautL_p_cb() visible(MastCautL_p_img, true); visible(MastCautL_r_img,false) end
   function MastCautL_r_cb() visible(MastCautL_r_img, true); visible(MastCautL_p_img,false);   msfs_rpn("0 (>L:A32NX_MASTER_CAUTION, enum)  1 (>L:PUSH_AUTOPILOT_MASTERCAUT_L)") end
   MastCautL_button = button_add(nil, nil,165,210,60,60, MastCautL_p_cb, MastCautL_r_cb)
-- =============================================================================
-- 1.2 Master Warning:
   msfs_variable_subscribe( "L:A32NX_MASTER_WARNING", "enum",    function(stat) visible(MastWarnL_img, stat > 0.5) end)

   function MastWarnL_p_cb()  visible(MastWarnL_p_img,true); visible(MastWarnL_r_img,false) end
   function MastWarnL_r_cb()  visible(MastWarnL_r_img,true); visible(MastWarnL_p_img,false);  msfs_rpn("0 (>L:A32NX_MASTER_WARNING, enum) 1 (>L:PUSH_AUTOPILOT_MASTERAWARN_L)") end
   MastWarnL_button = button_add(nil,nil,165,100,60,60, MastWarnL_p_cb, MastWarnL_r_cb)
-- =============================================================================
-- 1.3 Chrono:
   function ChronoL_p_cb() visible(Chrono_img,false); visible(Chrono_p_img,true)  msfs_event("H:A32NX_EFIS_L_CHRONO_PUSHED")  end
   function ChronoL_r_cb()   visible(Chrono_p_img,false); visible(Chrono_img,true)   end
   ChronoL_button = button_add(nil,nil,320,100,60,60,ChronoL_p_cb, ChronoL_r_cb)

-- =============================================================================
-- 1.3 Sidestick Priority:
-- Switching Seems not be implemented yet !!!
   -- function SidestickL_p_cb()    end
   -- function SidestickL_r_cb()    end
   -- SidestickL_button = button_add(nil,nil,320,210,60,60,SidestickL_p_cb, SidestickL_r_cb)

   -- 6. Night Mode:
   function Illumination_mode_cb(Illumination_mode_val)
     if Illumination_mode_val[1] == 1.0 then
       opacity(night_overlay_img,      1 - Illumination_mode_val[6] * 0.037)
       var1  = var_cap(Illumination_mode_val[5] * 0.031 + 0.3, 0.3, 1.0); var1y = var_cap(Illumination_mode_val[5] * 0.25 - 5.75, 0.0, 1.0)
       opacity(text_overlay_img, var1); opacity(text_overlay_y_img, var1y); opacity(backlite1_group, var1)
     else
        opacity(night_overlay_img,0.0); opacity(text_overlay_img,1.0); opacity(text_overlay_y_img,0.0); opacity(backlite1_group,1.0)
     end
   end
   si_variable_subscribe("Illumination_mode","FLOAT[10]", Illumination_mode_cb)
   
 -- =============================================================================
-- 7 Compact Panel
  
       
  if compact_user  then
       move(MastCautL_img, 30,94,65,65);
       move(MastCautL_p_img,30,96,71,71)
       move(MastCautL_r_img,30,96,65,65)
       move(MastWarnL_img,30,172,65,65)
       move(MastWarnL_p_img,30,172,65,65)
       move(MastWarnL_r_img,30,172,65,65)
       move(Autoland_img,32,251,65,65)
       move(Autoland_p_img,32,251,65,65)
       move(Chrono_p_img,34,36,55,55)
       move(Chrono_img,34,36,55,55)
       move(MastWarnL_button,30,172,65,65)
       
       move (MastCautL_button,30,96,65,65)
       move (ChronoL_button,34,36,55,55)
       
       visible(SidestickL_act_t_img,false)
       visible(SidestickL_act_b_img,false)
       visible(SidestickL_p_img,false)
       visible(SidestickL_r_img,false)
       
       
   end

  