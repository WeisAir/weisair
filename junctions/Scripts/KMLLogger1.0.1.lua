--[[
KMLLogger
Mike Nixon 2026-01-03
(Based on MNFlightLogger)
Log flight path in KML format
Log flight data in csv format
KML logging is optional, but csv will always be saved
    provided flight time > MIN_FLIGHT_SECS  (5 mins)
Please see the README and KMLLogger.pdf for details
]]--
-- ------------------------------------------------------------------
local mn_VERSION_NO = "1.0.1"
local mn_VERSION_DATE= "2026-01-02"  -- current version
-- ------------------------------------------------------------------

-- this will show a pop-up window so you can add a KML waypoint to your route
add_macro("KMLLogger Add Waypoint","mn_add_waypoint()" )
create_command("MHN/KMLLogger/Waypoint", "Mark a waypoint", "mn_add_waypoint()", "", "")
-- this will show the pop-up window with current status
add_macro("KMLLogger Status", "mn_show_status()")
create_command("MHN/KMLLogger/ShowWindow", "Display current status", "mn_show_status()", "", "")
-- ------------------------------------------------------------------

--get datarefs
local qnh          = dataref_table("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot" )
local time_z       = dataref_table("sim/time/zulu_time_sec") -- time in UTC/Zulu
local time_l       = dataref_table("sim/time/local_time_sec") -- sim time LOCAL
local on_ground    = dataref_table("sim/flightmodel/forces/faxil_gear") -- +ve value = on ground, 0 = aloft
local replay_mode  = dataref_table("sim/operation/prefs/replay_mode") -- in replay mode?
local paused       = dataref_table("sim/time/paused")
local aloft        = dataref_table("sim/flightmodel/position/y_agl")   -- height above ground in METERS
local sim_distance = dataref_table("sim/flightmodel/controls/dist") -- total distance travelled in m
local a_dialled    = dataref_table("sim/cockpit/autopilot/altitude")      -- altitude ft dialled into a/p
local alt_pilot    = dataref_table("sim/cockpit2/gauges/indicators/altitude_ft_pilot") -- altitude shown on PFD
local gs_ms        = dataref_table("sim/flightmodel/position/groundspeed") -- groundspeed in m/s - needs to be converted to kts!
local vs           = dataref_table("sim/flightmodel/position/vh_ind_fpm") -- vertical speed ft/min
local ws           = dataref_table("sim/cockpit2/gauges/indicators/wind_speed_kts") -- wind speed in kts
local wd           = dataref_table("sim/cockpit2/gauges/indicators/wind_heading_deg_mag") -- wind direction in degrees magnetic
local dirn         = dataref_table("sim/cockpit/misc/compass_indicated") -- compass reading degrees magnetic
--local parkbrake    = dataref_table("sim/flightmodel/controls/parkbrake") --park brake on? --**1230**
local engine_on    = dataref_table("sim/flightmodel/engine/ENGN_running") --  array: is engine running **1203**
-- ------------------------------------------------------------------

-- safety!
if not SUPPORTS_FLOATING_WINDOWS then
    -- to make sure the script doesn't stop old FlyWithLua versions
    mn_logit("imgui not supported by your FlyWithLua version")
    return
end
-- ------------------------------------------------------------------

