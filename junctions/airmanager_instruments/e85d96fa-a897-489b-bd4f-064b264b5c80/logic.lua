frame_prop = user_prop_add_boolean("Show display frame", true, "draw a frame around the display")

offset_frame_x = 0
offset_frame_y = 0

if user_prop_get(frame_prop) == true then
    background = img_add_fullscreen("display_frame.png")
    video_stream_id = video_stream_add("xpl/gauges[1]", 12, 12, 745, 998, 0, 1015, 800, 1020)
    offset_frame_x = -4
    offset_frame_y = 10
else
    video_stream_id = video_stream_add("xpl/gauges[1]", 0, 0, 800, 1020, 0, 1015, 800, 1020)
end

--temporary image for layout phase - remove at release!
--global_button_img = "button_helper.png"
global_button_img = ""

global_var_map_menu_is_open = false
global_plan_menu_is_open = false
global_systems_menu_is_open = false
global_selected_page 		= 0
global_show_navaids 		= 0
global_show_navaids 		= 0
global_show_airports 		= 0
global_show_wpt_ident 		= 0
global_show_progress 		= 0
global_show_vertical_path 	= 0
global_missed_approach 		= 0
global_show_tcas 		= 0
global_map_overlay_mode 	= 1



--callback functions for 1st level operations
function map_button_pressed_callback()
    xpl_command("XCrafts/ERJ/MFD/MAP_tab")
end

function plan_button_pressed_callback()
    xpl_command("XCrafts/ERJ/MFD/PLAN_tab")
end

function sys_button_pressed_callback()
    xpl_command("XCrafts/ERJ/MFD/SYS_tab")
end

--callback functions for 2nd level operations
function submenu_map_navaids_button_callback()
    if (global_var_map_menu_is_open == true or global_plan_menu_is_open == true) then
        if (global_show_navaids == 0) then xpl_dataref_write("XCrafts/ERJ/MFD/Navaids", "INT", 1) else xpl_dataref_write("XCrafts/ERJ/MFD/Navaids", "INT", 0) end
    end
end

function submenu_map_airports_button_callback()
    if (global_var_map_menu_is_open == true or global_plan_menu_is_open == true) then
        if (global_show_airports == 0) then xpl_dataref_write("sim/cockpit2/EFIS/EFIS_airport_on", "INT", 1) else xpl_dataref_write("sim/cockpit2/EFIS/EFIS_airport_on", "INT", 0) end
    end
end

function submenu_map_wptident_button_callback()
    if (global_var_map_menu_is_open == true or global_plan_menu_is_open == true) then
        if (global_show_wpt_ident == 0) then xpl_dataref_write("XCrafts/ERJ/MFD/WPT_Ident", "INT", 1) else xpl_dataref_write("XCrafts/ERJ/MFD/WPT_Ident", "INT", 0) end
    end
end

function submenu_map_progress_button_callback()
    if (global_var_map_menu_is_open == true or global_plan_menu_is_open == true) then
        if (global_show_progress == 0) then xpl_dataref_write("XCrafts/ERJ/MFD/Progress_visible", "INT", 1) else xpl_dataref_write("XCrafts/ERJ/MFD/Progress_visible", "INT", 0) end
    end
end

function submenu_map_vertprof_button_callback()
    if (global_var_map_menu_is_open == true or global_plan_menu_is_open == true) then
        if (global_show_vertical_path == 0) then xpl_dataref_write("XCrafts/VSD", "INT", 1) else xpl_dataref_write("XCrafts/VSD", "INT", 0) end
    end
end

function submenu_map_mssdappr_button_callback()
    if (global_var_map_menu_is_open == true) then
        --if (global_missed_approach == 0) then xpl_dataref_write("XCrafts/ERJ/MFD/Navaids", "INT", 1) else xpl_dataref_write("XCrafts/ERJ/MFD/Navaids", "INT", 0) end
    end
end

function submenu_map_tcas_button_callback()
    if (global_var_map_menu_is_open == true) then
        if (global_show_tcas == 0) then xpl_dataref_write("sim/cockpit2/EFIS/EFIS_tcas_on", "INT", 1) else xpl_dataref_write("sim/cockpit2/EFIS/EFIS_tcas_on", "INT", 0) end
    end
