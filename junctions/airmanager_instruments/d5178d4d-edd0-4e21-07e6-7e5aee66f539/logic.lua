--[[
******************************************************************************************
************FSS ERJ - 1XX - FCU Autopilot**********************************************
******************************************************************************************
##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
-]]

img_add_fullscreen("background4.png")
--snd_click = sound_add("click4.wav")
--sound_volume(snd_click, 0.5)
--snd_click2 = sound_add("roll.wav")
--sound_volume(snd_click2, 1.0)

--CAP CRS-------------------------------------------------------------------
img_dial_crs1 = img_add(nil, 54,235, 120,120)
local local_knob_crs1 = 0

function CRS1(dir)
    if dir == -1 then 
        local_knob_crs1 = (local_knob_crs1 - 1)%360
        rotate(img_dial_crs1, local_knob_crs1*2) 
        xpl_command("sim/radios/obs1_down","FLOAT",1) 
    elseif dir == 1 then  
        local_knob_crs1 = (local_knob_crs1 + 1)%360
        rotate(img_dial_crs1, local_knob_crs1*2) 
        xpl_command("sim/radios/obs1_up","FLOAT",1) 
    end
end
img_crs1_dial = dial_add("r_dial.png", 54,235, 120,120,.1, CRS1)

--DIR------------------
local DIR_value = 0  

function DIR_Engage()
        xpl_command("sim/radios/obs_HSI_direct","FLOAT")
end
DIR_ENG = button_add(nil, nil, 74, 256, 80, 80, DIR_Engage)

--VS WHEEL-------------------------------------------------------------------
img_scrollwheel_vsw = img_add(nil, 1690,128, 55, 200)
local local_scrollwheel_vsw = 0

function VSW(dir)
    if dir == 1 then 
         local_scrollwheel_vsw = ( local_scrollwheel_vsw - 1)%360
        rotate(img_scrollwheel_vsw, local_scrollwheel_vsw) 
        xpl_command("XCrafts/ERJ/VS_dn_100","FLOAT", 1)
    elseif dir == -1 then  
        local_scrollwheel_vs = ( local_scrollwheel_vsw + 1)%360
        rotate(img_scrollwheel_vsw, local_scrollwheel_vsw) 
        xpl_command("XCrafts/ERJ/VS_up_100","FLOAT", 1)
    end
end
img_scrollwheel_vsw = dial_add(nil,1692, 110, 75, 240, 0.1, VSW)

--FPA SEL-------------------------------------------------------------------
img_dial_fpa = img_add(nil, 1491,235, 120, 120)
local local_knob_fpa = 0

function FPA(dir)
    if dir == -1 then 
        local_knob_fpa = (local_knob_fpa - 1)%360
        rotate(img_dial_fpa, local_knob_fpa*2) 
		xpl_command("XCrafts/ERJ/FPA_dn_pt_one","FLOAT", 1)
    elseif dir == 1 then  
        local_knob_fpa = (local_knob_fpa + 1)%360
        rotate(img_dial_fpa, local_knob_fpa*2) 
        xpl_command("XCrafts/ERJ/FPA_up_pt_one","´FLOAT", 1)
    end
end
img_fpa_dial = dial_add("r_dial.png",1491,235, 120, 120, 0.1, FPA)

--FMS/MAN-------------------------------------------------------------
img_spd_on = img_add("fms_img.png", 862, 217, 154, 154) visible(img_spd_on, false)
img_spd_off = img_add("man_img.png", 862, 217, 154, 154) visible(img_spd_off, false)

xpl_dataref_subscribe("XCrafts/speed_knob_fms_man", "INT",
    function(state)
        if state == 1 then
            visible(img_spd_on, true)
            visible(img_spd_off, false)
        elseif state == 0 then
            visible(img_spd_on, false)
            visible(img_spd_off, true)
        end
    end
)
function SPD_Button()
	xpl_command("XCrafts/ERJ/PFD/AT_speed_source","FLOAT")	
end
img_spd_button = button_add(nil, nil, 916,371,46,39, SPD_Button)

--SPD Dial--------------------------------------------
img_dial_spd = img_add(nil, 872,243, 144, 144)

local local_knob_spd = 0

function SPD(dir)
    if dir == -1 then 
        local_knob_SPD = (local_knob_spd - 1)%360
        rotate(img_dial_spd, local_knob_spd*2)
        xpl_command("XCrafts/ERJ/SPD_dn_1","FLOAT", 1)
    elseif dir == 1 then  
        local_knob_spd = (local_knob_spd + 1)%360
        rotate(img_dial_spd, local_knob_spd*2) 
        xpl_command("XCrafts/ERJ/SPD_up_1","FLOAT", 1)
    end
end
img_spd_dial = dial_add("s_dial.png", 862,219, 154, 154, 0.1, SPD)

--MACH/KIAS------------------
local DIR_value = 0  

function MACH_Engage()
        xpl_command("sim/autopilot/knots_mach_toggle","FLOAT")
end
MACH_ENG = button_add(nil, nil, 900, 256, 80, 80, MACH_Engage)

--ALT DIAL--------------------------------------------------------------
img_dial_alt = img_add(nil, 1274, 234, 190, 190)
local local_knob_alt = 0

function ALT(dir)
    if dir == -1 then 
        local_knob_alt = (local_knob_alt - 1)%360
        rotate(img_dial_alt, local_knob_alt*2) 
        xpl_command("XCrafts/ERJ/ALT_dn_1000","FLOAT", 1)
    elseif dir == 1 then  
        local_knob_alt = (local_knob_alt + 1)%360
        rotate(img_dial_alt, local_knob_alt*2)
        xpl_command("XCrafts/ERJ/ALT_up_1000","FLOAT", 1)

    end
