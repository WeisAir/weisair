--background = img_add_fullscreen("background.png")
local txt_style = "font: roboto_bold.ttf; valign:center; halign:center; size: 12; color: white;"
local lable_text = user_prop_add_string("Lable Text", "Lable Text", "The lable text")
txt_add(user_prop_get(lable_text), txt_style, 0,0,72,20)