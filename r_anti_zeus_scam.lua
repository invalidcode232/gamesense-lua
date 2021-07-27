-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_exec, client_set_event_callback, client_trace_line, entity_get_classname, entity_get_local_player, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_hitbox_position, ui_get, ui_new_checkbox, ui_new_multiselect, ipairs = client.exec, client.set_event_callback, client.trace_line, entity.get_classname, entity.get_local_player, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.hitbox_position, ui.get, ui.new_checkbox, ui.new_multiselect, ipairs

--[[
    Anti zeus scam 

    Author: invalidcode#1337
]]

-- Libs
local vector = require "vector"
local csgo_weapons = require "gamesense/csgo_weapons"
local images = require "gamesense/images"

local interface = {
    enable = ui_new_checkbox("LUA", "B", "Anti zeus scam"),
    smart_switch = ui_new_checkbox("LUA", "B", "Disable if zeusable"),
    whitelist_wpn = ui_new_multiselect("LUA", "B", "Whitelisted weapons", { "SSG 08", "R8 Revolver", "AWP" }),
}

local function contains(table, value)
	if table == nil then
		return false
	end
	
    table = ui_get(table)
    for i=0, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end

local function get_wpn_name(ent)
    local wpn_ent = entity_get_player_weapon(ent)
    local wpn = csgo_weapons(wpn_ent)

    return wpn.name
end

local function get_wpn_class(ent)
    return entity_get_classname(entity_get_player_weapon(ent))
end

-- Get max weapon dist 
local function get_max_wpn_dist(wpn_ent)
    local weapon = csgo_weapons(wpn_ent)

    return weapon.range
end

-- Get ent distance
local function get_ent_dist(ent_1, ent_2)
    local ent1_pos = vector(entity_get_prop(ent_1, "m_vecOrigin"))
    local ent2_pos = vector(entity_get_prop(ent_2, "m_vecOrigin"))

    local dist = ent1_pos:dist(ent2_pos)

    return dist
end

-- Check if target is within zeus range
local function is_zeusable(target)
    local me = entity_get_local_player()

    if get_wpn_class(me) ~= "CWeaponTaser" then return false end

    local wpn_ent = entity_get_player_weapon(me)
    local max_zeus_range = get_max_wpn_dist(wpn_ent)

    local dist = get_ent_dist(me, target)

    return dist < max_zeus_range
end

-- Check if ent is visible
local function is_visible(ent)
    local me = entity_get_local_player()

    local l_x, l_y, l_z = entity_hitbox_position(me, 0)
    local e_x, e_y, e_z = entity_hitbox_position(ent, 0)

    local frac, ent = client_trace_line(me, l_x, l_y, l_z, e_x, e_y, e_z)

    return frac > 0.7
end

-- Function to check if enemy is using "long ranged" weapon
local function is_long_weapon(ent)
    local ent_wpn = get_wpn_class(ent)

    return ent_wpn ~= "CWeaponTaser" and ent_wpn ~= "CKnife" and ent_wpn ~= "CC4" and ent_wpn ~= "CMolotovGrenade" and ent_wpn ~= "CSmokeGrenade" and ent_wpn ~= "CHEGrenade" and ent_wpn ~= "CIncendiaryGrenade" and ent_wpn ~= "CFlashbang" and ent_wpn ~= "CDecoyGrenade"
end

-- Check if local player is damageable by any long-range weapon
local function is_damageable()
    local enemies = entity_get_players(true)

    for i,v in ipairs(enemies) do
        if is_visible(v) and is_long_weapon(v) and not contains(interface.whitelist_wpn, get_wpn_name(v)) then return true end
    end

    return false
end

-- Check if we can zeus any enemies 
local function can_zeus_enemy()
    local me = entity_get_local_player()
    local enemies = entity_get_players(true)

    for i, v in ipairs(enemies) do
        if is_zeusable(me, v) then
            return true
        end
    end

    return false
end

local function anti_zeus_scam()
    local me = entity_get_local_player()

    -- print(get_wpn_name(me))

    if ui_get(interface.smart_switch) and can_zeus_enemy() then return end

    if get_wpn_class(me) == "CWeaponTaser" and is_damageable() then
        client_exec("slot1")
    end
end

client_set_event_callback("setup_command", function()
    anti_zeus_scam()
end)