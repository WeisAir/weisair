color_black			= "#000000;"
color_grey			= "#414141;"
color_amber			= "#f9b01e;"
color_yellow		= "yellow;"

font_SZ0			= "size:27px; halign:center; font:arimo_bold.ttf; color:"

style_00_amber		= font_SZ0 .. color_amber
style_00_grey1		= font_SZ0 .. color_grey

--img_bg				= img_add_fullscreen("background.png")

function press_six_fo()
	xpl_command("laminar/B738/push_button/fo_six_pack", 1)
	xpl_dataref_write("laminar/B738/push_button/fo_six_pack", "FLOAT", 1)
end
function release_six_fo()
	xpl_command("laminar/B738/push_button/fo_six_pack", 0)
	xpl_dataref_write("laminar/B738/push_button/fo_six_pack", "FLOAT", 0)
end

function press_six_capt()
	xpl_command("laminar/B738/push_button/capt_six_pack", 1)
	xpl_dataref_write("laminar/B738/push_button/capt_six_pack", "FLOAT", 1)
end
function release_six_capt()
	xpl_command("laminar/B738/push_button/capt_six_pack", 0)
	xpl_dataref_write("laminar/B738/push_button/capt_six_pack", "FLOAT", 0)
end

function reset_fire_warn_pressed()
	xpl_command("laminar/B738/push_button/fire_bell_light1",1)
end

function reset_fire_warn_release()
	xpl_command("laminar/B738/push_button/fire_bell_light1",0)
end

function click_MC()
	xpl_command("laminar/B738/push_button/master_caution1",1)
	xpl_dataref_write("laminar/B738/push_button/master_caution_accept1", "FLOAT", 1)
end

function release_MC()
	xpl_command("laminar/B738/push_button/master_caution1",0)
	xpl_dataref_write("laminar/B738/push_button/master_caution_accept1", "FLOAT", 0)
end

local col1 = 395
local col2 = 560

local row_spacing = 35

local row1 = 35
local row2 = row1 + row_spacing
local row3 = row2 + row_spacing

local row4 = 190
local row5 = row4 + row_spacing
local row6 = row5 + row_spacing


local textbox_width = 140
local textbox_height = 30

capt_fire_warn_dark		= img_add("fire_warn_dark.png",				30,  95,  133, 133)
capt_MC_dark			= img_add("mc_dark.png",					201,  95,  133, 133)
txt_drk_flt_cont		= txt_add("FLT CONT", style_00_grey1,		col1,	row1, textbox_width, textbox_height)
txt_drk_irs				= txt_add("IRS", style_00_grey1, 			col1,  	row2, textbox_width, textbox_height)
txt_drk_fuel			= txt_add("FUEL", style_00_grey1,			col1, 	row3, textbox_width, textbox_height)
txt_drk_elec			= txt_add("ELEC", style_00_grey1,			col2, 	row1, textbox_width, textbox_height)
txt_drk_apu				= txt_add("APU", style_00_grey1,			col2, 	row2, textbox_width, textbox_height)
txt_drk_ovht_det		= txt_add("OVHT/DET", style_00_grey1,		col2, 	row3, textbox_width, textbox_height)

capt_an_fire_warn_state	= img_add("fire_warn.png",					30,  95,  133, 133)
capt_an_MC_state		= img_add("mc_lit.png",						201,  95,  133, 133)
txt_flt_cont			= txt_add("FLT CONT", style_00_amber,		col1,	row1, textbox_width, textbox_height)
txt_irs					= txt_add("IRS", style_00_amber,			col1,  	row2, textbox_width, textbox_height)
txt_fuel				= txt_add("FUEL", style_00_amber,			col1, 	row3, textbox_width, textbox_height)
txt_elec				= txt_add("ELEC", style_00_amber,			col2, 	row1, textbox_width, textbox_height)
txt_apu					= txt_add("APU", style_00_amber,			col2, 	row2, textbox_width, textbox_height)
txt_ovht_det			= txt_add("OVHT/DET", style_00_amber,		col2, 	row3, textbox_width, textbox_height)

btn_six_pack_capt		= button_add(nil,nil,						363,  9, 369, 153, press_six_capt, release_six_capt)
btn_six_pack_fo			= button_add(nil,nil,						363,  164, 369, 153, press_six_fo, release_six_fo)
btn_fire_warn_capt		= button_add(nil,nil,						30,  95,  133, 133, reset_fire_warn_pressed, reset_fire_warn_release)
btn_MC_capt				= button_add(nil,nil,						201,  95,  133, 133, click_MC, release_MC)

