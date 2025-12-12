img_add_fullscreen( "background.png")



--LAYOUT
head = 40
left_indent = 20
left_block_indent = left_indent + 10
inter_row_spacing = 10
inter_column_spacing = 10
textbox_width = 110
textbox_height = 14
textbox_attribute_style = "font:arimo_regular.ttf; size:".. textbox_height .."; color: white; halign:left;"
textbox_headline_style = "font:arimo_bold.ttf; size:".. textbox_height .."; color: white; none; halign:left;"
textbox_frequency_style = "font:digital-7-mono.ttf; size:".. textbox_height .."; color: grey; halign:left;" 	
textbox_act_frequency_style = "font:digital-7-mono.ttf; size:".. textbox_height .."; color: #8EC127; halign:left;" 	
row_y_pos = head + 10

---------------------------------
---------------------------------
--ENVIRONMENT BLOCK: Lables
headline_evironment 			= txt_add("Environment"			, textbox_headline_style, 		0* left_block_indent + 0*textbox_width + left_indent 									, row_y_pos - 	5 										, textbox_width, textbox_height)
attribute_time_zulu 			= txt_add("Time (Zulu):"		, textbox_attribute_style,		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos + 	1* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_time_local 			= txt_add("Time (Local):"		, textbox_attribute_style, 		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos + 	2* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_time_elapsed 			= txt_add("Time elapsed:"		, textbox_attribute_style, 		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos + 	3* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_temp_outside 			= txt_add("Temperature:"		, textbox_attribute_style, 		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos + 	4* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_wind 					= txt_add("Wind:"				, textbox_attribute_style, 		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos + 	5* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_altimeter_cur_hpa		= txt_add("QNH (current):"		, textbox_attribute_style, 		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos + 	6* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_altimeter_cur_inhg	= txt_add(""					, textbox_attribute_style, 		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos +	7* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_altimeter_sea_hpa		= txt_add("QNH (sea level):"	, textbox_attribute_style, 		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos + 	8* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_altimeter_sea_inhg	= txt_add(""					, textbox_attribute_style, 		1* left_block_indent + 0*textbox_width + 0* inter_column_spacing	, row_y_pos +	9* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)

--ENVIRONMENT BLOCK: Values
value_time_zulu 				= txt_add("HH:MM:SS"			, textbox_attribute_style,		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos + 	1* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_time_local 				= txt_add("HH:MM:SS"			, textbox_attribute_style, 		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos + 	2* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_time_elapsed 				= txt_add("HH:MM:SS"			, textbox_attribute_style, 		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos + 	3* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_temp_outside 				= txt_add("--°C"				, textbox_attribute_style, 		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos + 	4* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_wind 						= txt_add("--kts / ---°"		, textbox_attribute_style, 		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos + 	5* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)

image_wind_arrow 				= img_add ( "arrow.png",										1* left_block_indent + 0.4*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	5* (textbox_height + inter_row_spacing) -2  , textbox_height , textbox_height )

value_altimeter_cur_hpa			= txt_add("---- / --.--"		, textbox_attribute_style, 		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos + 	6* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_altimeter_cur_inhg		= txt_add("---- / --.--"		, textbox_attribute_style, 		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos + 	7* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_altimeter_sea_hpa			= txt_add("---- / --.--"		, textbox_attribute_style, 		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos +	8* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_altimeter_sea_inhg		= txt_add("---- / --.--"		, textbox_attribute_style, 		1* left_block_indent + 1*textbox_width + 0* inter_column_spacing 	, row_y_pos + 	9* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)

---------------------------------
---------------------------------
--RADIO BLOCK: Lables
headline_evironment 			= txt_add("Radio"				, textbox_headline_style, 		0* left_block_indent + 2*textbox_width								, row_y_pos - 	5 										, textbox_width, textbox_height)
attribute_transponder 			= txt_add("Transponder:"		, textbox_attribute_style,		0* left_block_indent + 2*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	1* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_com1_act 				= txt_add("COM1 (ACT):"			, textbox_attribute_style, 		0* left_block_indent + 2*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	2* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_com1_stby				= txt_add("COM1 (STB):"			, textbox_attribute_style, 		0* left_block_indent + 2*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	3* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_com2_act 				= txt_add("COM2 (ACT):"			, textbox_attribute_style, 		0* left_block_indent + 2*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	4* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
attribute_com2_stby				= txt_add("COM2 (STB):"			, textbox_attribute_style, 		0* left_block_indent + 2*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	5* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)

--RADIO BLOCK: Values
value_transponder 				= txt_add("ABCDEFG"				, textbox_attribute_style,		0* left_block_indent + 3*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	1* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_com1_act 					= txt_add("123.456"				, textbox_act_frequency_style, 	0* left_block_indent + 3*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	2* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_com1_stby					= txt_add("123.456"				, textbox_frequency_style, 		0* left_block_indent + 3*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	3* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)
value_com2_act 					= txt_add("123.456"				, textbox_act_frequency_style, 	0* left_block_indent + 3*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	4* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)		
value_com2_stby		        	= txt_add("123.456"				, textbox_frequency_style, 		0* left_block_indent + 3*textbox_width + 1* inter_column_spacing 	, row_y_pos + 	5* (textbox_height + inter_row_spacing) , textbox_width, textbox_height)


function environment_attributes_generic (barometer_current_inhg,barometer_sealevel_inhg,zulu_time_hours,
zulu_time_minutes,zulu_time_seconds,local_time_hours,local_time_minutes,local_time_seconds,elapsed_time_hours,elapsed_time_minutes,elapsed_time_seconds,	
outside_air_temp_degc, wind_direction_degt, wind_speed_kt)

	formatted_elapsed_time_hours = string.format("%02.0f", elapsed_time_hours)
	formatted_elapsed_time_minutes = string.format("%02.0f", elapsed_time_minutes)
	formatted_elapsed_time_seconds = string.format("%02.0f", elapsed_time_seconds)
	formatted_outside_air_temp_degc = string.format("%.1f", outside_air_temp_degc)
	formatted_wind_direction_degt = string.format("%.0f", wind_direction_degt)
	formatted_wind_speed_kt = string.format("%.0f", wind_speed_kt)
	formatted_barometer_current_inhg = string.format("%.2f", barometer_current_inhg)
	formatted_barometer_sealevel_inhg = string.format("%.2f", barometer_sealevel_inhg)

	txt_set(value_time_zulu,	zulu_time_hours .. ":" .. zulu_time_minutes ..":" .. zulu_time_seconds)
	txt_set(value_time_local,	local_time_hours .. ":" .. local_time_minutes ..":" .. local_time_seconds)
	txt_set(value_time_elapsed,	formatted_elapsed_time_hours .. ":" .. formatted_elapsed_time_minutes ..":" .. formatted_elapsed_time_seconds)
	txt_set(value_temp_outside, formatted_outside_air_temp_degc .. " °C")
	txt_set(value_wind, formatted_wind_speed_kt .. " kts / " .. formatted_wind_direction_degt .. " °")
	txt_set(value_altimeter_cur_hpa, string.format("%.0f",formatted_barometer_current_inhg*33.86) .. " hPA")
	txt_set(value_altimeter_cur_inhg, formatted_barometer_current_inhg .. " inHg")
	txt_set(value_altimeter_sea_hpa, string.format("%.0f",formatted_barometer_sealevel_inhg*33.86) .. " hPA")
	txt_set(value_altimeter_sea_inhg, formatted_barometer_sealevel_inhg .. " inHg")
	
	rotate(image_wind_arrow, wind_direction_degt-180)

end

function radio_attributes_generic ()

)

end

xpl_dataref_subscribe(
"sim/weather/barometer_current_inhg","FLOAT",
"sim/weather/barometer_sealevel_inhg","FLOAT",
"sim/cockpit2/clock_timer/zulu_time_hours","INT",
"sim/cockpit2/clock_timer/zulu_time_minutes","INT",
"sim/cockpit2/clock_timer/zulu_time_seconds","INT",
"sim/cockpit2/clock_timer/local_time_hours","INT",
"sim/cockpit2/clock_timer/local_time_minutes","INT",
"sim/cockpit2/clock_timer/local_time_seconds","INT",
"sim/cockpit2/clock_timer/elapsed_time_hours","INT",
"sim/cockpit2/clock_timer/elapsed_time_minutes","INT",
"sim/cockpit2/clock_timer/elapsed_time_seconds","INT",
"sim/cockpit2/temperature/outside_air_temp_degc","FLOAT",
"sim/weather/wind_direction_degt","FLOAT",
"sim/weather/wind_speed_kt[0]","FLOAT",
environment_attributes_generic)

xpl_dataref_subscribe(


radio_attributes_generic)