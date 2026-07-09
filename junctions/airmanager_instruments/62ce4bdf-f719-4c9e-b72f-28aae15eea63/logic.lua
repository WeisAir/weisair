-- Global variables --
-- Fill in the EGT
max_egt_prop = user_prop_add_integer("Maximum EGT value", 100, 2500, 600, "Fill in the maximum EGT for your aircraft")
local max_egt = user_prop_get(max_egt_prop)

img_add_fullscreen("temp_backdrop.png")
img_neddle_cht = img_add("engine_neddle.png",98,0,60,256)
img_neddle_egt = img_add("engine_neddle.png",98,0,60,256)
rotate(img_neddle_cht, -135)
rotate(img_neddle_egt, 132)

img_add("engine_center.png",98,98,60,60)

function PT_cht(cht)
    cht = var_cap(cht[1], 50, 250)
    rotate(img_neddle_cht, -135 + (90 / 200 * (cht - 50)) )
end

function PT_egt(egtraw)
    egt = var_cap(egtraw[1], max_egt - 240, max_egt + 40)
    rotate(img_neddle_egt, (84 / 280 * (egt - (max_egt - 240)) - 132) * -1)    
end

function PT_cht_FSX(cht)
    PT_cht({cht})
end

function PT_egt_FSX(egt)
    PT_egt({egt})
end

-- Bus subscribe --
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/CHT_deg_C", "FLOAT[8]", PT_cht)
xpl_dataref_subscribe("sim/cockpit2/engine/indicators/EGT_deg_C", "FLOAT[8]",PT_egt)
fsx_variable_subscribe("RECIP ENG CYLINDER HEAD TEMPERATURE:1", "Celsius", PT_cht_FSX)
fsx_variable_subscribe("GENERAL ENG EXHAUST GAS TEMPERATURE:1", "Celsius", PT_egt_FSX)
msfs_variable_subscribe("RECIP ENG CYLINDER HEAD TEMPERATURE:1", "Celsius", PT_cht_FSX)
msfs_variable_subscribe("GENERAL ENG EXHAUST GAS TEMPERATURE:1", "Celsius", PT_egt_FSX)