txt_drk_anti_ice		= txt_add("ANTI-ICE", style_00_grey1,		col1, row4, textbox_width, textbox_height)
txt_drk_hyd				= txt_add("HYD", style_00_grey1,			col1, row5, textbox_width, textbox_height)
txt_drk_doors			= txt_add("DOORS", style_00_grey1,			col1, row6, textbox_width, textbox_height)
txt_drk_eng				= txt_add("ENG", style_00_grey1,			col2, row4, textbox_width, textbox_height)
txt_drk_overhead		= txt_add("OVERHEAD", style_00_grey1,		col2, row5, textbox_width, textbox_height)
txt_drk_air_cond		= txt_add("AIR COND", style_00_grey1,		col2, row6, textbox_width, textbox_height)

txt_anti_ice			= txt_add("ANTI-ICE", style_00_amber,		col1, row4, textbox_width, textbox_height)
txt_hyd					= txt_add("HYD", style_00_amber,			col1, row5, textbox_width, textbox_height)
txt_doors				= txt_add("DOORS", style_00_amber,			col1, row6, textbox_width, textbox_height)
txt_eng					= txt_add("ENG", style_00_amber,			col2, row4, textbox_width, textbox_height)
txt_overhead			= txt_add("OVERHEAD", style_00_amber,		col2, row5, textbox_width, textbox_height)
txt_air_cond			= txt_add("AIR COND", style_00_amber,		col2, row6, textbox_width, textbox_height)


function annun_state_status(FLT_CON_state,			-- param #01
							IRS_state,				-- param #02
							FUEL_state,				-- param #03
							ELEC_state,				-- param #04
							APU_state,				-- param #05
							OVHT_DET_state,			-- param #06
							ANTI_ICE_state,			-- param #07
							HYD_state,				-- param #08
							DOORS_state,			-- param #09
							ENG_state,				-- param #10
							OVERHEAD_state,			-- param #11
							AIR_COND_state,			-- param #12
							fire_warn_state,		-- param #13
							fire_warn_state2,		-- param #14
							MC_state)				-- param #15

		visible(txt_flt_cont,		(FLT_CON_state > 0))
		visible(txt_irs,			(IRS_state > 0))
		visible(txt_fuel,			(FUEL_state > 0))
		visible(txt_elec,			(ELEC_state > 0))
		visible(txt_apu,			(APU_state > 0))
		visible(txt_ovht_det,		(OVHT_DET_state > 0))
		visible(capt_an_fire_warn_state,(fire_warn_state > 0))
		visible(capt_an_MC_state,		(MC_state > 0))
	
		visible(txt_anti_ice,		(ANTI_ICE_state > 0))
		visible(txt_hyd,			(HYD_state > 0))
		visible(txt_doors,			(DOORS_state > 0))
		visible(txt_eng,			(ENG_state > 0))
		visible(txt_overhead,		(OVERHEAD_state > 0))
		visible(txt_air_cond,		(AIR_COND_state > 0))
		visible(fo_an_fire_warn_state,(fire_warn_state2 > 0))
		visible(fo_an_MC_state,		(MC_state > 0))
	
end

xpl_dataref_subscribe("laminar/B738/annunciator/six_pack_flt_cont", "FLOAT",			-- param #01
						"laminar/B738/annunciator/six_pack_irs", "FLOAT",				-- param #02
						"laminar/B738/annunciator/six_pack_fuel", "FLOAT",				-- param #03
						"laminar/B738/annunciator/six_pack_elec", "FLOAT",				-- param #04
						"laminar/B738/annunciator/six_pack_apu", "FLOAT",				-- param #05
						"laminar/B738/annunciator/six_pack_fire", "FLOAT",				-- param #06
						"laminar/B738/annunciator/six_pack_ice", "FLOAT",				-- param #07
						"laminar/B738/annunciator/six_pack_hyd", "FLOAT",				-- param #08
						"laminar/B738/annunciator/six_pack_doors", "FLOAT",				-- param #09
						"laminar/B738/annunciator/six_pack_eng", "FLOAT",				-- param #10
						"laminar/B738/annunciator/six_pack_overhead", "FLOAT",			-- param #11
						"laminar/B738/annunciator/six_pack_air_cond", "FLOAT",			-- param #12
						"laminar/B738/annunciator/fire_bell_annun", "FLOAT",			-- param #13
						"laminar/B738/annunciator/fire_bell_annun2", "FLOAT",			-- param #14
						"laminar/B738/annunciator/master_caution_light", "FLOAT",		-- param #15
						annun_state_status)