end

function submenu_map_weather_button_callback()
    if (global_var_map_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Map_Overlay", "INT", 1) end
end

function submenu_map_terrain_button_callback()
    if (global_var_map_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Map_Overlay", "INT", 2) end
end

function submenu_map_off_button_callback()
    if (global_var_map_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Map_Overlay", "INT", 0) end
end

function submenu_plan_acfcntrd_button_callback()
    --if (global_var_map_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Map_Overlay", "INT", 2) end
end

function submenu_plan_wptcntrd_button_callback()
    --if (global_var_map_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Map_Overlay", "INT", 3) end
end

function submenu_systems_status_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 0) end
end

function submenu_systems_fltctrl_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 1) end
end

function submenu_systems_hydrl_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 2) end
end

function submenu_systems_fuel_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 3) end
end

function submenu_systems_elec_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 4) end
end

function submenu_systems_ecs_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 5) end
end

function submenu_systems_antiice_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 6) end
end

function submenu_systems_engmaint_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 7) end
end

function submenu_systems_maint_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 8) end
end

function submenu_systems_sysconf_button_callback()
	if (global_systems_menu_is_open == true) then xpl_dataref_write("XCrafts/ERJ/MFD/Selected_Page", "INT", 9) end
end

--1st level buttons
map_button = button_add(global_button_img, global_button_img, 22, 20+offset_frame_y, 235, 55, map_button_pressed_callback)
plan_button = button_add(global_button_img, global_button_img, 270+2*offset_frame_x, 20+offset_frame_y, 235, 55, plan_button_pressed_callback)
sys_button = button_add(global_button_img, global_button_img, 518+4*offset_frame_x, 20+offset_frame_y, 235, 55, sys_button_pressed_callback)

--2nd level buttons
submenu_map_navaids_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 102+offset_frame_y, 37, 38,  submenu_map_navaids_button_callback)
submenu_map_airports_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 153+offset_frame_y, 37, 38, submenu_map_airports_button_callback)
submenu_map_wptident_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 204+offset_frame_y, 37, 38, submenu_map_wptident_button_callback)
submenu_map_progress_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 254+offset_frame_y, 37, 38, submenu_map_progress_button_callback)
submenu_map_vertprof_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 304+offset_frame_y, 37, 38, submenu_map_vertprof_button_callback)
submenu_map_mssdappr_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 354+offset_frame_y, 37, 38, submenu_map_mssdappr_button_callback)
submenu_map_tcas_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 404+offset_frame_y, 37, 38, 	 submenu_map_tcas_button_callback)
submenu_map_weather_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 468+offset_frame_y, 37, 38,  submenu_map_weather_button_callback)
submenu_map_terrain_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 518+offset_frame_y, 37, 38,  submenu_map_terrain_button_callback)
submenu_map_off_button = button_add(global_button_img, global_button_img, 208+offset_frame_x, 568+offset_frame_y, 37, 38, 	 submenu_map_off_button_callback)

submenu_plan_navaids_button = button_add(global_button_img, global_button_img, 455+5*offset_frame_x, 102+offset_frame_y, 37, 38,  submenu_map_navaids_button_callback)
submenu_plan_airports_button = button_add(global_button_img, global_button_img, 455+5*offset_frame_x, 153+offset_frame_y, 37, 38, submenu_map_airports_button_callback)
submenu_plan_wptident_button = button_add(global_button_img, global_button_img, 455+5*offset_frame_x, 204+offset_frame_y, 37, 38, submenu_map_wptident_button_callback)
submenu_plan_progress_button = button_add(global_button_img, global_button_img, 455+5*offset_frame_x, 254+offset_frame_y, 37, 38, submenu_map_progress_button_callback)
submenu_plan_vertprof_button = button_add(global_button_img, global_button_img, 455+5*offset_frame_x, 304+offset_frame_y, 37, 38, submenu_map_vertprof_button_callback)
submenu_plan_acfcntrd_button = button_add(global_button_img, global_button_img, 455+5*offset_frame_x, 378+offset_frame_y, 37, 38, submenu_plan_acfcntrd_button_callback)
submenu_plan_wptcntrd_button = button_add(global_button_img, global_button_img, 455+5*offset_frame_x, 442+offset_frame_y, 37, 38, submenu_plan_wptcntrd_button_callback)

