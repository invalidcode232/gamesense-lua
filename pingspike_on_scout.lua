--[[
    Ping spike on SSG-08

    Author: invalidcode#7810
]]

local ref_lib = require "gamesense/ref_lib"

client.set_event_callback("setup_command", function ()
    local wpn = entity.get_classname(entity.get_player_weapon(entity.get_local_player()))
    ui.set(ref_lib.misc.ping_spike[1], wpn == "CWeaponSSG08" and "Always on" or "Toggle")
end)