--[[
    Scoreboard changer

    Author: invalidcode#1337

    (yes i didn't know it has been made and posted on forums before good thing i haven't posted this tho :D)
]]

-- UI elements
local interface = {
    kills = ui.new_slider("LUA", "B", "Kill(s)", -1, 100, -1, true, nil, 1, { [-1] = "Off" }),
    assists = ui.new_slider("LUA", "B", "Assist(s)", -1, 100, -1, true, nil, 1, { [-1] = "Off" }),
    deaths = ui.new_slider("LUA", "B", "Death(s)", -1, 100, -1, true, nil, 1, { [-1] = "Off" }),
    score = ui.new_slider("LUA", "B", "Score", -1, 100, -1, true, nil, 1, { [-1] = "Off" }),
}

-- Global variables
local var = {
    desired_kills = -1,
    desired_assists = -1,
    desired_deaths = -1,
    desired_score = -1,
}

-- Change scoreboard values
local function change_scoreboard_values()
    local player_resource = entity.get_player_resource()
    local me = entity.get_local_player()

    if var.desired_kills ~= -1 then entity.set_prop(player_resource, "m_iKills", var.desired_kills, me) end
    if var.desired_assists ~= -1 then entity.set_prop(player_resource, "m_iAssists", var.desired_assists, me) end
    if var.desired_deaths ~= -1 then entity.set_prop(player_resource, "m_iDeaths", var.desired_deaths, me) end
    if var.desired_score ~= -1 then entity.set_prop(player_resource, "m_iScore", var.desired_score, me) end
end

local function update_variables()
    var.desired_kills = ui.get(interface.kills)
    var.desired_assists = ui.get(interface.assists)
    var.desired_deaths = ui.get(interface.deaths)
    var.desired_score = ui.get(interface.score)
end

local change_btn = ui.new_button("LUA", "B", "Change scoreboard values", update_variables)

client.set_event_callback("paint", change_scoreboard_values)