-- Constants
local SECS24HRS       = 86400 -- number of seconds in 24 hours 60 * 60 * 24
local NAV_TYPE_V      = xplm_Nav_Airport+xplm_Nav_VOR+xplm_Nav_Localizer+ xplm_Nav_Fix
local NAV_TYPE_I      = NAV_TYPE_V  + xplm_Nav_DME 
local MIN_FLIGHT_SECS = 60 -- minimum flight time to be logged = 10 mins
local MIN_GS          = 30  -- below this level we are effectively stationary!
local MIN_VFR_ALTM    = 600 -- m (+- 2000' agl) below this log every 10 secs, above log every minute
local CSVLog          = "FlightLog" .. mn_VERSION_NO:match("%d+.%d+") ..".csv"  -- file name of csv log file
local FOLDER          = SYSTEM_DIRECTORY .. "KML"  -- folder name for KML files
local MIN_MINS_AT_FL  = 5  -- min time at same altitude in order to log it  
local THRESHOLD_O     = 10 -- less than this distance from waypoint check every 10 sec, otherwise every 60 sec
local THRESHOLD_I     = 5  -- min distance nm IFR from waypoint to consider logging it
local THRESHOLD_V     = 3  -- min distance nm VFR from waypoint to consider logging it --**0101**
local MAX_FLS         = 4  -- maximum number of flight levels to log at end
local RADIUS          = 3444; -- Earth RADIUS in nm
local MPi             = math.pi / 180  -- used in orbital distance calculation

-- ignore these waypoint ids
local SKIP_IDS        = { "DISCON","(INTC)", "(HOLD)","^%-%-%-%-%-$","(VECTOR)","^RW%d+" }
-- kml format for waypoint
local FMT_WPT = [=[<Placemark>
        <name>%s</name>
        <description>%s</description>
		<styleUrl>#fix-style</styleUrl>
        <Style><IconStyle><scale>%.1f</scale><Icon><href>%s</href></Icon></IconStyle></Style>
        <ExtendedData>
          <Data name="gs"><value>%d</value></Data>
          <Data name="alt"><value>%d</value></Data>
          <Data name="agl"><value>%d</value></Data>
          <Data name="dn"><value>%d</value></Data>
          <Data name="vs"><value>%d</value></Data>
          <Data name="wd"><value>%d</value></Data>
          <Data name="ws"><value>%d</value></Data>
          <Data name="qnh"><value>%s</value></Data>
          <Data name="time"><value>%s</value></Data>
        </ExtendedData>
 		<Point>
           <altitudeMode>absolute</altitudeMode>
   		 <coordinates>%.8f,%.8f,%d</coordinates>
		</Point>
 </Placemark>
]=]
-- ------------------------------------------------------------------

-- Table Variables
local flight = {
ap_on,         -- autopilot on/off 0=off >0 = on
f_done,        -- true =  flight has ended
flying,        -- true = in  the air
landed,        -- true = flight ended & acft on the ground
isactive,      -- false if paused, in replay mode etc
log_to_kml,    -- true if flight is being saved as KML
kmlchecked,    -- true if kml confirmation screen has been displayed
Timeout_FL,    -- counter to designate MIN_MINS_AT_FL have elapsed   
prev_alt,       -- previous altitude flown
max_alt        -- maximum altituded reached
}

local wpts   = {
 Timeout_kml,  -- write KML at least once per minute --**1218**
 prev_wpt,     -- name of the last waypoint (fix/vor/apt etc) we have passed
 prev_dist,    -- previous distance from next waypoint **1203**
 savelon,      -- save longitude of previous waypoint
 savelat,      -- save latitude of previous waypoint 
 savetype,     -- type of waypoint: vor,ndb,apt,fix
 tmptyp,       -- temporary holder for savetype
 tmp_wptname,  -- tmp holder for new waypoint
 wpt_save,     -- name of manually added waypoint
 next_wpt_id,  -- **1208** id of next waypoint
 next_wpt_dist, -- **1208** distance to next waypoint
 prev_idx,      -- DB index for previous waypoint search
 hnav,          -- autopilot state reads either 9 or 22 (hnav engaged) --**0102**
 gpss           -- autopilot gps state 2=engaged --**0102**
}

local vfr = { -- **0105**
 prev_wpt,     -- name of the last waypoint (fix/vor/apt etc) we have passed
 prev_dist,    -- previous distance from next waypoint **1203**
-- savelon,      -- save longitude of previous waypoint
-- savelat,      -- save latitude of previous waypoint 
 --savetype,     -- type of waypoint: vor,ndb,apt,fix
 prev_idx      -- previous db index of waypoint
}

local stats = {
 dep_icao, 
 dep_name,               -- departure airport code and name
 flight_start_distance,  -- start distance recorded at commencement of flight
 takeoff_time,           -- takeoff time in UTC
 takeoff_local,          -- takeoff time in LOCAL
 block_out_time,         -- **1205** time from engine start & brakes off
 block_in_time,          -- **1205** time from brakes on, engines off (fmrr94 request!)
 num_engines,            -- how many engines in the aircraft
 fuel_start,             -- quantity of fuel in kg at startup
 fuel_end                -- quantity of fuel in kg at end
}
-- Other Variables
local rte_descript    -- description of the route: used in KML header
local KMLLogFile      -- name of the KML file that will be created
local FL              -- array to contain altitudes flown, plus length of time in mins
local f_hdr           -- temporary file which will contain KML header
local t_hdr           -- name of temporary file
local f_trk           -- temporary file which will contain all the KML trackpoints
local t_trk           -- name of temporary file
local is_zibomod_acft -- true = warn string when using the Zibomod 737: no way at present to find next waypoint from the FMS :-/
local flt_details     -- array showing flight stats: from, to, distance, flightlevels etc
local flt_date        -- date of flight (local)
local screenopen      -- true if there is an imgui screen open
local show_popup      -- if true then display bubble showing KML log file created
local close_popup     -- time to close the bubble
local num_trackpoints -- total number of trackpoints logged in KML
local num_waypoints   -- total number of named waypoints
-- ------------------------------------------------------------------------

-- initialize/reset variables
function mn_reset_script()
  set("sim/time/use_system_time",0) -- IMPORTANT! This allows times to match what the sim is doing: speed-up, pause etc
  FL                    = {} -- default to climb, various, descent
  flight.f_done         = false
  flight.flying         = false
  flight.landed         = false
  flight.isactive       = false
  flight.log_to_kml     = false
  flight.kmlchecked     = false
  flight.max_alt        = 0
  flight.prev_alt       = 0
  flight.Timeout_FL     = 0
  vfr.prev_wpt          = "*"
  vfr.prev_dist         = 9999
  vfr.prev_idx          = -1
  screenopen            = false
  flt_date              = os.date("%Y-%m-%d")
  rte_descript          = ""
  wpts.Timeout_kml      = 0
  wpts.savelon          = LONGITUDE
  wpts.savelat          = LATITUDE
  wpts.savetype         = 0
  wpts.prev_idx         = -1
  wpts.tmp_wptname      = ""
  wpts.prev_dist        = 9999 --**1203**
  wpts.prev_wpt         = "*"
  num_trackpoints       = 0
  num_waypoints         = 0
  stats.flight_start_distance = 0
  stats.takeoff_time    = time_z[0]
  flt_details           = {"",""}
  show_popup            = false
  stats.block_out_time  = 0 --**1203**
  stats.block_in_time   = 0 --**1203**
  close_popup           = time_z[0]    
  stats.fuel_start      = 0 --**1222**
  stats.fuel_end        = 0 --**1222**
  stats.num_engines     = get("sim/aircraft/engine/acf_num_engines") --**1214**
  -- Zibomod aircraft use different datarefs here
  is_zibomod_acft       = ((XPLMFindDataRef("laminar/B738/fms/legs") and XPLMFindDataRef("laminar/B738/fms/fpln_nav_id")) ~= nil) --these are unique to Zibomod
  if (is_zibomod_acft) then
      wpts.next_wpt_id   = dataref_table("laminar/B738/fms/fpln_nav_id") -- next waypoint in FMS
      wpts.next_wpt_dist = dataref_table("laminar/B738/fms/id_dist") 
      flight.ap_on       = dataref_table("laminar/autopilot/ap_on")
      wpts.hnav          = {[0]=0}  --**0102**
      wpts.gpss          = {[0]=0}  --**0102**
  else
      wpts.next_wpt_id   = dataref_table("sim/cockpit2/radios/indicators/gps_nav_id")
      wpts.next_wpt_dist = dataref_table("sim/cockpit2/radios/indicators/gps_dme_distance_nm")
      flight.ap_on       = dataref_table("sim/cockpit2/autopilot/autopilot_on")
      wpts.hnav          = dataref_table("sim/cockpit/autopilot/mode_hnav") --**0102**
      wpts.gpss          = dataref_table("sim/cockpit2/autopilot/gpss_status") --**0102**

  end
  mn_logit("XPlane verson: " .. XPLANE_VERSION .. " Aircraft: " ..PLANE_ICAO ..  " [" .. stats.num_engines .." engine/s].")
  mn_logit("Zibomod aircraft? ".. tostring(is_zibomod_acft))
  if (not mn_FileExists(CSVLog)) then  -- write Log file header if file does not exist
	   mn_WriteLog("Date,Aircraft,Departure ICAO,Departure APT,Arrival ICAO,Arrival APT,TakeOff (Z),Land (Z),TakeOff (Local),Land (Local),Duration (h:m:s),Duration (hour),Distance (nm),Altitude/s,Max Altitude (ft),Block Out Time (Z),Block In Time (Z),Fuel Start (kg),Fuel End (kg)")
  end
  stats.dep_icao, stats.dep_name = mn_get_airport()
  mn_logit("script initialized.")
end
-- --------------------------------------------------------------------------

-- convert time in sec to HH:MM:SS
function mn_SecToTime(sec) 
	local _hour = math.floor(sec / 3600)
	local _min = math.floor((sec % 3600) / 60)
	local _sec = sec - ((_hour * 3600) + (_min * 60))
	return string.format("%02d:%02d:%02d",_hour,_min,_sec) 
end
-- --------------------------------------------------------------------------

-- log message using current date and ZULU time
function mn_logit(msg)
 if (msg) then 
    logMsg("KMLLogger" .. mn_VERSION_NO .." ".. mn_SecToTime(time_z[0]).. "Z: " .. msg)
 end 
end
-- --------------------------------------------------------------------------

-- does the file exist?
function mn_FileExists(filename)
       return os.rename(filename, filename) and true or false
end
-- --------------------------------------------------------------------------

-- log the last flight
function mn_WriteLog(data) 
   local _file = io.open( CSVLog, "a+")
   if (_file == nil) then 
      mn_logit("ERROR! Can not write log file "  .. CSVLog)
    else
      _file:write(data,"\n")
      io.close(_file)
   end
end
-- --------------------------------------------------------------------------

-- display waypoint form
function mn_wpt_show()
       imgui.PushStyleColor(imgui.constant.Col.WindowBg, 0xFFFFFFFF) -- White Background
       imgui.SetCursorPosX(94)
       imgui.PushStyleColor(imgui.constant.Col.Text, 0xff0000FF) -- red text
       imgui.TextUnformatted("*** Set KML Waypoint ***")
       imgui.PopStyleColor()
       imgui.PushStyleColor(imgui.constant.Col.FrameBg,0xfff0d0d0)
       imgui.PushStyleColor(imgui.constant.Col.FrameBgActive,0xff0000ff)
       imgui.SetCursorPosX(30)
       if (imgui.RadioButton("Undefined",wpts.savetype == 0)) then
         wpts.savetype = 0
       end
       imgui.SameLine()
       if (imgui.RadioButton("Airport",wpts.savetype == 1)) then
         wpts.savetype = 1
       end
       imgui.SameLine()
       if (imgui.RadioButton("NDB",wpts.savetype == 2)) then
         wpts.savetype = 2
       end
       imgui.SameLine()
       if (imgui.RadioButton("VOR",wpts.savetype == 4)) then
         wpts.savetype = 4
       end
       imgui.SameLine()
       if (imgui.RadioButton("FIX",wpts.savetype == 512)) then
         wpts.savetype = 512
       end
       imgui.SetCursorPosY(imgui.GetCursorPosY() +10)
       imgui.PushStyleColor(imgui.constant.Col.Text, 0xff000000) -- black text
       imgui.PushStyleColor(imgui.constant.Col.FrameBg,0xff00ff00) -- text input/radiobutton background green
       imgui.SetCursorPosX(90)
       imgui.TextUnformatted("Enter Waypoint description\n") 
       imgui.SetWindowFontScale(1.2) --larger text
       imgui.SetCursorPosX(65)
       local changed, newVal = imgui.InputText(" ",wpts.tmp_wptname, 32)
       if (changed) then 
           wpts.wpt_save = newVal 
       end
       imgui.SetWindowFontScale(1.0) -- normal text
       imgui.PopStyleColor()
       imgui.SetCursorPosX(150)
       if imgui.Button("Save", 60, 20) then
            if (wpts.wpt_save and wpts.wpt_save >"") then
                 mn_write_KML(true,wpts.wpt_save)
            end
            float_wnd_destroy(mnwnd_wpt)        -- close the window
       end
end

-- --------------------------------------------------------------------------

-- waypoint form closed, so unpause the sim
function mn_wpt_close()
  mnwnd_wpt= nil
  flight.flying = true
  wpts.savetype = wpts.tmptyp -- restore original value
  if (paused[0] ~= 0) then
     command_once("sim/operation/pause_toggle")
  end
end
-- --------------------------------------------------------------------------

-- add a custom waypoint: create a form
-- but pause the sim while we wait for input
function mn_add_waypoint()
  if (flight.isactive and flight.log_to_kml and flight.flying) then
      if (paused[0] == 0) then
         command_once("sim/operation/pause_toggle")
      end
     flight.flying = false
     wpts.tmptyp=wpts.savetype  --save value
     wpts.savetype = 0 --UNK
     wpts.wpt_save = ""
     local w = 380 
     local h = 130
     local x,y = mn_find_top_centre(w,h)
     mnwnd_wpt= float_wnd_create(w, h, 1, true)
     float_wnd_set_position(mnwnd_wpt, x, y)
     float_wnd_set_title(mnwnd_wpt,"KMLLogger " .. mn_VERSION_NO .." " ..mn_VERSION_DATE)
     float_wnd_set_imgui_builder(mnwnd_wpt, "mn_wpt_show")
     float_wnd_set_onclose(mnwnd_wpt,"mn_wpt_close")
  end
end
-- --------------------------------------------------------------------------

-- create KML folder if necessary, then create date-stamped filename
function mn_create_kmllogfile()
    local ok, err, code = os.rename(FOLDER, FOLDER) -- does the folder exist?
    if (not ok) then
          local lfs = require("lfs_ffi")  -- filesystem utils
          lfs.mkdir(FOLDER) -- create the folder
    end
    KMLLogFile  = os.date("%Y%m%d_%H%M")
    t_hdr                    = os.tmpname() 
    f_hdr                    = io.open(t_hdr,"w+")
    t_trk                    = os.tmpname()
    f_trk                    = io.open(t_trk,"w+")
end
-- --------------------------------------------------------------------------

-- display initial "do you want to log this flight?" form
function mn_kml_show_screen()
      imgui.PushStyleColor(imgui.constant.Col.WindowBg, 0xFFFFFFFF) -- White Background
      imgui.PushStyleColor(imgui.constant.Col.Text, 0xff0000ff) -- red text
      imgui.SetCursorPosX(90)
      imgui.TextUnformatted("*** Log KML Track ***")
      imgui.PopStyleColor()
      imgui.PushStyleColor(imgui.constant.Col.Text, 0xff000000) -- black text
      imgui.TextUnformatted("Do you want to save this flight path to KML,\nwhich you can then upload to Google Earth?\n")
      imgui.SetCursorPosX(90)
      imgui.PushStyleColor(imgui.constant.Col.Button,0xff0000ff) -- text input/radiobutton background red
      if (imgui.Button("No",40,20)) then
          flight.log_to_kml = false
          float_wnd_destroy(mnwnd_kml)
      end
      imgui.PopStyleColor()
      imgui.PushStyleColor(imgui.constant.Col.Button,0xff00ff00) -- text input/radiobutton background green
      imgui.SameLine()
      imgui.SetCursorPosX(220)
      if imgui.Button("Yes", 40, 20) then
          flight.log_to_kml = true
          mn_create_kmllogfile()
          mn_write_KML(true,string.format("%s: %s [%s]",stats.dep_icao, stats.dep_name, PLANE_ICAO)) --**1230**
          float_wnd_destroy(mnwnd_kml)
      end
 end
-- --------------------------------------------------------------------------

--window closed
function mn_kml_window_closed()
   mnwnd_kml = nil
   screenopen = false
   if (flight.log_to_kml) then
      mn_logit("KML logging ENABLED")
   else
      mn_logit("KML logging DISABLED")
   end
end
-- --------------------------------------------------------------------------

-- create input screen to confirm logging KML
function mn_kml_create_screen()
 if (not screenopen) then
    rte_descript = stats.dep_icao .. ": " .. stats.dep_name .. "  [" .. PLANE_ICAO .. "]" 
    local w = 360 
    local h = 90
    local x,y = mn_find_top_centre(w,h)
    mnwnd_kml = float_wnd_create(w, h, 1, true)
    float_wnd_set_position(mnwnd_kml, x,y)
    float_wnd_set_title(mnwnd_kml,"KMLLogger " .. mn_VERSION_NO .." " ..mn_VERSION_DATE)
    float_wnd_set_imgui_builder(mnwnd_kml, "mn_kml_show_screen")
    float_wnd_set_onclose(mnwnd_kml,"mn_kml_window_closed")
    screenopen = true
  end
end
-- --------------------------------------------------------------------------

-- after engine start-up, show kml input screen
function mn_check_kml()
  if (flight.kmlchecked) then return end
  if (mn_isEngineRunning() and not screenopen)  then
        flight.kmlchecked = true
        mn_kml_create_screen()
  end
end
-- --------------------------------------------------------------------------

-- get normalized flight level dialled into a/p
function mn_norm_ap_alt()
  return math.floor((a_dialled[0] + 50)/100)*100
end
-- --------------------------------------------------------------------------

-- get current flight altitude in feet, rounded to nearest 100 feeet
function mn_get_flight_level()
 -- return math.floor(((ELEVATION * 3.2808) + 50)/100)*100  -- to feet
    return math.floor((alt_pilot[0] + 50)/100) * 100 -- 2025-11-05 more reliable than converting ELEVATION
end
-- --------------------------------------------------------------------------
-- get height agl in feet
function mn_get_agl()
  return math.floor(aloft[0] * 3.28084)
end
-- --------------------------------------------------------------------------

-- get qnh in hg and hPa. 
function mn_get_qnh()
  local qnh_hp = qnh[0]  * 33.8637526
  return string.format("%2.2fhg/%4.1fhPa", qnh[0],qnh_hp)
end
-- --------------------------------------------------------------------------

-- convert m/sec to kts
function mn_get_gs_kts()
 return math.floor(gs_ms[0] * 1.94384)
end
-- --------------------------------------------------------------------------

-- get the current airport name etc
function mn_get_airport()
    local a_icao
    local a_name
    wpts.savetype, _, _, _, _, _, a_icao, a_name = XPLMGetNavAidInfo(XPLMFindNavAid(nil, nil, LATITUDE, LONGITUDE, nil,xplm_Nav_Airport )) 
    return a_icao, a_name:gsub(",","")  -- remove any commas!
end
-- --------------------------------------------------------------------------

-- what will the time be in 1 minute
function mn_next_min(mins)
  mins = mins or 1
  return time_z[0] + (mins * 60) -- one minute time
end
-- --------------------------------------------------------------------------

-- convert meters to nautical miles
function mn_m_to_nm()
 return math.floor((sim_distance[0] - stats.flight_start_distance) / 1852)  -- convert distance from  m to nm
end
-- --------------------------------------------------------------------------

-- get flight duration in secs, allowing for wrap!
function mn_get_duration(start,finish)
       local duration = finish - start
       -- if we take off at 23:00 and time now is 07:16 duration would be negative, 
       -- so add 24 hours
       if (duration < 0) then duration = duration + SECS24HRS end
       return duration
end
-- --------------------------------------------------------------------------

-- get most used flight levels
function mn_list_flight_levels()
   local rslt = ""
   local idx = {}
   for i,_  in pairs(FL) do 
       table.insert(idx,i)
   end
   table.sort(idx, function(a, b)
        return FL[a][2] > FL[b][2]
    end)
    -- build result string
    local cnt = 0
    for i,v in ipairs(idx) do
        -- only list top MAX_FLS levels
        if (cnt >= MAX_FLS) then break end
        if (rslt > "") then rslt = rslt .. "/" end
        rslt = rslt .. FL[v][1] 
        cnt = cnt + 1
    end
    if (rslt > "") then  return rslt else return "^~v" end
end
-- --------------------------------------------------------------------------

function mn_status_window_closed()
   show_popup = false
   mnwnd_stat = nil
end
-- --------------------------------------------------------------------------

-- show current status
function mn_show_current_status()
   imgui.PushStyleColor(imgui.constant.Col.WindowBg, 0xFFFFFFFF) -- White Background
   imgui.PushStyleColor(imgui.constant.Col.Text, 0xff000000) -- black text
   imgui.TextUnformatted(flt_details[1]) -- update the pop-up window with results
   if (flt_details[2]>"") then
      imgui.Separator()
      imgui.TextUnformatted(flt_details[2])
   end
   if (flight.f_done) then
       imgui.Separator()
       imgui.SetCursorPosX(120)
       if imgui.Button("Close", 160, 20) then
            mn_reset_script()
            float_wnd_destroy(mnwnd_stat)        -- close the window
       end
   end
end
-- --------------------------------------------------------------------------

-- position float window dead centre
function mn_find_top_centre(w,h)
   local x = math.floor((SCREEN_WIDTH - w) /2)
   --local y = math.floor((SCREEN_HEIGHT - h) /2)
   local y = SCREEN_HEIGHT - h - 80
   return x,y
end
-- --------------------------------------------------------------------------
-- update onscreen status
function mn_upd_stat() --**1218**
--**1218**
local FMT_STATUS =[=[
***  Current Status  ***
Altitude    : %s ft
Height agl  : %d ft
Heading     : %d°
Distance    : %s nm
Duration    : %s hh:mm:ss
Ground spd  : %d kts
Vertical spd: %d ft/min
Winds       : %d°/%dkts 
QNH         : %s
]=]

    local v_spd = math.floor(vs[0] / 50 + 0.5) * 50 
    --flt_details = {"",""}
    local dtn = 0
    if (flight.flying) then 
         dtn = mn_get_duration(stats.takeoff_time,time_z[0]) 
    end
    local agl = math.floor(aloft[0] * 3.28084)
    flt_details[1] = string.format(FMT_STATUS,mn_get_flight_level(),agl, math.floor(dirn[0]),mn_m_to_nm(), mn_SecToTime(dtn), mn_get_gs_kts(),v_spd,math.floor(wd[0]), math.floor(ws[0]),mn_get_qnh())
end
-- --------------------------------------------------------------------------

--create imgui box to show status
function mn_show_status()
     if ( show_popup ) then return end -- do not want 2 windows open at same time
    local w = 350 
    local h = 145
    flt_details[2] = ""
    if (flight.log_to_kml) then
       h = 170
       flt_details[2] = "Logging data to KML"
    end
    local x,y = mn_find_top_centre(w,h)
    mnwnd_stat = float_wnd_create(w, h, 1, true)
    float_wnd_set_position(mnwnd_stat, x,y)
    float_wnd_set_title(mnwnd_stat,"KMLLogger " .. mn_VERSION_NO.." " ..mn_VERSION_DATE)
    float_wnd_set_imgui_builder(mnwnd_stat, "mn_show_current_status")
    float_wnd_set_onclose(mnwnd_stat,"mn_status_window_closed")
    close_popup = time_z[0] + 15  -- close in 15secs
    mn_upd_stat() --**1218**
    show_popup  = true
end
-- --------------------------------------------------------------------------

-- write flight data to csv log & show bubble
function mn_write_csv_log(arr_icao,arr_name,flevels,duration,dht,distance)
  local fmt = "Departure: %s,Arrival  : %s,Aircraft : %s,Distance : %dnm,Duration : %s,Altitudes: %s"
  if (duration > MIN_FLIGHT_SECS) then -- only log if in air for > 10 mins!
   mn_WriteLog(string.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%.1f,%d,%s,%d,%s,%s,%.1f,%.1f",                              
              flt_date,PLANE_ICAO, stats.dep_icao, stats.dep_name, arr_icao, arr_name,mn_SecToTime(stats.takeoff_time), mn_SecToTime(time_z[0]),                       mn_SecToTime(stats.takeoff_local),mn_SecToTime(time_l[0]),mn_SecToTime(duration), dht, distance,    flevels,flight.max_alt,mn_SecToTime(stats.block_out_time),mn_SecToTime(stats.block_in_time),stats.fuel_start,stats.fuel_end))
  end
