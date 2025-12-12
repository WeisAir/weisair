local instr_alt = instrument_get("80ab149b-2063-43a2-91dc-fef3f0125868",0)
local instr_hdg = instrument_get("80ab149b-2063-43a2-91dc-fef3f0125868",1)
local instr_com = instrument_get("80ab149b-2063-43a2-91dc-fef3f0125868",2)
local instr_crs = instrument_get("80ab149b-2063-43a2-91dc-fef3f0125868",3)
local instr_xxx = instrument_get("80ab149b-2063-43a2-91dc-fef3f0125868",4)

first_page_instruments = group_add(instr_alt, instr_hdg, instr_com)
second_page_instruments = group_add(instr_crs, instr_xxx)

visible(first_page_instruments, true)
visible(second_page_instruments, false)


function fwd_pressed_callback()
  -- Called when button is pressed
  
  visible(first_page_instruments, true)
  visible(second_page_instruments, false)
end

fwd_btn = button_add("btn_not_pressed.png", "btn_pressed.png", 100, 400, 200, 100, fwd_pressed_callback)

function back_pressed_callback()
  -- Called when button is pressed
  
  visible(first_page_instruments, false)
  visible(second_page_instruments, true)
end

back_btn = button_add("btn_not_pressed.png", "btn_pressed.png", 500, 400, 200, 100, back_pressed_callback)


--xpl_command_subscribe(commandref, callback_function)
