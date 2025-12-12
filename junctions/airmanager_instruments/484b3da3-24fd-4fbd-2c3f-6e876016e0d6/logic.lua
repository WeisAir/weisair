my_image = img_add_fullscreen("ops_blade.png")

-- user properties definitions

----cosmetics
local prop_screws = user_prop_add_boolean("Show screws", true, "Show the screws")

--geometry and style settings
----instrument
local instrument_height = 548    
local instrument_width = 720

----screws
local screw_width = 15
local screw_height = 15
local screw_border_offset = 25

----screws
screw_ul = img_add("screw.png", screw_border_offset, screw_border_offset, screw_width, screw_height)
screw_ll = img_add("screw.png", screw_border_offset, instrument_height - screw_border_offset - screw_height , screw_width, screw_height)
screw_ur = img_add("screw.png", instrument_width - screw_border_offset - screw_width, screw_border_offset, screw_width, screw_height)
screw_lr = img_add("screw.png", instrument_width - screw_border_offset - screw_width, instrument_height - screw_border_offset - screw_height, screw_width, screw_height)

--visibility settings
group_screws = group_add(screw_ul,screw_ll,screw_ur,screw_lr)
visible(group_screws,false)
if user_prop_get(prop_screws)==true then visible(group_screws,true) end