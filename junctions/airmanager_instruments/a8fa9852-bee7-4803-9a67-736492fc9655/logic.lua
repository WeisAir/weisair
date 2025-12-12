
----------------------------------------------------------
 img_add  ("caut_off.png",0,0,100,100)

--Caution Select
local CAUT_value = 0  

function CAUT_Engage()
        xpl_command("sim/annunciator/clear_master_caution","FLOAT")
end
CAUT_ENG = button_add(nil, nil, 0, 0, 100, 100, CAUT_Engage)

--Caution Light
img_caut_indicator = img_add("caut_on.png", 0, 0, 100, 100, "visible:false")

function light_caut(sw_on)
    if sw_on >= 0.1 then					    
        visible(img_caut_indicator, true)
    else
        visible(img_caut_indicator, false)
    end
end     
xpl_dataref_subscribe("sim/cockpit/warnings/master_caution_on", "FLOAT", light_caut)