background_image = img_add_fullscreen ( "background_black.png" )
nav_btn_l_off = img_add ( "nav_off.png" 		, 10 , 40 	, 40 , 40 )
nav_btn_l = img_add ( "nav_l.png" 				, 10 , 40 	, 40 , 40 )
nav_btn_r_off = img_add ( "nav_off.png" 		, 55 , 40 	, 40 , 40 )	
nav_btn_r = img_add ( "nav_r.png" 				, 55 , 40 	, 40 , 40 )
below_gs_off = img_add ( "below_gs_off.png" 	, 100 , 40 	, 40 , 40 )
below_gs = img_add ( "below_gs.png" 			, 100 , 40 	, 40 , 40 )
alt_alert_off = img_add ( "alt_alert_off.png" 	, 145 , 40 	, 40 , 40 )
alt_alert = img_add ( "alt_alert.png" 			, 145 , 40 	, 40 , 40 )


gnd_op_off = img_add ( "gnd_op_off.png" 	, 10, 100 		, 40 , 40 )	
gnd_op = img_add ( "gnd_op.png" 			, 10, 100 		, 40 , 40 )
to_inh_off = img_add ( "to_inh_off.png" 	, 55 , 100 		, 40 , 40 )
to_inh = img_add ( "to_inh.png" 			, 55 , 100 		, 40 , 40 )
terrain_off = img_add ( "terrain_off.png" 	, 100 , 100 	, 40 , 40 )
terrain = img_add ( "terrain.png" 			, 100 , 100 	, 40 , 40 )


ann_header = txt_add("Announciators", "font:arimo_regular.ttf; size:16; color: white; halign:center;", 0, 10, 120, 100)
--NAV = txt_add("NAV", "font:arimo_regular.ttf; size:16; color: white; halign:center;", 25, 55, 30, 30)
--TO = txt_add("CONF", "font:arimo_regular.ttf; size:13; color: white; halign:center;", 25, 120, 30, 30)
misc_status = txt_add("MISC Status", "font:arimo_regular.ttf; size:16; color: white; halign:left;", 200, 10, 120, 100)

CTOT = txt_add("CTOT / %", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 200, 40, 100, 50)
--CTOT_STATUS_L = txt_add("OFF", "font:arimo_regular.ttf; size:14; color: red; halign:left;", 300, 40, 100, 50)
--CTOT_STATUS_R = txt_add("OFF", "font:arimo_regular.ttf; size:14; color: red; halign:left;", 330, 40, 100, 50)
CTOT_STATUS = txt_add("OFF", "font:arimo_regular.ttf; size:14; color: red; halign:left;", 300, 40, 100, 50)
CTOT_PERCENT= txt_add("OFF", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 330, 40, 100, 50)

PROP_SYNC = txt_add("Prop Sync", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 200, 60, 100, 50)
PROP_SYNC_STATUS = txt_add("OFF", "font:arimo_regular.ttf; size:14; color: red; halign:left;", 300, 60, 100, 50)

AUTOCOARSEN = txt_add("Auto Coarsen", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 200, 80, 100, 50)
AUTOCOARSEN_STATUS = txt_add("OFF", "font:arimo_regular.ttf; size:14; color: red; halign:left;", 300, 80, 100, 50)

TORQUE = txt_add("Torque L%R%", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 200, 100, 100, 50)
TORQUE_STATUS_L = txt_add("NA", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 300, 100, 100, 50)
TORQUE_STATUS_R = txt_add("NA", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 330	, 100, 100, 50)

ATC = txt_add("ATC Mode", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 200, 120, 100, 50)
ATC_MODE_STATUS = txt_add("NA", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 300, 120, 100, 50)

ANTISKID = txt_add("ANTISKID", "font:arimo_regular.ttf; size:14; color: white; halign:left;", 200, 140, 100, 50)
ANTISKID_STATUS = txt_add("OFF", "font:arimo_regular.ttf; size:14; color: red; halign:left;", 300, 140, 100, 50)


function nav_selector (nav_l, nav_r)
visible ( nav_btn_l , nav_l >= 0.69)
visible ( nav_btn_r , nav_r >= 0.69)
end

function to_gnd_conf (to_inh_status, gnd_op_status)
visible ( to_inh , to_inh_status >= 0.69)
visible ( gnd_op , gnd_op_status >= 0.69)
end

function misc_announciators (alt_alert_stat, below_gs_stat, below_gs_inh_stat, terrain_stat)

visible ( terrain , terrain_stat >= 0.69)
visible ( alt_alert , alt_alert_stat >= 0.69)
visible ( below_gs , below_gs_stat >= 0.69)

end

