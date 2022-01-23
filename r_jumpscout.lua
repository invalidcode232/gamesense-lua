local strafe = ui.reference('MISC', 'Movement', 'Air strafe')

local function get_velocity(ent)
    local vx, vy, vz = entity.get_prop(ent, 'm_vecVelocity')

    return math.sqrt(vx ^ 2 + vy ^ 2)
end

client.set_event_callback('setup_command', function ()
    ui.set(strafe, get_velocity(entity.get_local_player()) > 5)
end)