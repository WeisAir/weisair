--[[
*****************************************************************
************FSS ERJ - 1XX - Ground / Emergency **************
*****************************************************************
##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
--]]


img_add_fullscreen("background.png")

--Ground /Prox Button--------------------------------------------------
img_sw_wing_mid = img_add("off_btn.png",  55, 100, 110, 110)
img_sw_wing_dn = img_add("on_btn.png",  55, 100, 110, 110) visible(img_sw_wing_dn, false)

fs2020_variable_subscribe("L:FSS_EXX_GND_PROX_INHIB_L", "Number", 
        function (state)
            switch_set_position(sw_wing, state)
                visible(img_sw_wing_dn, state ==1)
            
                visible(img_sw_wing_mid, state ==0)
            
        end)

function cb_sw_wing(position)
    if (position == 0 ) then
        fs2020_variable_write("L:FSS_EXX_GND_PROX_INHIB_L","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:FSS_EXX_GND_PROX_INHIB_L","Number",0) 
    end 
end

sw_wing= switch_add(nil,nil, 55, 100, 110, 110, cb_sw_wing)

---------------------------Parking Brake Read Only NO Button--------------------------------------

img_pb_on = img_add("on_btn.png",   280,100 ,110,110)
img_pb_off = img_add("off_btn.png",  280,100,110,110) visible(img_pb_off, false)

xpl_dataref_subscribe("sim/flightmodel/controls/parkbrake", "FLOAT", 
        function (state)
           
                visible(img_pb_on, state ==1)
                
                visible(img_pb_off, state ==0)            
end)