prop_panel_type = user_prop_add_enum("Panel Type", "Single PFD/ND,Single EFB/MFD,Single Screen", "Single PFD/ND", "Select Panel Type")
panel_type = tostring(user_prop_get(prop_panel_type))

local instrument_left_pfd = instrument_get("dd794039-ba70-4e86-2849-ce8c95351759")
local instrument_left_nd = instrument_get("99d6d7dc-c391-43ac-a8f8-537596496d25")
local instrument_left_ann_below_glideslope = instrument_get("e37146a4-8b06-49a8-ba16-14551a6991ba")
local instrument_left_ann_cabin_alt = instrument_get("02d5f029-bd34-48b2-9002-2c1a46f854f8")
local instrument_left_ann_takeoff_conf = instrument_get("4eea198a-9b25-4dbf-b068-eda4560ff788")
local instrument_left_ann_anti_skid_inop = instrument_get("b90790c5-7648-4c21-377d-2ed799289b59")
local instrument_left_ann_stab_out_of_trim = instrument_get("f710f020-38f4-42d1-08d4-3e4012116a40")
local instrument_left_ann_speeddbrakes_ext = instrument_get("d6fcba73-d680-4e6c-06d5-d225441f17e1")
local instrument_left_ann_speeddbrakes_arm = instrument_get ("9a81d55c-e47f-4be0-856a-680fbd7c5fdd")
local instrument_left_ann_speeddbrakes_not_arm = instrument_get("bad1a303-3263-4208-2e84-3dd51f33b7ba")
local instrument_left_ann_le_flaps_ext = instrument_get("21edc592-b9e1-422a-3148-6826408a800c")
local instrument_left_ann_auto_brake_disarm = instrument_get("74d1a00a-a13d-422a-b3ce-43f009113c73")
local instrument_left_ann_ap_prst = instrument_get("46992785-e64a-4823-3152-9fa8e92852f6")
local instrument_left_ann_at_prst = instrument_get("9a73872d-8602-449b-83af-4fb1bb557090") 
local instrument_left_ann_fmc_prst = instrument_get("740e115d-227a-40d9-8515-684a77ff8f45")
local instrument_left_ann_le_flaps_transit = instrument_get("4c24f9b6-1eea-4603-2eb5-8ebccfedbe14")
local instrument_left_clock = instrument_get("16a4ad1d-3545-4c5f-b488-4b89c177e8d8")
local instrument_left_et_timer = instrument_get("61035df7-d46b-4912-8f63-61a23088205c")
local instrument_left_timer_btn_left = instrument_get("2fa15f30-abc9-4d12-26ee-bec3c2c7db1c",0)
local instrument_left_timer_btn_right = instrument_get("2fa15f30-abc9-4d12-26ee-bec3c2c7db1c",1)
local instrument_left_sixpack = instrument_get("ba759372-8b37-4715-3f03-8229ce8a5399")

local instrument_right_knob_ias = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",0)
local instrument_right_knob_alt = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",1)
local instrument_right_knob_hdg = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",2)
local instrument_right_knob_vs = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",3)
local instrument_right_knob_crs1 = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",4)
local instrument_right_knob_crs2 = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",5)
local instrument_right_knob_com1 = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",6)
local instrument_right_knob_com2 = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",7)
local instrument_right_knob_nav1 = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",8)
local instrument_right_knob_nav2 = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",9)
local instrument_right_knob_adf1 = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",10)
local instrument_right_knob_adf2 = instrument_get("7aabab9e-b42a-449e-88de-7ce4d30cf30e",11)
local instrument_right_eicas = instrument_get("8e7cfe70-5c74-4eae-9568-e2ef0fc41b78") 
local instrument_right_display_com1 = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",0)
local instrument_right_display_com1_standby = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",1)
local instrument_right_display_nav1 = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",2)
local instrument_right_display_nav1_standby = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",3)
local instrument_right_display_adf1 = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",4)
local instrument_right_display_adf1_standby = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",5)
local instrument_right_display_com2 = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",6)
local instrument_right_display_com2_standby = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",7)
local instrument_right_display_nav2 = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",8)
local instrument_right_display_nav2_standby = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",9)
local instrument_right_display_adf2 = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",10)
local instrument_right_display_adf2_standby = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",11)
local instrument_right_display_mcp_alt = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",12)
local instrument_right_display_mcp_hdg = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",13)
local instrument_right_display_mcp_spd = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",14)
local instrument_right_display_mcp_vvi = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",15)
local instrument_right_display_mcp_plt_nav_obs = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",16)
local instrument_right_display_mcp_coplt_nav_obs = instrument_get("a18a19e4-4735-40af-2c8b-010119905d04",17)
local instrument_right_efb = instrument_get("6f49dcda-ff42-4278-bdcf-45fbd9dd7588")
local instrument_right_flaps = instrument_get("120593d7-ad10-48c8-975a-c87463013a20")
local instrument_right_ident_plate = instrument_get("0d5e0ebe-8a7e-4304-ad23-3fd74bc24163")
local instrument_right_autobrake = instrument_get("43b55ff3-91c2-434a-b212-3d290f9dfc8a")

