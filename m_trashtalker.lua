--[[
    Trashtalker

    Author: invalidcode#7810
]]

local function contains(table, value, key)
    for i, v in pairs(table) do
        if key then
            if v[key] == value then
                return true, i
            end
        else
            print('xdf')
            if v == value then
                return true, i
            end
        end
    end

    return false
end

local PLIST_TAB, PLIST_CONTAINER = 'PLAYERS', 'Adjustments'
local TAB, CONTAINER = 'LUA', 'B'

local ref = {
    plist = ui.reference('PLAYERS', 'Players', 'Player list'),
    reset = ui.reference('PLAYERS', 'Players', 'Reset all'),
}

local interface = {
    mode_select = ui.new_multiselect(PLIST_TAB, PLIST_CONTAINER, 'Trashtalk modes', { 'Replybot', 'Killsay' }),

    _ = ui.new_label(TAB, CONTAINER, 'Advanced Trashtalker'),
    delay_slider = ui.new_slider(TAB, CONTAINER, 'Delay', 0, 25, 0, true, 's', 0.5, {}),
    reply_hc_slider = ui.new_slider(TAB, CONTAINER, 'Trashtalk chance', 0, 10, 10, true, '%', 10, {}),
    reply_select = ui.new_combobox(TAB, CONTAINER, 'Replybot mode', { 'Clear chat', 'Trashtalk' }),
}

local SPAM = '﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽ ﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽ ﷽﷽ ﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽ ﷽﷽ ﷽﷽﷽ ﷽﷽ ﷽﷽﷽ ﷽ ﷽﷽ ﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽ ﷽﷽ ﷽﷽﷽ ﷽﷽'
local KILLSAYS = { '1', 'hs', 'owned' }
local DEATHSAYS = { 'nice baim', 'luckboosted', 'lucky', 'baim', 'kys' }
local NAMES = { 'bot', 'dog', 'nn', 'retard', 'faggot' }

local targets = {}

local function handle_plist()
    local bool, index = contains(targets, ui.get(ref.plist), 'ent')

    if not bool then
        table.insert(targets, {
            ent = ui.get(ref.plist),
            mode = ui.get(interface.mode_select),
        })
    else
        targets[index].mode = ui.get(interface.mode_select)
    end
end

ui.set_callback(interface.mode_select, handle_plist)
ui.set_callback(ref.plist, function ()
    local bool, index = contains(targets, ui.get(ref.plist), 'ent')

    if bool then
        ui.set(interface.mode_select, targets[index].mode)
    else
        ui.set(interface.mode_select, {})
    end
end)
ui.set_callback(ref.reset, function ()
    targets = {}
    ui.set(interface.mode_select, {})
end)

local function generate_replybot()
    local prefix = {'yo buddy', 'yo pal', 'listen here,', 'basically', 'hahaha', 'yeah well', 'yeah ok however', 'k', 'lol', 'dude', 'ok but', 'ok', 'lmaooo ok', 'lol ok', 'funny uh', 'uh ok', 'tahts funny', 'that is funny', 'that\'s funny', 'uh welp ok', 'ok but like', 'k but', 'kk', ':)'}
    local middle = {'ask i did not', 'name one person who asked', 'didnt ask', 'dont recall asking', 'i didnt ask', 'i really dont remember asking', 'xd who ask', 'did not ask', 'times i asked = 0', 'when i asked = never', 'me asking didnt happen', 'never asked ', 'i never asked', 'did i ask'}
    local suffix = {'so yeah', 'do you understand', 'so shut up', ' bro', ' nn', ' nn boi', ' dude', ' lmao', ' lol', ' lmfao', ' haha', ' tho', ' though lol', ' tho lmao', ' jajajja', 'xaxaxa', 'xddd', ', lol', 'lmao', 'XDD', 'ezzzzz', 'mi amigo', 'xd jajaja', 'hahaha', ':/', 'so plz be quiet', 'so stfu', 'so shush'}

    local random = math.random(1, 10)

    local reply = middle[math.random(1, #middle)]

    if random > 5 then
        reply = prefix[math.random(1, #prefix)] .. ' ' .. reply
    end

    if random > 8 then
        reply = reply .. ' ' .. suffix[math.random(1, #suffix)]
    end

    return reply
end

local function generate_killsay()
    local random = math.random(1, 10)

    local killsay = KILLSAYS[math.random(1, #KILLSAYS)]

    if random > 6 then
        killsay = killsay .. ' ' .. NAMES[math.random(1, #NAMES)]
    end

    return killsay
end

local function generate_deathsay()
    local random = math.random(1, 10)

    local deathsay = DEATHSAYS[math.random(1, #DEATHSAYS)]

    if random > 6 then
        deathsay = deathsay .. ' ' .. NAMES[math.random(1, #NAMES)]
    end

    return deathsay
end

client.set_event_callback('player_chat', function (event)
    local ent = event.entity

    local bool, index = contains(targets, ent, 'ent')

    if not bool then
        return
    end

    local mode = targets[index].mode
    if not contains(mode, 'Replybot') then
        return
    end

    local chance = ui.get(interface.reply_hc_slider) * 10
    if math.random(1, 100) > chance then
        return
    end

    client.delay_call(ui.get(interface.delay_slider) * 0.5, function ()
        client.exec(string.format('say "%s"', ui.get(interface.reply_select) == 'Clear chat' and SPAM or generate_replybot()))
    end)
end)

-- Killsay
client.set_event_callback('player_death', function (event)
    local userid = client.userid_to_entindex(event.userid)
    local attacker = client.userid_to_entindex(event.attacker)
    local me = entity.get_local_player()

    if me ~= attacker then
        return
    end

    local bool, index = contains(targets, userid, 'ent')

    if not bool then
        return
    end

    local mode = targets[index].mode
    if not contains(mode, 'Killsay') then
        return
    end

    local chance = ui.get(interface.reply_hc_slider) * 10
    if math.random(1, 100) > chance then
        return
    end

    client.delay_call(ui.get(interface.delay_slider) * 0.5, function ()
        client.exec(string.format('say "%s"', generate_killsay()))
    end)
end)

-- Deathsay
client.set_event_callback('player_death', function (event)
    local userid = client.userid_to_entindex(event.userid)
    local attacker = client.userid_to_entindex(event.attacker)
    local me = entity.get_local_player()

    if me ~= userid then
        return
    end

    local bool, index = contains(targets, attacker, 'ent')

    if not bool then
        return
    end

    local mode = targets[index].mode
    if not contains(mode, 'Deathsay') then
        return
    end

    local chance = ui.get(interface.reply_hc_slider) * 10
    if math.random(1, 100) > chance then
        return
    end

    client.delay_call(ui.get(interface.delay_slider) * 0.5, function ()
        client.exec(string.format('say "%s"', generate_deathsay()))
    end)
end)
