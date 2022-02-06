local strafe = ui.reference('MISC', 'Movement', 'Air strafe')

local TAB, CONTAINER = 'MISC', 'Movement'
local threshold_slider = ui.new_slider(TAB, CONTAINER, 'JS velocity threshold', 2, 250, 5, true, 'u', 1, {})

local function get_velocity(ent)
    local vx, vy, vz = entity.get_prop(ent, 'm_vecVelocity')

    return math.sqrt(vx ^ 2 + vy ^ 2)
end

client.set_event_callback('setup_command', function ()
    ui.set(strafe, get_velocity(entity.get_local_player()) > ui.get(threshold_slider))
end)