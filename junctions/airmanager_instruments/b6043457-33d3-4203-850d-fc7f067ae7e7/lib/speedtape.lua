--**************************************************************************************************

--THIS LIBRARY ONLY MANAGE THE SPEEDTAPE AND THE SPEEDCARROT ON THE LEFT SIDE OF THE PFD************

--**************************************************************************************************
function lib_speedtape_init()


--********Running text and images for speed**********************************************************
--These are the scroling numbers on the left side of the PFD
function item_value_callback_speed(i)
	if i %2 == 0 then
		return string.format("%d", 0 - (i * 10) )
	else
		return ""
	end
end
										--0,57,15,68,55
running_text_speed = running_txt_add_ver(0,50,15,68,55,item_value_callback_speed,"size:24px; font:BCG.ttf; color:white; halign:right;")
running_img_speed  = running_img_add_ver("speedimage.png",80,129,14,34,55)
 
running_txt_move_carot(running_text_speed, 0)
running_img_move_carot(running_img_speed, 0)
----------------------------------------------------------------------------------------------------


--******** Running text airspeed ***********************************************************************
--These are the running numbers in the black square on the left side of the PFD

--Images for this speedbox------------------
img_speedbox = img_add("altbox2.png", 0, 421 , 86, 75)
img_rotate(img_speedbox,180)


function item_value_callback_inner_speed_minor(i)
    
	if i > 0 then
		return""
	else
		return string.format("%d", (0 - i) % 10 )
	end
	
end

running_text_inner_speed_minor_id = running_txt_add_ver(50,367,5,30,40, item_value_callback_inner_speed_minor, "font:BCG.ttf; size:30px; color:white;")
running_txt_move_carot(running_text_inner_speed_minor_id, 0)
viewport_rect(running_text_inner_speed_minor_id,43,423,29,70)

function item_value_callback_inner_speed_major(i)
    
	if i == 0 then
		return ""
	else
		return string.format("%d", (0 - i) )
	end
	
end

running_text_inner_speed_major_id = running_txt_add_ver(-1,400,3,50,44, item_value_callback_inner_speed_major, "size:34px; font:BCG.ttf; color:white; halign:right")
running_txt_move_carot(running_text_inner_speed_major_id, 0)
viewport_rect(running_text_inner_speed_major_id,2,435 ,46,45)--2,433 ,46,57......2,426 ,46,65.....2,438 ,46,40
--******************************************************************************************************


-- Speedtape indicator running image********************************************************************
function speed_tape(airspeed)

	airspeed = var_cap(airspeed, 0, 999)
	if airspeed < 45 then airspeed = 45 end

	running_txt_move_carot(running_text_speed, (airspeed / 10) * -1)
    running_img_move_carot(running_img_speed, (airspeed / 10) * -1)

	
	yspeed = 300 + (airspeed * 6.6)

	yspeed = var_cap(yspeed, 300, 695)
	
	viewport_rect(running_text_speed,0,115,95,yspeed)   --0,115,95
	viewport_rect(running_img_speed,90,115,50,yspeed)

-- Speed indicator running text********************************************************************************
    running_txt_move_carot(running_text_inner_speed_minor_id, (airspeed / 1) * -1)

    if airspeed % 10 > 9 then
    	running_txt_move_carot(running_text_inner_speed_major_id, ( airspeed - 9 - (math.floor(airspeed / 10) * 9) ) * -1 )
    else
    	running_txt_move_carot(running_text_inner_speed_major_id, math.floor(airspeed / 10) * -1)
    end	
end
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT",	speed_tape)		--airspeed

--*************************************************************************************************************

end