-- AUTOPILOT LIBRARY --
-- TO DO TO DO TO DO TO DO TO DO --
-- BOX 3 green box doesn't behave like it should
-- Switching between FD and CMD sometimes causes the two annunciators to be visible on top of each other
-- TO DO TO DO TO DO TO DO TO DO --

-- Global variables
local gbl_annunATArm_time_out	= 0
local gbl_annunATArm			= false
local gbl_annunCMD_time_out		= 0
local gbl_annunCMD_A			= false
local gbl_annunCMD_B			= false
local gbl_cws_r_time_out		= 0
local gbl_annunCWS_A			= false
local gbl_cws_p_time_out		= 0
local gbl_annunCWS_B			= false
local gbl_annunFD_time_out		= 0
local gbl_annunFD				= false
local gbl_MCP_FDSw				= false
local gbl_annunHDG_SEL_time_out	= 0
local gbl_annunHDG_SEL			= false
local gbl_annunVOR_LOC_time_out	= 0
local gbl_annunVOR_LOC			= false
local gbl_box3_time_out			= 0
local gbl_box3_white_time_out	= 0
local gbl_annunALT_HOLD			= false
local gbl_annunVS               = false
local gbl_annunVSarm			= false
local gbl_annunLVL_CHG          = false
local gbl_box1_green_time_out	= 0
local gbl_annunRETARD 			= false
local gbl_annunN1 				= false
local gbl_annunMCPspd 			= false

function lib_autopilot_init()

img_cws_r_nobox = img_add("cws_r_nobox.png", 266, 94, nil, nil)
visible(img_cws_r_nobox, false)
img_cws_r_box = img_add("cws_r_box.png", 266, 94, nil, nil)
visible(img_cws_r_box, false)

img_cws_p_nobox = img_add("cws_p_nobox.png", 357, 94, nil, nil)
visible(img_cws_p_nobox, false)
img_cws_p_box = img_add("cws_p_box.png", 357, 94, nil, nil)
visible(img_cws_p_box, false)

img_cmd_nobox = img_add("cmd_no_box.png", 315, 142, 68, 36)
visible(img_cmd_nobox, false)
img_cmd_box = img_add("cmd_box.png", 315, 142, 68, 36)
visible(img_cmd_box, false)

img_FD_boxed = img_add("FD_box.png", 288, 154, nil, nil)
visible(img_FD_boxed, false)
img_FD_nobox = img_add("FD_nobox.png", 288, 154, nil, nil)
visible(img_FD_nobox, false)

-- Green warning boxes matrix. 1 - 3 = left to right line 1. 4 - 6 = left to right line 2.
img_box1_arm = img_add("warning_white.png", 133, 12, nil, nil)
txt_box1_arm = txt_add("ARM", "font:din1451alt.ttf; size:24px; color:white; halign:center;", 178, 8, 58, 26)
visible(img_box1_arm, false)
visible(txt_box1_arm, false)
img_box1_green = img_add("warning_green.png", 133, 12, nil, nil)
txt_box1_green = txt_add("ARM", "font:din1451alt.ttf; size:24px; color:#40fc21; halign:center;", 130, 8, 150, 26)
visible(img_box1_green, false)
visible(txt_box1_green, false)

img_box2 = img_add("warning_green.png", 283, 12, nil, nil)
txt_box2 = txt_add("HDG SEL", "font:din1451alt.ttf; size:24px; color:#40fc21; halign:center;", 280, 8, 150, 26)
visible(img_box2, false)
visible(txt_box2, false)
img_box2_white = img_add("warning_white.png", 283, 12, nil, nil)
txt_box2_white = txt_add("VOR LOC", "font:din1451alt.ttf; size:24px; color:white; halign:center;", 280, 8, 150, 26)
visible(img_box2_white, false)
visible(txt_box2_white, false)

img_box3 = img_add("warning_green.png", 433, 12, nil, nil)
txt_box3 = txt_add(" ", "font:din1451alt.ttf; size:24px; color:#40fc21; halign:center;", 431, 8, 150, 26)
visible(img_box3, false)
visible(txt_box3, false)
img_box3_white = img_add("warning_white.png", 433, 12, nil, nil)
txt_box3_white = txt_add("V/S", "font:din1451alt.ttf; size:24px; color:white; halign:center;", 431, 8, 150, 26)
visible(img_box3_white, false)
visible(txt_box3_white, false)

txt_box5_white = txt_add("VOR LOC", "font:din1451alt.ttf; size:20px; color:white; halign:center;", 280, 32, 150, 26)

txt_lvnav = txt_add(" ", "font:din1451alt.ttf; size:17px; color:white; halign:left;", 161, 161, 140, 18)

end

