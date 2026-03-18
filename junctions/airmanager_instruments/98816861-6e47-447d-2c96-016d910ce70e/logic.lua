--[[
    Title:           Flood lights Glareshield panel for FlyByWire Airbus A320 (Air Manager instrument)
    Author:          Yves Levesque adapted for MSFS 2020
    Contributors:    Alexander Hildmann created for FlightFactor A320 on Xplane
    IMPORTANT:       Creates flood light effect on the Glareshield panel, needs input from the Illumination Pedestal Captain instrument
    Changes:         2022-02-19           Correct Power and Illumination
                     2024-12-21  YL  v3.0 Adapt to MSFS2024
   ======================================================================= --]]
   local flood_light_overlay_img   =  img_add_fullscreen("flood_light.png"); opacity(flood_light_overlay_img, 0.0)
  local power             = 0
  local Illumination_mode

   function Illumination_mode_cb(Illumination_mode_val)
     Illumination_mode = Illumination_mode_val
     if Illumination_mode_val[1] == 1.0 then
       opacity(flood_light_overlay_img, var_cap(Illumination_mode_val[7] * 0.027, 0.0, 0.7))
     else
       opacity(flood_light_overlay_img, 0.0)
     end
      
     if power == 0 then
       opacity(flood_light_overlay_img,0)
     end
    
    end
    si_variable_subscribe("Illumination_mode","FLOAT[10]", Illumination_mode_cb)
    
--=============================================================
  --Power management----------------------------------------------------
--=============================================================
   function power_cb (powered)
      power = powered
      if Illumination_mode ~= nil then Illumination_mode_cb(Illumination_mode) end
  end
 msfs_variable_subscribe( "L:A32NX_ELEC_DC_ESS_BUS_IS_POWERED","enum", power_cb)


