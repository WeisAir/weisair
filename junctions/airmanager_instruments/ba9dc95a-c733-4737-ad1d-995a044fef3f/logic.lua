background_image = img_add_fullscreen ( "background.png" )

local buttonWidth = 100
local buttonHeight = 50
local buttonSpacingX = 10
local buttonSpacingY = 10
local buttonGridOffsetX = 70
local buttonGridOffsetY = 50
local headerOffsetX = 20

local c1 = buttonGridOffsetX
local c2 = c1 + buttonWidth + buttonSpacingX
local c3 = c2 + buttonWidth + buttonSpacingX
local c4 = c3 + buttonWidth + buttonSpacingX
local c5 = c4 + buttonWidth + buttonSpacingX
local c6 = c5 + buttonWidth + buttonSpacingX

local r1 = buttonGridOffsetY
local r2 = r1 + buttonHeight + buttonSpacingY
local r3 = r2 + buttonHeight + buttonSpacingY
local r4 = r3 + buttonHeight + buttonSpacingY
local r5 = r4 + buttonHeight + buttonSpacingY

local textBoxWidth = buttonWidth * 1.0
local textBoxHeight = buttonHeight * 0.5

local buttonTextBoxOffsetX = (buttonWidth - textBoxWidth) * 0.5
local buttonTextBoxOffsetY = (buttonHeight - textBoxHeight) * 0.5

local headerTextBoxOffsetX = buttonTextBoxOffsetX
local headerTextBoxOffsetY = buttonTextBoxOffsetY

local buttonTexStyle = "font:1_roboto_regular.ttf; size:18px; color: white; halign: center;"
local buttonTexStyle_INOP = "font:1_roboto_regular.ttf; size:18px; color: grey; halign: center;"
local headerTexStyle = "font:1_roboto_regular.ttf; size:20px; color: white; halign: left;"

function cb_btn_SIMPAUSE_pressed() xpl_command("sim/operation/pause_toggle") end
function cb_btn_SIMSPEED_pressed() xpl_command("sim/operation/flightmodel_speed_change") end
function cb_btn_SCREENSHOT_pressed() xpl_command("sim/operation/screenshot") end
function cb_btn_LUA_RELOAD_pressed() xpl_command("FlyWithLua/debugging/reload_scripts") end
function cb_btn_POSITION_AC_pressed() xpl_command("") end
function cb_btn_WXR_CAVOK_pressed() xpl_command("xEnviro/CAVOK") end
function cb_btn_PUSHBACK_START_pressed() xpl_command("BetterPushback/start") end
function cb_btn_PUSHBACK_PLAN_pressed() xpl_command("BetterPushback/start_planner") end
function cb_btn_TOGGLE_XCAM_pressed() xpl_command("SRS/X-Camera/Toggle_X-Camera_on_or_off") end
function cb_btn_TOGGLE_XPREALISTIC_pressed() xpl_command("XPRealistic/MasterSwitch") end
function cb_btn_EMPTY_pressed() end
function cb_btn_TOGGLE_HEADTRACKER_pressed() xpl_command("SRS/X-Camera/Toggle_TrackIR_on_or_off_for_this_camera") end
function cb_btn_TOGGLE_FPS_pressed() xpl_command("sim/operation/show_fps") end
function cb_btn_TOGGLE_RPLCTRL_pressed() xpl_command("sim/replay/replay_controls_toggle") end
function cb_btn_DUMMY_pressed() end

function cb_btn_SIMPAUSE_released() end
function cb_btn_SIMSPEED_released() end
function cb_btn_SCREENSHOT_released() end
function cb_btn_LUA_RELOAD_released() end
function cb_btn_POSITION_AC_released() end
function cb_btn_WXR_CAVOK_released() end
function cb_btn_PUSHBACK_START_released() end
function cb_btn_PUSHBACK_PLAN_released() end
function cb_btn_TOGGLE_XCAM_released() end
function cb_btn_TOGGLE_XPREALISTIC_released() end
function cb_btn_EMPTY_released() end
function cb_btn_TOGGLE_HEADTRACKER_released() end
function cb_btn_TOGGLE_FPS_released() xpl_command("") end
function cb_btn_TOGGLE_RPLCTRL_released() end
function cb_btn_DUMMY_released() end  

-- ROW 1: SIM Operations --

txtHeader1 = txt_add("SIM",headerTexStyle,headerOffsetX,r1+headerTextBoxOffsetY,textBoxWidth,textBoxHeight)

