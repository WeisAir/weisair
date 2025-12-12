background_image = img_add_fullscreen ( "background.png" )

local text_white = "font:1_roboto_regular.ttf; size:18px; color: white; halign: center;"
local text_green = "font:1_roboto_regular.ttf; size:18px; color: green; halign: center;"

text_A = txt_add("TEXT A",text_white,100,100,50,50)
text_B = txt_add("TEXT B",text_white,100,120,50,50)

text_group = group_add(text_A, text_B)

txt_style(text_A,text_green)

move(text_group, 150, 150)


canvas_id = canvas_add(0, 0, 200, 30	, function()
  _rect(0,0,200,200)
  _fill("black")
  _txt("abdefghi</br>njklmnopqrstuvwxyz abdefghijklmnopqrstuvwxyz", "font:roboto_bold.ttf; size:25; color: green; halign:left;", 0, 0)
  _txt("üüüüüüü</br>üüüüüüüüüz", "font:roboto_bold.ttf; size:25; color: green; halign:left;", 20, 0)
end)