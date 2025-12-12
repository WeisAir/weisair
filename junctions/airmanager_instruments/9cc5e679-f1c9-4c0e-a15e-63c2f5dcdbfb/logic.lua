my_image = img_add_fullscreen("background_square.png")
--local add_frame = user_prop_add_boolean("Add Frame to Annunciator", true, "Shows a tiny frame around the annunciator on demand.")

--if user_prop_get(add_frame) == true then
--    annunciator_inactive = img_add("ann_inactive.png",3,3,82,82) 
--    annun_warning_active = img_add("warn_active.png",3,3,82,82) 
--    annun_caution_active = img_add("caution_active.png",3,3,82,82) 
--else
    annunciator_inactive = img_add_fullscreen("ann_inactive.png") 
    annun_warning_active = img_add("warn_active.png",0,0,89,45) 
    annun_caution_active = img_add("caution_active.png",0,46,89,44) 
--end 

visible(annun_warning_active,false)
visible(annun_caution_active,false)

function MC_value (warning_active, caution_active)
    visible( annun_warning_active, warning_active > 0)
    visible( annun_caution_active, caution_active > 0)
end

function  press_callback()
    xpl_command( "WeisAIR/b748/clear_master_caution" , 1 )
end

function release_callback()
    xpl_command( "WeisAIR/b748/clear_master_caution" ,0 )
end

btn = button_add(nil,nil,0,0,89,89, press_callback, release_callback)

-- Simulator data subscription
xpl_dataref_subscribe(
"ssg/EICAS/light_warning_ann", "INT",
"ssg/EICAS/light_caution_ann", "INT",
 MC_value)