end
-- --------------------------------------------------------------------------

-- combine all temp files into KML final
function mn_save_KML(arr_icao,arr_name,flevels,duration,distance)
   mn_logit("WEISAIR: in function mn_save_KML ") 
   -- formats for kml sections
    local hdr1 = [=[
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
]=]
    local hdr2 = [=[
 <Style id="fix-style">
    <IconStyle><color>ffc2ff0b</color></IconStyle>
    <LabelStyle><color>ff00ffff</color></LabelStyle>
    <BalloonStyle><text>
    <![CDATA[<center><b><font size=5>$[name]</font> <font size=4>($[description])</font><br/>%s &RightArrow; <br/>&RightArrow; %s<br/>(%s)</b></center><br/>
<pre>
gs  : $[gs]kts
alt : $[alt]ft
agl : $[agl]ft
hdg : $[dn]°    
vs  : $[vs]ft/min
wind: $[wd]°/$[ws]kts
QNH : $[qnh]
time: $[time]Z
</pre>]]></text></BalloonStyle>
</Style>
]=]

local INFO = [=[
 <Style id="line-style">
      <LineStyle>
        <color>ffff55ff</color>
        <width>4</width>
      </LineStyle>
      <PolyStyle><color>8fff55ff</color></PolyStyle>
    <IconStyle><color>ffc2ff0b</color></IconStyle>
    <LabelStyle><color>ff00ffff</color></LabelStyle>
    <BalloonStyle>
    <text><![CDATA[<center><b><font size=4>%s-%s</font><br/> %s &RightArrow; <br/> &RightArrow; %s<br/></b></center><pre>
Date        : %s local
Aircaft     : %s
Distance    : %dnm
Duration    : %s
Altitudes   : %s
Waypoints   : %d
Trackpoints : %d
</pre>
<p style="font-size:8px">KMLLogger %s (Mike Nixon)</p>]]></text>
     </BalloonStyle>
 </Style>
<styleUrl>#line-style</styleUrl>
]=]
 
   local trkstart = [=[
      <Placemark>
      <name>%s-%s</name>
      <styleUrl>#line-style</styleUrl>
      <LineString>
        <extrude>1</extrude>
        <tessellate>0</tessellate>
        <altitudeMode>absolute</altitudeMode>
        <coordinates>
]=]

  local trailer = [=[
       </coordinates>
      </LineString>
    </Placemark>
</Document>
</kml>
]=]

   --save final destination
   mn_logit("WEISAIR: calling function mn_write_KML")
   mn_write_KML(true,string.format("%s: %s [%s]",arr_icao, arr_name, PLANE_ICAO)) 
   local tm  = flt_date .. " " .. mn_SecToTime(stats.takeoff_local)
   local dta = string.format(INFO, stats.dep_icao,arr_icao,stats.dep_name,arr_name,os.date("%Y-%m-%d"),PLANE_ICAO,distance,mn_SecToTime(duration),flevels,num_waypoints,num_trackpoints,mn_VERSION_NO.." " ..mn_VERSION_DATE)
   local tmp = stats.dep_icao .."-" .. arr_icao .. "_" .. KMLLogFile .. ".kml"
   KMLLogFile = tmp
   local fname  = FOLDER .. "/" .. KMLLogFile

   mn_logit("WEISAIR: Saving KML flight data to: " .. fname)
   --safety! Just in case there is already an existing file with the same name
   local success, err = os.remove(fname)
   if (success) then
      mn_logit("DELETED pre-existing kml file: " .. fname)
   end
   local _kml = io.open( fname, "a+") 
   if (_kml == nil) then 
       mn_logit("ERROR! Can not write KML file "  .. fname)
   else
      _kml:write(hdr1)
      _kml:write(dta)
      _kml:write(string.format(hdr2,stats.dep_name,arr_name,PLANE_ICAO))
     -- write out waypoints
     f_hdr:seek("set",0) 
     local line = f_hdr:read("*line")
     while (line) do
        _kml:write(line,"\n")
       line = f_hdr:read("*line")
     end
     io.close(f_hdr)
     -- start of track
     _kml:write(string.format(trkstart,stats.dep_icao,arr_icao))
     f_trk:seek("set",0) 
     line = f_trk:read("*line")
     while (line) do
        _kml:write(line,"\n")
        line = f_trk:read("*line")
     end
     -- finally close file
     _kml:write(trailer)
     io.close(f_trk)
     io.close(_kml)
     os.remove(t_hdr) --delete temp files
     os.remove(t_trk)
  end
