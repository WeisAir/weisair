--[[
*****************************************************************
************FSS ERJ - 1XX - OVERHEAD PANEL TEST****************
*****************************************************************
##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
--]]

img_add_fullscreen("greybackground.png")

--PASSENGER SIGNS----------------------------------------------------------
---------------------------------------------------------------------------------
--Emergency Light Knob----------------
img_sw_emlt_off = img_add("snub_dial.png",  473,882, 68,68) visible(img_sw_emlt_off, true)
img_sw_emlt_arm = img_add("snub_dial.png",  473,882, 68,68) visible(img_sw_emlt_arm, false)
img_sw_emlt_on = img_add("snub_dial.png",  473,882, 68,68) visible(img_sw_emlt_on, false)
rotate(img_sw_emlt_off, -55)
rotate(img_sw_emlt_on, 55)
function emlt_image_cb (state)
        switch_set_position(sw_emlt, state)     
        visible(img_sw_emlt_off, state == 0)
        visible(img_sw_emlt_arm, state == 1)
        visible(img_sw_emlt_on, state == 2)
 end

xpl_dataref_subscribe("XCrafts/light/emerg_switch", "FLOAT", emlt_image_cb)

function cb_sw_emlt(val,dir)
        xpl_command("XCrafts/light/emerg_switch", "FLOAT", val + dir)  
end

function cb_sw_emlt(position, direction)
    if direction == 1 then  
        if position == 1 then		
		xpl_command("sim/lights/generic_15_light_tog", "FLOAT",2)
		elseif position == 0 then
		xpl_command("sim/lights/generic_15_light_tog","FLOAT",1)	
	end
    else 		   
        if position == 2 then
		xpl_command("sim/lights/generic_15_light_tog","FLOAT",1)
        elseif position == 1 then
		xpl_command("sim/lights/generic_15_light_tog","FLOAT",0)
	end
	end
end
sw_emlt = switch_add(nil,nil,nil,473,882, 68,68, cb_sw_emlt)

--Sterile Switch-------------------
img_sw_stl_on = img_add("silver4_dn.png",   462, 950,60,120)
img_sw_stl_off = img_add("silver4_up.png",  462, 950,60,120) visible(img_sw_stl_off, false)

function cb_sw_stl(position)
		if position == 1 then
		xpl_command("sim/lights/generic_07_light_tog")
		visible(img_sw_stl_off, false)
		visible(img_sw_stl_on, true)
		switch_set_position(sw_stl, 0)
		elseif position == 0 then
		xpl_command("sim/lights/generic_07_light_tog")
		visible(img_sw_stl_on, false)
		visible(img_sw_stl_off, true)
		switch_set_position(sw_stl, 1)	
        end
end
sw_stl= switch_add(nil,nil,462, 950, 60,120, cb_sw_stl)

--[[
xpl_dataref_subscribe("XCrafts/light/sterile_switch", "FLOAT", 
        function (state)
            switch_set_position(sw_stl, state)
                visible(img_sw_stl_off, state ==1)
            
                visible(img_sw_stl_on, state ==0)         
        end)

function cb_sw_stl(position)
    if (position == 0 ) then
        xpl_command("XCrafts/light/sterile_switch","FLOAT",1) 
    elseif (position == 1 ) then
        xpl_command("XCrafts/light/sterile_switch","FLOAT",0)  
    end 
end
sw_stl= switch_add(nil,nil,462, 950, 60,120, cb_sw_stl)
--]]
-----
img_sw_smk_up = img_add("silver4_up.png",    550, 950,60,120)
img_sw_smk_dn = img_add("silver4_dn.png",   550, 950,60,120) visible(img_sw_smk_dn, false)

xpl_dataref_subscribe("sim/cockpit/switches/no_smoking", "INT", 
        function (state)
            switch_set_position(sw_smk, state)
                visible(img_sw_smk_dn, state ==0)
                visible(img_sw_smk_up, state ==1)
         end)

function cb_sw_smk(position)
    if (position == 0 ) then
        xpl_command("sim/systems/no_smoking_toggle") 
		visible(img_sw_smk_up, false)
    elseif (position == 1 ) then
        xpl_command("sim/systems/no_smoking_toggle")
		xpl_command("sim/systems/no_smoking_toggle")
    end 
end
sw_smk= switch_add(nil,nil,   550, 950,60,120, cb_sw_smk)

------
img_sw_sb_up = img_add("silver4_up.png",   644, 950,60,120)
img_sw_sb_dn = img_add("silver4_dn.png",  644, 950,60,120) visible(img_sw_sb_dn, false)

xpl_dataref_subscribe("sim/cockpit/switches/fasten_seat_belts", "INT", 
        function (state)
            switch_set_position(sw_sb, state)
                visible(img_sw_sb_dn, state ==0)
                visible(img_sw_sb_up, state ==1)
        end)

function cb_sw_sb(position)
    if (position == 0 ) then
        xpl_command("sim/systems/seatbelt_sign_toggle")
    elseif (position == 1 ) then
        xpl_command("sim/systems/seatbelt_sign_toggle")
		xpl_command("sim/systems/seatbelt_sign_toggle")
    end 
end
sw_sb= switch_add(nil,nil, 644, 950,60,120, cb_sw_sb)

