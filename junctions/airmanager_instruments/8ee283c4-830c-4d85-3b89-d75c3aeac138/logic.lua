my_image = img_add_fullscreen("background_square.png")
local add_frame = user_prop_add_boolean("Add Frame to Annunciator", true, "Shows a tiny frame around the annunciator on demand.")

if user_prop_get(add_frame) == true then
    annunciator_inactive = img_add("generic_annun_BAR_inactive.png",3,3,82,82) 
else
    annunciator_inactive = img_add_fullscreen("generic_annun_BAR_inactive.png") 
end 

function  press_callback()
    xpl_command( "XCrafts/ERJ/takeoff" , 1 )
end

function release_callback()
    xpl_command( "XCrafts/ERJ/takeoff" ,0 )
end

btn = button_add(nil,nil,0,0,136,65, press_callback, release_callback)