end
-- --------------------------------------------------------------------------

-- at end of flight combine the 2 temp files into a KML file
function mn_closeoff()
local fmt=[=[
***  Final Flight Stats  ***
Takeoff     : %s UTC
Landing     : %s UTC
En route    : %s
Decimal     : %.1f hours
Distance    : %d nm
Flt Lvl(s)  : %s
Max Altitude: %d
Flight data is in: %s
]=]

  local f_levels = mn_list_flight_levels()
  local duration = mn_get_duration(stats.takeoff_time,time_z[0])
  local icao,nme = mn_get_airport()
  local dist = mn_m_to_nm()
  local dht = duration / 3600 -- duration in decimal hours 
  -- save in csv log file
  mn_write_csv_log(icao,nme,f_levels,duration,dht,dist)
  --save kml
  if (flight.log_to_kml) then 
      mn_logit("WEISAIR: in function mn_closeoff calling function mn_save_KML") 
      mn_save_KML(icao,nme,f_levels,duration,dist) 
   end
 -- if we are showing status, then close that window first
  if (mnwnd_stat) then  float_wnd_destroy(mnwnd_stat) end
  local h = 180
  local w = 400
  flt_details = {"",""}
  flt_details[1] = string.format(fmt, mn_SecToTime(stats.takeoff_time), mn_SecToTime(time_z[0]), mn_SecToTime(duration),dht,dist,f_levels,flight.max_alt,CSVLog ) 
  if (flight.log_to_kml) then
       h = h + 30
       flt_details[2] = "KML data : " .. KMLLogFile .. "\nin folder: " .. FOLDER
  end
 
  -- show popup
  local x,y =  mn_find_top_centre(w,h)
  mnwnd_stat = float_wnd_create(w, h, 1, true)
  float_wnd_set_position(mnwnd_stat, x, y)
  float_wnd_set_title(mnwnd_stat,"KMLLogger " .. mn_VERSION_NO.." " ..mn_VERSION_DATE)
  float_wnd_set_imgui_builder(mnwnd_stat, "mn_show_current_status")
  float_wnd_set_onclose(mnwnd_stat,"mn_status_window_closed")
  close_popup = time_z[0] + 60  -- close in 15secs
  show_popup  = true
