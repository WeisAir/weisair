-- Bell UH-1H Huey --
-- For use with X-Plane Nimbus Huey --
-- Vertical Speed Indicator --



-- Variables --
local a = 0
local cur_vsi = 0
local tgt_vsi = 0
local factor = 0.08



-- User Selections --

-- Instrument panel on/off --
panel_show = user_prop_add_boolean("Panel", true, "Show Panel")
local panel = user_prop_get(panel_show)

-- Instrument panel, and screw countersink colour --
panel_colour = user_prop_add_enum("Panel Colour", "Black,Grey", "Black", "Select Colour")
local colour = user_prop_get(panel_colour)

if colour == "Black" then colour_selected = "panel_black.png" 
else colour_selected = "panel_grey.png"
end

if colour == "Black" and panel == true then screws_selected = "screws_black.png"
elseif colour == "Grey" and panel == true then screws_selected = "screws_grey.png"
else screws_selected = "screws.png"
end

-- Panel type, Front mount or Flush mount --

bezel_prop = user_prop_add_enum ("Bezel Type", "Front,Flush", "Front", "Select Bezel Type")
local bezel_type = user_prop_get(bezel_prop)

if bezel_type == "Front" then bezel_selected = "bezel_1_v2.png"
else bezel_selected = "bezel_v2.png"
end

-- Bezel on/off --
bezel_visible  = user_prop_add_boolean("Bezel", true, "Show the bezel")
local bezel_ring = user_prop_get(bezel_visible)

-- Screws on/off --
screws = user_prop_add_boolean("Mounting Screws", true, "Show Screws")
local screws_visible = user_prop_get(screws)

-- Post Light on/off --
post_light = user_prop_add_boolean("Post Light", true, "Show Post Light")
local post_light_true = user_prop_get(post_light)



-- Add images depending on user selections --

-- Panel --
if panel then
img_add_fullscreen(colour_selected)
end

-- Face plate, and gauge markings --
img_add_fullscreen("gauge_faceplate.png")

-- Needle --	
img_needle = img_add("needle.png", 76, 236, 360, 40)

-- Mounting screws --
if screws_visible then 
img_add(screws_selected,58,58,44,44)
img_add(screws_selected,410,58,44,44)
img_add(screws_selected,410,410,44,44)
img_add(screws_selected,58,410,44,44)
end	

-- Bezel --
if bezel_ring then img_add_fullscreen(bezel_selected) 
end
		
-- Post Light --
if post_light_true then 
img_add("post_light_LH.png",0,0,160,160)
img_add("post_light_RH.png",352,0,160,160)
end	
	


-- Gauge operation --

-- Get data for needle --
function data(vsi)
	
	tgt_vsi = vsi
	
	-- Maths for VSI --

	if tgt_vsi >= 5000 then
	a = (11/1000 * (tgt_vsi - 5000) + 159)
	elseif tgt_vsi >= 4000 then
	a = (13/1000 * (tgt_vsi - 4000) + 146)
	elseif tgt_vsi >= 3000 then
	a = (16/1000 * (tgt_vsi - 3000) + 130)
	elseif tgt_vsi >= 2000 then
	a = (19/1000 * (tgt_vsi - 2000) + 111)
	elseif tgt_vsi >= 1000 then
	a = (37/1000 * (tgt_vsi - 1000) + 74)
	elseif tgt_vsi >= -1000 then
	a = (148/2000 * (tgt_vsi + 1000) - 74)
	elseif tgt_vsi >= -2000 then
	a = (37/1000 * (tgt_vsi + 2000) - 111)
	elseif tgt_vsi >= -3000 then
	a = (19/1000 * (tgt_vsi + 3000) - 130)
	elseif tgt_vsi >= -4000 then
	a = (16/1000 * (tgt_vsi + 4000) - 146)
	elseif tgt_vsi >= -5000 then
	a = (13/1000 * (tgt_vsi + 5000) - 159)
	elseif tgt_vsi >= -6000 then
	a = (11/1000 * (tgt_vsi + 6000) - 170)
	end
	
	end
	
	
-- Animate needle --
function timer_callback()
	
	-- Rotate VSI needle --
	rotate (img_needle, cur_vsi)
	cur_vsi = cur_vsi + ((a - cur_vsi) * factor)
			
end


-- timer start --
tmr_blink = timer_start(0, 50, timer_callback)


-- DataRef --
xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT", data)



