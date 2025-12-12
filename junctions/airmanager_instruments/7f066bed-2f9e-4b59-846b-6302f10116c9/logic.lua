background_image = img_add_fullscreen ( "background_black_min.png" )

img_width = 60
img_height = 23
line_diff = 34
coll_diff = 90
line_1 = 15
col_1 = 10
col_2 = col_1 + coll_diff
col_3 = col_2 + coll_diff
col_4 = col_3 + coll_diff
line_2 = line_1 + line_diff
line_3 = line_2 + line_diff
line_4 = line_3 + line_diff
line_5 = line_4 + line_diff
line_6 = line_5 + line_diff
line_7 = line_6 + line_diff
line_8 = line_7 + line_diff
line_9 = line_8 + line_diff
line_10 = line_9 + line_diff

img_engine_fire_L = img_add ( "engine_fire_L.png" , col_1 , line_1 , img_width , img_height )
img_avionic_smoke = img_add ( "avionic_smoke.png" , col_2 , line_1 , img_width , img_height )
img_lav_smoke 	= 	img_add ( "lav_smoke.png" , col_3 , line_1 , img_width , img_height )
img_engine_fire_R = img_add ( "engine_fire_R.png" , col_4 , line_1 , img_width , img_height )

img_eng_oil_press_L = img_add ( "eng_oil_press_L.png" , col_1 , line_2 , img_width , img_height )
img_cargo_smoke = img_add ( "cargo_smoke.png" , col_2 , line_2 , img_width , img_height )
img_cabin_press	= 	img_add ( "cabin_press.png" , col_3 , line_2 , img_width , img_height )
img_eng_oil_press_R = img_add ( "eng_oil_press_R.png" , col_4 , line_2 , img_width , img_height )

img_tail_P_hot_L = img_add ( "tail_P_hot_L.png" , col_1 , line_3 , img_width , img_height )
img_black1 = img_add ( "black.png" , col_2 , line_3 , img_width , img_height )
img_prop_brake = img_add ( "prop_brake.png" , col_3 , line_3 , img_width , img_height )
img_tail_P_hot_R = img_add ( "tail_P_hot_R.png" , col_4 , line_3 , img_width , img_height )

img_black2 = img_add ( "black.png" , col_1 , line_4 , img_width , img_height )
img_auto_trim = img_add ( "auto_trim.png" , col_2 , line_4 , img_width , img_height )
img_config = img_add ( "config.png" , col_3 , line_4 , img_width , img_height )
img_black3 = img_add ( "black.png" , col_4 , line_4 , img_width , img_height )

img_autocoarsen = img_add ( "autocoarsen.png" , col_1 , line_5 , img_width , img_height )
img_black4 = img_add ( "black.png" , col_2 , line_5 , img_width , img_height )
img_pitch_trim = img_add ( "pitch_trim.png" , col_3 , line_5 , img_width , img_height )
img_rudder_limit = img_add ( "rudder_limit.png" , col_4 , line_5 , img_width , img_height )

img_fire_det_fail_L = img_add ( "fire_det_fail_L.png" , col_1 , line_6 , img_width , img_height )
img_fuel = img_add ( "fuel.png" , col_2 , line_6 , img_width , img_height )
img_elec = img_add ( "elec.png" , col_3 , line_6 , img_width , img_height )
img_fire_det_fail_R = img_add ( "fire_det_fail_R.png" , col_4 , line_6 , img_width , img_height )

img_ice_prot = img_add ( "ice_prot.png" , col_1 , line_7 , img_width , img_height )
img_engine = img_add ( "engine.png" , col_2 , line_7 , img_width , img_height )
img_flaps = img_add ( "flaps.png" , col_3 , line_7 , img_width , img_height )
img_aircond = img_add ( "aircond.png" , col_4 , line_7 , img_width , img_height )

img_park_brk_on = img_add ( "park_brk_on.png" , col_1 , line_8 , img_width , img_height )
img_hydr = img_add ( "hydr.png" , col_2 , line_8 , img_width , img_height )
img_emer_lts_unarm = img_add ( "emer_lts_unarm.png" , col_3 , line_8 , img_width , img_height )
img_oxygen = img_add ( "oxygen.png" , col_4 , line_8 , img_width , img_height )

img_askid_inop = img_add ( "askid_inop.png" , col_1 , line_9 , img_width , img_height )
img_avionics = img_add ( "avionics.png" , col_2 , line_9 , img_width , img_height )
img_avionics_vent = img_add ( "avionics_vent.png" , col_3 , line_9 , img_width , img_height )
img_doors = img_add ( "doors.png" , col_4 , line_9 , img_width , img_height )

img_stall_fail_L = img_add ( "stall_fail_L.png" , col_1 , line_10 , img_width , img_height )
img_gust_lock = img_add ( "gust_lock.png" , col_2 , line_10 , img_width , img_height )
img_pusher_system = img_add ( "pusher_system.png" , col_3 , line_10 , img_width , img_height )
img_stall_fail_R = img_add ( "stall_fail_R.png" , col_4 , line_10 , img_width , img_height )