end
-- --------------------------------------------------------------------------

-- save a named waypoint (fix,airport,vor etc)
function mn_save_WPT(wptname, lat, lon, elv)
   if (not flight.log_to_kml) then return end
   local iconurl = "http://maps.google.com/mapfiles/kml/paddle/wht-blank.png"
   local scale   = 1
   local wt = "Info"
   if (wpts.savetype) then 
        if (wpts.savetype == 1) then 
           wt = "APT"
           iconurl ="http://maps.google.com/mapfiles/kml/paddle/wht-blank.png"
        elseif (wpts.savetype == 2) then 
           wt =  "NDB"
           iconurl ="http://maps.google.com/mapfiles/kml/shapes/target.png"
        elseif (wpts.savetype == 4) then 
          wt =  "VOR"
          scale = 1.2 
          iconurl ="http://maps.google.com/mapfiles/kml/shapes/polygon.png"
        elseif (wpts.savetype == 8) then
          wt = "ILS"
          iconurl = "http://maps.google.com/mapfiles/kml/shapes/cross-hairs.png"
        elseif (wpts.savetype == 512) then
          wt = "FIX"
          iconurl = "http://maps.google.com/mapfiles/kml/shapes/triangle.png"
        elseif (wpts.savetype == 1024) then
          wt = "DME"
          iconurl = "http://maps.google.com/mapfiles/kml/shapes/square.png"
        elseif (wpts.savetype == 9999) then
          wt = "Info"
        end
   end --savetype
   mn_logit("saveWPT " .. wptname .. " type: " .. wt)
   local v_spd = math.floor(vs[0] / 50 + 0.5) * 50 -- round vertical speed to nearest 50 feet
   local agl = math.floor(aloft[0] * 3.28084)
   local wpts=string.format(FMT_WPT,wptname,wt,scale,iconurl,mn_get_gs_kts(),mn_get_flight_level(),agl,math.floor(dirn[0]),v_spd,math.floor(wd[0]),math.floor(ws[0]), mn_get_qnh(), mn_SecToTime(time_z[0]) ,lon,lat,elv)
   f_hdr:write(wpts)
   num_waypoints = num_waypoints + 1
