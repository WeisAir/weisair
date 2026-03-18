--[[
    Title:           Glareshield panel for FlyByWire Airbus A320 (Air Manager instrument)	                 
    Author:          Alexander Hildmann
    Contributors:    
    IMPORTANT:       To use "Illumination mode", Illumination Pedestal Captain instrument is needed                    
    Changes:         2022-02-13: Adapted for FlyByWire A320 (only name change no code change)  
                     2024-12-21  YL  v3.0 Adapt to MSFS2024
   =============================================================================== --]]
-- IMAGES/TEXT
   local backplate_img         = img_add_fullscreen("Glareshield_Captain_panel.png")  -- (1920, 1080)
   local night_overlay_img     = img_add_fullscreen("Glareshield_Captain_panel_night.png")
   
-- ============================================================================================
-- 1. Illumination Mode
   function Illumination_mode_cb(Illumination_mode_val)
     if Illumination_mode_val[1] == 1.0 then
       opacity(night_overlay_img, 1 - Illumination_mode_val[6] * 0.037)
     else   opacity(night_overlay_img,0.0)
     end
   end
   si_variable_subscribe("Illumination_mode","FLOAT[10]", Illumination_mode_cb)