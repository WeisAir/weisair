--[[
*****************************************************************
************FSS ERJ - 1XX - Screen Bezel*************************
*****************************************************************
##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
--]]


img_add_fullscreen("background.png")

----Engine 1 Starter--------------------------------------------------------------------------
--img_sw_eng1_mid = img_add("snub_dial.png",  172,207, 190, 190)
--rotate(img_sw_eng1_mid, -48)
--[[
function START1(dir)
    if dir == -1 then 
		rotate(img_sw_eng1_mid, -48)
        xpl_command("XCrafts/Starter_Eng_1_down_CCW","FLOAT",1)
		xpl_command("sim/starters/shut_down_1","INT",1)
    elseif dir == 1 then  
		rotate(img_sw_eng1_mid, 0)
        xpl_command("XCrafts/Starter_Eng_1_up_CW","FLOAT",1) 
    end
end
img_start2_dial = dial_add(nil,172,207, 190, 190, START1)

--ENG1 START
function eng1_start_pressed(sw_position)
		xpl_command("sim/starters/engage_starter_1", 1, "INT")
		xpl_command("sim/starters/engage_start_run_1", 1, "INT")
		xpl_command("sim/ignition/engage_starter_1", 1, "INT")
		rotate(img_sw_eng1_mid, 48)
    end
function eng1_start_released()
		rotate(img_sw_eng1_mid, 0)
end


button_add(nil, nil, 348,180, 100,50, eng1_start_pressed, eng1_start_released)
--]]

img_sw_eng1_off = img_add("snub_dial.png",  172,207, 190, 190) visible(img_sw_eng1_off, true)
img_sw_eng1_on = img_add("snub_dial.png",  172,207, 190, 190) visible(img_sw_eng1_on, false)
img_sw_eng1_start = img_add("snub_dial.png",  172,207, 190, 190) visible(img_sw_eng1_start, false)
rotate(img_sw_eng1_off, -48)
rotate(img_sw_eng1_on, 0)
rotate(img_sw_eng1_start, 48)
function eng1_image_cb (state)
        switch_set_position(sw_eng1, state)      
        visible(img_sw_eng1_off, state == 0)
        visible(img_sw_eng1_on, state == 1)
        visible(img_sw_eng1_start, state == 2)
 end
xpl_dataref_subscribe("XCrafts/ERJ/engine1_starter_knob", "INT", eng1_image_cb)

function cb_sw_eng1(position)
    if (position == 1 ) then
        xpl_command("XCrafts/Starter_Eng_1_down_CCW")
    elseif (position == 0 ) then
--        xpl_command("XCrafts/Starter_Eng_1_up_CW")
		xpl_command("sim_starters/shut_down_1")
    end 
end
sw_eng1 = switch_add(nil,nil,nil, 172,207, 190, 190, cb_sw_eng1)

--eng1 START
function eng1_start_pressed(sw_position)
		xpl_command("sim/starters/engage_starter_1", 1, "INT")
		visible (img_sw_eng1_on, false)
        visible (img_sw_eng1_off , false)
		visible (img_sw_eng1_start, true)
		    end
function eng1_start_released()
--        xpl_command("XCrafts/Starter_Eng_1_up_CW")
		xpl_command("sim_starters/shut_down_1")
		visible (img_sw_eng1_start, false)
		visible (img_sw_eng1_on , true)
end
button_add(nil, nil,  348,180, 100,50, eng1_start_pressed, eng1_start_released)
--[[
---Engine 1 Cover-----------------------------------------------------------------------------
img_cover_dn = img_add("cover1_dn.png",25,130, 500,380)
img_cover_up = img_add("cover_up.png",25,430, 493,88) visible(img_cover_up, false)

fs2020_variable_subscribe("L:FSS_EXX_PDSTL_POWERPLANT_L_COVER", "Number", 
        function (state)
            switch_set_position(sw_cover, state)
                visible(img_cover_dn, state ==0)            
                visible(img_cover_up, state ==1)
            
        end)

function cb_sw_cover(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_PDSTL_POWERPLANT_L_COVER","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_PDSTL_POWERPLANT_L_COVER","Number",0) 
    end 
end

sw_cover= switch_add(nil,nil, 70, 430, 400, 75,cb_sw_cover)

---Engine 2 Starter----------------------------------------------------------------------------------
img_sw_eng2_mid = img_add("snub_dial.png",677,207, 190, 190)
rotate(img_sw_eng2_mid, -48)

function START2(dir)
    if dir == -1 then 
		rotate(img_sw_eng2_mid, -48)
        xpl_command("XCrafts/Starter_Eng_2_down_CCW","FLOAT",1)
		xpl_command("sim/starters/shut_down_2","INT",1)
    elseif dir == 1 then  
		rotate(img_sw_eng2_mid, 0)
        xpl_command("XCrafts/Starter_Eng_2_up_CW","FLOAT",1) 
    end
end
img_start2_dial = dial_add(nil,677,207, 190, 190, START2)

--ENG2 START
function eng2_start_pressed(sw_position)
		xpl_command("sim/starters/engage_starter_2", 1, "INT")
		xpl_command("sim/starters/engage_start_run_2", 1, "INT")
		xpl_command("sim/ignition/engage_starter_2", 1, "INT")
		rotate(img_sw_eng2_mid, 48)
    end
function eng2_start_released()
		rotate(img_sw_eng2_mid, 0)
end
button_add(nil, nil, 854,180, 100,50, eng2_start_pressed, eng2_start_released)
--[[
---Engine 2 Cover-----------------------------------------------------------------------------
img_cover2_dn = img_add("cover2_dn.png",525,130, 500,380)
img_cover2_up = img_add("cover_up.png",525,430, 493,88) visible(img_cover2_up, false)

fs2020_variable_subscribe("L:FSS_EXX_PDSTL_POWERPLANT_R_COVER", "Number", 
        function (state)
            switch_set_position(sw_cover2, state)
                visible(img_cover2_dn, state ==0)
            
                visible(img_cover2_up, state ==1)
            
        end)

function cb_sw_cover2(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_PDSTL_POWERPLANT_R_COVER","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_PDSTL_POWERPLANT_R_COVER","Number",0) 
    end 
end

sw_cover2= switch_add(nil,nil, 570, 430, 400, 75,cb_sw_cover2)

button_add(nil, nil, 348,180, 100,50, eng2_start_pressed, eng2_start_released)
--]]