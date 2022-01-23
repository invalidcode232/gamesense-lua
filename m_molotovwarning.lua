--[[
    LUA NOT DONE, will fix later
]]

--region Dependencies
if not pcall(require, 'gamesense/ref_lib') then
    error('Missing reference library. Please download at #dependencies channel')
end

if not pcall(require, 'gamesense/nade_prediction') then
    error('Missing nade prediction library. Please download at https://gamesense.pub/forums/viewtopic.php?id=34582')
end

local vector = require "vector"
local ref = require 'gamesense/ref_lib'
local nade_prediction = require 'gamesense/nade_prediction'
local entity_lib = require "gamesense/entity"
--endregion

--region Menu
local menu = {
    switch = ui.new_checkbox('Visuals', 'Other ESP', 'Nade Warning')
}
--endregion

--region Main
local nade_p = nade_prediction:create()

local nades = {
    data = {},
    last_throw = 0,
    last_predict = 0,
}

function nades:get()
    for k, v in pairs(entity.get_players(false)) do
        local ent_wpn = entity.get_player_weapon(v)
        print(ent_wpn)
        local m_fThrowTime = entity.get_prop(ent_wpn, 'm_fThrowTime')

        if not m_fThrowTime or (entity.get_classname(ent_wpn) ~= 'CMolotovGrenade' and entity.get_classname(ent_wpn) ~= 'CIncendiaryGrenade')  then return end
    
        local is_throwing = m_fThrowTime > 0 and globals.curtime() - nades.last_throw > 0.5
        
        if is_throwing then
            nades.last_throw = globals.curtime()
    
            nade_p = nade_prediction.create()
    
            if nade_p:init(v) == false then 
                print(nade_p.error)
                return 
            end
        
            local predict_info = nade_p:predict()
        
            for k,v in pairs(predict_info.points) do
                if k > 1 then
                    if globals.curtime() - nades.last_predict > 0.5 then
                        table.insert(nades.data, {
                            end_pos = v.end_pos,
                            curtime = globals.curtime()
                        })
                    end
                    nades.last_predict = globals.curtime()
                end
            end
        end
    end
end

function nades:sanitize()
    for i = 1, #nades.data do
        local nade = nades.data[i]
        if globals.curtime() - nade.curtime > 3 then
            table.remove(nades.data, i)
        end
    end
end

function nades:draw()
    local screen_x, screen_y = client.screen_size()
    local me_pos = vector(entity.get_prop(entity.get_local_player(), "m_vecOrigin"))

    for i = 1, #nades.data do
        local nade = nades.data[i]
        local dist = me_pos:dist2d(nade.end_pos)

        if dist < 280 then
            renderer.text(screen_x / 2, 300, 255, 0, 0, 255, "c+", nil, '⚠️ MOLOTOV INCOMING: ' .. math.floor(dist))
        end
    end
end
--endregion

--region Callbacks
client.set_event_callback('setup_command', function ()
    nades:get()
    nades:sanitize()
end)
client.set_event_callback('paint', function ()
    nades:draw()
end)
--endregion
