background_image_id = img_add_fullscreen("alt_indicator_new.png")

--set up running text field altitude drum tens  place
function alt_10_value_callback(i)
  return "" .. (0 - i) % 10
end

function alt_10_value_callback(i)
    return string.format("%02d", (4- (i%5) ) * 20 )
end

alt_numbers_offset_y = 35

alt_viewport_x = 121
alt_viewport_y = 153 + alt_numbers_offset_y
alt_viewport_width = 261
alt_viewport_height = 61

alt_10_running_txt_id = running_txt_add_ver(294,111+alt_numbers_offset_y,4,77,45,alt_10_value_callback,"size:55px; font:DejaVuSans.ttf; color:white; halign:right;")
viewport_rect(alt_10_running_txt_id, alt_viewport_x,alt_viewport_y, alt_viewport_width, alt_viewport_height)


--set up running text field altitude drum hundreds place

function alt_100_value_callback(i)
  return "" .. (0 - i) % 10
end

alt_100_running_txt_id = running_txt_add_ver(257,66+alt_numbers_offset_y,4,38,45,alt_100_value_callback,"size:55px; font:DejaVuSans.ttf; color:white; halign:right;")
viewport_rect(alt_100_running_txt_id, alt_viewport_x,alt_viewport_y, alt_viewport_width, alt_viewport_height)

 --set up running text field altitude drum thousands place

function alt_1000_value_callback(i)
  return "" .. ((0 - i -1) % 10) 
end

alt_1000_running_txt_id = running_txt_add_ver(193,150+alt_numbers_offset_y,3,40,65,alt_1000_value_callback,"size:65px; font:DejaVuSans.ttf; color:white; halign:right;")
viewport_rect(alt_1000_running_txt_id, alt_viewport_x,alt_viewport_y, alt_viewport_width, alt_viewport_height)

 --set up running text field altitude drum ten-thousands place

function alt_10000_value_callback(i)
  return "" .. ((0 - i - 1) % 10)
end

alt_10000_running_txt_id = running_txt_add_ver(133,150+alt_numbers_offset_y,3,40,65,alt_10000_value_callback,"size:65px; font:DejaVuSans.ttf; color:white; halign:right;")
viewport_rect(alt_10000_running_txt_id, alt_viewport_x,alt_viewport_y-3, alt_viewport_width, alt_viewport_height-1)


-- Baro set knob image and command function and inputs

function baro_dial_it(direction)
  if direction == 1 then
    xpl_command ("les/sf34a/acft/inst/mnp/altimeter_baro_knob_up_pilot", 1)
  elseif direction == -1 then
    xpl_command ("les/sf34a/acft/inst/mnp/altimeter_baro_knob_dn_pilot", 1)
  end
end

baro_dial = dial_add("baro_knob_new.png",6,328,160,160,baro_dial_it)
--dial_click_rotate ( baro_dial , 36 )

 --set up running text field baro drum hundreths (.01) place


 
function baro_pt01_value_callback(i)
  return "" .. (0 - i) % 10
end

baro_numbers_offset_x = 75
baro_numbers_offset_y = 25

baro_viewport_x = 272 - baro_numbers_offset_x
baro_viewport_y = 330 + baro_numbers_offset_y
baro_viewport_width = 102
baro_viewport_height = 32


baro_pt01_running_txt_id = running_txt_add_ver(347-baro_numbers_offset_x,298+baro_numbers_offset_y,3,20,32,baro_pt01_value_callback,"size:29px; font:DejaVuSans.ttf; color:white; halign:right;")
viewport_rect(baro_pt01_running_txt_id, baro_viewport_x,baro_viewport_y, baro_viewport_width, baro_viewport_height)

 --set up running text field baro drum tents (.1) place
 
function baro_pt10_value_callback(i)
  return "" .. (0 - i) % 10
end

baro_pt10_running_txt_id = running_txt_add_ver(327-baro_numbers_offset_x,298+baro_numbers_offset_y,3,20,32,baro_pt10_value_callback,"size:29px; font:DejaVuSans.ttf; color:white; halign:right;")
viewport_rect(baro_pt10_running_txt_id, baro_viewport_x,baro_viewport_y, baro_viewport_width, baro_viewport_height)

 --set up running text field baro drum ones place
 
function baro_1_value_callback(i)
  return "" .. (0 - i) % 10
end

baro_1_running_txt_id = running_txt_add_ver(303-baro_numbers_offset_x,298+baro_numbers_offset_y,3,20,32,baro_1_value_callback,"size:29px; font:DejaVuSans.ttf; color:white; halign:right;")
viewport_rect(baro_1_running_txt_id, baro_viewport_x,baro_viewport_y, baro_viewport_width, baro_viewport_height)

 --set up running text field baro drum tens place
 
function baro_10_value_callback(i)
  return "" .. (0 - i) % 10
end