button11 = button_add("button.png","button.png", c1 , r1 , buttonWidth , buttonHeight, cb_btn_SIMPAUSE_pressed, cb_btn_SIMPAUSE_released)
txtBtn11 = txt_add("SIM PAUSE",buttonTexStyle,c1+buttonTextBoxOffsetX,r1+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button12 = button_add("button.png","button.png", c2 , r1 , buttonWidth , buttonHeight, cb_btn_SCREENSHOT_pressed, cb_btn_SCREENSHOT_released)
txtBtn12 = txt_add("SCREENSHOT",buttonTexStyle,c2+buttonTextBoxOffsetX,r1+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button13 = button_add("button.png","button.png", c3 , r1 , buttonWidth , buttonHeight, cb_btn_LUA_RELOAD_pressed, cb_btn_LUA_RELOAD_released)
txtBtn13 = txt_add("LUA RELOAD",buttonTexStyle,c3+buttonTextBoxOffsetX,r1+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button14 = button_add("button.png","button.png", c4 , r1 , buttonWidth , buttonHeight, cb_btn_SIMSPEED_pressed, cb_btn_SIMSPEED_released)
txtBtn14 = txt_add("SIM SPEED",buttonTexStyle,c4+buttonTextBoxOffsetX,r1+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button15 = button_add("button.png","button.png", c5 , r1 , buttonWidth , buttonHeight, cb_btn_TOGGLE_FPS_pressed, cb_btn_TOGGLE_FPS_released)
txtBtn15 = txt_add("TOGGLE FPS",buttonTexStyle,c5+buttonTextBoxOffsetX,r1+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

-- ROW 2: ENV Operations --

txtHeader2 = txt_add("ENV",headerTexStyle,headerOffsetX,r2+headerTextBoxOffsetY,textBoxWidth,textBoxHeight)

button21 = button_add("button.png","button.png", c1 , r2 , buttonWidth , buttonHeight, cb_btn_WXR_CAVOK_pressed, cb_btn_WXR_CAVOK_released)
txtBtn21 = txt_add("WXR CAVOX",buttonTexStyle,c1+buttonTextBoxOffsetX,r2+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button22 = button_add("button.png","button.png", c2 , r2 , buttonWidth , buttonHeight, cb_btn_PUSHBACK_PLAN_pressed, cb_btn_PUSHBACK_PLAN_released)
txtBtn22 = txt_add("PUSHBACK PL",buttonTexStyle,c2+buttonTextBoxOffsetX,r2+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button23 = button_add("button.png","button.png", c3 , r2 , buttonWidth , buttonHeight, cb_btn_PUSHBACK_START_pressed, cb_btn_PUSHBACK_START_released)
txtBtn23 = txt_add("PUSHBACK GO",buttonTexStyle,c3+buttonTextBoxOffsetX,r2+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button24 = button_add("button.png","button.png", c4 , r2 , buttonWidth , buttonHeight, cb_btn_POSITION_AC_pressed, cb_btn_POSITION_AC_released)
txtBtn24 = txt_add("POSITION AC",buttonTexStyle,c4+buttonTextBoxOffsetX,r2+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button25 = button_add("button.png","button.png", c5 , r2 , buttonWidth , buttonHeight, cb_btn_DUMMY_pressed, cb_btn_DUMMY_released)
txtBtn25 = txt_add("INOP",buttonTexStyle_INOP,c5+buttonTextBoxOffsetX,r2+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)


-- ROW 3: IMM Operations --
txtHeader3 = txt_add("IMM",headerTexStyle,headerOffsetX,r3+headerTextBoxOffsetY,textBoxWidth,textBoxHeight)

button31 = button_add("button.png","button.png", c1 , r3 , buttonWidth , buttonHeight, cb_btn_TOGGLE_XCAM_pressed, cb_btn_TOGGLE_XCAM_released)
txtBtn31 = txt_add("TOGGLE X-CAM",buttonTexStyle,c1+buttonTextBoxOffsetX,r3+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button32 = button_add("button.png","button.png", c2 , r3 , buttonWidth , buttonHeight, cb_btn_TOGGLE_XPREALISTIC_pressed, cb_btn_TOGGLE_XPREALISTIC_released)
txtBtn32 = txt_add("TOGGLE XPRE",buttonTexStyle,c2+buttonTextBoxOffsetX,r3+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button33 = button_add("button.png","button.png", c3 , r3 , buttonWidth , buttonHeight, cb_btn_TOGGLE_HEADTRACKER_pressed, cb_btn_TOGGLE_HEADTRACKER_released)
txtBtn33 = txt_add("TGL HEADTRK",buttonTexStyle,c3+buttonTextBoxOffsetX,r3+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button34 = button_add("button.png","button.png", c4 , r3 , buttonWidth , buttonHeight, cb_btn_TOGGLE_RPLCTRL_pressed, cb_btn_TOGGLE_RPLCTRL_released)
txtBtn34 = txt_add("REPLAY CTRL",buttonTexStyle,c4+buttonTextBoxOffsetX,r3+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

button35 = button_add("button.png","button.png", c5 , r3 , buttonWidth , buttonHeight, cb_btn_DUMMY_pressed, cb_btn_DUMMY_released)
txtBtn35 = txt_add("INOP",buttonTexStyle_INOP,c5+buttonTextBoxOffsetX,r3+buttonTextBoxOffsetY,textBoxWidth,textBoxHeight)

--buttonI = button_add("button.png","button.png", c4 , r2 , buttonWidth , buttonHeight, cb_btn_DUMMY_pressed, cb_btn_DUMMY_released)