------ELECTRIC SECTION-----------------------------------------------------
--------------------------------------------------------------------------------
--IDG 2-----------------
img_sw_idg2_auto = img_add("snub_dial.png", 263,264, 68,68) visible(img_sw_idg2_auto, true)
img_sw_idg2_off = img_add("snub_dial.png",  263,264, 68,68) visible(img_sw_idg2_off, false)
img_sw_idg2_disc = img_add("snub_dial.png",  263,264, 68,68) visible(img_sw_idg2_disc, false)
rotate(img_sw_idg2_off, 50)
rotate(img_sw_idg2_disc, 93)
function idg2_image_cb (state)
        switch_set_position(sw_idg2, state)
       
        visible(img_sw_idg2_disc, state == 0)
        visible(img_sw_idg2_off, state == 1)
        visible(img_sw_idg2_auto, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_ELEC_BV_IDG2", "Number", idg2_image_cb)

function cb_sw_idg2(val,dir)
        fs2020_variable_write("L:FSS_EXX_ELEC_BV_IDG2", "Number", val + dir)  
end
sw_idg2 = switch_add(nil,nil,nil, 263,264, 68,68, cb_sw_idg2)

--IDG 1----------------
img_sw_idg1_disc = img_add("snub_dial.png", 64,263, 68,68) visible(img_sw_idg1_disc, false)
img_sw_idg1_off = img_add("snub_dial.png",  64,263, 68,68) visible(img_sw_idg1_off, false)
img_sw_idg1_auto = img_add("snub_dial.png",  64,263, 68,68) visible(img_sw_idg1_auto, true)
rotate(img_sw_idg1_off, -50)
rotate(img_sw_idg1_disc, -93)
function idg1_image_cb (state)
        switch_set_position(sw_idg1, state)
       
        visible(img_sw_idg1_disc, state == 0)
        visible(img_sw_idg1_off, state == 1)
        visible(img_sw_idg1_auto, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_ELEC_BV_IDG1", "Number", idg1_image_cb)

function cb_sw_idg1(val,dir)
        fs2020_variable_write("L:FSS_EXX_ELEC_BV_IDG1", "Number", val + dir)  
end
sw_idg1 = switch_add(nil,nil,nil, 64,263, 68,68, cb_sw_idg1)

--GPU------------------------
img_sw_gpu_on = img_add("push_btn_on.png",  45,413, 65,64)
img_sw_gpu_off = img_add("push_btn_off.png",   51,419, 54,53) visible(img_sw_gpu_off, true)

fs2020_variable_subscribe("L:FSS_EXX_ELEC_BV_GPU_BTN", "Number", 
        function (state)
            switch_set_position(sw_gpu, state)
                visible(img_sw_gpu_on, state ==1)
            
                visible(img_sw_gpu_off, state ==0)
            
        end)

function cb_sw_gpu(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_ELEC_BV_GPU_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_ELEC_BV_GPU_BTN","Number",0) 
    end 
end

sw_gpu= switch_add(nil,nil,47,415, 61,60, cb_sw_gpu)


--AC BUS TIES----------------
img_sw_acbus_open1= img_add("snub_dial.png", 164,420, 68,68) visible(img_sw_acbus_open1, false)
img_sw_acbus_auto = img_add("snub_dial.png",  164,420, 68,68) visible(img_sw_acbus_auto, true)
img_sw_acbus_open2 = img_add("snub_dial.png",  164,420, 68,68) visible(img_sw_acbus_open2, false)
rotate(img_sw_acbus_open2, 55)
rotate(img_sw_acbus_open1, -55)
function acbus_image_cb (state)
        switch_set_position(sw_acbus, state)
       
        visible(img_sw_acbus_open1, state == 0)
        visible(img_sw_acbus_auto, state == 1)
        visible(img_sw_acbus_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_ELEC_BV_AC_BUS_TIES", "Number", acbus_image_cb)

function cb_sw_acbus(val,dir)
        fs2020_variable_write("L:FSS_EXX_ELEC_BV_AC_BUS_TIES", "Number", val + dir)  
end
sw_acbus = switch_add(nil,nil,nil, 164,420, 68,68, cb_sw_acbus)


--APU GEN------------------------
img_sw_apgen_on = img_add("push_btn_on.png",285,413, 65,64)
img_sw_apgen_off = img_add("push_btn_off.png",292,419, 54,53) visible(img_sw_apgen_off, true)

fs2020_variable_subscribe("L:FSS_EXX_ELEC_BV_APUGEN_BTN", "Number", 
        function (state)
            switch_set_position(sw_apgen, state)
                visible(img_sw_apgen_on, state ==0)
            
                visible(img_sw_apgen_off, state ==1)
            
        end)

function cb_sw_apgen(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_ELEC_BV_APUGEN_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_ELEC_BV_APUGEN_BTN","Number",0) 
    end 
end

sw_apgen= switch_add(nil,nil,285,413, 65,64, cb_sw_apgen)


--Bat 2--------------------
img_sw_bat2_on = img_add("snub_dial.png",  273,680, 68,68)
img_sw_bat2_off = img_add("snub_dial.png",  273,680, 68,68) visible(img_sw_bat2_off, false)
rotate(img_sw_bat2_on, -50)
xpl_dataref_subscribe("sim/cockpit2/electrical/battery_on", "INT[8]", 
        function (state)
            switch_set_position(sw_bat2, state[2])
                visible(img_sw_bat2_on, state[2] ==0)           
                visible(img_sw_bat2_off, state[2] ==1)        
        end)

function cb_sw_bat2(position)
    if (position == 0 ) then
		xpl_command("sim/electrical/battery_2_on")
    elseif (position == 1 ) then
		xpl_command("sim/electrical/battery_2_off")
    end 
end
sw_bat2= switch_add(nil,nil,  273,680, 68,68, cb_sw_bat2)

--Bat 1--
img_sw_bat_on = img_add("snub_dial.png",  53,680, 68,68)
img_sw_bat_off = img_add("snub_dial.png",  53,680, 68,68) visible(img_sw_bat_off, false)
rotate(img_sw_bat_off, -50)
xpl_dataref_subscribe("sim/cockpit2/electrical/battery_on", "INT[8]", 
        function (state)
            switch_set_position(sw_bat, state[1])
                visible(img_sw_bat_off, state[1] ==0)           
                visible(img_sw_bat_on, state[1] ==1)           
        end)

function cb_sw_bat(position)
    if (position == 0 ) then
		xpl_command("sim/electrical/battery_1_on")
    elseif (position == 1 ) then
		xpl_command("sim/electrical/battery_1_off")
    end 
end
sw_bat= switch_add(nil,nil,  53,680, 68,68, cb_sw_bat)

-----COCKPIT LIGHTING------------------------------------------------------
-------------------------------------------------------------------------------------------
--Main Panel Lighting Dial--------------------------------------------------------------

img_mp = img_add("class_dial.png", 68,888,50,50)
fs2020_variable_subscribe("L:FSS_EXX_CPLT_BV_MAIN_KNOB", "Number", 
    function(value)
        local rotation_angle = value * 260 - 130  
        rotate(img_mp, rotation_angle)
    end
 )
function knob_mp( direction)
    if direction ==  1 then
        fs2020_rpn("(L:FSS_EXX_CPLT_BV_MAIN_KNOB) 0.05 + 1 min 0 max (>L:FSS_EXX_CPLT_BV_MAIN_KNOB)")
    elseif direction == -1 then
        fs2020_rpn("(L:FSS_EXX_CPLT_BV_MAIN_KNOB) 0.05 - 1 min 0 max (>L:FSS_EXX_CPLT_BV_MAIN_KNOB)")
    end
end

mp_dial = dial_add(nil, 68,888,50,50, knob_mp)
dial_click_rotate(mp_dial, 4)

--Overhead Panel Lighting Dial---------------------------------------------------------
img_ohpnl = img_add("class_dial.png", 172,888,50,50)
fs2020_variable_subscribe("L:FSS_EXX_CPLT_BV_OVHD_KNOB", "Number", 
    function(value)
        local rotation_angle = value * 260 - 130  
        rotate(img_ohpnl, rotation_angle)
    end
)
function knob_ohpnl(direction)
    if direction == 1 then
        fs2020_rpn("(L:FSS_EXX_CPLT_BV_OVHD_KNOB) 0.05 + 1 min 0 max (>L:FSS_EXX_CPLT_BV_OVHD_KNOB)")
    elseif direction == -1 then
        fs2020_rpn("(L:FSS_EXX_CPLT_BV_OVHD_KNOB) 0.05 - 1 min 0 max (>L:FSS_EXX_CPLT_BV_OVHD_KNOB)")
    end
end

ohpnl_dial = dial_add(nil, 172,888,50,50, knob_ohpnl)
dial_click_rotate(ohpnl_dial, 4)

--Pedestal Lighting Dial---------------------------------------------------------

img_ped = img_add("class_dial.png", 276, 888, 50, 50)
fs2020_variable_subscribe("L:FSS_EXX_CPLT_BV_PDSTL_KNOB", "Number", 
    function(value)
        local rotation_angle = value * 260 - 130  
        rotate(img_ped, rotation_angle)
    end
)
function knob_ped(direction)
    if direction == 1 then
        fs2020_rpn("(L:FSS_EXX_CPLT_BV_PDSTL_KNOB) 0.05 + 1 min 0 max (>L:FSS_EXX_CPLT_BV_PDSTL_KNOB)")
    elseif direction == -1 then
        fs2020_rpn("(L:FSS_EXX_CPLT_BV_PDSTL_KNOB) 0.05 - 1 min 0 max (>L:FSS_EXX_CPLT_BV_PDSTL_KNOB)")
    end
end

ped_dial = dial_add(nil, 276, 888, 50, 50, knob_ped)
dial_click_rotate(ped_dial, 4)

--Annunciators Test Button----------------------------------------------------------------------------
local ann_value = 0 

function Ann_Press()
    fs2020_variable_write("L:FSS_EXX_OVHD_CPL_ANUNTEST_BTN", "Number", 1)  
end

function Ann_Release()
    fs2020_variable_write("L:FSS_EXX_OVHD_CPL_ANUNTEST_BTN", "Number", 0)  
end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_CPL_ANUNTEST_BTN", "Number",
    function(val)
        ann_value = val
    end
)
Ann_ENG = button_add(nil, "circle_pressed.png", 85, 988, 40, 40, Ann_Press, Ann_Release)

---DOME LIGHT---------------------------------------------------------------

img_sw_dome_on = img_add("silver4_up.png",  248, 950, 60,120)
img_sw_dome_off = img_add("silver4_dn.png",  248, 950, 60,120) visible(img_sw_dome_off, false)

function cb_sw_dome(position)
		if position == 1 then
		xpl_command("XCrafts/Lights/cockpit_dome_toggle")
		visible(img_sw_dome_off, false)
		visible(img_sw_dome_on, true)
		switch_set_position(sw_dome, 0)
		elseif position == 0 then
		xpl_command("XCrafts/Lights/cockpit_dome_toggle")
		visible(img_sw_dome_on, false)
		visible(img_sw_dome_off, true)
		switch_set_position(sw_dome, 1)	
        end
end
sw_dome= switch_add(nil,nil,248, 950, 60,120, cb_sw_dome)

--FUEL SECTION--------------------------------------------------------------
--------------------------------------------------------------------------------

--X FEED DIAL-----------------
img_sw_xf_open1= img_add("snub_dial.png", 549,463, 68,68) visible(img_sw_xf_open1, false)
img_sw_xf_auto = img_add("snub_dial.png",  549,463, 68,68) visible(img_sw_xf_auto, true)
img_sw_xf_open2 = img_add("snub_dial.png",  549,463, 68,68) visible(img_sw_xf_open2, false)
rotate(img_sw_xf_open2, 55)
rotate(img_sw_xf_open1, -55)
function xf_image_cb (state)
        switch_set_position(sw_xf, state)
        visible(img_sw_xf_open1, state == 0)
        visible(img_sw_xf_auto, state == 1)
        visible(img_sw_xf_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_FUEL_XFEED", "Number", xf_image_cb)

function cb_sw_xf(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_FUEL_XFEED", "Number", val + dir)  
end
sw_xf = switch_add(nil,nil,nil, 549,463, 68,68, cb_sw_xf)

---DC PUMP DIAL-------------------------------------------------------------

img_sw_dc_open1= img_add("snub_dial.png", 549,598, 68,68) visible(img_sw_dc_open1, false)
img_sw_dc_auto = img_add("snub_dial.png",  549,598, 68,68) visible(img_sw_dc_auto, true)
img_sw_dc_open2 = img_add("snub_dial.png",  549,598, 68,68) visible(img_sw_dc_open2, false)
rotate(img_sw_dc_open2, 50)
rotate(img_sw_dc_open1, -50)
function dc_image_cb (state)
        switch_set_position(sw_dc, state)
        visible(img_sw_dc_open1, state == 0)
        visible(img_sw_dc_auto, state == 1)
        visible(img_sw_dc_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_FUEL_DC_PUMP", "Number", dc_image_cb)

function cb_sw_dc(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_FUEL_DC_PUMP", "Number", val + dir)  
end
sw_dc = switch_add(nil,nil,nil, 549,598, 68,68, cb_sw_dc)

---AC PUMP 1 DIAL-------------------------------------------------------------

img_sw_ac1_open1= img_add("snub_dial.png", 450,682, 68,68) visible(img_sw_ac1_open1, false)
img_sw_ac1_auto = img_add("snub_dial.png",  450,682, 68,68) visible(img_sw_ac1_auto, true)
img_sw_ac1_open2 = img_add("snub_dial.png",  450,682, 68,68) visible(img_sw_ac1_open2, false)
rotate(img_sw_ac1_open2, 50)
rotate(img_sw_ac1_open1, -50)
function ac1_image_cb (state)
        switch_set_position(sw_ac1, state)
        visible(img_sw_ac1_open1, state == 0)
        visible(img_sw_ac1_auto, state == 1)
        visible(img_sw_ac1_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_FUEL_AC_PUMP_1", "Number", ac1_image_cb)

function cb_sw_ac1(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_FUEL_AC_PUMP_1", "Number", val + dir)  
end
sw_ac1 = switch_add(nil,nil,nil, 450,682, 68,68, cb_sw_ac1)

-------AC PUMP 2 DIal----------

img_sw_ac2_open1= img_add("snub_dial.png", 650,682, 68,68) visible(img_sw_ac2_open1, false)
img_sw_ac2_auto = img_add("snub_dial.png",  650,682, 68,68) visible(img_sw_ac2_auto, true)
img_sw_ac2_open2 = img_add("snub_dial.png",  650,682, 68,68) visible(img_sw_ac2_open2, false)
rotate(img_sw_ac2_open2, 50)
rotate(img_sw_ac2_open1, -50)
function ac2_image_cb (state)
        switch_set_position(sw_ac2, state)
        visible(img_sw_ac2_open1, state == 0)
        visible(img_sw_ac2_auto, state == 1)
        visible(img_sw_ac2_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_FUEL_AC_PUMP_2", "Number", ac2_image_cb)

function cb_sw_ac2(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_FUEL_AC_PUMP_2", "Number", val + dir)  
end
sw_ac2 = switch_add(nil,nil,nil, 650,682, 68,68, cb_sw_ac2)


------EXTERNAL LIGHTS------------------------------------------------------
--------------------------------------------------------------------------------

--Wing Inspection Light--
img_sw_inspl_on = img_add("silver4_up.png",  1040, 794, 60,120)
img_sw_inspl_off = img_add("silver4_dn.png",  1040, 794, 60,120) visible(img_sw_inspl_on, false)

function cb_sw_inspl(position)
		if position == 1 then
		xpl_command("sim/lights/generic_12_light_tog")
		visible(img_sw_inspl_on, false)
		visible(img_sw_inspl_off, true)
		switch_set_position(sw_inspl, 0)
		elseif position == 0 then
		xpl_command("sim/lights/generic_12_light_tog")
		visible(img_sw_inspl_off, false)
		visible(img_sw_inspl_on, true)
		switch_set_position(sw_inspl, 1)	
        end
end
sw_inspl= switch_add(nil,nil,  1040, 794, 60,120, cb_sw_inspl)
--[[
img_sw_inspl_on = img_add("silver4_up.png",  1040, 794, 60,120)
img_sw_inspl_off = img_add("silver4_dn.png",  1040, 794, 60,120) visible(img_sw_inspl_off, false)

xpl_dataref_subscribe("XCrafts/light/inspection_switch", "FLOAT", 
        function (state)
            switch_set_position(sw_inspl, state)
                visible(img_sw_inspl_off, state ==0)            
                visible(img_sw_inspl_on, state ==1)           
        end)

function cb_sw_inspl(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_EXLT_INSP_SWITCH","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_EXLT_INSP_SWITCH","Number",0) 
    end 
end
--]]

--Side Taxi Light--
img_sw_stax_on = img_add("flat_dn.png",  966,792,60,120)
img_sw_stax_off = img_add("flat_up.png",  966,792,60,120) visible(img_sw_stax_off, false)

function cb_sw_stax(position)
		if position == 0 then
		xpl_command("sim/lights/generic_22_light_tog")
		visible(img_sw_stax_on, false)
		visible(img_sw_stax_off, true)
		switch_set_position(sw_stax, 1)
		elseif position == 1 then
		xpl_command("sim/lights/generic_22_light_tog")
		visible(img_sw_stax_off, false)
		visible(img_sw_stax_on, true)
		switch_set_position(sw_stax, 0)	
        end
end
sw_stax= switch_add(nil,nil,  966,792,60,120, cb_sw_stax)
--[[
--Side Taxi Light--
img_sw_stax_on = img_add("flat_up.png",  966,792,60,120)
img_sw_stax_off = img_add("flat_dn.png",  966,792,60,120) visible(img_sw_stax_off, false)

xpl_dataref_subscribe("sim/cockpit2/switches/taxi_light_on", "INT", 
        function (state)
            switch_set_position(sw_stax, state)
                visible(img_sw_stax_off, state ==0)          
                visible(img_sw_stax_on, state ==1)           
        end)

function cb_sw_stax(position)
    if (position == 0 ) then
		xpl_command("sim/lights/taxi_lights_on")
    elseif (position == 1 ) then
		xpl_command("sim/lights/taxi_lights_off")
    end 
end
--]]
--Nose Taxi Light--
img_sw_ntax_on = img_add("flat_up.png",  896,792,60,120)
img_sw_ntax_off = img_add("flat_dn.png",  896,792,60,120) visible(img_sw_ntax_off, false)

xpl_dataref_subscribe("sim/cockpit2/switches/taxi_light_on", "INT", 
        function (state)
            switch_set_position(sw_ntax, state)
                visible(img_sw_ntax_off, state ==0)
                visible(img_sw_ntax_on, state ==1)
        end)

function cb_sw_ntax(position)
    if (position == 0 ) then
		xpl_command("sim/lights/taxi_lights_on")
    elseif (position == 1 ) then
		xpl_command("sim/lights/taxi_lights_off")
    end 
end
sw_ntax= switch_add(nil,nil,  896,792,60,120, cb_sw_ntax)

--Logo Light--
img_sw_logo_on = img_add("silver4_dn.png",  826, 794, 60,120)
img_sw_logo_off = img_add("silver4_up.png",  826, 794, 60,120) visible(img_sw_logo_off, false)

function cb_sw_logo(position)
		if position == 0 then
		xpl_command("sim/lights/generic_11_light_tog")
		visible(img_sw_logo_on, false)
		visible(img_sw_logo_off, true)
		switch_set_position(sw_logo, 1)
		elseif position == 1 then
		xpl_command("sim/lights/generic_11_light_tog")
		visible(img_sw_logo_off, false)
		visible(img_sw_logo_on, true)
		switch_set_position(sw_logo, 0)	
        end
end
sw_logo= switch_add(nil,nil,  826, 794, 60,120, cb_sw_logo)
--[[
img_sw_logo_on = img_add("silver4_up.png",  826, 794, 60,120)
img_sw_logo_off = img_add("silver4_dn.png",  826, 794, 60,120) visible(img_sw_logo_off, false)

xpl_dataref_subscribe("XCrafts/light/logo_switch", "FLOAT", 
        function (state)
            switch_set_position(sw_logo, state)
                visible(img_sw_logo_off, state ==0)
                visible(img_sw_logo_on, state ==1)
        end)

function cb_sw_logo(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_EXLT_LOGO_SWITCH","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_EXLT_LOGO_SWITCH","Number",0) 
    end 
end

--]]

--Right Landing Light--
img_sw_rlt_mid = img_add("up_lswitch.png",  1028, 950, 60, 110)
img_sw_rlt_dn = img_add("dn_lswitch.png",  1028, 950, 60, 110) visible(img_sw_rlt_dn, false)

xpl_dataref_subscribe("sim/cockpit2/switches/landing_lights_switch", "FLOAT[16]", 
        function (state)
            switch_set_position(sw_rlt, state[3])
                visible(img_sw_rlt_dn, state[3] ==1)
                visible(img_sw_rlt_mid, state[3] ==0)
        end)

function cb_sw_rlt(position)
    if (position == 0 ) then
        xpl_command("XCrafts/Lights/right_landing_light_toggle") 
    elseif (position == 1 ) then
        xpl_command("XCrafts/Lights/right_landing_light_toggle")  
    end 
end
sw_rlt= switch_add(nil,nil,1028, 950, 60, 110, cb_sw_rlt)

--Center Landing Light--
img_sw_clt_mid = img_add("up_lswitch.png",  932, 950, 60, 110)
img_sw_clt_dn = img_add("dn_lswitch.png",  932, 950, 60, 110) visible(img_sw_clt_dn, false)

xpl_dataref_subscribe("sim/cockpit2/switches/landing_lights_switch", "FLOAT[16]", 
        function (state)
            switch_set_position(sw_clt, state[1])
                visible(img_sw_clt_dn, state[1] ==1)
                visible(img_sw_clt_mid, state[1] ==0) 
        end)

function cb_sw_clt(position)
    if (position == 0 ) then
        xpl_command("XCrafts/Lights/center_landing_light_toggle") 
    elseif (position == 1 ) then
        xpl_command("XCrafts/Lights/center_landing_light_toggle") 
    end 
end
sw_clt= switch_add(nil,nil,932, 950, 60, 110, cb_sw_clt)

--Left Landing Light--
img_sw_llt_mid = img_add("up_lswitch.png",  836, 950, 60, 110)
img_sw_llt_dn = img_add("dn_lswitch.png",  836, 950, 60, 110) visible(img_sw_llt_dn, false)

xpl_dataref_subscribe("sim/cockpit2/switches/landing_lights_switch", "FLOAT[16]", 
        function (state)
            switch_set_position(sw_llt, state[2])
                visible(img_sw_llt_dn, state[2] ==1)
                visible(img_sw_llt_mid, state[2] ==0)
        end)

function cb_sw_llt(position)
    if (position == 0 ) then
        xpl_command("XCrafts/Lights/left_landing_light_toggle") 
    elseif (position == 1 ) then
        xpl_command("XCrafts/Lights/left_landing_light_toggle") 
    end 
end
sw_llt= switch_add(nil,nil, 836, 950, 60, 110, cb_sw_llt)

--Red Beacon--
img_sw_rb_on = img_add("silver4_up.png",  1038, 670, 60,120)
img_sw_rb_off = img_add("silver4_dn.png",  1038, 670, 60,120) visible(img_sw_rb_off, false)

xpl_dataref_subscribe("sim/cockpit2/switches/beacon_on", "INT", 
        function (state)
            switch_set_position(sw_rb, state)
                visible(img_sw_rb_off, state ==0)            
                visible(img_sw_rb_on, state ==1)           
        end)

function cb_sw_rb(position)
    if (position == 0 ) then
        xpl_command("sim/lights/beacon_lights_on") 
    elseif (position == 1 ) then
        xpl_command("sim/lights/beacon_lights_off") 
    end 
end

sw_rb= switch_add(nil,nil, 1038, 670, 60,120, cb_sw_rb)

--Strobe Switch--
img_sw_strb_mid = img_add("flat_up.png",  930, 666, 60,120)
img_sw_strb_dn = img_add("flat_dn.png",  930, 666, 60,120) visible(img_sw_strb_dn, false)


xpl_dataref_subscribe("sim/cockpit2/switches/strobe_lights_on", "INT", 
        function (state)
            switch_set_position(sw_strb, state)
                visible(img_sw_strb_dn, state ==0)           
                visible(img_sw_strb_mid, state ==1)           
        end)

function cb_sw_strb(position)
    if (position == 0 ) then
        xpl_command("sim/lights/strobe_lights_on") 
    elseif (position == 1 ) then
        xpl_command("sim/lights/strobe_lights_off") 
    end 
end

sw_strb= switch_add(nil,nil, 930, 666, 60,120, cb_sw_strb)

--Nav Switch--
img_sw_nav_mid = img_add("silver4_up.png",  832, 670, 60,120)
img_sw_nav_dn = img_add("silver4_dn.png",  832, 670, 60,120) visible(img_sw_nav_dn, false)

xpl_dataref_subscribe("sim/cockpit/electrical/nav_lights_on", "INT", 
        function (state)
            switch_set_position(sw_nav, state)
                visible(img_sw_nav_dn, state ==0)           
                visible(img_sw_nav_mid, state ==1)          
        end)

function cb_sw_nav(position)
    if (position == 0 ) then
        xpl_command("sim/lights/nav_lights_on") 
    elseif (position == 1 ) then
        xpl_command("sim/lights/nav_lights_off") 
    end 
end
sw_nav= switch_add(nil,nil, 832, 670, 60,120, cb_sw_nav)

---------------------------------------------------------------------------------------------
--Hydraulic Section------------------------------------------------------------------------

--PTU DIAL------------------------------------------
img_sw_ptu_open1= img_add("snub_dial.png", 1307,440, 68,68) visible(img_sw_ptu_open1, false)
img_sw_ptu_auto = img_add("snub_dial.png", 1307,440, 68,68) visible(img_sw_ptu_auto, true)
img_sw_ptu_open2 = img_add("snub_dial.png",  1307,440, 68,68) visible(img_sw_ptu_open2, false)
rotate(img_sw_ptu_open2, 50)
rotate(img_sw_ptu_open1, -50)
function ptu_image_cb (state)
        switch_set_position(sw_ptu, state)
        visible(img_sw_ptu_open1, state == 0)
        visible(img_sw_ptu_auto, state == 1)
        visible(img_sw_ptu_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HYD_PTU", "Number", ptu_image_cb)

function cb_sw_ptu(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_HYD_PTU", "Number", val + dir)  
end
sw_ptu = switch_add(nil,nil,nil, 1307,440, 68,68, cb_sw_ptu)

--SYSTEM 1 PUMP--------------------
img_sw_sys1_open1= img_add("snub_dial.png", 1208,570, 68,68) visible(img_sw_sys1_open1, false)
img_sw_sys1_auto = img_add("snub_dial.png",  1208,570, 68,68) visible(img_sw_sys1_auto, true)
img_sw_sys1_open2 = img_add("snub_dial.png",  1208,570, 68,68) visible(img_sw_sys1_open2, false)
rotate(img_sw_sys1_open2, 50)
rotate(img_sw_sys1_open1, -50)
function sys1_image_cb (state)
        switch_set_position(sw_sys1, state)
        visible(img_sw_sys1_open1, state == 0)
        visible(img_sw_sys1_auto, state == 1)
        visible(img_sw_sys1_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HYD_ELC_SYS1_PUMP", "Number", sys1_image_cb)

function cb_sw_sys1(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_HYD_ELC_SYS1_PUMP", "Number", val + dir)  
end
sw_sys1 = switch_add(nil,nil,nil, 1208,570, 68,68, cb_sw_sys1)

--SYSTEM 2 PUMP------------------------------------------
img_sw_sys2_open1= img_add("snub_dial.png", 1412,570, 68,68) visible(img_sw_sys2_open1, false)
img_sw_sys2_auto = img_add("snub_dial.png", 1412,570, 68,68) visible(img_sw_sys2_auto, true)
img_sw_sys2_open2 = img_add("snub_dial.png",  1412,570, 68,68) visible(img_sw_sys2_open2, false)
rotate(img_sw_sys2_open2, 50)
rotate(img_sw_sys2_open1, -50)
function sys2_image_cb (state)
        switch_set_position(sw_sys2, state)
        visible(img_sw_sys2_open1, state == 0)
        visible(img_sw_sys2_auto, state == 1)
        visible(img_sw_sys2_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HYD_ELC_SYS2_PUMP", "Number", sys2_image_cb)

function cb_sw_sys2(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_HYD_ELC_SYS2_PUMP", "Number", val + dir)  
end
sw_sys2 = switch_add(nil,nil,nil, 1412,570, 68,68, cb_sw_sys2)

--Electric Pump A---------------------
img_sw_sys3a_mid = img_add("snub_dial.png",  1208, 702, 68, 68) rotate(img_sw_sys3a_mid, -48)
--img_sw_sys3a_dn = img_add("snub_dial.png",  1208, 702, 68, 68) visible(img_sw_sys3a_dn, false)
--rotate(img_sw_sys3a_dn, -42)

function cb_sw_sys3a(position)
		if position == 1 then
		rotate(img_sw_sys3a_mid, -48)
		switch_set_position(sw_sys3a, 0)
		elseif position == 0 then
		rotate(img_sw_sys3a_mid, 0)
		switch_set_position(sw_sys3a, 1)	
        end
end
sw_sys3a= switch_add(nil,nil,  1208, 702, 68, 68, cb_sw_sys3a)
--[[
--rotate(img_sw_sys3a_dn, -42)
xpl_dataref_subscribe("XCrafts/hydraulic/sys3_elec_pump_a_switch", "INT", 
        function (state)
            switch_set_position(sw_sys3a, state)
                visible(img_sw_sys3a_dn, state ==0)           
                visible(img_sw_sys3a_mid, state ==1)           
        end)
--[[
function cb_sw_sys3a(position)
    if (position == 0 ) then
        fs2020_variable_write("XCrafts/hydraulic/sys3_elec_pump_a_switch","INT",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("XCrafts/hydraulic/sys3_elec_pump_a_switch","INT",0) 
    end 
end
--]]
--Electric Pump B------------------------------------------
img_sw_epb_open1= img_add("snub_dial.png", 1412,702, 68,68) visible(img_sw_epb_open1, false)
img_sw_epb_auto = img_add("snub_dial.png", 1412,702, 68,68) visible(img_sw_epb_auto, true)
img_sw_epb_open2 = img_add("snub_dial.png",  1412,702, 68,68) visible(img_sw_epb_open2, false)
rotate(img_sw_epb_open2, 50)
rotate(img_sw_epb_open1, -50)
function epb_image_cb (state)
        switch_set_position(sw_epb, state)
        visible(img_sw_epb_open1, state == 0)
        visible(img_sw_epb_auto, state == 1)
        visible(img_sw_epb_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HYD_ELC_PUMP_B", "Number", epb_image_cb)

function cb_sw_epb(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_HYD_ELC_PUMP_B", "Number", val + dir)  
end
sw_epb = switch_add(nil,nil,nil, 1412,702, 68,68, cb_sw_epb)



---PRESSURIZATION----------------------------------------------------------
--------------------------------------------------------------------------------

--CABIN PRESSURE ALT DIAL-------------------------------------
img_sw_pcalt_open1= img_add("snub_dial.png",  1214,872, 68,68) visible(img_sw_pcalt_open1, false)
img_sw_pcalt_auto = img_add("snub_dial.png", 1214,872, 68,68) visible(img_sw_pcalt_auto, true)
img_sw_pcalt_open2 = img_add("snub_dial.png",   1214,872, 68,68) visible(img_sw_pcalt_open2, false)
rotate(img_sw_pcalt_open2, 50)
rotate(img_sw_pcalt_open1, -50)
function pcalt_image_cb (state)
        switch_set_position(sw_pcalt, state)
        visible(img_sw_pcalt_open1, state == 0)
        visible(img_sw_pcalt_auto, state == 1)
        visible(img_sw_pcalt_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_PRESS_CABIN_ALT", "Number", pcalt_image_cb)

function cb_sw_pcalt(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_PRESS_CABIN_ALT", "Number", val + dir)  
end
sw_pcalt = switch_add(nil,nil,nil,  1214,872, 68,68, cb_sw_pcalt)

--CABIN PRESSURE MODE DIAL---------------------------------

img_sw_pmode_open1= img_add("snub_dial.png", 1398,872, 68,68) visible(img_sw_pmode_open1, false)
img_sw_pmode_auto = img_add("snub_dial.png", 1398,872, 68,68) visible(img_sw_pmode_auto, true)
img_sw_pmode_open2 = img_add("snub_dial.png", 1398,872, 68,68) visible(img_sw_pmode_open2, false)
rotate(img_sw_pmode_open2, 50)
rotate(img_sw_pmode_open1, -50)
function pmode_image_cb (state)
        switch_set_position(sw_pmode, state)
        visible(img_sw_pmode_open1, state == 0)
        visible(img_sw_pmode_auto, state == 1)
        visible(img_sw_pmode_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_PRESS_MODE", "Number", pmode_image_cb)

function cb_sw_pmode(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_PRESS_MODE", "Number", val + dir)  
end
sw_pmode = switch_add(nil,nil,nil, 1398,872, 68,68, cb_sw_pmode)


--CABIN PRESSURE LFE DIAL---------------------------------

img_sw_lfe_open1= img_add("snub_dial.png", 1394,972, 68,68) visible(img_sw_lfe_open1, false)
img_sw_lfe_auto = img_add("snub_dial.png", 1394,972, 68,68) visible(img_sw_lfe_auto, true)
img_sw_lfe_open2 = img_add("snub_dial.png", 1394,972, 68,68) visible(img_sw_lfe_open2, false)
rotate(img_sw_lfe_open2, 50)
rotate(img_sw_lfe_open1, -50)
function lfe_image_cb (state)
        switch_set_position(sw_lfe, state)
        visible(img_sw_lfe_open1, state == 0)
        visible(img_sw_lfe_auto, state == 1)
        visible(img_sw_lfe_open2, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_PRESS_LFE", "Number", lfe_image_cb)

function cb_sw_lfe(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_PRESS_LFE", "Number", val + dir)  
end
sw_lfe = switch_add(nil,nil,nil, 1394,972, 68,68, cb_sw_lfe)


---APU CONTROL-------------------------------------------------------------
--------------------------------------------------------------------------------
img_sw_apu_off = img_add("snub_dial.png",  854,345, 68,68) visible(img_sw_apu_off, true)
img_sw_apu_on = img_add("snub_dial.png",  854,345, 68,68) visible(img_sw_apu_on, false)
img_sw_apu_start = img_add("snub_dial.png",  854,345, 68,68) visible(img_sw_apu_start, false)
rotate(img_sw_apu_on, 50)
rotate(img_sw_apu_start, 93)
function apu_image_cb (state)
        switch_set_position(sw_apu, state)      
        visible(img_sw_apu_off, state == 0)
        visible(img_sw_apu_on, state == 1)
        visible(img_sw_apu_start, state == 2)
 end
xpl_dataref_subscribe("XCrafts/ERJ/APU_switch", "FLOAT", apu_image_cb)

function cb_sw_apu(position)
    if (position == 1 ) then
        xpl_command("XCrafts/APU_CCW")
    elseif (position == 0 ) then
        xpl_command("XCrafts/APU_CW")
    end 
end
sw_apu = switch_add(nil,nil,nil, 854,345, 68,68, cb_sw_apu)

--APU START
function apu_start_pressed(sw_position)
		xpl_command("sim/electrical/APU_start", 1, "INT")
		visible (img_sw_apu_on, false)
        visible (img_sw_apu_off , false)
		visible (img_sw_apu_start, true)
    end
function apu_start_released()
		xpl_command("sim/electrical/APU_start", 0, "INT")
		visible (img_sw_apu_start, false)
		visible (img_sw_apu_on , true)
end
button_add(nil, nil, 927, 371, 40, 21, apu_start_pressed, apu_start_released)

--WINDSHIELD WIPER SECTION-----------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
---Captain Side Windshield Wiper---------------------------------------------------------------------

img_sw_capws_time = img_add("snub_dial.png",  842,532, 68,68) visible(img_sw_capws_time, false)
img_sw_capws_off = img_add("snub_dial.png",  842,532, 68,68) visible(img_sw_capws_off, true)
img_sw_capws_low = img_add("snub_dial.png",  842,532, 68,68) visible(img_sw_capws_low, false)
img_sw_capws_hi = img_add("snub_dial.png",  842,532, 68,68) visible(img_sw_capws_hi, false)
rotate(img_sw_capws_time, -40)
rotate(img_sw_capws_low, 40)
rotate(img_sw_capws_hi, 82)
function capws_image_cb (state)
        switch_set_position(sw_capws, state)
       
        visible(img_sw_capws_time, state == 0)
        visible(img_sw_capws_off, state == 1)
        visible(img_sw_capws_low, state == 2)
        visible(img_sw_capws_hi, state == 3)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_WSHIELD_WIPER_1", "Number",capws_image_cb)

function cb_sw_capws(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_WSHIELD_WIPER_1", "Number", val + dir)  
end
sw_capws = switch_add(nil,nil,nil,nil, 842,532, 68,68, cb_sw_capws)


--First Officer Side Windshield Wiper-------------------------------------------------------

img_sw_fopws_time = img_add("snub_dial.png",  1016,532, 68,68) visible(img_sw_fopws_time, false)
img_sw_fopws_off = img_add("snub_dial.png",  1016,532, 68,68) visible(img_sw_fopws_off, true)
img_sw_fopws_low = img_add("snub_dial.png",  1016,532, 68,68) visible(img_sw_fopws_low, false)
img_sw_fopws_hi = img_add("snub_dial.png",  1016,532, 68,68) visible(img_sw_fopws_hi, false)
rotate(img_sw_fopws_time, -40)
rotate(img_sw_fopws_low, 40)
rotate(img_sw_fopws_hi, 82)
function fopws_image_cb (state)
        switch_set_position(sw_fopws, state)
       
        visible(img_sw_fopws_time, state == 0)
        visible(img_sw_fopws_off, state == 1)
        visible(img_sw_fopws_low, state == 2)
        visible(img_sw_fopws_hi, state == 3)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_WSHIELD_WIPER_2", "Number",fopws_image_cb)

function cb_sw_fopws(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_WSHIELD_WIPER_2", "Number", val + dir)  
end
sw_fopws = switch_add(nil,nil,nil,nil, 1016,532, 68,68, cb_sw_fopws)

----WINDSHIELD HEAT-------------------------------------------------------------
--------------------------------------------------------------------------------------

--WINDHIELD HEAT SWITCH 1----------
img_sw_wh1_mid = img_add("push_btn_off.png",  1625, 56, 52,51)
img_sw_wh1_dn = img_add("push_btn_on.png",  1620, 51, 60,59) visible(img_sw_wh1_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HEATING_WSHIELD_1_BTN", "Number", 
        function (state)
            switch_set_position(sw_wh1, state)
                visible(img_sw_wh1_dn, state ==0)
            
                visible(img_sw_wh1_mid, state ==1)
            
        end)

function cb_sw_wh1(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_WSHIELD_1_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_WSHIELD_1_BTN","Number",0) 
    end 
end

sw_wh1= switch_add(nil,nil, 1620, 51, 60,59, cb_sw_wh1)

--WINDHIELD HEAT SWITCH 2----------
img_sw_wh2_mid = img_add("push_btn_off.png",  1769, 56, 52,51)
img_sw_wh2_dn = img_add("push_btn_on.png",  1764, 51, 60,59) visible(img_sw_wh2_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HEATING_WSHIELD_2_BTN", "Number", 
        function (state)
            switch_set_position(sw_wh2, state)
                visible(img_sw_wh2_dn, state ==0)
            
                visible(img_sw_wh2_mid, state ==1)
            
        end)

function cb_sw_wh2(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_WSHIELD_2_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_WSHIELD_2_BTN","Number",0) 
    end 
end

sw_wh2= switch_add(nil,nil, 1764, 51, 60,59, cb_sw_wh2)

--ENGINE 1 HEAT----------
img_sw_eng1_mid = img_add("push_btn_off.png",  1574, 208, 52,51)
img_sw_eng1_dn = img_add("push_btn_on.png",  1570, 203, 60,59) visible(img_sw_eng1_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HEATING_ICE_ENG1_BTN", "Number", 
        function (state)
            switch_set_position(sw_eng1, state)
                visible(img_sw_eng1_dn, state ==0)
            
                visible(img_sw_eng1_mid, state ==1)
            
        end)

function cb_sw_eng1(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_ICE_ENG1_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_ICE_ENG1_BTN","Number",0) 
    end 
end

sw_eng1= switch_add(nil,nil, 1574,208, 60,59, cb_sw_eng1)

--ENGINE 2 HEAT----------
img_sw_eng2_mid = img_add("push_btn_off.png",  1820, 208, 52,51)
img_sw_eng2_dn = img_add("push_btn_on.png",  1816, 203, 60,59) visible(img_sw_eng2_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HEATING_ICE_ENG2_BTN", "Number", 
        function (state)
            switch_set_position(sw_eng2, state)
                visible(img_sw_eng2_dn, state ==0)
            
                visible(img_sw_eng2_mid, state ==1)
            
        end)

function cb_sw_eng2(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_ICE_ENG2_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_ICE_ENG2_BTN","Number",0) 
    end 
end

sw_eng2= switch_add(nil,nil, 1820,208, 60,59, cb_sw_eng2)

--WING HEAT----------
img_sw_wing_mid = img_add("push_btn_off.png",  1700, 208, 52,51)
img_sw_wing_dn = img_add("push_btn_on.png",  1695, 203, 60,59) visible(img_sw_wing_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HEATING_ICE_WING_BTN", "Number", 
        function (state)
            switch_set_position(sw_wing, state)
                visible(img_sw_wing_dn, state ==0)
            
                visible(img_sw_wing_mid, state ==1)
            
        end)

function cb_sw_wing(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_ICE_WING_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_ICE_WING_BTN","Number",0) 
    end 
end

sw_wing= switch_add(nil,nil, 1698,207, 60,59, cb_sw_wing)

--ICE MODE DIAL-----------------
img_sw_ipmode_mid = img_add("snub_dial.png",  1615, 338, 68, 68)
img_sw_ipmode_dn = img_add("snub_dial.png",  1615, 338, 68, 68) visible(img_sw_ipmode_dn, false)
rotate(img_sw_ipmode_dn, 50)
fs2020_variable_subscribe("L:FSS_EXX_OVHD_HEATING_ICE_MODE", "Number", 
        function (state)
            switch_set_position(sw_ipmode, state)
                visible(img_sw_ipmode_dn, state ==1)
            
                visible(img_sw_ipmode_mid, state ==0)
            
        end)

function cb_sw_ipmode(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_ICE_MODE","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_ICE_MODE","Number",0) 
    end 
end

sw_ipmode= switch_add(nil,nil,  1615, 338, 68, 68, cb_sw_ipmode)

-----------ICE PROTECTION DIAL---------------
img_sw_iptst_eng = img_add("snub_dial.png",  1775,338, 68,68) visible(img_sw_iptst_eng, false)
img_sw_iptst_off = img_add("snub_dial.png",  1775,338, 68,68) visible(img_sw_iptst_off, true)
img_sw_iptst_wing = img_add("snub_dial.png",  1775,338, 68,68) visible(img_sw_iptst_wing, false)
rotate(img_sw_iptst_eng, -50)
rotate(img_sw_iptst_wing, 50)
function iptst_image_cb (state)
        switch_set_position(sw_iptst, state)
       
        visible(img_sw_iptst_eng, state == 0)
        visible(img_sw_iptst_off, state == 1)
        visible(img_sw_iptst_wing, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_HEATING_TEST", "Number", iptst_image_cb)

function cb_sw_iptst(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_HEATING_TEST", "Number", val + dir)  
end
sw_iptst = switch_add(nil,nil,nil,1775,338, 68,68, cb_sw_iptst)

---AIR CONDITIONING SECTION-------------
------------------------------------------------

--COCKPIT TEMP DIAL-----
img_ckpt = img_add("class_dial.png", 1578,514,50,50)
fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_CKPT", "Number", 
    function(value)
        local rotation_angle = value * 260 - 130  
        rotate(img_ckpt, rotation_angle)
    end
 )
function knob_ckpt( direction)
    if direction ==  1 then
        fs2020_rpn("(L:FSS_EXX_OVHD_AIRCOND_CKPT) 0.05 + 1 min 0 max (>L:FSS_EXX_OVHD_AIRCOND_CKPT)")
    elseif direction == -1 then
        fs2020_rpn("(L:FSS_EXX_OVHD_AIRCOND_CKPT) 0.05 - 1 min 0 max (>L:FSS_EXX_OVHD_AIRCOND_CKPT)")
    end
end

ckpt_dial = dial_add(nil, 1578,514,50,50, knob_ckpt)
dial_click_rotate(ckpt_dial, 4)

----PAX TEMP DIAL----


--COCKPIT TEMP DIAL-----
img_pax = img_add("class_dial.png", 1817,514,50,50)
fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_PSGR", "Number", 
    function(value)
        local rotation_angle = value * 260 - 130  
        rotate(img_pax, rotation_angle)
    end
 )
function knob_pax( direction)
    if direction ==  1 then
        fs2020_rpn("(L:FSS_EXX_OVHD_AIRCOND_PSGR) 0.05 + 1 min 0 max (>L:FSS_EXX_OVHD_AIRCOND_PSGR)")
    elseif direction == -1 then
        fs2020_rpn("(L:FSS_EXX_OVHD_AIRCOND_PSGR) 0.05 - 1 min 0 max (>L:FSS_EXX_OVHD_AIRCOND_PSGR)")
    end
end

pax_dial = dial_add(nil, 1817,514,50,50, knob_pax)
dial_click_rotate(pax_dial, 4)


----RECIRCULATION BUTTON------

img_sw_recirc_mid = img_add("push_btn_off.png",  1697, 514, 52,51)
img_sw_recirc_dn = img_add("push_btn_on.png",  1692, 509, 60,59) visible(img_sw_recirc_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_RECIRC_BTN", "Number", 
        function (state)
            switch_set_position(sw_recirc, state)
                visible(img_sw_recirc_dn, state ==0)
            
                visible(img_sw_recirc_mid, state ==1)
            
        end)

function cb_sw_recirc(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_RECIRC_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_RECIRC_BTN","Number",0) 
    end 
end

sw_recirc= switch_add(nil,nil, 1697, 514, 60,59, cb_sw_recirc)

---PACK 1 Button--------
img_sw_pk1_mid = img_add("push_btn_off.png",  1578, 630, 52,51)
img_sw_pk1_dn = img_add("push_btn_on.png",  1574, 626, 60,59) visible(img_sw_pk1_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_PACK1_BTN", "Number", 
        function (state)
            switch_set_position(sw_pk1, state)
                visible(img_sw_pk1_dn, state ==0)
            
                visible(img_sw_pk1_mid, state ==1)
            
        end)

function cb_sw_pk1(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_PACK1_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_PACK1_BTN","Number",0) 
    end 
end

sw_pk1= switch_add(nil,nil, 1574, 626, 60,59, cb_sw_pk1)

---PACK 2 Button-------

img_sw_pk2_mid = img_add("push_btn_off.png",  1818, 630, 52,51)
img_sw_pk2_dn = img_add("push_btn_on.png",  1814, 625, 60,59) visible(img_sw_pk2_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_PACK2_BTN", "Number", 
        function (state)
            switch_set_position(sw_pk2, state)
                visible(img_sw_pk2_dn, state ==0)
            
                visible(img_sw_pk2_mid, state ==1)
            
        end)

function cb_sw_pk2(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_PACK2_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_PACK2_BTN","Number",0) 
    end 
end

sw_pk2= switch_add(nil,nil, 1818, 626, 60,59, cb_sw_pk2)

----XBLEED BUTTON------

img_sw_xbld_mid = img_add("push_btn_off.png",  1701, 710, 52,51)
img_sw_xbld_dn = img_add("push_btn_on.png",  1696, 706, 60,59) visible(img_sw_xbld_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_XBLEED_BTN", "Number", 
        function (state)
            switch_set_position(sw_xbld, state)
                visible(img_sw_xbld_dn, state ==0)
            
                visible(img_sw_xbld_mid, state ==1)
            
        end)

function cb_sw_xbld(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_XBLEED_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_XBLEED_BTN","Number",0) 
    end 
end

sw_xbld= switch_add(nil,nil, 1697, 700, 60,59, cb_sw_xbld)

---BLEED 1Button--------
img_sw_bld1_mid = img_add("push_btn_off.png",  1579, 820, 52,51)
img_sw_bld1_dn = img_add("push_btn_on.png",  1574, 816, 60,59) visible(img_sw_bld1_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_BLEED_1_BTN", "Number", 
        function (state)
            switch_set_position(sw_bld1, state)
                visible(img_sw_bld1_dn, state ==0)
            
                visible(img_sw_bld1_mid, state ==1)
            
        end)

function cb_sw_bld1(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_BLEED_1_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_BLEED_1_BTN","Number",0) 
    end 
end

sw_bld1= switch_add(nil,nil, 1579, 820, 60,59, cb_sw_bld1)

---APU BLEED Button--------
img_sw_apubld_mid = img_add("push_btn_off.png",  1701, 820, 52,51)
img_sw_apubld_dn = img_add("push_btn_on.png",  1696, 815, 60,59) visible(img_sw_apubld_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_BLEED_APU_BTN", "Number", 
        function (state)
            switch_set_position(sw_apubld, state)
                visible(img_sw_apubld_dn, state ==0)
            
                visible(img_sw_apubld_mid, state ==1)
            
        end)

function cb_sw_apubld(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_BLEED_APU_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_BLEED_APU_BTN","Number",0) 
    end 
end

sw_apubld= switch_add(nil,nil, 1701, 820, 60,59, cb_sw_apubld)

--BLEED 2 Button-------
img_sw_bld2_mid = img_add("push_btn_off.png",  1819, 820, 52,51)
img_sw_bld2_dn = img_add("push_btn_on.png",  1815, 815, 60,59) visible(img_sw_bld2_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_OVHD_AIRCOND_BLEED_2_BTN", "Number", 
        function (state)
            switch_set_position(sw_bld2, state)
                visible(img_sw_bld2_dn, state ==0)
            
                visible(img_sw_bld2_mid, state ==1)
            
        end)

function cb_sw_bld2(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_BLEED_2_BTN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_OVHD_AIRCOND_BLEED_2_BTN","Number",0) 
    end 
end

sw_bld2= switch_add(nil,nil, 1819, 820, 60,59, cb_sw_bld2)

--PASSENGER OXYGEN-----

---Dial 

img_sw_pom_eng = img_add("snub_dial.png",  1608,982, 68,68) visible(img_sw_pom_eng, false)
img_sw_pom_off = img_add("snub_dial.png",  1608,982, 68,68) visible(img_sw_pom_off, true)
img_sw_pom_wing = img_add("snub_dial.png",  1608,982, 68,68) visible(img_sw_pom_wing, false)
rotate(img_sw_pom_eng, -50)
rotate(img_sw_pom_wing, 50)
function pom_image_cb (state)
        switch_set_position(sw_pom, state)
       
        visible(img_sw_pom_eng, state == 0)
        visible(img_sw_pom_off, state == 1)
        visible(img_sw_pom_wing, state == 2)
 end

fs2020_variable_subscribe("L:FSS_EXX_OVHD_OXY_MASK", "Number", pom_image_cb)

function cb_sw_pom(val,dir)
        fs2020_variable_write("L:FSS_EXX_OVHD_OXY_MASK", "Number", val + dir)  
end
sw_pom = switch_add(nil,nil,nil,1608,982, 68,68, cb_sw_pom)

---IMAGE CAUSE BUTTON IS INOP---
img_add("push_btn_off.png",1792,990,52,51)