function misc_status (ctot_l, ctot_r, prop_sync, autocoarsen, antiskid)
	
	ctot=-1.0
	if ctot_l == ctot_r then ctot = ctot_l end
	
	
	--if ctot_l == 1.0 then
	--	txt_set(CTOT_STATUS_L, "ON")
	--	txt_style(CTOT_STATUS_L , "color: green")
	--end
	--if ctot_r == 1.0 then
	--	txt_set(CTOT_STATUS_R, "ON")
	--	txt_style(CTOT_STATUS_R , "color: green")
	--end
	--if ctot_l == 0.0 then
	--	txt_set(CTOT_STATUS_L, "ARM")
	--	txt_style(CTOT_STATUS_L , "color: red")
	--end
	--if ctot_r == 0.0 then
	--	txt_set(CTOT_STATUS_R, "ARM")
	--	txt_style(CTOT_STATUS_R , "color: red")
	--end
	
	if ctot == 1.0 then
		txt_set(CTOT_STATUS, "ARM")
		txt_style(CTOT_STATUS , "color: green")
	end
	
	if ctot == 0.0 then
		txt_set(CTOT_STATUS, "OFF")
		txt_style(CTOT_STATUS , "color: red")
	end	
	
	if prop_sync == 0.0 then
		txt_set(PROP_SYNC_STATUS, "OFF")
		txt_style(PROP_SYNC_STATUS , "color: red")
	end
	if prop_sync == 1.0 then
		txt_set(PROP_SYNC_STATUS, "ON")
		txt_style(PROP_SYNC_STATUS , "color: green")
	end
	if autocoarsen == 0.0 then
		txt_set(AUTOCOARSEN_STATUS, "OFF")
		txt_style(AUTOCOARSEN_STATUS , "color: red")
	end
	if autocoarsen == 1.0 then
		txt_set(AUTOCOARSEN_STATUS, "ON")
		txt_style(AUTOCOARSEN_STATUS , "color: green")
	end
	if antiskid == 1.0 then
		txt_set(ANTISKID_STATUS, "ON")
		txt_style(ANTISKID_STATUS , "color: green")
	end
	if antiskid == 0.0 then
		txt_set(ANTISKID_STATUS, "OFF")
		txt_style(ANTISKID_STATUS , "color: red")
	end
end

function torque_status (torque_l, torque_r)

	torque_val_l = string.format("%.0f", torque_l)
	torque_val_r = string.format("%.0f", torque_r)

	txt_set(TORQUE_STATUS_L,torque_val_l)
	txt_set(TORQUE_STATUS_R,torque_val_r)
	
end

function ctot_val_status (ctot_set)

	ctot_val = string.format("%.0f", ctot_set)
	txt_set(CTOT_PERCENT,ctot_val)
	
end

function atc_status (atc_mode_selected)

	if atc_mode_selected == 0.0 then
		txt_set(ATC_MODE_STATUS, "OFF")
		txt_style(ATC_MODE_STATUS , "color: red")
	end
	
	if atc_mode_selected == 1.0 then
		txt_set(ATC_MODE_STATUS, "STBY")
		txt_style(ATC_MODE_STATUS , "color: green")
	end

	if atc_mode_selected == 2.0 then
		txt_set(ATC_MODE_STATUS, "ON")
		txt_style(ATC_MODE_STATUS , "color: green")
	end

	if atc_mode_selected == 3.0 then
		txt_set(ATC_MODE_STATUS, "ALT")
		txt_style(ATC_MODE_STATUS , "color: green")
	end

	
end

xpl_dataref_subscribe( 
"LES/saab/annun/MCP/nav_src_L" , "FLOAT", 
"LES/saab/annun/MCP/nav_src_R", "FLOAT", 
nav_selector)

xpl_dataref_subscribe( 
"LES/saab/annun/takeoff_inhibit" , "FLOAT", 
"LES/saab/annun/ground_op", "FLOAT", 
to_gnd_conf)

xpl_dataref_subscribe( 
"les/sf34a/acft/engn/anm/ctot_switch_L" , "FLOAT", 
"les/sf34a/acft/engn/anm/ctot_switch_R", "FLOAT", 
"les/sf34a/acft/engn/anm/prop_sync_switch", "FLOAT",
"les/sf34a/acft/engn/anm/autocoarsen_switch", "FLOAT",
"les/sf34a/acft/gear/anm/anti_skid_switch","FLOAT",
misc_status)

xpl_dataref_subscribe(
"LES/saab/engine_torque_L", "FLOAT",
"LES/saab/engine_torque_R", "FLOAT",
torque_status)

xpl_dataref_subscribe(
"les/sf34a/acft/engn/anm/ctot_trq_knob", "FLOAT",
ctot_val_status)

xpl_dataref_subscribe(
"les/sf34a/acft/avio/anm/pl2_atc_func_knob", "FLOAT",
atc_status)

xpl_dataref_subscribe(
"LES/saab/annun/altitude_alert","FLOAT",
"LES/saab/annun/below_gs","FLOAT",
"LES/saab/annun/below_gs_inhibit","FLOAT",
"LES/saab/annun/terrain","FLOAT",
misc_announciators)