submenu_systems_status_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 95+offset_frame_y, 37, 38,  submenu_systems_status_button_callback)
submenu_systems_fltctrl_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 145+offset_frame_y, 37, 38,  submenu_systems_fltctrl_button_callback)
submenu_systems_hydrl_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 195+offset_frame_y, 37, 38,  submenu_systems_hydrl_button_callback)
submenu_systems_fuel_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 245+offset_frame_y, 37, 38,  submenu_systems_fuel_button_callback)
submenu_systems_elec_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 295+offset_frame_y, 37, 38,  submenu_systems_elec_button_callback)
submenu_systems_ecs_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 345+offset_frame_y, 37, 38,  submenu_systems_ecs_button_callback)
submenu_systems_antiice_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 395+offset_frame_y, 37, 38,  submenu_systems_antiice_button_callback)
submenu_systems_engmaint_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 445+offset_frame_y, 37, 38,  submenu_systems_engmaint_button_callback)
submenu_systems_maint_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 495+offset_frame_y, 37, 38,  submenu_systems_maint_button_callback)
submenu_systems_sysconf_button = button_add(global_button_img, global_button_img, 673+9*offset_frame_x, 545+offset_frame_y, 37, 38,  submenu_systems_sysconf_button_callback)


--initially hide all submenu buttons
visible(submenu_map_navaids_button, false)
visible(submenu_map_airports_button, false)
visible(submenu_map_wptident_button, false)
visible(submenu_map_progress_button, false)
visible(submenu_map_vertprof_button, false)
visible(submenu_map_mssdappr_button, false)
visible(submenu_map_tcas_button, false)
visible(submenu_map_weather_button, false) 
visible(submenu_map_terrain_button, false) 
visible(submenu_map_off_button, false)
visible(submenu_plan_navaids_button, false)
visible(submenu_plan_airports_button, false)
visible(submenu_plan_wptident_button, false)
visible(submenu_plan_progress_button, false)
visible(submenu_plan_vertprof_button, false)
visible(submenu_plan_acfcntrd_button, false)
visible(submenu_plan_wptcntrd_button, false)
visible(submenu_systems_status_button, false)
visible(submenu_systems_fltctrl_button, false) 
visible(submenu_systems_hydrl_button, false) 
visible(submenu_systems_fuel_button, false)
visible(submenu_systems_elec_button, false)
visible(submenu_systems_ecs_button, false)
visible(submenu_systems_antiice_button, false)
visible(submenu_systems_engmaint_button, false)
visible(submenu_systems_maint_button, false)
visible(submenu_systems_sysconf_button, false)