function misc_status (
eng_oil_press_L,
eng_oil_press_R,
fuel,
aircond,
askid_inop,
auto_trim,
avionic_smoke,
avionics,
autocoarsen,
avionics_vent,
cabin_press,
cargo_smoke,
config,
doors,
elec,
emer_lts_unarm,
engine,
engine_fire_L,
engine_fire_R,
fire_det_fail_L,
fire_det_fail_R,
flaps,
gust_lock,
hydr,
ice_prot,
lav_smoke,
oxygen,
park_brk_on,
pitch_trim,
prop_brake,
pusher_system,
rudder_limit,
stall_fail_L,
stall_fail_R,
tail_P_hot_L,
tail_P_hot_R)

visible ( img_eng_oil_press_L,eng_oil_press_L > 0.3)
visible ( img_eng_oil_press_R,eng_oil_press_R > 0.3)
visible ( img_fuel,fuel > 0.3)
visible ( img_aircond,aircond > 0.3)
visible ( img_askid_inop,askid_inop > 0.3)
visible ( img_auto_trim,auto_trim > 0.3)
visible ( img_avionic_smoke,avionic_smoke > 0.3)
visible ( img_avionics,avionics > 0.3)
visible ( img_autocoarsen,autocoarsen > 0.3)
visible ( img_avionics_vent,avionics_vent > 0.3)
visible ( img_cabin_press,cabin_press > 0.3)
visible ( img_cargo_smoke,cargo_smoke > 0.3)
visible ( img_config,config > 0.3)
visible ( img_doors,doors > 0.3)
visible ( img_elec,elec > 0.3)
visible ( img_emer_lts_unarm,emer_lts_unarm > 0.3)
visible ( img_engine,engine > 0.3)
visible ( img_engine_fire_L,engine_fire_L > 0.3)
visible ( img_engine_fire_R,engine_fire_R > 0.3)
visible ( img_fire_det_fail_L,fire_det_fail_L > 0.3)
visible ( img_fire_det_fail_R,fire_det_fail_R > 0.3)
visible ( img_flaps,flaps > 0.3)
visible ( img_gust_lock,gust_lock > 0.3)
visible ( img_hydr,hydr > 0.3)
visible ( img_ice_prot,ice_prot > 0.3)
visible ( img_lav_smoke,lav_smoke > 0.3)
visible ( img_oxygen,oxygen > 0.3)
visible ( img_park_brk_on,park_brk_on > 0.3)
visible ( img_pitch_trim,pitch_trim > 0.3)
visible ( img_prop_brake,prop_brake > 0.3)
visible ( img_pusher_system,pusher_system > 0.3)
visible ( img_rudder_limit,rudder_limit > 0.3)
visible ( img_stall_fail_L,stall_fail_L > 0.3)
visible ( img_stall_fail_R,stall_fail_R > 0.3)
visible ( img_tail_P_hot_L,tail_P_hot_L > 0.3)
visible ( img_tail_P_hot_R,tail_P_hot_R > 0.3)
	
end

xpl_dataref_subscribe( 
"LES/saab/annun/CWP/eng_oil_press_L" , "FLOAT", 
"LES/saab/annun/CWP/eng_oil_press_R", "FLOAT", 
"LES/saab/annun/CWP/fuel", "FLOAT",
"LES/saab/annun/CWP/aircond", "FLOAT",
"LES/saab/annun/CWP/askid_inop", "FLOAT",
"LES/saab/annun/CWP/auto_trim", "FLOAT",
"LES/saab/annun/CWP/avionic_smoke", "FLOAT",
"LES/saab/annun/CWP/avionics", "FLOAT",
"LES/saab/annun/CWP/autocoarsen", "FLOAT",
"LES/saab/annun/CWP/avionics_vent", "FLOAT",
"LES/saab/annun/CWP/cabin_press", "FLOAT",
"LES/saab/annun/CWP/cargo_smoke", "FLOAT",
"LES/saab/annun/CWP/config", "FLOAT",
"LES/saab/annun/CWP/doors", "FLOAT",
"LES/saab/annun/CWP/elec", "FLOAT",
"LES/saab/annun/CWP/emer_lts_unarm", "FLOAT",
"LES/saab/annun/CWP/engine", "FLOAT",
"LES/saab/annun/CWP/engine_fire_L", "FLOAT",
"LES/saab/annun/CWP/engine_fire_R", "FLOAT",
"LES/saab/annun/CWP/fire_det_fail_L", "FLOAT",
"LES/saab/annun/CWP/fire_det_fail_R", "FLOAT",
"LES/saab/annun/CWP/flaps", "FLOAT",
"LES/saab/annun/CWP/gust_lock", "FLOAT",
"LES/saab/annun/CWP/hydr", "FLOAT",
"LES/saab/annun/CWP/ice_prot", "FLOAT",
"LES/saab/annun/CWP/lav_smoke", "FLOAT",
"LES/saab/annun/CWP/oxygen", "FLOAT",
"LES/saab/annun/CWP/park_brk_on", "FLOAT",
"LES/saab/annun/CWP/pitch_trim", "FLOAT",
"LES/saab/annun/CWP/prop_brake", "FLOAT",
"LES/saab/annun/CWP/pusher_system", "FLOAT",
"LES/saab/annun/CWP/rudder_limit", "FLOAT",
"LES/saab/annun/CWP/stall_fail_L", "FLOAT",
"LES/saab/annun/CWP/stall_fail_R", "FLOAT",
"LES/saab/annun/CWP/tail_P_hot_L", "FLOAT",
"LES/saab/annun/CWP/tail_P_hot_R", "FLOAT",
misc_status)
