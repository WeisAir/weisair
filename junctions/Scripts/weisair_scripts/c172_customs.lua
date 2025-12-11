function next_manipulator()

	-- nothing happens, this is just to trigger an action in the connected AirManager panel

end
create_command("WeisAIR/common/next_manipulator", "next_manipulator", "next_manipulator()", "", "")


function prev_manipulator()

	-- nothing happens, this is just to trigger an action in the connected AirManager panel

end
create_command("WeisAIR/common/prev_manipulator", "prev_manipulator", "prev_manipulator()", "", "")


function dual_enc_outerUp()

	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("WeisAIR/common/next_manipulator")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("sim/GPS/g430n1_chapter_up")
	
	end

end
create_command("WeisAIR/common/dual_enc_outerUp", "dual_enc_outerUp", "dual_enc_outerUp()", "", "")


function dual_enc_outerDn()

	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("WeisAIR/common/prev_manipulator")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("sim/GPS/g430n1_chapter_dn")
	
	end

end
create_command("WeisAIR/common/dual_enc_outerDn", "dual_enc_outerDn", "dual_enc_outerDn()", "", "")

function dual_enc_pushButton()

	dataref("FN_BUTTON", "bgood/xsaitekpanels/fnbutton/status", "readonly")
	
	if FN_BUTTON == 1 then 
	
		command_once("WeisAIR/common/prev_manipulator")
	
	end
	
	if FN_BUTTON == 0 then
	
		 command_once("sim/GPS/g430n1_chapter_dn")
	
	end

end
create_command("WeisAIR/common/dual_enc_pushButton", "dual_enc_pushButton", "dual_enc_pushButton()", "", "")