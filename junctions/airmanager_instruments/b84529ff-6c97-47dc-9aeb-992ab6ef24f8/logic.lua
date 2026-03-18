--[[
    Title:           ISIS (Integrated Standby Instrument System) for FlyByWire Airbus A320 (Air Manager instrument)
    Author:          Yves Levesque and Alexander Hildmann
    IMPORTANT:       To use "Illumination mode", Illumination Pedestal Captain instrument is needed.
    Informations:    Brightness button + - sets brightness in Cockpit only, not for the popout
    ERRORS:          Brightness button + - does not work properly. After change in instrument seems to set back to value set in cockpit
    Changes:         2022-03-03  Initial version
                     2023-02-12  YL  Change msfs_variable_write to msfs_rpn()
                     2024-12-21  YL  v3.0 Adapt to MSFS2024
                     2025-06-09  YL  v3.0.3 Correct baro knob for dev version
   ======================================================================= --]]
local FBW_A32NX_Version ="stable";
si_variable_subscribe( "FBW_A32NX_Version", "STRING", function(val) print ("si: "..val); if val== "Development" then FBW_A32NX_Version = val else FBW_A32NX_Version = "Stable" end end)


-- IMAGES & TEXT
   local backplate_img       = img_add_fullscreen("a320_isis_panel.png")
   local ISIS_knob_outer_img = img_add("ISIS_knob_outer_shadow.png",256,258,56,56)
   local night_overlay_img   = img_add_fullscreen("a320_isis_panel_night.png")
   local text_overlay_img    = img_add_fullscreen("a320_isis_panel_text.png")
   local text_overlay_y_img  = img_add_fullscreen("a320_isis_panel_text_yellow.png")
-- INIT
   local baro_brightness  = 0
   local ls_active        = 0
   local bugs_active      = 0
   local baro_mode        = 0
-- =============================================================================
-- 1. Brightness
-- =============================================================================
   function Plus_p_cb()
    msfs_event ("H:A32NX_ISIS_PLUS_PRESSED",1)
   end
   
    function Plus_r_cb()
    msfs_event ("H:A32NX_ISIS_PLUS_PRESSED",0)
   end
   Plus_button = button_add("Plus_r.png","Plus_p.png",7,88,30,60,Plus_p_cb, Plus_r_cb)

   function Minus_p_cb()
    msfs_event ("H:A32NX_ISIS_MINUS_PRESSED",1)
   end
   function Minus_r_cb()
    msfs_event ("H:A32NX_ISIS_MINUS_PRESSED",0)
   end
   Minus_button = button_add("Minus_r.png","Minus_p.png",7,184,30,60,Minus_p_cb, Minus_r_cb)

-- =============================================================================
-- 2. BUGS
-- =============================================================================
   msfs_variable_subscribe("L:A32NX_ISIS_BUGS_ACTIVE", "enum", function (bugs) bugs_active = bugs end)

   function BUGS_p_cb() msfs_rpn(math.abs(bugs_active -1).." (>L:A32NX_ISIS_BUGS_ACTIVE, enum)") end
   BUGS_button = button_add("BUGS_r.png","BUGS_p.png",86,5,60,30,BUGS_p_cb)

-- =============================================================================
-- 3. LS
-- =============================================================================
   msfs_variable_subscribe("L:A32NX_ISIS_LS_ACTIVE", "enum", function (lsa) ls_active = lsa end)

   function LS_p_cb() msfs_rpn(math.abs(ls_active -1).." (>L:A32NX_ISIS_LS_ACTIVE, enum)") end
   LS_button = button_add("LS_r.png","LS_p.png",186,5,60,30,LS_p_cb)

-- =============================================================================
-- 4. RST
-- =============================================================================
   function RST_p_cb() msfs_event ("H:A32NX_ISIS_RST_PRESSED")  end
   RST_button = button_add("RST_r.png","RST_p.png",87,282,60,30,RST_p_cb)

-- =============================================================================
-- 5. BARO
-- =============================================================================
--[[
  msfs_variable_subscribe("KOHLSMAN SETTING HG:2", "inHg",  = Baro in Hg
  msfs_variable_subscribe("KOHLSMAN SETTING MB:2", "millibar",   = baro in millibar
  there is a variable
  L:A32NX_ISIS_BARO_UNIT_INHG    it does'nt seem to do anything.
--]]

   msfs_variable_subscribe("L:A32NX_ISIS_BARO_MODE", "enum", function (baro_m) baro_mode = baro_m end)

   function turn_lower_cb (direction)
        if bugs_active == 0 then
           if direction > 0 then
               if FBW_A32NX_Version == "Stable" then 
                   msfs_event ("KOHLSMAN_INC",2)
               else
                    msfs_event ("KOHLSMAN_INC",3)
                 -- msfs_rpn("(L:A32NX_ISIS_BARO_MODE, enum) 1 != if{ (L:A32NX_ISIS_BARO_UNIT_INHG, enum) if{3 (>K:KOHLSMAN_INC)}els{ 3 (A:KOHLSMAN SETTING MB:3, millibars) ++ 16 * (>K:2:KOHLSMAN_SET) } ")
               end
           else
                if FBW_A32NX_Version == "Stable" then 
                   msfs_event ("KOHLSMAN_DEC",2)
                else
                   msfs_event ("KOHLSMAN_DEC",3)
                   --msfs_rpn("(L:A32NX_ISIS_BARO_MODE, enum) 1 != if{ (L:A32NX_ISIS_BARO_UNIT_INHG, enum) if{3 (>K:KOHLSMAN_DEC)}els{3 (A:KOHLSMAN SETTING MB:3, millibars) -- 16 * (>K:2:KOHLSMAN_SET) }")
                end
           end
        else
           if direction > 0 then   msfs_event ("H:A32NX_ISIS_KNOB_CLOCKWISE")
           else   msfs_event ("H:A32NX_ISIS_KNOB_ANTI_CLOCKWISE") end
        end
   end
   Baro_lower_dial_id = dial_add("ISIS_knob_outer.png", 256,258,56,56, turn_lower_cb)

   --function Baro_p_cb() msfs_rpn(math.abs(baro_mode -1.." (>L:A32NX_ISIS_BARO_MODE, enum)")) end
   function Baro_p_cb() 
       if bugs_active == 0 then
           msfs_rpn(math.abs(baro_mode -1).." (>L:A32NX_ISIS_BARO_MODE, enum)") 
       else
           msfs_event ("H:A32NX_ISIS_KNOB_PRESSED",0) 
       end
   end
   Baro_button = button_add("ISIS_knob_inner_released.png","ISIS_knob_inner_pushed.png",267, 269, 34, 34,Baro_p_cb)

-- =============================================================================
-- 6. Illumination Mode
-- =============================================================================
   function Illumination_mode_cb(Illumination_mode_val)
     if Illumination_mode_val[1] == 1.0 then
       opacity(night_overlay_img, 1 - Illumination_mode_val[6] * 0.037)
       --opacity(knob_group,var_cap(Illumination_mode_val[6] * 0.037,0.7,1.0))
       var1  = var_cap(Illumination_mode_val[5] * 0.031 + 0.3, 0.3, 1.0); var1y = var_cap(Illumination_mode_val[5] * 0.25 - 5.75, 0.0, 1.0)
       opacity(text_overlay_img, var1); opacity(text_overlay_y_img, var1y)
     else
       opacity(night_overlay_img,0.0); opacity(text_overlay_img,1.0); opacity(text_overlay_y_img,0.0)
       --; opacity(knob_group,1.0)
     end
   end
   si_variable_subscribe("Illumination_mode","FLOAT[10]", Illumination_mode_cb)