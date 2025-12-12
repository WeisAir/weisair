--THIS LIBRARY IS MANAGING THE FLAPS, V1, Vref AND THE GREEN ACCELERATION ARROWS******************

--************************************************************************************************

function lib_new_info_left_init()

img_no_vspeed = img_add("no_vspd-1.png", 132, 320, 30, 120)
img_v1 = img_add("V1.png", 70,450, 80, 250)	--70,450, 100, 270
img_vRef = img_add("vRefBug.png", 85,900, 78, 145)--81,900, 82, 158		
img_accel_up = img_add("accel_up.png", 82, 278, 14, 181)visible(img_accel_up,false)
img_accel_dn = img_add("accel_dn.png", 82, 460, 14, 181)visible(img_accel_dn,false)
img_vRef20 = img_add("flapmarker.png", 105, 400, 35, 20)visible(img_vRef20, false) 	--105, 650, 35, 20


txt_flap_1 = txt_add("___1", "size:24px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
txt_flap_2 = txt_add("___2", "size:24px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
txt_flap_5 = txt_add("___5", "size:24px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
txt_flap_up = txt_add("___up", "size:22px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
--txt_flap_10 = txt_add("___10", "size:24px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
txt_flap_15 = txt_add("___15", "size:24px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
txt_flap_25 = txt_add("___25", "size:24px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
--txt_flap_30 = txt_add("___30", "size:24px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
--txt_flap_40 = txt_add("___40", "size:24px; font:FreeSansBold.ttf; color: lime;  halign:left;", 90, 400, 100, 100)
txt_vrefspd1 = txt_add(" ", "size:18px; font:BCG.ttf; color: lime;  halign:left;", 130, 400, 100, 100)
txt_vrefspd2 = txt_add(" ", "size:18px; font:BCG.ttf; color: lime;  halign:left;", 130, 400, 100, 100)


viewport_rect(img_v1,60,115,137,695)
viewport_rect(img_vRef,60,115,137,695)
viewport_rect(img_vRef20,60,115,137,695)
viewport_rect(txt_flap_1,60,115,137,695)
viewport_rect(txt_flap_2,60,115,137,695)	
viewport_rect(txt_flap_5,60,115,137,695)	
viewport_rect(txt_flap_up,60,115,137,695)    
--viewport_rect(txt_flap_10,60,115,137,695)
viewport_rect(txt_flap_15,60,115,137,695)
viewport_rect(txt_flap_25,60,115,137,695)
--viewport_rect(txt_flap_30,60,115,137,695)
--viewport_rect(txt_flap_40,60,115,137,695)
--viewport_rect(txt_vrefspd,60,115,157,695)	--60,115,137,695
viewport_rect(img_accel_up, 70, 178, 40, 280)--70, 182, 40, 280
viewport_rect(img_accel_dn, 70, 460, 40, 250)


-- Flap Manoeuvering Speed and v1-rotate and vRef bugs and acceleration arrows

function new_info_left(ind_altid,flaps_1s,flaps_2s,flaps_5s,flaps_15s,flaps_25s,flap1_position,flap2_position,flap5_position,
flap15_position,flap25_position,flapsup_show,flapsup_position,v1,v1rbug,vrefbug,speed,
acceleration,vref_spd,ref_flaps,novspd)

	
	if flaps_1s == 1 then 
		move(txt_flap_1,nil, ((flap1_position - speed) * -5.5) + 438,nil,nil)
	else 
		move(txt_flap_1,nil,-50,nil,nil) 
	end
	
	if flaps_2s == 1 then 
		move(txt_flap_2,nil, ((flap2_position - speed) * -5.5) + 438,nil,nil)  
	else 
		move(txt_flap_2,nil,-50,nil,nil) 
	end
	
	if flaps_5s == 1 then
		move(txt_flap_5,nil,((flap5_position - speed) * -5.5) + 438,nil,nil)
	else
		move(txt_flap_5,nil,-50,nil,nil)
	end
	
	if flaps_15s == 1 then 
		move(txt_flap_15,nil,((flap15_position - speed) * -5.5) + 438,nil,nil)	
	else 
		move(txt_flap_15,nil,-50,nil,nil) 
	end
	
	if flaps_25s == 1 then 
		move(txt_flap_25,nil,((flap25_position - speed) * -5.5) + 438,nil,nil)	
	else 
		move(txt_flap_25,nil,-50,nil,nil) 
	end
-----------------------------------------------------------------------------------------------	
	
	if flapsup_show == 1 then 
		move(txt_flap_up,nil,((flapsup_position - speed) * -5.5) + 438,nil,nil) 
	else 
		visible(txt_flap_up,false) 
	end
	
	if  novspd == 1 then 
		visible(img_no_vspeed, true) 
	else 
		visible(img_no_vspeed, false) 
	end

--------v1rotate marker
	 if v1rbug == 1 then
		y_v1marker = 305 + ((v1 - speed) * -5.5)
		y_v1marker_ex = var_cap(y_v1marker, -200, 850)    
		move(img_v1,nil,y_v1marker_ex,nil,nil)
	 else
		move(img_v1,nil,-50,nil,nil)
	 end

-----vRef marker
	if vrefbug == 1 then 									--speed >10 then
		local y_vRefmarker = ((vref_spd - speed) * -5.5)+386		
		y_vRefmarker = var_cap(y_vRefmarker, -200, 850)			
		visible(img_vRef,true)
		move(img_vRef,nil,y_vRefmarker,nil,nil)
	elseif vrefbug == 0 then
		visible(img_vRef,false)
	end
	
	if vref_spd > 0 then
		local y_vRef20 = (((vref_spd) - speed) * -5.5)+340		
		y_vRef20 = var_cap(y_vRef20, -200, 850)
		txt_set(txt_vrefspd1,"REF")
		move(txt_vrefspd1,145,770,nil,nil)
		txt_set(txt_vrefspd2, string.format ("%.f",ref_flaps) .. "/" .. string.format ("%.f",vref_spd))
		move(txt_vrefspd2,145,790,nil,nil)
		visible(img_vRef20,true)
		move(img_vRef20,nil,y_vRef20,nil,nil)
	else
		txt_set(txt_vrefspd1,"")
		txt_set(txt_vrefspd2,"")
		visible(img_vRef20,false)
	end
	
	--acceleration arrows
	visible(img_accel_up, acceleration >= 0.3)
    visible(img_accel_dn, acceleration <= -0.3)
  
    move(img_accel_up, nil, var_cap(462 + (-60 * acceleration),278,462), nil, nil)
    move(img_accel_dn, nil, var_cap(279 - ((-60 * acceleration) * -1), 279, 460), nil, nil)
	
end
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",			--ind_altid
					  "laminar/B738/pfd/flaps_1_show", "INT",								--flaps_1s
					  "laminar/B738/pfd/flaps_2_show", "INT",								--flaps_2s
					  "laminar/B738/pfd/flaps_5_show", "INT",								--flaps_5s
					  "laminar/B738/pfd/flaps_15_show", "INT",								--flaps_15s
					  "laminar/B738/pfd/flaps_25_show", "INT",								--flaps_25s
					  "laminar/B738/pfd/flaps_1", "FLOAT",									--flap1_position
					  "laminar/B738/pfd/flaps_2", "FLOAT",									--flap2_position
					  "laminar/B738/pfd/flaps_5", "FLOAT",									--flap5_position
					  "laminar/B738/pfd/flaps_15", "FLOAT",									--flap15_position
					  "laminar/B738/pfd/flaps_25", "FLOAT",									--flap25_position
					  "laminar/B738/pfd/flaps_up_show", "FLOAT",							--flapsup_show
					  "laminar/B738/pfd/flaps_up", "FLOAT",									--flapsup_position
					  "laminar/B738/FMS/v1_set", "INT",										--v1
					  "laminar/B738/FMS/v1r_bugs", "INT",									--v1rbug
					  "laminar/B738/FMS/vref_bugs", "INT", 									--vrefbug
					  "sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT",			--speed
					  "sim/cockpit2/gauges/indicators/airspeed_acceleration_kts_sec_pilot", "FLOAT",	--acceleration
					  "laminar/B738/FMS/vref", "FLOAT",										--vref_spd
					  "laminar/B738/FMS/approach_flaps", "FLOAT",							--ref_flaps
					  "laminar/B738/pfd/no_vspd", "INT", new_info_left)						--novspd
			  
end
---------------------------------------------------------------------------------------------------------------------