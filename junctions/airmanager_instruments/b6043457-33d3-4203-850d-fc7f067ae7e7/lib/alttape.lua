--THIS LIBRARY IS MANAGING THE RUNNING ALTITUDE TAPE AND THE RUNNING ALTITUDE TEXT

--************************************************************************************************

function lib_alttape_init()

local my_string = ""
local length = 0
local alt_string = 0
local zirrow_string = 0

--*** THIS IS THE FUNCTION FOR THE LINES AND TEXT ON THE GREY TAPE ON THE RIGHT SIDE***********************************
--Thousend and Ten Thousend as bigger figures
function item_value_callback_alt(i)
	if i % 2 == 0 then								--even or odd ?
		--return string.format("%d", i * 100 * -1) 							--output as integer
                my_string = (string.format("%d", i * 100 * -1))
				length = string.len(my_string)
					if length == 3 then --or i == 0 then
						--alt_string = string.sub(my_string, 1, 1)			--hundreds
						--new_alt_string = (string.format("%d", i * 100 * -1))
						new_alt_string = " "								--hundreds
					elseif length == 4 then
						alt_string = string.sub(my_string, 1, 1)			--thousend
						new_alt_string = alt_string .. "     "
					elseif length == 5 then
						alt_string = string.sub(my_string, 1, 2)			--ten thousend
						new_alt_string = alt_string .. "     "
					end
                return new_alt_string 
	else
		return ""
	end 	
end

running_text_alt = running_txt_add_ver(717,-40,12,80,80,item_value_callback_alt,"size:39px; font:FreeSans.ttf; color:white; halign:right;")
--running_img_alt  = running_img_add_ver("speedimage.png",684,64,10,31,80)

--running_img_move_carot(running_img_alt, 0)
running_txt_move_carot(running_text_alt, 0)

--Values after the bigger figures
function item_value_callback_alt_minor(ii)
	if ii % 2 == 0 then
		my_string_minor = (string.format("%d", ii * 100 * -1))					--output as integer
				length_minor = string.len(my_string_minor)
					if length_minor == 3 or ii == 0 then
						--alt_string_minor = string.sub(my_string_minor, 2, 3)			--hundreds
						if ii == 0 then
							alt_string_minor = "000"
						else
							alt_string_minor = (string.format("%d", ii * 100 * -1))
						end
					elseif length_minor == 4 then
						alt_string_minor = string.sub(my_string_minor, 2, 4)			--thousend
					elseif length_minor == 5 then
						alt_string_minor = string.sub(my_string_minor, 3, 5)			--ten thousend
					end
                return alt_string_minor 
	else
		return ""
	end 	
	
	
end


running_text_alt_minor = running_txt_add_ver(720,-34,12,80,80,item_value_callback_alt_minor,"size:31px; font:FreeSans.ttf; color:white; halign:right;") 
running_img_alt  = running_img_add_ver("speedimage.png",684,64,10,31,80)

running_img_move_carot(running_img_alt, 0)
running_txt_move_carot(running_text_alt_minor, 0)

-----------------------------------------------------------------------------------------------------------------------------

-- Altitude indicator running image. This is the running grey tape at the right side of the PFD
function alt_tape(altitude)

--Position of the altitudes on the tape
	altitude = var_cap(altitude, 0, 40000)
	
	running_txt_move_carot(running_text_alt_minor, (altitude / 100) * -1)

	running_txt_move_carot(running_text_alt, (altitude / 100) * -1)
    running_img_move_carot(running_img_alt, (altitude / 100) * -1)
	
	yalt = 600 + (altitude * 1.16)	--was 300
	yalt = var_cap(yalt, 300, 695)
	
	viewport_rect(running_text_alt_minor,663,115,137,yalt)
	
	viewport_rect(running_text_alt,663,115,137,yalt)
	viewport_rect(running_img_alt,663,115,137,yalt)
	
--****THIS IS THE END FOR THE LINES AND TEXT ON THE GREY TAPE ON THE RIGHT SIDE************************************



--*** THIS IS THE RUNNING TEXT FOR THE ALTITUDE IN THE BLACK BOX ON THE RIGHT**************************************	
-- Altitude indicator running text, these are the numbers in the black box************************************
	running_txt_move_carot(running_text_inner_alt_minor_id, (altitude / 10) * -1)
	
	if altitude % 100 > 90 then
    	running_txt_move_carot(running_text_inner_alt_major100_id, ( altitude - 90 - (math.floor(altitude / 100) * 90) ) * -0.1 )
    else
    	running_txt_move_carot(running_text_inner_alt_major100_id, math.floor(altitude / 100) * -1)
    end
	
	if (altitude % 1000) > 990 then
    	running_txt_move_carot(running_text_inner_alt_major1000_id, (( altitude - 990 - (math.floor(altitude / 1000) * 990) ) * -0.1))
    else
    	running_txt_move_carot(running_text_inner_alt_major1000_id, math.floor( altitude / 1000 ) * -1)
    end
	
end


--Images for the altitude box------------
img_add("altbox2.png", 704, 426, 140, 75)


function item_value_callback_inner_alt_minor(i)   	
	if i == 0 then
		return"0"
	elseif i > 0 then
		return""
	elseif string.format("%02d", ((4-(i%5))*20)+20) == "100" then --%02d = links opvullen met 2 nullen 
		return "00" 
	else
		return string.format("%02d", ((4-(i%5))*20)+20)
	end															
end
													--780,399,8,50,25
running_text_inner_alt_minor_id = running_txt_add_ver(780,352,8,50,25, item_value_callback_inner_alt_minor, "font:BCG.ttf; size:26px; color:white; halign:center; valign:center")--26px
running_txt_move_carot(running_text_inner_alt_minor_id, 0)
viewport_rect(running_text_inner_alt_minor_id,785,432,42,65)      --was 785,439,42,60


function item_value_callback_inner_alt_major100(i)
    
	if i == 0 then
		return"0"
	else
		return string.format("%d", (0 - i)%10 )
	end
	
end
														--741,409,3,44,38
running_text_inner_alt_major100_id = running_txt_add_ver(741,413,3,44,38, item_value_callback_inner_alt_major100, "font:BCG.ttf; size:26px; color:white; halign:right")
running_txt_move_carot(running_text_inner_alt_major100_id, 0)
viewport_rect(running_text_inner_alt_major100_id,725,437,60,52)		--was 725,439,60,52....725,432,60,65

function item_value_callback_inner_alt_major1000(i)

	if i == 0 then
		return"0"
	else
		return"" .. - i
	end
	
end
														--709,391,3,55,50
running_text_inner_alt_major1000_id = running_txt_add_ver(709,397,3,55,50, item_value_callback_inner_alt_major1000, "font:BCG.ttf; size:32px; color:white; halign:right")--44px
running_txt_move_carot(running_text_inner_alt_major1000_id, 0)
viewport_rect(running_text_inner_alt_major1000_id,715,437,60,52)		--was 715,439,60,52....715,432,60,65

--********END RUNNING ALTITUDE TEXT FOR THE BLACK BOX ON THE RIGHT ****************************************************

xpl_dataref_subscribe("sim/flightmodel/misc/h_ind", "FLOAT", alt_tape)			--altitude
------------------------------------------------------------------------------------------------------------------------

end