-- Functions
function autopilot_callback(annunATArm, annunFD, MCP_FDSw, annunHDG_SEL, annunALT_HOLD, annunVS, annunVSarm, annunLVL_CHG, annunVOR_LOC, annunCMD_A, annunCWS_A, annunCMD_B, annunCWS_B, LNAV, VNAV, annunRETARD, 
							annunN1, annunMCPspd, zulu_time)

	-- Convert integers to booleans
	annunATArm		= annunATArm	== 1
	annunFD			= annunFD		== 1
	MCP_FDSw		= MCP_FDSw		== 1
	annunHDG_SEL	= annunHDG_SEL	== 1
	annunALT_HOLD	= annunALT_HOLD == 1
	annunVS			= annunVS		== 1
	annunVSarm		= annunVSarm	== 1
	annunLVL_CHG	= annunLVL_CHG	== 1
	annunVOR_LOC	= annunVOR_LOC	== 1
	annunCMD_A		= annunCMD_A	== 1
	annunCWS_A		= annunCWS_A	== 1
	annunCMD_B		= annunCMD_B	== 1
	annunCWS_B		= annunCWS_B	== 1
	LNAV			= LNAV			== 1
	VNAV			= VNAV			== 1	
	annunRETARD		= annunRETARD	== 2
	annunN1			= annunN1		== 1
	annunMCPspd		= annunMCPspd	== 1
	
	-- LNAV / VNAV indicator according to X-FMC datarefs
	if VNAV and not LNAV then
		txt_set(txt_lvnav, "VNAV")
	elseif not VNAV and LNAV then
		txt_set(txt_lvnav, "LNAV")
	elseif VNAV and LNAV then
		txt_set(txt_lvnav, "LNAV / VNAV")
	else
		txt_set(txt_lvnav, " ")
	end
	
	-- Flight director annunciator
	visible(img_FD_nobox, ((annunFD or (annunCWS_A or annunCWS_B)) and (not annunCMD_A and not annunCMD_B)) and MCP_FDSw and gbl_annunFD_time_out >= 10)

	gbl_annunFD		= annunFD
	gbl_MCP_FDSw	= MCP_FDSw
	
	if not timer_running(timer_annunFD) and annunFD and (not annunCMD_A and not annunCMD_B) and MCP_FDSw then
		timer_annunFD = timer_start(0, 1000, timer_annunFD_callback)
		gbl_annunFD_time_out = 0
		timer_stop(timer_annunCMD)
		gbl_annunCMD_time_out = 0
	elseif timer_running(timer_annunFD) and not annunFD or (annunCMD_A or annunCMD_B) and not MCP_FDSw then
		timer_stop(timer_annunFD)
		visible(img_FD_boxed, false)
	end
	
	-- CMD mode annunciator
	visible(img_cmd_nobox, (annunCMD_A or annunCMD_B) and gbl_annunCMD_time_out >= 10)
	
	gbl_annunCMD_A	= annunCMD_A
	gbl_annunCMD_B	= annunCMD_B
	gbl_annunCWS_A	= annunCWS_A
	gbl_annunCWS_B	= annunCWS_B
	
	if not timer_running(timer_annunCMD) and (annunCMD_A or annunCMD_B) and (not annunCWS_A or not annunCWS_B) then
		timer_annunCMD = timer_start(0, 1000, timer_annunCMD_callback)
		gbl_annunCMD_time_out = 0
		timer_stop(timer_annunFD)
		gbl_annunFD_time_out = 0
	elseif timer_running(timer_annunCMD) and (not annunCMD_A and not annunCMD_B) or (annunCWS_A or annunCWS_B) then
		timer_stop(timer_annunCMD)
		visible(img_cmd_box, false)
	end
	
	-- CWS R annunciator
	visible(img_cws_r_nobox, (annunCMD_A or annunCWS_A or annunCMD_B or annunCWS_B) and gbl_cws_r_time_out >= 10)
	
	if not timer_running(timer_cws_r) and (annunCMD_A or annunCMD_B or annunCWS_A or annunCWS_B) then
		timer_cws_r = timer_start(0, 1000, timer_cws_r_callback)
		gbl_cws_r_time_out = 0
	elseif timer_running(timer_cws_r) and (not annunCMD_A and not annunCMD_B and not annunCWS_A and not annunCWS_B) then
		timer_stop(timer_cws_r)
		visible(img_cws_r_box, false)
	end
	
	-- CWS P annunciator
	visible(img_cws_p_nobox, (annunCWS_A or annunCWS_B) and gbl_cws_p_time_out >= 10)
	
	if not timer_running(timer_cws_p) and (annunCWS_A or annunCWS_B) then
		timer_cws_p = timer_start(0, 1000, timer_cws_p_callback)
		gbl_cws_p_time_out = 0
	elseif timer_running(timer_cws_p) and (not annunCWS_A and not annunCWS_B) then
		timer_stop(timer_cws_p)
		visible(img_cws_p_box, false)
	end

	--Box 1 annunciator and text
	-- White
	visible(txt_box1_arm, annunATArm and (not annunRETARD and not annunN1 and not annunMCPspd) )
	gbl_annunATArm = annunATArm
	
	if not timer_running(timer_annunATArm) and annunATArm and not annunRETARD and not annunN1 and not annunMCPspd then
		timer_annunATArm = timer_start(0, 1000, timer_box1_callback)
		gbl_annunATArm_time_out = 0
	elseif timer_running(timer_annunATArm) and not annunATArm or annunRETARD or annunN1 or annunMCPspd then
		timer_stop(timer_annunATArm)
		visible(img_box1_arm, false)
	end
	
	-- Green
	gbl_annunRETARD = annunRETARD
	gbl_annunN1 = annunN1
	gbl_annunMCPspd = annunMCPspd
	visible(txt_box1_green, annunRETARD or annunN1 or annunMCPspd)
	
	if annunRETARD and not annunN1 then
		txt_set(txt_box1_green, "RETARD")
	elseif annunN1 then
		txt_set(txt_box1_green, "N1")
	elseif annunMCPspd and not annunRETARD then
		txt_set(txt_box1_green, "MCP SPD")
	else
		txt_set(txt_box1_green, " ")
	end
	
	if not timer_running(timer_box1_green) and (annunRETARD or annunN1 or annunMCPspd) then
		timer_box1_green = timer_start(0, 1000, timer_box1_green_callback)
		gbl_box1_green_time_out = 0
	elseif timer_running(timer_box1_green) and (not annunRETARD and not annunN1 and not annunMCPspd) then
		timer_stop(timer_box1_green)
		visible(img_box1_green, false)
	end

	-- Box 2 annunciator
	visible(txt_box2, annunHDG_SEL)
	visible(txt_box2_white, annunVOR_LOC and not annunHDG_SEL)
	
	gbl_annunHDG_SEL = annunHDG_SEL
	gbl_annunVOR_LOC = annunVOR_LOC
	
	if not timer_running(timer_annunHDG_SEL) and annunHDG_SEL then
		timer_annunHDG_SEL = timer_start(0, 1000, timer_box2_callback)
		gbl_annunHDG_SEL_time_out = 0
	elseif timer_running(timer_annunHDG_SEL) and not annunHDG_SEL then
		timer_stop(timer_annunHDG_SEL)
		visible(img_box2, false)
	end
	
	if not timer_running(timer_annunVOR_LOC) and annunVOR_LOC and not annunHDG_SEL then
		timer_annunVOR_LOC = timer_start(0, 1000, timer_box2_white_callback)
		gbl_annunVOR_LOC_time_out = 0
	elseif timer_running(timer_annunVOR_LOC) and (not annunVOR_LOC or annunHDG_SEL) then
		timer_stop(timer_annunVOR_LOC)
		visible(img_box2_white, false)
	end
	
	-- Box 3 annunciations
	visible(txt_box3, (annunALT_HOLD or annunVS) and not annunVSarm)
	visible(txt_box3_white, annunVSarm)
	
	-- Set the text for the 3 different modes
	if annunALT_HOLD then
		txt_set(txt_box3, "ALT HOLD")
	elseif annunVS then
		txt_set(txt_box3, "V/S")
	else
		txt_set(txt_box3, " ")
	end

	-- Make these 4 variables global
	gbl_annunALT_HOLD = annunALT_HOLD
	gbl_annunVS = annunVS
	gbl_annunVSarm = annunVSarm
	
	-- Put a green annunciator box around one of these 3 texts, with a 10 seconds time out
	if not timer_running(timer_box3) and (annunALT_HOLD or annunVS) and not annunVSarm then
		timer_box3 = timer_start(0, 1000, timer_box3_callback)
		gbl_box3_time_out = 0
	elseif timer_running(timer_box3) and (not annunALT_HOLD and not annunVS) then
		timer_stop(timer_box3)
		visible(img_box3, false)
	end
	
	-- Put a white annunciator box around one of the texts, with a 10 seconds time out
	if not timer_running(timer_box3_white) and annunVSarm then
		timer_box3_white = timer_start(0, 1000, timer_box3_white_callback)
		gbl_box3_white_time_out = 0
	elseif timer_running(timer_box3_white) and not annunVSarm then
		timer_stop(timer_box3_white)
		visible(img_box3_white, false)
	end
	
	-- Box 5 annunciations
	visible(txt_box5_white, annunVOR_LOC and annunHDG_SEL)
	
