--[[
    Config Statistics

    Author: invalidcode#7810
]]

local table_gen = require 'gamesense/table_gen' or error 'table_gen not found'

local DB_KEY = 'config_data'
local config_name = false

-- Check if our database exists
if not database.read(DB_KEY) then
    database.write(DB_KEY, {})
end

local function get_config_name()
    local config = table.pack( ui.reference( 'CONFIG', 'Presets', 'Presets' ) )
    
    return ui.get(config[3])
end

local function is_bot(ent)
    local player_resource = entity.get_player_resource()

    -- shit method but works
    return entity.get_prop(player_resource, 'm_iPing', ent) == 0
end

local function print_all_statistics()
    local config_db = database.read(DB_KEY)
    
    local config_headers = { 'Config name', 'Kills', 'Deaths', 'KD', 'Hits', 'Misses', 'Accuracy (%)' }
    local config_data = {}

    for k, v in pairs(config_db) do
        table.insert(config_data, { k, v[#v].kills, v[#v].deaths, v[#v].kd, v[#v].hits, v[#v].misses, v[#v].accuracy })
    end

    local config_table_out = table_gen(config_data, config_headers, {
        style = 'Unicode (Single Line)'
    })

    client.log('All config statistics: \n' .. config_table_out)
end

local function print_config_statistics(custom_cfg)
    local config_db = database.read(DB_KEY)
    -- local config_name = get_config_name()

    local config_name = custom_cfg or get_config_name()

    if not config_name then
        return
    end
    
    local update_headers = { 'Updated on', 'Kills', 'Deaths', 'KD', 'Hits', 'Misses', 'Accuracy (%)' }
    local update_data = {}

    if not config_db[config_name] then
        client.log('Config not yet logged.')
        return 
    end

    for i = 1, #config_db[config_name] do
        table.insert(update_data, {config_db[config_name][i].date, config_db[config_name][i].kills, config_db[config_name][i].deaths, config_db[config_name][i].kd, config_db[config_name][i].hits, config_db[config_name][i].misses, config_db[config_name][i].accuracy})
    end
    
    local update_table_out = table_gen(update_data, update_headers, {
        style = 'Unicode (Single Line)'
    })
    
    client.log('Current config statistics (Config name: ' .. config_name .. ')\n' .. update_table_out)
end

local save_btn = ui.reference('CONFIG', 'Presets', 'Save')

local interface = {
    ind_switch = ui.new_checkbox('Config', 'Lua', 'Display indicator'),
    all_btn = ui.new_button('Config', 'Lua', 'Get all statistics', print_all_statistics),
    config_btn = ui.new_button('Config', 'Lua', 'Get current config stats', function ()
        print_config_statistics()
    end),
    reset_btn  = ui.new_button('Config', 'Lua', 'Reset all statistics', function ()
        database.write(DB_KEY, {})
    end)
}

-- Our data for this round
local data = {}

client.set_event_callback('round_end', function(event)
    -- If config name is still not stored by now, we will use the current config selection
    if not config_name then
        config_name = get_config_name()
    end

    local config_db = database.read(DB_KEY) 

    local cur_kills = data.kills or 0
    local cur_hits = data.hits or 0
    local cur_misses = data.misses or 0
    local cur_death = data.death or 0

    if config_db[config_name] then
        local cur_data = config_db[config_name][#config_db[config_name] or 1]

        if not cur_data then
            table.insert(config_db[config_name], {
                date = client.unix_time(),
                kills = 0,
                deaths = 0,
                kd = 0,
                hits = 0,
                misses = 0,
                accuracy = 0,
            })
        end

        local date = cur_data.date or client.unix_time()

        local kills = (cur_data.kills or 0) + cur_kills
        local deaths = (cur_data.deaths or 0) + cur_death
        local hits = (cur_data.hits or 0) + cur_hits
        local misses = (cur_data.misses or 0) + cur_misses

        local accuracy = math.floor(((hits * 100) / (hits + misses)) * 10) / 10
        local kd = deaths == 0 and kills or math.floor((kills / deaths) * 100) / 100
        
        -- Add the new data to our config data
        cur_data.date = date

        cur_data.kills = kills
        cur_data.deaths = deaths
        cur_data.kd = kd
        cur_data.hits = hits
        cur_data.misses = misses
        cur_data.accuracy = accuracy
    else -- If we haven't had any data for this config yet
        config_db[config_name] = {}

        table.insert(config_db[config_name], {
            date = client.unix_time(),

            kills = cur_kills,
            deaths = cur_death,
            kd = cur_death == 0 and cur_kills or math.floor((cur_kills / cur_death) * 100) / 100,
            hits = cur_hits,
            misses = cur_misses,
            accuracy = math.floor(((cur_hits * 100) / (cur_hits + cur_misses)) * 10) / 10,
        })
    end

    database.write(DB_KEY, config_db)
    
    data = {}
end)

client.set_event_callback('player_death', function(event)
    local attacker = client.userid_to_entindex(event.attacker)
    local victim = client.userid_to_entindex(event.userid)
    local me = entity.get_local_player()

    if attacker == me and not is_bot(victim) then
        data.kills = (data.kills or 0) + 1
    end

    if victim == me and attacker ~= me then
        data.death = 1
    end
end)

client.set_event_callback('aim_miss', function (event)
    if is_bot(event.target) then
        return
    end

    data.misses = (data.misses or 0) + 1
end)

client.set_event_callback('player_hurt', function (event)
    local attacker = client.userid_to_entindex(event.attacker)
    local victim = client.userid_to_entindex(event.userid)

    if attacker == entity.get_local_player() and not is_bot(victim) then
        data.hits = (data.hits or 0) + 1
    end
end)

ui.set_callback(save_btn, function ()
    -- local config_name = get_config_name()
    if not config_name then
        return
    end

    local config_db = database.read(DB_KEY)

    if not config_db[config_name] then
        config_db[config_name] = {}
    end

    -- Insert a new row in our config data when the config is saved
    table.insert(config_db[config_name], {
        date = client.unix_time(),

        kills = 0,
        deaths = 0,
        kd = 0,
        hits = 0,
        misses = 0,
        accuracy = 0,
    })
end)

client.set_event_callback('console_input', function (text)
    -- Get the first word of the input before the space
    local command = text:match('^(%S+)')

    if command ~= './showstats' then
        return
    end

    -- Get all the words after './showstats'
    local args = text:match('^./showstats%s+(.+)')

    if not args then
        print_all_statistics()
    else
        print_config_statistics(args)
    end
end)

client.set_event_callback('pre_config_load', function ()
    config_name = get_config_name()
end)

client.set_event_callback('paint_ui', function ()
    if not ui.is_menu_open() or not ui.get(interface.ind_switch) then
        return
    end

    local menu_pos = { ui.menu_position() }
    local menu_size = { ui.menu_size() }

    local x, y = menu_pos[1] + menu_size[1] + 20, menu_pos[2]

    local config_db = database.read(DB_KEY)

    local width = 250
    local height = 50

    for k, v in pairs(config_db) do
        height = height + 15
    end

    -- renderer.rectangle(x, y, width, 1, 255, 255, 255, 255)
    renderer.blur(x, y + 1, width, height)
    renderer.rectangle(x, y + 20, width, 1, 255, 255, 255, 255)

    x = x + 10
    y = y + 5

    renderer.text(x, y, 255, 255, 255, 255, '', nil, 'Config statistics')

    local margin_top = 20

    renderer.text(x, y + margin_top, 255, 255, 255, 255, '', nil, 'Config')

    renderer.text(x + 50, y + margin_top, 255, 255, 255, 255, '', nil, 'Kill')
    renderer.text(x + 85, y + margin_top, 255, 255, 255, 255, '', nil, 'Death')
    renderer.text(x + 120, y + margin_top, 255, 255, 255, 255, '', nil, 'K/D')
    renderer.text(x + 145, y + margin_top, 255, 255, 255, 255, '', nil, 'Hit')
    renderer.text(x + 170, y + margin_top, 255, 255, 255, 255, '', nil, 'Miss')
    renderer.text(x + 200, y + margin_top, 255, 255, 255, 255, '', nil, 'Acc (%)')
    
    margin_top = margin_top + 15

    for k, v in pairs(config_db) do
        local config_name = k
        local config_data = v

        renderer.text(x, y + margin_top, 255, 255, 255, 255, '', nil, config_name)

        renderer.text(x + 50, y + margin_top, 255, 255, 255, 255, '', nil, config_data[#config_data].kills)
        renderer.text(x + 85, y + margin_top, 255, 255, 255, 255, '', nil, config_data[#config_data].deaths)
        renderer.text(x + 120, y + margin_top, 255, 255, 255, 255, '', nil, config_data[#config_data].kd)
        renderer.text(x + 145, y + margin_top, 255, 255, 255, 255, '', nil, config_data[#config_data].hits)
        renderer.text(x + 170, y + margin_top, 255, 255, 255, 255, '', nil, config_data[#config_data].misses)
        renderer.text(x + 200, y + margin_top, 255, 255, 255, 255, '', nil, config_data[#config_data].accuracy .. '%')

        margin_top = margin_top + 15
    end
end)
