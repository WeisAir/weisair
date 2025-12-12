img_background = img_add_fullscreen("airspeed_indicator_bg.png")

--graphic elements

img_bug = img_add_fullscreen("airspeed_indicator_bug.png")
ias_flag_rect = canvas_add(0, 0, 512, 512, function()
  _rect(349, 185, 30, 110)
  _fill("red")
end)
img_needle1 = img_add_fullscreen("airspeed_indicator_1st_needle.png")
img_needle2 = img_add_fullscreen("airspeed_indicator_2nd_needle.png")

--callback functions 

function cb_airspeed(airspeed,vmospeed,bugspeed,ias_flag)
   
   airspeed = var_cap(airspeed, 0, 350)
   bugspeed = var_cap(bugspeed, 0, 350)
   vmospeed = var_cap(vmospeed, 0,350)

	if airspeed <=40 then
		rotate(img_needle1,airspeed*0.3)
	elseif airspeed <= 70 then
		rotate(img_needle1,airspeed*(1.1*math.log(airspeed-18,10)-1.18))
	elseif airspeed <=130 then
		rotate(img_needle1,airspeed*(0.8*math.log(airspeed-20,10)-0.65))
	elseif airspeed <=200 then
		rotate(img_needle1,airspeed*(0.4*math.log(airspeed-20,10)+0.17))
	else
		rotate(img_needle1,airspeed*(-0.4*math.log(airspeed-20,10)+1.965))
	end
   
   
   if bugspeed <= 40 then
		rotate(img_bug,bugspeed*0.3)
	elseif bugspeed <= 70 then
		rotate(img_bug,bugspeed*(1.1*math.log(bugspeed-18,10)-1.18)-3.5)
	elseif bugspeed <=130 then
		rotate(img_bug,bugspeed*(0.8*math.log(bugspeed-20,10)-0.65)-3.5)
	elseif bugspeed <=200 then
		rotate(img_bug,bugspeed*(0.4*math.log(bugspeed-20,10)+0.17)-3.5)
	else
		rotate(img_bug,bugspeed*(-0.4*math.log(bugspeed-20,10)+1.965)-3.5)
	end
    
    rotate(img_needle2,vmospeed+2)
    
    if ias_flag == 1.0 then visible(ias_flag_rect,true) end
    if ias_flag == 0.0 then visible(ias_flag_rect,false) end
    
end

function callback(direction)
        
        if direction == 1 then  xpl_command("les/sf34a/acft/inst/mnp/airspeed_ind_bug_knob_up_pilot") end
	if direction == -1 then xpl_command("les/sf34a/acft/inst/mnp/airspeed_ind_bug_knob_dn_pilot") end
	
end

-- Adds a dial, The callback function will be called when the dial is being turned
my_dial = dial_add("knob.png", 50,420,80,80,callback)

function pressed_callback()
    xpl_command("les/sf34a/acft/inst/mnp/airspeed_ind_test_button_pilot",1) 
end

function released_callback()
    xpl_command("les/sf34a/acft/inst/mnp/airspeed_ind_test_button_pilot",0) 
end

test_button = button_add("","", 50,420,80,80, pressed_callback, released_callback)

visible(ias_flag_rect,false)

xpl_dataref_subscribe(
"LES/saab/ias_pointer", "FLOAT",
"LES/saab/Vmo_pointer","FLOAT",
"les/sf34a/acft/inst/anm/airspeed_ind_bug_knob_pilot","FLOAT",
"LES/saab/ias_flag","FLOAT", cb_airspeed)


