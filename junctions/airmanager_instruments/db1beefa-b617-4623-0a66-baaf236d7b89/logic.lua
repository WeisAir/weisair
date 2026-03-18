   --[[
    Title:           Nosewheel tiller for FlyByWire Airbus A320 (Air Manager instrument)
    Author:          Yves Levesque adapted for MSFS 2020
    Contributors:    Alexander Hildmann created for FlightFactor A320 on Xplane
    IMPORTANT:       To use "Illumination mode", Illumination Pedestal Captain instrument is needed.
                     Tiller should be activated in FlyPad EFB    
    Changes:         2021-12-15   v 2.1   Add Illunination Mode
                                          Correct rotation scale
                     2022-02-16   v 2.1.1 Add realistic mode
                     2024-12-21  YL  v3.0 Adapt to MSFS2024
   ======================================================================= --]]
   
     prop_realistic = user_prop_add_boolean("Realistic mode",true,"Use tiller realistic mode?")

-- IMAGES/TEXT
   local backplate_img        = img_add_fullscreen("a320_tiller_panel.png") --722,722
   local night_overlay_img    = img_add_fullscreen("a320_tiller_panel_night.png")
   local text_overlay_img     = img_add_fullscreen("a320_tiller_panel_text.png")
   local text_overlay_y_img   = img_add_fullscreen("a320_tiller_panel_text_yellow.png")
   local tiller_img           = img_add("a320_tiller.png",           0,   0, 722, 722)
   local tiller_knob_in_img   = img_add("a320_tiller_knob_in.png", 300, 305, 116, 116); visible(tiller_knob_in_img,false)
   local tiller_knob_out_img  = img_add("a320_tiller_knob_out.png",300, 305, 116, 116); visible(tiller_knob_out_img,true)
   local nw_pos_txt           = txt_add("", "font:arimo_bold.ttf ; size:60; color:blue; halign:left;", 460, 545, 150, 60)

-- INIT
   local angles = {{-1,-60},{-0.84,-50},{-0.65,-42},{-0.32,-3},{0,15},{0.32,32},{0.65,69},{0.84,79},{1,89}}
   local wheel_position = 0
   local realistic_mode = user_prop_get(prop_realistic) and 1 or 0
   msfs_variable_write("L:A32NX_REALISTIC_TILLER_ENABLED", "number",realistic_mode)
   
-- =============================================================================
-- 1 Receive nose wheel position from Xplane and show pos
   function nose_wheel_position_cb  (nose_wheel_pos)
     wheel_position = nose_wheel_pos
     ang= interpolate_linear(angles, nose_wheel_pos)
     img_rotate(tiller_img, ang); img_rotate(tiller_knob_in_img, ang); img_rotate(tiller_knob_out_img,ang)
   end
   msfs_variable_subscribe("L:A32NX_TILLER_HANDLE_POSITION", "number", nose_wheel_position_cb)
-- =============================================================================
-- 2 set nose wheel position via instrument
   function set_nose_wheel_position_cb(dir)
       wheel_position = wheel_position + (dir* 0.1)
        --msfs_variable_write("L:A32NX_TILLER_HANDLE_POSITION", "number", 0)
        if dir == 1 then msfs_event ("STEERING_INC")
        else             msfs_event ("STEERING_DEC")
        end
    end
   set_nose_wheel_dial = dial_add(nil,200, 205, 300, 300, 1, set_nose_wheel_position_cb)
-- =============================================================================
-- 3 Nosewheel takeover button
   function nosewheel_takeover_cb (realistic)
           visible(tiller_knob_in_img, realistic == 0)
           visible(tiller_knob_out_img, realistic == 1)
           realistic_mode = realistic
   end
   msfs_variable_subscribe("L:A32NX_REALISTIC_TILLER_ENABLED", "number", nosewheel_takeover_cb)
 
   function takeoverL_p_cb ()
        realistic_mode = math.abs(realistic_mode-1) 
        msfs_variable_write("L:A32NX_REALISTIC_TILLER_ENABLED", "number",realistic_mode)
   end
   takeover_buttonL = button_add(nil,nil,300, 305, 116, 116,takeoverL_p_cb)
    
-- =============================================================================
-- 4. Illumination Mode
   function Illumination_mode_cb(Illumination_mode_val)
     if Illumination_mode_val[1] == 1.0 then
       opacity(night_overlay_img, 1 - Illumination_mode_val[6] * 0.037)
        var1  = var_cap(Illumination_mode_val[5] * 0.031 + 0.3, 0.3, 1.0); var1y = var_cap(Illumination_mode_val[5] * 0.25 - 5.75, 0.0, 1.0)
       opacity(text_overlay_img, var1); opacity(text_overlay_y_img, var1y)
     else
        opacity(night_overlay_img,0.0); opacity(text_overlay_img,1.0); opacity(text_overlay_y_img,0.0)
     end
   end
   si_variable_subscribe("Illumination_mode","FLOAT[10]", Illumination_mode_cb)