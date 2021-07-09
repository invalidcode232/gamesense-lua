local ref = {
	enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
	pitch = ui.reference("AA", "Anti-aimbot angles", "pitch"),
	yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
	yaw = { ui.reference("AA", "Anti-aimbot angles", "Yaw") },
    fakeyawlimit = ui.reference("AA", "anti-aimbot angles", "Fake yaw limit"),
    fsbodyyaw = ui.reference("AA", "anti-aimbot angles", "Freestanding body yaw"),
    edgeyaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    maxprocticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
    fakeduck = ui.reference("RAGE", "Other", "Duck peek assist"),
    safepoint = ui.reference("RAGE", "Aimbot", "Force safe point"),
	forcebaim = ui.reference("RAGE", "Other", "Force body aim"),
	player_list = ui.reference("PLAYERS", "Players", "Player list"),
	reset_all = ui.reference("PLAYERS", "Players", "Reset all"),
	apply_all = ui.reference("PLAYERS", "Adjustments", "Apply to all"),
	load_cfg = ui.reference("Config", "Presets", "Load"),
	fl_limit = ui.reference("AA", "Fake lag", "Limit"),
	dt_limit = ui.reference("RAGE", "Other", "Double tap fake lag limit"),

	quickpeek = { ui.reference("RAGE", "Other", "Quick peek assist") },
	yawjitter = { ui.reference("AA", "Anti-aimbot angles", "Yaw jitter") },
	bodyyaw = { ui.reference("AA", "Anti-aimbot angles", "Body yaw") },
	freestand = { ui.reference("AA", "Anti-aimbot angles", "Freestanding") },
	os = { ui.reference("AA", "Other", "On shot anti-aim") },
	slow = { ui.reference("AA", "Other", "Slow motion") },
	dt = { ui.reference("RAGE", "Other", "Double tap") },
	ps = { ui.reference("RAGE", "Other", "Double tap") },
	fakelag = { ui.reference("AA", "Fake lag", "Enabled") },

    slidewalk = ui.reference("AA", "Other", "Leg movement")
}

client.set_event_callback("paint", function ()
    addition = 0

    renderer.text(100, 400 + addition, 255, 255, 255, 255, "c", nil, "Fake limit: " .. tostring(ui.get(ref.fakeyawlimit)))
    addition = addition + 20

    renderer.text(100, 400 + addition, 255, 255, 255, 255, "c", nil, "Body yaw mode: " .. tostring(ui.get(ref.bodyyaw[1])))
    addition = addition + 20

    renderer.text(100, 400 + addition, 255, 255, 255, 255, "c", nil, "Body yaw offset: " .. tostring(ui.get(ref.bodyyaw[2])))
    addition = addition + 20

    renderer.text(100, 400 + addition, 255, 255, 255, 255, "c", nil, "Yaw offset: " .. tostring(ui.get(ref.yaw[2])))
    addition = addition + 20

    renderer.text(100, 400 + addition, 255, 255, 255, 255, "c", nil, "Yaw jitter mode: " .. tostring(ui.get(ref.yawjitter[1])))
    addition = addition + 20

    renderer.text(100, 400 + addition, 255, 255, 255, 255, "c", nil, "Yaw jitter offset: " .. tostring(ui.get(ref.yawjitter[2])))
    addition = addition + 20
end)