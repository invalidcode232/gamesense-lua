-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_set_event_callback, entity_get_local_player, entity_get_player_resource, entity_set_prop, ui_get, ui_new_button, ui_new_slider = client.set_event_callback, entity.get_local_player, entity.get_player_resource, entity.set_prop, ui.get, ui.new_button, ui.new_slider

--[[
    Scoreboard changer

    Author: invalidcode#1337

    (yes i didn't know it has been made and posted on forums before good thing i haven't posted this tho :D)
]]

-- UI elements
local interface = {
    kills = ui_new_slider("LUA", "B", "Kill(s)", -1, 100, -1, true, nil, 1, { [-1] = "Off" }),
    assists = ui_new_slider("LUA", "B", "Assist(s)", -1, 100, -1, true, nil, 1, { [-1] = "Off" }),
    deaths = ui_new_slider("LUA", "B", "Death(s)", -1, 100, -1, true, nil, 1, { [-1] = "Off" }),
    score = ui_new_slider("LUA", "B", "Score", -1, 100, -1, true, nil, 1, { [-1] = "Off" }),
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
    local player_resource = entity_get_player_resource()
    local me = entity_get_local_player()

    if var.desired_kills ~= -1 then entity_set_prop(player_resource, "m_iKills", var.desired_kills, me) end
    if var.desired_assists ~= -1 then entity_set_prop(player_resource, "m_iAssists", var.desired_assists, me) end
    if var.desired_deaths ~= -1 then entity_set_prop(player_resource, "m_iDeaths", var.desired_deaths, me) end
    if var.desired_score ~= -1 then entity_set_prop(player_resource, "m_iScore", var.desired_score, me) end
end

local function update_variables()
    var.desired_kills = ui_get(interface.kills)
    var.desired_assists = ui_get(interface.assists)
    var.desired_deaths = ui_get(interface.deaths)
    var.desired_score = ui_get(interface.score)
end

local change_btn = ui_new_button("LUA", "B", "Change scoreboard values", update_variables)

client_set_event_callback("paint", change_scoreboard_values)
