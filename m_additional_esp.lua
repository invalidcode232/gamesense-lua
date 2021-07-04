--[[
    Additional ESP flags

    Author: invalidcode#1337
]]

-- UI elements
local interface = {
    flags_select = ui.new_multiselect("Visuals", "Other ESP", "Helper flags", { "High K/D", "Minus K/D", "Low ping", "High ping" }),

    dangerous_label = ui.new_label("Visuals", "Other ESP", "Dangerous flag"),
    dangerous_clr = ui.new_color_picker("Visuals", "Other ESP", "dangerous_clr", 245, 50, 37, 155),

    safe_label = ui.new_label("Visuals", "Other ESP", "Safe flag"),
    safe_clr = ui.new_color_picker("Visuals", "Other ESP", "safe_clr", 65, 245, 37, 255),
}

-- Global variables
local var = {
    enemies = { },
}

-- Setup global variables
local function setup_vars()
    -- Get enemies
    var.enemies = entity.get_players(true)

    -- Set everything to false
    for i, v in ipairs(var.enemies) do
        var.enemies[i] = {
            index = v,

            low_ping = false,
            high_ping = false,
            
            high_kd = false,
            low_kd = false,

            toe_aim = false,
        }
    end
end

local function contains(table, value)
	if table == nil then
		return false
	end
	
    table = ui.get(table)
    for i=0, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end


local function get_kd(kills, deaths)
    if kills == 0 then return 0 end

    return kills / deaths
end

local function draw_flag(ent, flag, clr, index)
    local x1, y1, x2, y2, alpha_mult = entity.get_bounding_box(ent)

    if alpha_mult == 0 then return end

    if x1 == nil or y1 == nil or x2 == nil or y2 == nil then return end

    local x = (x1 + x2) / 2
    local y = y1 - 15 - (8 * index)

    renderer.text(x, y, clr[1], clr[2], clr[3], clr[4], "c-", nil, flag)
end

-- Get enemy flags
local function get_flags()
    for i, v in ipairs(var.enemies) do
        local player_resource = entity.get_player_resource()

        local ping = entity.get_prop(player_resource, "m_iPing", var.enemies[i].index)
        local kills = entity.get_prop(player_resource, "m_iKills", var.enemies[i].index)
        local deaths = entity.get_prop(player_resource, "m_iDeaths", var.enemies[i].index)
        local kd = get_kd(kills, deaths)

        if ping < 15 and contains(interface.flags_select, "Low ping") then
            var.enemies[i].low_ping = true
        elseif ping > 60 and contains(interface.flags_select, "High ping") then
            var.enemies[i].high_ping = true
        end

        if kd > 1.5 and contains(interface.flags_select, "High K/D") then
            var.enemies[i].high_kd = true
        elseif kd < 1 and not (kills == 0 and deaths == 0) and contains(interface.flags_select, "Minus K/D") then
            var.enemies[i].low_kd = true
        end
    end
end

local function draw_flags()
    local safe_clr = { ui.get(interface.safe_clr) }
    local dangerous_clr = { ui.get(interface.dangerous_clr) }

    for i, v in ipairs(var.enemies) do
        local index = 0

        if var.enemies[i].high_ping then
            draw_flag(var.enemies[i].index, "HIGH PING", safe_clr, index)
            index = index + 1
        elseif var.enemies[i].low_ping then
            draw_flag(var.enemies[i].index, "LOW PING", dangerous_clr, index)
            index = index + 1
        end

        if var.enemies[i].high_kd then
            draw_flag(var.enemies[i].index, "HIGH KD", safe_clr, index)
            index = index + 1
        elseif var.enemies[i].low_kd then
            draw_flag(var.enemies[i].index, "MINUS KD", safe_clr, index)
            index = index + 1
        end
    end
end

client.set_event_callback("paint", function()
    setup_vars()
    get_flags()
    draw_flags()
end)