local last_screen = "pfd_nd"

group_pfd_nd_panel = group_add(instrument_left_pfd,instrument_left_nd,instrument_left_ann_below_glideslope,instrument_left_ann_cabin_alt, instrument_left_ann_takeoff_conf,instrument_left_ann_anti_skid_inop,instrument_left_ann_stab_out_of_trim,instrument_left_ann_speeddbrakes_ext,instrument_left_ann_speeddbrakes_arm,instrument_left_ann_speeddbrakes_not_arm, instrument_left_ann_le_flaps_ext,instrument_left_ann_auto_brake_disarm,instrument_left_ann_ap_prst,instrument_left_ann_at_prst,instrument_left_ann_fmc_prst,instrument_left_ann_le_flaps_transit,instrument_left_clock,instrument_left_et_timer,instrument_left_timer_btn_left,instrument_left_timer_btn_right,instrument_left_sixpack)
group_efb_mfd_panel = group_add(instrument_right_knob_ias,instrument_right_knob_alt,instrument_right_knob_hdg,instrument_right_knob_vs,instrument_right_knob_crs1,instrument_right_knob_crs2,instrument_right_knob_com1,instrument_right_knob_com2,instrument_right_knob_nav1,instrument_right_knob_nav2,instrument_right_knob_adf1,instrument_right_knob_adf2,instrument_right_eicas,instrument_right_display_com1,instrument_right_display_com1_standby,instrument_right_display_nav1,instrument_right_display_nav1_standby,instrument_right_display_adf1,instrument_right_display_adf1_standby,instrument_right_display_com2,instrument_right_display_com2_standby,instrument_right_display_nav2,instrument_right_display_nav2_standby,instrument_right_display_adf2,instrument_right_display_adf2_standby,instrument_right_display_mcp_alt,instrument_right_display_mcp_hdg,instrument_right_display_mcp_spd,instrument_right_display_mcp_vvi,instrument_right_display_mcp_plt_nav_obs,instrument_right_display_mcp_coplt_nav_obs,instrument_right_efb,instrument_right_flaps,instrument_right_ident_plate,instrument_right_autobrake)

function panel_toggle_button_callback()
  if last_screen == "pfd_nd" then
      visible(group_pfd_nd_panel,false)
      visible(group_efb_mfd_panel,true)
      last_screen = "efb_mfd"  
     
  else
      visible(group_pfd_nd_panel,false)
      visible(group_efb_mfd_panel,true)
      last_screen = "pfd_nd"
  end
end

visible(group_pfd_nd_panel,false)
visible(group_efb_mfd_panel,false)

if user_prop_get(prop_panel_type) == "Single PFD/ND" then 
        img_background = img_add_fullscreen("background_left.png") 
        visible(group_pfd_nd_panel,true)
    end

if user_prop_get(prop_panel_type) == "Single EFB/MFD" then 
        img_background = img_add_fullscreen("background_right.png") 
	visible(group_efb_mfd_panel,true)

    end

if user_prop_get(prop_panel_type) == "Single Screen" then 
        img_background = img_add_fullscreen("background_left.png") 
        panel_toggle_button = button_add("swap_panel.png", "swap_panel.png", 75, 1000, 50, 50, panel_toggle_button_callback)
        visible(group_pfd_nd_panel,true)        
    end
    