end
-- --------------------------------------------------------------------------

-- write data to kml file
function mn_write_KML(logroute,wptname, lat, lon)
  mn_logit("WEISAIR: in function mn_write_KML")
   if (not flight.log_to_kml) then
      mn_logit("WEISAIR: in function mn_write_KML --> log_to_kml is false, returning") 
      return end
  lon = lon or LONGITUDE 
  lat = lat or LATITUDE
  elv = math.floor(ELEVATION) --math.floor(aloft[0])
  num_trackpoints = num_trackpoints + 1
  if (wptname and wptname > "") then
   mn_logit("WEISAIR: calling function mn_save_WPT") 
     mn_save_WPT(wptname, lat, lon, elv)
  end 
  if (logroute) then
   mn_logit("WEISAIR: in function mn_write_KML -> logroute is true, writing to f_trk")
     f_trk:write(string.format("          %.8f,%.8f,%d\n",lon,lat,elv))
  end
end
-- --------------------------------------------------------------------------

-- is at least 1 engine running?
function mn_isEngineRunning()
   if (stats.num_engines) then --any engines running??
      local eng_no = 0
      while (eng_no < stats.num_engines) do
         if (engine_on[eng_no] ==1) then return true end
         eng_no = eng_no + 1
      end
   else
      return (engine_on[0] ==1)
   end
