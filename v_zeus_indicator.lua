-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_set_event_callback, entity_get_bounding_box, entity_get_classname, entity_get_local_player, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_is_alive, globals_curtime, math_abs, math_sin, renderer_text, ui_get, ui_new_checkbox, ui_new_color_picker, readfile, ipairs = client.set_event_callback, entity.get_bounding_box, entity.get_classname, entity.get_local_player, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.is_alive, globals.curtime, math.abs, math.sin, renderer.text, ui.get, ui.new_checkbox, ui.new_color_picker, readfile, ipairs

--[[
    Mjolnir zeus indicator 

    Author: invalidcode#1337
]]

-- Libs
local vector = require "vector"
local csgo_weapons = require "gamesense/csgo_weapons"
local images = require "gamesense/images"

-- UI elements
local interface = {
    enable = ui_new_checkbox("Visuals", "Other ESP", "Mjolnir zeus"),
    clr = ui_new_color_picker("Visuals", "Other ESP", "clr", 255, 255, 255, 255)
}

-- Get zeus icon
local zeus_icon = images.load_png(readfile("zeus_icon_small.png"))

-- Get weapon class name
local function get_wpn_class(ent)
    return entity_get_classname(entity_get_player_weapon(ent))
end

-- Get ent distance
local function get_ent_dist(ent_1, ent_2)
    local ent1_pos = vector(entity_get_prop(ent_1, "m_vecOrigin"))
    local ent2_pos = vector(entity_get_prop(ent_2, "m_vecOrigin"))

    local dist = ent1_pos:dist(ent2_pos)

    return dist
end

-- Get zeusable targets
local function is_zeusable(me, target)
    local max_zeus_range = csgo_weapons.weapon_taser.range

    local dist = get_ent_dist(me, target)

    return dist < max_zeus_range
end

local function draw_zeus_flag(ent, clr)
    local x1, y1, x2, y2, alpha_mult = entity_get_bounding_box(ent)

    if alpha_mult == 0 then return end
    if x1 == nil or y1 == nil or x2 == nil or y2 == nil then return end

    local x = (x1 + x2) / 2
    local y = y1 - 15

    local curtime = globals_curtime()
    local anim = math_sin(math_abs(-math.pi + (curtime * 2.5) % (math.pi * 2)))

    local alpha = anim * 80

    renderer_text(x, y, clr[1], clr[2], clr[3], 120 + alpha, "cb", nil, "MJOLNIR")
    zeus_icon:draw(x - 15, y - 50, 50, 50, 255, 255, 255, 120 + alpha, true, "f")
end

local function mjolnir_zeus()
    if not ui_get(interface.enable) then return end

    local me = entity_get_local_player()

    if not entity_is_alive(me) then return end

    local enemies = entity_get_players(true)
    local clr = { ui_get(interface.clr) }

    for i, v in ipairs(enemies) do
        if is_zeusable(me, v) then
            draw_zeus_flag(v, clr)
        end
    end
end

client_set_event_callback("paint", function ()
    mjolnir_zeus()
end)