end
img_alt_dial = dial_add("r_dial.png", 1274, 234, 120, 120, 0.1, ALT)

--HDG DIAL--------------------------------------------------------------
img_dial_hdg = img_add(nil,  408,230, 130, 130)
local local_knob_hdg = 0

function HDG(dir)
    if dir == -1 then 
        local_knob_hdg = (local_knob_hdg - 1)%360
        rotate(img_dial_hdg, local_knob_hdg*2) 
        xpl_command("sim/autopilot/heading_down","FLOAT", 1)
    elseif dir == 1 then  
        local_knob_hdg = (local_knob_hdg + 1)%360
        rotate(img_dial_hdg, local_knob_hdg*2) 
        xpl_command("sim/autopilot/heading_up","FLOAT", 1)
    end
end
img_hdg_dial = dial_add("hdg_dial.png", 408,230, 130, 130, 0.1, HDG)
	
--HDG SYNC-------------------
local HDSYNC_value = 0  

function HDSYNC_Engage()
        xpl_command("sim/autopilot/heading_sync","FLOAT")
end
HDSYNC_ENG = button_add(nil, nil, 433, 256, 80, 80, HDSYNC_Engage)

---------------------------------BUTTONS--------------------------------
--FD1-------------------------------------------------------------------
local FD_value = 0  

function FD_Engage()
        xpl_command("XCrafts/ERJ/fdir_toggle","FLOAT")
end
FD_ENG = button_add(nil, "button_pressed.png", 70, 68, 84, 64, FD_Engage)

--NAV--------------------------------------------------------------------
local NAV_value = 0  

function NAV_Engage()
        xpl_command("XCrafts/ERJ/LNAV","FLOAT")
end
NAV_ENG = button_add(nil, "button_pressed.png", 262, 68, 84, 64, NAV_Engage)

--HDG--------------------------------------------------------------------
local HDG_value = 0  

local HDG_value = 0  

function HDG_Engage()
        xpl_command("sim/autopilot/heading","FLOAT")
end
HDG_ENG = button_add(nil, "button_pressed.png", 434, 68, 84, 64, HDG_Engage)

--APP--------------------------------------------------------------------
local APP_value = 0  

function APP_Engage()
        xpl_command("XCrafts/ERJ/APPCH","FLOAT")
end
APP_ENG = button_add(nil, "button_pressed.png", 262, 204, 84, 64, APP_Engage)

--BANK-------------------------------------------------------------------
local BANK_value = 0  

function BANK_Engage()

    if BANK_value == 0 then
        BANK_value = 1
        xpl_command("sim/autopilot/bank_limit_down","FLOAT")
		xpl_command("sim/autopilot/bank_limit_down","FLOAT")
		xpl_command("sim/autopilot/bank_limit_down","FLOAT")
    else
        BANK_value = 0
        xpl_command("sim/autopilot/bank_limit_up","FLOAT")
		xpl_command("sim/autopilot/bank_limit_up","FLOAT")
		xpl_command("sim/autopilot/bank_limit_up","FLOAT")
    end
end
BANK_ENG = button_add(nil, "button_pressed.png", 262, 340, 84, 64, BANK_Engage)

--AP MASTER--------------------------------------------------------------
local AP_value = 0  

function AP_Engage()
        xpl_command("XCrafts/APYD_Toggle","FLOAT")
end
AP_ENG = button_add(nil, "button_pressed.png", 629, 68, 108, 64, AP_Engage)

--YD---------------------------------------------------------------------
local YD_value = 0 

function YD_Engage()
        xpl_command("sim/systems/yaw_damper_toggle","FLOAT")
end
YD_ENG = button_add(nil, "button_pressed.png", 640, 202, 84, 64, YD_Engage)

--SRC----------------------------------------------------------------------
local SRC_value = 0 

function SRC_Engage()
        fs2020_variable_write("L:FSS_EXX_FGC_BTN_SRC", "Number")
end
SRC_ENG = button_add(nil, "button_pressed.png", 640, 342, 84, 64, SRC_Engage)

--ATHRTL---------------------------------------------------------------------
local AT_value = 0  

function AT_Engage()
        xpl_command("XCrafts/ERJ/AutoThrottle","INT")
end
AT_ENG = button_add(nil, "button_pressed.png", 888, 68, 108, 64, AT_Engage)

--VNAV-------------------------------------------------------------------------
local VNAV_value = 0 

function VNAV_Engage()
        xpl_command("XCrafts/ERJ/VNAV","FLOAT")
end
VNAV_ENG = button_add(nil, "button_pressed.png", 1090, 72, 84, 64, VNAV_Engage)

--FLCH--------------------------------------------------------------------------
local FLCH_value = 0 

function FLCH_Engage()
        xpl_command("XCrafts/ERJ/FLCH","FLOAT")
end
FLCH_ENG = button_add(nil, "button_pressed.png", 1088, 272, 84, 64, FLCH_Engage)

--ALT----------------------------------------------------------------------------
local ALT_value = 0 

function ALT_Engage()
        xpl_command("XCrafts/ERJ/alt_hold","FLOAT")
end
ALT_ENG = button_add(nil, "button_pressed.png", 1292, 72, 84, 64, ALT_Engage)

--FPA----------------------------------------------------------------------------
local FPA_value = 0 

function FPA_Engage()
        xpl_command("XCrafts/ERJ/FPA","FLOAT") 
end
FPA_ENG = button_add(nil, "button_pressed.png", 1508, 72, 84, 64, FPA_Engage)

--VS----------------------------------------------------------------------------
local VS_value = 0 

function VS_Engage()
        xpl_command("XCrafts/ERJ/VS","FLOAT") 
end
VS_ENG = button_add(nil, "button_pressed.png", 1808, 72, 84, 64, VS_Engage)


