dataref("current_xcam", "SRS/X-Camera/integration/SelectedCamera") -- currently selected XCAMERA

static_xcam_group_cockpit = 0
static_xcam_group_external = 150
static_xcam_group_overhead = 300

function toggle_cockpit_cameras()
	
	if (math.abs(static_xcam_group_cockpit - current_xcam) > 149)
	then set("SRS/X-Camera/integration/SelectedCamera", static_xcam_group_cockpit)
	else command_once("SRS/X-Camera/Next_Camera") end
end
create_command("WeisAIR/generic/camera/toggle_cockpit_cameras", "toggle_cockpit_cameras", "toggle_cockpit_cameras()", "", "")

function toggle_external_cameras()
	
	if (math.abs(static_xcam_group_external - current_xcam) > 149)
	then set("SRS/X-Camera/integration/SelectedCamera", static_xcam_group_external)
	else command_once("SRS/X-Camera/Next_Camera") end
end
create_command("WeisAIR/generic/camera/toggle_external_cameras", "toggle_external_cameras", "toggle_external_cameras()", "", "")

function toggle_overhead_cameras()
	
	if (math.abs(static_xcam_group_overhead - current_xcam) > 149)
	then set("SRS/X-Camera/integration/SelectedCamera", static_xcam_group_overhead)
	else command_once("SRS/X-Camera/Next_Camera") end
end
create_command("WeisAIR/generic/camera/toggle_overhead_cameras", "toggle_overhead_cameras", "toggle_overhead_cameras()", "", "")