end

-- Timer functions
-- All autopilot notifications are expressed for 10 seconds by a green border
function timer_annunFD_callback()

	gbl_annunFD_time_out = var_cap(gbl_annunFD_time_out + 1, 0, 11)
	visible(img_FD_boxed, (gbl_annunFD_time_out >= 0 and gbl_annunFD_time_out < 11) and ((gbl_annunFD or (gbl_annunCWS_A or gbl_annunCWS_B)) and (not gbl_annunCMD_A and not gbl_annunCMD_B)) and gbl_MCP_FDSw)

end

function timer_annunCMD_callback()

	gbl_annunCMD_time_out = var_cap(gbl_annunCMD_time_out + 1, 0, 11)
	visible(img_cmd_box, (gbl_annunCMD_time_out >= 0 and gbl_annunCMD_time_out < 11) and (gbl_annunCMD_A or gbl_annunCMD_B) and (not gbl_annunCWS_A and not gbl_annunCWS_B))
	
end

function timer_cws_r_callback()

	gbl_cws_r_time_out = var_cap(gbl_cws_r_time_out + 1, 0, 11)
	visible(img_cws_r_box, (gbl_cws_r_time_out >= 0 and gbl_cws_r_time_out < 11) and (gbl_annunCMD_A or gbl_annunCMD_B or gbl_annunCWS_A or gbl_annunCWS_B))