function MFD_ops_callback(map_menu_is_open,map_overlay_mode,show_navaids,plan_menu_is_open,show_progress,show_wpt_ident,show_dest_wpt_id,show_vertical_path,show_airports,show_tcas,systems_menu_is_open,selected_page)
 
    if (map_menu_is_open == 1) then
		visible(submenu_map_navaids_button, true)
		visible(submenu_map_airports_button, true)
		visible(submenu_map_wptident_button, true)
		visible(submenu_map_progress_button, true)
		visible(submenu_map_vertprof_button, true)
		visible(submenu_map_mssdappr_button, true)
		visible(submenu_map_tcas_button, true)
		visible(submenu_map_weather_button, true) 
		visible(submenu_map_terrain_button, true) 
		visible(submenu_map_off_button, true) 		
		
		global_var_map_menu_is_open = true
        global_show_navaids = show_navaids
		global_show_airports = show_airports
		global_show_wpt_ident = show_wpt_ident
		global_show_progress = show_progress
		global_show_vertical_path = show_vertical_path
		--global_missed_approach = missed_approach -- which dataref for missed_approach selector??
		global_show_tcas = show_tcas
		global_map_overlay_mode = map_overlay_mode
	
	end
	
	if (plan_menu_is_open == 1) then
		visible(submenu_plan_navaids_button,  true)
		visible(submenu_plan_airports_button, true)
		visible(submenu_plan_wptident_button, true)
		visible(submenu_plan_progress_button, true)
		visible(submenu_plan_vertprof_button, true)
		visible(submenu_plan_acfcntrd_button, true)
		visible(submenu_plan_wptcntrd_button, true)
		
		global_plan_menu_is_open = true
		global_show_navaids = show_navaids
		global_show_airports = show_airports
		global_show_wpt_ident = show_wpt_ident
		global_show_progress = show_progress
		global_show_vertical_path = show_vertical_path
		
		
	end
	
	if (systems_menu_is_open == 1) then
		visible(submenu_systems_status_button, true)
		visible(submenu_systems_fltctrl_button, true) 
		visible(submenu_systems_hydrl_button, true) 
		visible(submenu_systems_fuel_button, true)
		visible(submenu_systems_elec_button, true)
		visible(submenu_systems_ecs_button, true)
		visible(submenu_systems_antiice_button, true)
		visible(submenu_systems_engmaint_button, true)
		visible(submenu_systems_maint_button, true)
		visible(submenu_systems_sysconf_button, true)
	
		global_systems_menu_is_open = true
		global_selected_page = selected_page
		
	end
	
	if (map_menu_is_open == 0 and plan_menu_is_open == 0 and systems_menu_is_open == 0) then
     
        visible(submenu_map_navaids_button, false)
		visible(submenu_map_airports_button, false)
		visible(submenu_map_wptident_button, false)
		visible(submenu_map_progress_button, false)
		visible(submenu_map_vertprof_button, false)
		visible(submenu_map_mssdappr_button, false)
		visible(submenu_map_tcas_button, false)
		visible(submenu_map_weather_button, false) 
		visible(submenu_map_terrain_button, false) 
		visible(submenu_map_off_button, false)
		visible(submenu_plan_navaids_button, false)
		visible(submenu_plan_airports_button, false)
		visible(submenu_plan_wptident_button, false)
		visible(submenu_plan_progress_button, false)
		visible(submenu_plan_vertprof_button, false)
		visible(submenu_plan_acfcntrd_button, false)
		visible(submenu_plan_wptcntrd_button, false)
		visible(submenu_systems_status_button, false)
		visible(submenu_systems_fltctrl_button, false) 
		visible(submenu_systems_hydrl_button, false) 
		visible(submenu_systems_fuel_button, false)
		visible(submenu_systems_elec_button, false)
		visible(submenu_systems_ecs_button, false)
		visible(submenu_systems_antiice_button, false)
		visible(submenu_systems_engmaint_button, false)
		visible(submenu_systems_maint_button, false)
		visible(submenu_systems_sysconf_button, false)
        
		global_var_map_menu_is_open = false
		global_plan_menu_is_open = false
		global_systems_menu_is_open = false
		
    end   

end 

xpl_dataref_subscribe(
     "XCrafts/ERJ/MFD/Map_Ops_Open", "INT",
     "XCrafts/ERJ/MFD/Map_Overlay", "INT",
     "XCrafts/ERJ/MFD/Navaids", "INT",
     "XCrafts/ERJ/MFD/Plan_Ops_Open", "INT",
     "XCrafts/ERJ/MFD/Progress_visible", "INT",
     "XCrafts/ERJ/MFD/WPT_Ident", "INT",
     "XCrafts/ERJ/MFD_MAP_dest_wpt_ID", "INT", --???
     "XCrafts/VSD", "INT",
     "sim/cockpit2/EFIS/EFIS_airport_on", "INT",
     "sim/cockpit2/EFIS/EFIS_tcas_on", "INT",
	 "XCrafts/ERJ/MFD/Select_Menu_Open","INT",
	 "XCrafts/ERJ/MFD/Selected_Page", "INT",
  MFD_ops_callback)
  