end

-- --------------------------------------------------------------------------
-- get engine on/off times
function mn_get_block_time(isBlockOut)
   -- got our times already?
   if (isBlockOut and stats.block_out_time >0 ) then return true
   elseif (not isBlockOut and stats.block_in_time > 0) then return true
   end
   local eng_running = mn_isEngineRunning()
   --if (isBlockOut and eng_running and parkbrake[0] == 0) then --**1230**
     if (isBlockOut and eng_running) then   --**1230**
        stats.block_out_time = time_z[0]
        stats.fuel_start = get("sim/flightmodel/weight/m_fuel_total")
        return true
   --elseif (not isBlockOut and not eng_running and parkbrake[0] == 1 ) then
     elseif (not isBlockOut and not eng_running) then --**1230**
        stats.block_in_time = time_z[0]
        stats.fuel_end = get("sim/flightmodel/weight/m_fuel_total")
        return true
   else
      return false
   end
end
-- --------------------------------------------------------------------------

--get distance to waypoint using coords
function mn_getGPSDistance( lat2, lon2)
    local lat1Rad = LATITUDE * MPi;
    local lon1Rad = LONGITUDE * MPi;
    local lat2Rad = lat2 * MPi;
    local lon2Rad = lon2 * MPi;
    local deltaLat = lat2Rad - lat1Rad;
    local deltaLon = lon2Rad - lon1Rad;
    local a = math.sin(deltaLat / 2)^2 + 
              math.cos(lat1Rad) * math.cos(lat2Rad) * 
              math.sin(deltaLon / 2)^2;
    local c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    --return R * c
    return math.floor(RADIUS * c * 10) /10  -- only 1 decimal
end
-- --------------------------------------------------------------------------
-- Flying WITHOUT autopilot or fms plan --**0101**
function mn_check_vfr_waypoints()
       --mn_logit("Check VFR waypoints")
       local rf = XPLMFindNavAid(nil,nil,LATITUDE, LONGITUDE, nil, NAV_TYPE_V)
       local nextw = "*"
       local typ = 0
       local lat1,lon1
       local nextd  = 9999
       local deltaflag = (vfr.prev_wpt == "*")
       if (rf > -1) then
          if (rf ~= vfr.prev_idx) then
               deltaflag = true
          end -- if rf ==
          typ,lat1,lon1, _, _, _, nextw, _ = XPLMGetNavAidInfo(rf) 
          typ  = typ or 0
          lat1 = lat1 or LATITUDE
          lon1 = lon1 or LONGITUDE
          nextd = mn_getGPSDistance( lat1, lon1)
          mn_logit("Nearest VFR waypoint: " .. nextw .. " type: " .. typ .. " dist: " .. nextd .. " prev dist: " .. vfr.prev_dist)
          if(vfr.prev_wpt ~= nextw  and vfr.prev_wpt ~= stats.dep_icao and vfr.prev_dist < THRESHOLD_V) then  --**0101**
                 mn_logit("Passed VFR Wpt: " .. vfr.prev_wpt .. " DISTANCE: " .. vfr.prev_dist .. " Type: " .. wpts.savetype.." lat: " .. lat1.." lon: "..lon1) 
                 mn_write_KML(false,vfr.prev_wpt,wpts.savelat,wpts.savelon)
                 deltaflag = true
          end -- if wpts.p
       end -- if rf >-1
       if (deltaflag) then
                 vfr.prev_dist = 9999 
                 vfr.prev_wpt  = nextw
                 wpts.savelat   = lat1
                 wpts.savelon   = lon1
                 wpts.savetype  = typ
                 vfr.prev_idx  = rf
       else
          --if (vfr.prev_dist > nextd) then
           vfr.prev_dist = nextd 
          --end
       end --deltaflag
end

-- --------------------------------------------------------------------------

-- valid waypoint name?
function mn_valid_apt(wpt)  --**0103**
     if (not wpt ) or (wpt =="") then
         mn_logit("NO waypoint!")
         return false
     elseif (wpt == stats.dep_icao) then --**0106**
        return false
     else
        for _,w in pairs(SKIP_IDS) do
            if (string.match(wpt,w)) then
               mn_logit("INVALID waypoint: " .. wpt)         
               return false
            end
        end
       return true
     end
end