end

function timer_cws_p_callback()

	gbl_cws_p_time_out = var_cap(gbl_cws_p_time_out + 1, 0, 11)
	visible(img_cws_p_box, (gbl_cws_p_time_out >= 0 and gbl_cws_p_time_out < 11) and (gbl_annunCWS_A or gbl_annunCWS_B))
	
end

function timer_box1_callback()

	gbl_annunATArm_time_out = var_cap(gbl_annunATArm_time_out + 1, 0, 11)
	visible(img_box1_arm, (gbl_annunATArm_time_out >= 0 and gbl_annunATArm_time_out < 11) and gbl_annunATArm and not gbl_annunRETARD and not gbl_annunN1 and not gbl_annunMCPspd)

end

function timer_box1_green_callback()

	gbl_box1_green_time_out = var_cap(gbl_box1_green_time_out + 1, 0, 11)
	visible(img_box1_green, (gbl_box1_green_time_out >= 0 and gbl_box1_green_time_out < 11) and (gbl_annunRETARD or gbl_annunN1 or gbl_annunMCPspd))

end

function timer_box2_callback()

	gbl_annunHDG_SEL_time_out = var_cap(gbl_annunHDG_SEL_time_out + 1, 0, 11)
	visible(img_box2, (gbl_annunHDG_SEL_time_out >= 0 and gbl_annunHDG_SEL_time_out < 11) and gbl_annunHDG_SEL)

end

function timer_box2_white_callback()

	gbl_annunVOR_LOC_time_out = var_cap(gbl_annunVOR_LOC_time_out + 1, 0, 11)
	visible(img_box2_white, (gbl_annunVOR_LOC_time_out >= 0 and gbl_annunVOR_LOC_time_out < 11) and gbl_annunVOR_LOC and not gbl_annunHDG_SEL)

end

function timer_box3_callback()

	gbl_box3_time_out = var_cap(gbl_box3_time_out + 1, 0, 11)
	visible(img_box3, (gbl_box3_time_out ~= 0 and gbl_box3_time_out < 11) and (gbl_annunALT_HOLD or gbl_annunVS))

end

function timer_box3_white_callback()

	gbl_box3_white_time_out = var_cap(gbl_box3_white_time_out + 1, 0, 11)
	visible(img_box3_white, (gbl_box3_white_time_out ~= 0 and gbl_box3_white_time_out < 11) and gbl_annunVSarm)

end

-- Variable subscribe
xpl_dataref_subscribe("x737/systems/athr/athr_armed", "INT", 
					  "x737/systems/afds/fd_master", "INT",
					  "x737/cockpit/MCP/FDA_switch", "FLOAT",
					  "x737/systems/afds/HDG", "INT", 
					  "x737/systems/PFD/PFD_ALTHLD_mode_on", "INT",
					  "x737/systems/afds/VS", "INT", 
					  "x737/systems/afds/VS_arm", "INT",
					  "x737/systems/afds/LVLCHG", "INT",
					  "x737/systems/afds/VORLOC_armed", "INT",
					  "x737/systems/afds/CMD_A", "INT",
					  "x737/cockpit/MCP/CWSA_button", "INT",
					  "x737/systems/afds/CMD_B", "INT",
					  "x737/cockpit/MCP/CWSB_button", "INT", 
					  "x737/systems/afds/LNAV", "INT", 
					  "x737/systems/afds/VNAV", "INT",
					  "x737/systems/PFD/PFD_RETARD_mode_on", "INT",
					  "x737/systems/athr/N1_mode", "INT",
					  "x737/systems/athr/MCPSPD_mode", "INT",
					  "sim/time/zulu_time_sec", "FLOAT", autopilot_callback)