-- knob marker definition
-------------------------

circle_test1 = canvas_add(0, 0, 1366, 768, function()
    _circle(271, 169, 18)
    _stroke("yellow", 5)
end)

circle_test2 = canvas_add(0, 0, 1366, 768, function()
 
    _circle(451, 333, 18)
    _stroke("yellow", 5)
end)

circle_test3 = canvas_add(0, 0, 1366, 768, function()
    _circle(637, 490, 18)
    _stroke("yellow", 5)
end)

-- function definitions
-------------------------

function all_circles_invisible()

    visible(circle_test1,false)
    visible(circle_test2,false)
    visible(circle_test3,false)

end

function button_state (fnState, alt_selected, vs_selected )

    if fnState == 1 then
        if alt_selected == 1 then all_circles_invisible() visible(circle_test1,true) end
        if vs_selected == 1 then all_circles_invisible() visible(circle_test2,true) end
    else
        all_circles_invisible()
    end 
end

-- panel behaviour
------------------

all_circles_invisible()


-- sim communication
--------------------

xpl_dataref_subscribe( 
"bgood/xsaitekpanels/fnbutton/status" , "INT" ,
"bgood/xsaitekpanels/multipanel/altswitch/status" , "INT", 
"bgood/xsaitekpanels/multipanel/vsswitch/status" , "INT",  button_state )