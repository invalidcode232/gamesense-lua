--[[
    Heartmarker

    Author: invalidcode#1337
]]

local interface = {
    enable = ui.new_checkbox("Visuals", "Other ESP", "Heartmarker")
}

local red_heart =
{
	{{r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 255, g = 132, b = 135, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 136, g = 0, b = 21, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 136, g = 0, b = 21, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 136, g = 0, b = 21, a = 255}, {r = 0, g = 0, b = 0, a = 255}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 136, g = 0, b = 21, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 136, g = 0, b = 21, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 237, g = 28, b = 36, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
}

local green_heart =
{
	{{r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 99, g = 228, b = 124, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 16, g = 92, b = 31, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 16, g = 92, b = 31, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 16, g = 92, b = 31, a = 255}, {r = 0, g = 0, b = 0, a = 255}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 16, g = 92, b = 31, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 16, g = 92, b = 31, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 31, g = 180, b = 61, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
}

local yellow_heart =
{
	{{r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 249, g = 253, b = 96, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 149, g = 153, b = 2, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 149, g = 153, b = 2, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 149, g = 153, b = 2, a = 255}, {r = 0, g = 0, b = 0, a = 255}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 149, g = 153, b = 2, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 149, g = 153, b = 2, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 220, g = 225, b = 4, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
}

local orange_heart =
{
	{{r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 249, g = 253, b = 96, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 193, g = 78, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 193, g = 78, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 193, g = 78, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 193, g = 78, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 193, g = 78, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 255, g = 127, b = 39, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
	{{r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 0, g = 0, b = 0, a = 255}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, {r = 255, g = 255, b = 255, a = 0}, },
}


local hearts = {}

local function draw_heart(pic, x, y, scale, alpha)
	for i = 1, #pic do
		for j = 1, #pic[i] do
			-- don't draw white background color
			if(pic[j][i].r + pic[j][i].g + pic[j][i].b == 255 * 3) then
				renderer.rectangle(x + (j-1) * scale, y + (i-1) * scale, scale, scale, pic[j][i].r, pic[j][i].g, pic[j][i].b, 0)
			else
				renderer.rectangle(x + (j-1) * scale, y + (i-1) * scale, scale, scale, pic[j][i].r, pic[j][i].g, pic[j][i].b, alpha)
			end			
		end
	end
end

local function on_hurt(e)
	local ent = client.userid_to_entindex(e.userid)
	local attacker = client.userid_to_entindex(e.attacker)

	if attacker ~= entity.get_local_player() or not entity.is_enemy(ent) then
		return
	end

	local hb = { entity.hitbox_position(ent, 3) }
	local dmg = e.dmg_health
	local curtime = globals.curtime()

	table.insert(hearts, {
		hitbox = hb,
		time = curtime,
		damage = dmg
	})
end

local function get_heart_color(dmg)
	local color = {}

	if dmg <= 15 then return green_heart end
	if dmg <= 30 then return yellow_heart end
	if dmg <= 60 then return orange_heart end
	if dmg > 60 then return red_heart end
end

local function heartmarker()
	if not ui.get(interface.enable) then return end

	local curtime = globals.curtime()

	for i = 1, #hearts do
		if hearts[i] == nil then return end

		local heart_time = hearts[i].time
		local damage = hearts[i].damage
		local x, y = renderer.world_to_screen(hearts[i].hitbox[1], hearts[i].hitbox[2], hearts[i].hitbox[3])

		if x == nil or y == nil then return end

		local y_add = (curtime - heart_time) * 30
		local alpha = math.floor(255 - 255 * (curtime - heart_time))

		draw_heart(get_heart_color(damage), x, y - y_add, 2, math.max(alpha, 0))

		if curtime > heart_time + 1 then
			table.remove(hearts, i)
		end
	end
end

client.set_event_callback("player_hurt", function(e)
	on_hurt(e)
end)

client.set_event_callback("paint", heartmarker)