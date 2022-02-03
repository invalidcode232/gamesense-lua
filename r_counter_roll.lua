--[[
    Counter roll

    Author: invalidcode#7810
    
    This is not meant to be a good nor consistent solution to roll antiaim, 
    but rather a quick and dirty solution to counter roll users.

    Keep in mind even with force body aim on gamesense still has a hard time baiming roll users.
    Eso pls fix :pray:
]]

local function table_contains(table, key)
    for index, value in pairs(table) do
        if value == key then return true, index end
    end
    return false, nil
end

local function get_velocity(ent)
    local vx, vy, vz = entity.get_prop(ent, 'm_vecVelocity')

    return math.sqrt(vx ^ 2 + vy ^ 2)
end

local ref = {
    plist = ui.reference('PLAYERS', 'Players', 'Player list'),
    reset = ui.reference('PLAYERS', 'Players', 'Reset all'),
}

local PLIST_TAB, PLIST_CONTAINER = 'PLAYERS', 'Adjustments'
local TAB, CONTAINER = 'LUA', 'B'   
local interface = {
    roll_switch = ui.new_checkbox(PLIST_TAB, PLIST_CONTAINER, 'Roll user'),

    options = ui.new_multiselect(TAB, CONTAINER, 'Anti roll options', { 'Baim', 'Safepoint' }),
}

local targets = {}

ui.set_callback(interface.roll_switch, function ()
    if ui.get(interface.roll_switch) then
        table.insert(targets, ui.get(ref.plist))
    else
        local bool, index = table_contains(targets, ui.get(ref.plist))
        if bool then
            table.remove(targets, index)
        end
    end
end)

ui.set_callback(ref.plist, function ()
    ui.set(interface.roll_switch, table_contains(targets, ui.get(ref.plist)) and true or false)
end)

ui.set_callback(ref.reset, function ()
    targets = {}
    ui.set(interface.roll_switch, false)
end)

client.set_event_callback('setup_command', function ()
    local players = entity.get_players(true)
    for _, player in pairs(players) do
        if not contains(targets, player) then
            return
        end

        local velocity = get_velocity(player)
        if table_contains(interface.options, 'Baim') then
            plist.set('Override prefer body aim', velocity < 5 and 'Force' or '-')
        end

        if table_contains(interface.options, 'Safepoint') then
            plist.set('Override safe point', velocity < 5 and 'Force' or '-')
        end
    end
end)

client.register_esp_flag('ROLL', 255, 0, 0, function ()
    local players = entity.get_players(true)

    for _, player in pairs(players) do
        if table_contains(targets, player) then
            return true
        end
    end

    return false
end)
