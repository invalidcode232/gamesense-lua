-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_set_event_callback, client_trace_line, entity_get_classname, entity_get_local_player, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_hitbox_position, ui_get, ui_new_checkbox, ui_new_multiselect, ui_new_slider, ui_reference, ui_set_visible, ipairs, ui_set, ui_set_callback = client.set_event_callback, client.trace_line, entity.get_classname, entity.get_local_player, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.hitbox_position, ui.get, ui.new_checkbox, ui.new_multiselect, ui.new_slider, ui.reference, ui.set_visible, ipairs, ui.set, ui.set_callback

--[[
    Knifebot improvements

    Author: invalidcode#1337
]]

local vector = require "vector"

-- UI elements 
local interface = {
    switch = ui_new_checkbox("LUA", "B", "Enable knifebot improvements"),
    options = ui_new_multiselect("LUA", "B", "Knifebot options", { "Legit AA on knife target", "Force DT recharge on knife" }),
    min_dist_slider = ui_new_slider("LUA", "B", "Minimum distance to legit AA", 0, 1500, 600, true, nil, 1, { })
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

local function handle_visibility()
    ui_set_visible(interface.min_dist_slider, contains(interface.options, "Legit AA on knife target"))
end

handle_visibility()

local ref = {
    rage_enabled = { ui_reference("RAGE", "Aimbot", "Enabled") },

    pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw_base = ui_reference("AA", "Anti-aimbot angles", "Yaw base"),
    yaw = { ui_reference("AA", "Anti-aimbot angles", "Yaw") }
}

local function get_wpn_class(ent)
    return entity_get_classname(entity_get_player_weapon(ent))
end

local function is_visible(ent)
    local me = entity_get_local_player()
    local l_x, l_y, l_z = entity_hitbox_position(me, 0)
    local e_x, e_y, e_z = entity_hitbox_position(ent, 0)

    local frac, ent = client_trace_line(me, l_x, l_y, l_z, e_x, e_y, e_z)

    return frac > 0.6
end

local function get_ent_dist(ent_1, ent_2)
    local ent1_pos = vector(entity_get_prop(ent_1, "m_vecOrigin"))
    local ent2_pos = vector(entity_get_prop(ent_2, "m_vecOrigin"))

    local dist = ent1_pos:dist(ent2_pos)

    return dist
end

-- Function to check if enemy is using "long ranged" weapon
local function is_long_weapon(ent)
    local ent_wpn = get_wpn_class(ent)

    return ent_wpn ~= "CKnife" and ent_wpn ~= "CC4" and ent_wpn ~= "CMolotovGrenade" and ent_wpn ~= "CSmokeGrenade" and ent_wpn ~= "CHEGrenade"
end

-- Check if local player is damageable by any long-range weapon
local function is_damageable()
    local enemies = entity_get_players(true)

    for i,v in ipairs(enemies) do
        if is_visible(v) and is_long_weapon(v) then return true end
    end

    return false
end

local cache = {
    should_restore_cache = false,

    pitch = "down",
    yaw_base = "at targets",
    yaw = 180,
    yaw_slider = 0,
}

local function set_aa(pitch, yaw_base, yaw, yaw_slider)
    ui_set(ref.pitch, pitch)
    ui_set(ref.yaw_base, yaw_base)
    ui_set(ref.yaw[1], yaw)
    ui_set(ref.yaw[2], yaw_slider)
end

local function legit_aa_on_knife()
    if not ui_get(interface.switch) or not contains(interface.options, "Legit AA on knife target") then
        set_aa(cache.pitch, cache.yaw_base, cache.yaw, cache.yaw_slider)
        -- ui_set(ref.aa_enabled, true)
        return 
    end

    local me = entity_get_local_player()
    local enemies = entity_get_players(true)
    local should_legit_aa = false

    for i,v in ipairs(enemies) do
        if not is_damageable() and get_wpn_class(v) == "CKnife" and is_visible(v) then -- Check if enemy is using knife, visible, and not damageable
            local dist = get_ent_dist(me, v)

            if dist < ui_get(interface.min_dist_slider) then
                set_aa("off", "at targets", "off", 0)
                should_legit_aa = true
                cache.should_restore_cache = true
            end
        end
    end

    if should_legit_aa == false then
        if cache.should_restore_cache then
            set_aa(cache.pitch, cache.yaw_base, cache.yaw, cache.yaw_slider)
            cache.should_restore_cache = false
        else
            cache.pitch = ui_get(ref.pitch)
            cache.yaw_base = ui_get(ref.yaw_base)
            cache.yaw = ui_get(ref.yaw[1])
            cache.yaw_slider = ui_get(ref.yaw[2])
        end
    end
end

local function force_dt_recharge_knife()
    if not ui_get(interface.switch) or not contains(interface.options, "Force DT recharge on knife") then
        ui_set(ref.rage_enabled[1], true)
        return 
    end

    local me = entity_get_local_player()

    -- this is retarded but if it works it works
    ui_set(ref.rage_enabled[1], get_wpn_class(me) ~= "CKnife")
end

-- Callbacks
ui_set_callback(interface.options, handle_visibility)

client_set_event_callback("setup_command", function(e)
    legit_aa_on_knife()
    force_dt_recharge_knife()
end)