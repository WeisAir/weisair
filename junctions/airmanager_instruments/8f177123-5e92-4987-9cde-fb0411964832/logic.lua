   --[[
    Title:           Terrain On ND Captain instrument for FlyByWire Airbus A320 (Air Manager instrument)
    Author:          Yves Levesque adapted for MSFS 2020
    Contributors:    Alexander Hildmann created for FlightFactor A320 on Xplane
    IMPORTANT:       To use "Illumination mode", Illumination Pedestal Captain instrument is needed.
    Changes:         2021-12-15   v 2.1   Add Illunination Mode
                     2022-02-19           Correct Power and Illumination
                     2023-02-12  YL  Change msfs_variable_write to msfs_rpn()
                     2024-12-21  YL  v3.0 Adapt to MSFS2024
   ======================================================================= --]]

-- IMAGES/TEXT
   local backplane_img         = img_add_fullscreen("a320_terr_on_nd.png")  -- 180,280
   local night_overlay_img     = img_add_fullscreen("a320_terr_on_nd_night.png")
   local text_overlay_img      = img_add_fullscreen("a320_terr_on_nd_text.png")
   local text_overlay_Y_img    = img_add_fullscreen("a320_terr_on_nd_text_yellow.png")
   local terr_on_nd_on_img     = img_add("ko_gn_bot_back.png",56,58,71,71); visible(terr_on_nd_on_img,false)
   local terr_on_nd_p_img      = img_add("ko_dots_on_but_push.png", 56,59,71,71); visible(terr_on_nd_p_img,false)
   local terr_on_nd_r_img      = img_add("ko_dots_on_but_rel.png", 56,59,71,71)

---------------------------------------------------------------------------------------------------------------------------
-- INIT
  local power             = 0
  local Illumination_mode
  local terr_on_nd = 0
-- =============================================================================
-- 1. Terrain button:
  msfs_variable_subscribe( "L:A32NX_EFIS_TERR_L_ACTIVE", "enum", function (terronndstat)  terr_on_nd = terronndstat; visible( terr_on_nd_on_img ,  terronndstat == 1) end )

  function set_terr_p_cb()
     msfs_rpn(math.abs(terr_on_nd -1).." (>L:A32NX_EFIS_TERR_L_ACTIVE, enum)")
    visible(terr_on_nd_p_img,true)
  end
  
  function set_terr_r_cb()
    visible(terr_on_nd_p_img,false)
  end
   local showterr_but = button_add(nil, nil,56,59,71,71, set_terr_p_cb, set_terr_r_cb)
-- ============================================================================
-- 2. Illumination Mode
   function Illumination_mode_cb(Illumination_mode_val)
      Illumination_mode = Illumination_mode_val
    if Illumination_mode_val[1] == 1.0 then
       opacity(night_overlay_img, 1 - Illumination_mode_val[6] * 0.037)
       var1  = var_cap(Illumination_mode_val[5] * 0.031 + 0.3, 0.3, 1.0); var1y = var_cap(Illumination_mode_val[5] * 0.25 - 5.75, 0.0, 1.0)
       opacity(text_overlay_img,var1); opacity(text_overlay_Y_img, var1y);        opacity(terr_on_nd_on_img,var1)

     else
        opacity(night_overlay_img,0.0); opacity(text_overlay_img,1.0); opacity(text_overlay_Y_img,0.0)
        opacity(terr_on_nd_on_img,1.0)

     end
     
      if power == 0 then
        opacity(terr_on_nd_on_img,0)
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
 msfs_variable_subscribe( "L:A32NX_ELEC_DC_ESS_SHED_BUS_IS_POWERED","enum", power_cb)