-- --------------------------------------------------------------------------
-- have we passed a waypoint? ONLY valid if flightplan is loaded
function mn_check_waypoints()
  if (not flight.log_to_kml) then return end
  --mn_logit("a/p on: " .. flight.ap_on[0] .. " hnav: " .. wpts.hnav[0] .. " gpss: " .. wpts.gpss[0])
 
  local vfrflag = (flight.ap_on[0] == 0) 
  if (not vfrflag and not is_zibomod_acft ) then
         vfrflag = (wpts.hnav[0] ~= 22 and wpts.gpss[0] ~= 2)
  end
  if (vfrflag) then
       mn_check_vfr_waypoints()
       return
  end

  --mn_logit("Check FMS waypoints")
  -- ap on and flightplan loaded
  local nextd  = 0
  local typ    = 0
  local rf     = -1
  local lat1
  local lon1
  if (wpts.next_wpt_id[0] and wpts.next_wpt_id[0] >"" ) then
       nextd   = math.floor(wpts.next_wpt_dist[0] * 10) /10
       if (wpts.next_wpt_id[0] == wpts.prev_wpt) then
           if (wpts.prev_dist > nextd) then wpts.prev_dist = nextd end
       else
           rf = XPLMFindNavAid(nil,wpts.next_wpt_id[0],LATITUDE, LONGITUDE, nil, NAV_TYPE_I)
           if (rf > -1) then
               typ,lat1,lon1,_,_,_,_,_, _ = XPLMGetNavAidInfo(rf) 
           end
           typ  = typ or 0
           lat1 = lat1 or LATITUDE
           lon1 = lon1 or LONGITUDE
           mn_logit("Next FMS waypoint: " .. wpts.next_wpt_id[0] .. " type: " .. typ .. " dist: " .. nextd .. " prev dist: " .. wpts.prev_dist)
           local deltaflag = (wpts.prev_wpt == "*")
           if(wpts.prev_dist < THRESHOLD_I) then 
                if (mn_valid_apt(wpts.prev_wpt)) then
                    mn_logit("Passed FMS Wpt: " .. wpts.prev_wpt .. " DISTANCE: " .. wpts.prev_dist .. " Type: " .. wpts.savetype) 
                    mn_write_KML(false,wpts.prev_wpt,wpts.savelat,wpts.savelon)
                end
                deltaflag = true
           end
           if (deltaflag) then
                 wpts.prev_dist = 9999 
                 wpts.prev_wpt  = wpts.next_wpt_id[0]
                 wpts.savelat   = lat1
                 wpts.savelon   = lon1
                 wpts.savetype  = typ
           else
               if (wpts.prev_dist > nextd) then wpts.prev_dist = nextd end
           end --prev-dist
       end --if next wpt ==  
  end -- if nextwpt
end

-- --------------------------------------------------------------------------

-- add value to flight level array
function mn_add_to_FL(flv)
   for i,v in pairs(FL)
   do
     if (v[1] == flv) then
        v[2] = v[2] + 1
        return false
     end
   end
   local r = {}
   r[1] = flv
   r[2] = 1
   table.insert(FL,r)
   local s_t = wpts.savetype
   wpts.savetype = 9999
   mn_write_KML(true,"ALT: " .. flv)  -- save new flight level as kml
   mn_logit("New Cruise Alt:  " .. flv)
   wpts.savetype = s_t
   return true
end
-- --------------------------------------------------------------------------

-- check whether we have remained at flight level long enough to log it
-- if a/p is on, check alt=dialled alt, otherwise have we flown at SAME alt for > 5 mins
function mn_check_flight_level()
       local tmpalt = mn_get_flight_level()
       if  (tmpalt > flight.max_alt) then flight.max_alt = tmpalt end --**0101**
       local flag = false
       -- autopilot on?
       if (flight.ap_on[0] ~= 0) then
           if (tmpalt == mn_norm_ap_alt()) then
                if (delta_fl) then
                 flag = mn_add_to_FL(tmpalt) 
                 delta_fl = false
               end
           else     
              delta_fl = true
           end
       end -- isfd
       if (not flag) then
           if (tmpalt == flight.prev_alt) then
             if (time_z[0] >= flight.Timeout_FL) then
                  flag = mn_add_to_FL(tmpalt)
                  flight.Timeout_FL = mn_next_min(MIN_MINS_AT_FL) 
             end --time
           else
              flight.Timeout_FL = mn_next_min(MIN_MINS_AT_FL) 
           end --tmpalt
           if (not flag)  then
               mn_write_KML(true) -- write track regardless
           end
       end -- not flag
       flight.prev_alt = tmpalt
end
-- --------------------------------------------------------------------------
  
-- called every 10 secs. Rest of function is ignored if we are not flying, are paused, or in replay mode
function mn_check_progress()
     if (show_popup and (time_z[0] >= close_popup)) then
         --show_popup = false
         show_popup = true
         if (mnwnd_stat) then  float_wnd_destroy(mnwnd_stat) end
     end
     if (flight.isactive and (not flight.f_done)) then 
         if (flight.flying and not flight.landed) then
            -- "normal" loop
            if ((aloft[0] < MIN_VFR_ALTM) or  (wpts.prev_dist < THRESHOLD_O) or (time_z[0] >= wpts.Timeout_kml)) then
                 mn_check_waypoints()
                 mn_check_flight_level()
                 wpts.Timeout_kml = mn_next_min()
            end -- if aloft
         else
             if (not flight.kmlchecked) then 
                mn_check_kml()
             end
        end -- flying?
     end -- isactive?
end
-- --------------------------------------------------------------------------

--called every 1 sec.  Detect takeoff and landing
function mn_CheckStatus()
   mn_logit("WEISAIR: Enter mn_CheckStatus") 
   flight.isactive = ((replay_mode[0] == 0) and (paused[0] == 0))
    if (flight.isactive and (not flight.f_done)) then
         local gskts = mn_get_gs_kts() 
         if (on_ground[0] ~= 0 and aloft[0] < 4)  then -- on ground??
             if (gskts < MIN_GS) then --stationary/slow? < 30kts
                   if (flight.flying) then
                        flight.landed = true
                        mn_logit("**Landed**")
                        flight.flying = false
                   end  
                   if (flight.landed) then
                      flight.f_done = mn_get_block_time(false)
                      if (flight.f_done) then
                          mn_closeoff() 
                      end 
                   elseif (stats.block_out_time == 0) then
                      mn_get_block_time(true)
                   end --landed
             else
                 mn_write_KML(true) -- log ground movement
             end --gskts
         elseif ((not flight.flying) and (aloft[0] >= 2) and (aloft[0] <= 50)) then -- not on ground
                 mn_logit("**Takeoff**")
                 stats.flight_start_distance = sim_distance[0]
                 stats.takeoff_time  = time_z[0]
                 stats.takeoff_local = time_l[0]
                 flight.flying   = true
         elseif (flight.flying and show_popup) then
                 mn_upd_stat()
         end -- if on_ground[0]
    end --isactive
end
-- -------------------------------------------------------------------------

mn_reset_script()
do_often("mn_CheckStatus()")
do_sometimes("mn_check_progress()")