baro_10_running_txt_id = running_txt_add_ver(282-baro_numbers_offset_x,298+baro_numbers_offset_y,3,20,32,baro_10_value_callback,"size:29px; font:DejaVuSans.ttf; color:white; halign:right;")
viewport_rect(baro_10_running_txt_id, baro_viewport_x,baro_viewport_y, baro_viewport_width, baro_viewport_height)

-- initalize altitude flags

ten_thou_flag= img_add_fullscreen("altimeter_shutter.png")
one_thou_flag= img_add_fullscreen("neg_flag.png")
as_needle_image_id = img_add_fullscreen("AS_needle.png")

function PT_altimeter( altitude, baro )

--set as needle position 

  t = ( altitude - math.floor(altitude/10000)* 10000 )* 0.36
  rotate(as_needle_image_id, t)
  	
  --altimeter drums
  -- set 20s drum
   running_txt_move_carot(alt_10_running_txt_id, (altitude / 20) * -1) 
   
   
   
   if (altitude % 100) > 90 then
    running_txt_move_carot(alt_100_running_txt_id, ( altitude/10 - 9 - (math.floor(altitude / 100) * 9) ) * -1 )
  else 
    running_txt_move_carot(alt_100_running_txt_id, math.floor( altitude / 100 ) * -1)
  end


if (altitude % 1000) > 900 then
    running_txt_move_carot(alt_1000_running_txt_id, ( altitude/100 - 9 - (math.floor(altitude / 1000) * 9) ) * -1 )
  else 
    running_txt_move_carot(alt_1000_running_txt_id, math.floor( altitude / 1000 ) * -1)
  end
  
  if (altitude % 10000) > 9900 then
     running_txt_move_carot(alt_10000_running_txt_id, ( altitude/1000 - 9.9 - (math.floor(altitude / 10000) * 9.9) ) * -10 )
  else 
    running_txt_move_carot(alt_10000_running_txt_id,math.floor( altitude / 10000 ) * -1) 
  end


 --set altitude flags
 
 if( altitude < 0) then 
  visible(one_thou_flag,true)
  visible(ten_thou_flag,true)
elseif (altitude < 10000)  then
  visible(ten_thou_flag,true)
  visible(one_thou_flag,false)
else
  visible(ten_thou_flag,false)
  visible(one_thou_flag,false)
end	
  
  --baro drums
  
  if (baro  > 31) then
   baro = 31.00
   end
  if( baro < 26) then
   baro = 26.00
  end
  
  baro_integer, baro_fraction = math.modf(baro)
  baro_fraction = baro_fraction * 100
  
 running_txt_move_carot(baro_pt01_running_txt_id, ( baro_fraction % 10) * -1 )
  
  if (baro_fraction % 10) > 9 then
   running_txt_move_carot(baro_pt10_running_txt_id, ( baro_fraction - 9 - (math.floor(baro_fraction / 10) * 9) ) * -1 )
  else 
   running_txt_move_carot(baro_pt10_running_txt_id, math.floor( baro_fraction / 10 ) * -1)
  end

 running_txt_move_carot(baro_1_running_txt_id,    ( baro_integer% 10) * -1 )
  
  if (baro_integer % 10) > 9 then
   running_txt_move_carot(baro_10_running_txt_id, ( baro_integer - 9 - (math.floor(baro_integer / 10) * 9) ) * -1 )
  else 
  running_txt_move_carot(baro_10_running_txt_id, math.floor( baro_integer / 10 ) * -1)
  end  
  
  mbaro = baro * 33.8638815
  
   running_txt_move_carot(mbaro_pt01_running_txt_id, (mbaro * -1) )
   
   --set tens drum
  if (mbaro % 10) > 9 then
    running_txt_move_carot(mbaro_pt10_running_txt_id, ( mbaro/10 - 0.09 - (math.floor(mbaro / 10) * 0.09) ) * -1 )
  else 
    running_txt_move_carot(mbaro_pt10_running_txt_id, math.floor( mbaro / 10 ) * -1)
  end 
  --set hundreds drum
  if (mbaro % 100) > 90 then
    running_txt_move_carot(mbaro_1_running_txt_id, ( mbaro/100 - .9 - (math.floor(mbaro / 100) * .9) ) * -1 )
  else 
    running_txt_move_carot(mbaro_1_running_txt_id, math.floor( mbaro / 100 ) * -1)
  end
  --set thusands drum
  if (mbaro % 1000) > 990 then
    running_txt_move_carot(mbaro_10_running_txt_id, ( mbaro/1000 - 9.9 - (math.floor(mbaro / 1000) * 9.9) ) * -1 )
  else 
    running_txt_move_carot(mbaro_10_running_txt_id, math.floor( mbaro / 1000 ) * -1)
  end	
  
 end	


--XP Data Subscriptions
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",
                      "sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", "FLOAT", PT_altimeter)
fsx_variable_subscribe("INDICATED ALTITUDE","Feet","KOHLSMAN SETTING HG","inHg",PT_altimeter) 