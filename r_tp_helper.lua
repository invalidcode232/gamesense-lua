--[[
    Teleport Helper

    Author: invalidcode#7810
]] 

local csgo_weapons = require 'gamesense/csgo_weapons'

-- Utils
local function contains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end

    return false
end

local function extrapolate_position(xpos, ypos, zpos, ticks, ent)
    local x, y, z = entity.get_prop(ent, 'm_vecVelocity')
    for i = 0, ticks do
        xpos = xpos + (x * globals.tickinterval())
        ypos = ypos + (y * globals.tickinterval())
        zpos = zpos + (z * globals.tickinterval())
    end

    return xpos, ypos, zpos
end

local function is_in_air(ent)
    return bit.band(entity.get_prop(ent, 'm_fFlags'), 1) ~= 1
end

-- References
local ref = {
    dt = {ui.reference('RAGE', 'OTHER', 'Double tap')}
}

-- Menu
local TAB, CONTAINER = 'AA', 'Other'
local WEAPONS = { 'SSG 08', 'AWP', 'R8 Revolver' }
local interface = {
    switch = ui.new_checkbox(TAB, CONTAINER, 'Teleport helper'),
    tp_hk = ui.new_hotkey(TAB, CONTAINER, 'tp_hk', true),
    tp_weapon_select = ui.new_multiselect(TAB, CONTAINER, 'Teleport weapons', WEAPONS),
    dmg_slider = ui.new_slider(TAB, CONTAINER, 'Minimum teleport damage', 1, 100, 1, true, nil, 1),
    ticks_slider = ui.new_slider(TAB, CONTAINER, 'Predicted ticks', 0, 30, 0, true, nil, 1),
    disable_air_switch = ui.new_checkbox(TAB, CONTAINER, 'Disable teleport in air'),
}

local function handle_visibility()
    local enabled = ui.get(interface.switch)

    ui.set_visible(interface.disable_air_switch, enabled)
    ui.set_visible(interface.dmg_slider, enabled)
    ui.set_visible(interface.ticks_slider, enabled)
end

ui.set_callback(interface.switch, handle_visibility)

local HITGROUP = 4 -- The hitgroup we want to trace
local teleporting = false -- Needed for indicator
local clr = {0, 255, 0, 255} -- Indicator color

-- Main
local function tp_helper()
    local me = entity.get_local_player()
    
    ui.set(ref.dt[1], true)
    teleporting = false

    if not ui.get(interface.switch) or (ui.get(interface.disable_air_switch) and not is_in_air(me)) or not ui.get(interface.tp_hk) then
        return
    end

    -- Check if we're holding a weapon we want to teleport
    local me_wpn = csgo_weapons(entity.get_player_weapon(me))
    local wpn_name = me_wpn.name
    if not contains(WEAPONS, wpn_name) then
        return
    end
    
    -- Extrapolate player pos
    local ticks = ui.get(interface.ticks_slider)
    local me_pos = {entity.hitbox_position(me, HITGROUP)}
    local x, y, z = extrapolate_position(me_pos[1], me_pos[2], me_pos[3], ticks, me)

    -- Damage calculation
    local dmg = ui.get(interface.dmg_slider)
    local players = entity.get_players(true)

    for _, player in pairs(players) do
        -- Trace bullet from enemy eye pos to our hitbox
        local eye_pos = {entity.hitbox_position(player, 0)}

        local _, b_dmg = client.trace_bullet(player, eye_pos[1], eye_pos[2], eye_pos[3], x, y, z, true)
        b_dmg = client.scale_damage(me, HITGROUP, b_dmg)

        if b_dmg > dmg then
            ui.set(ref.dt[1], false)
            teleporting = true
            clr = {0, 255, 0, 255}
            break
        elseif b_dmg > 0 then
            teleporting = true
            clr = {255, 0, 0, 255}
        else
            teleporting = false
        end
    end
end

-- Indicator
local function tp_indicator()
    local me = entity.get_local_player()

    if not entity.is_alive(me) then
        return
    end

    if teleporting then
        renderer.indicator(clr[1], clr[2], clr[3], clr[4], 'TELEPORTING')
    elseif ui.get(interface.tp_hk) then
        renderer.indicator(255, 255, 255, 255, 'TP')
    end
end

-- Callbacks
client.set_event_callback('setup_command', tp_helper)
client.set_event_callback('paint', tp_indicator)
