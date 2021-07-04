--[[
    Knifebot improvements

    Author: invalidcode#1337
]]

local type=type;local setmetatable=setmetatable;local tostring=tostring;local a=math.pi;local b=math.min;local c=math.max;local d=math.deg;local e=math.rad;local f=math.sqrt;local g=math.sin;local h=math.cos;local i=math.atan;local j=math.acos;local k=math.fmod;local l={}l.__index=l;function Vector3(m,n,o)if type(m)~="number"then m=0.0 end;if type(n)~="number"then n=0.0 end;if type(o)~="number"then o=0.0 end;m=m or 0.0;n=n or 0.0;o=o or 0.0;return setmetatable({x=m,y=n,z=o},l)end;function l.__eq(p,q)return p.x==q.x and p.y==q.y and p.z==q.z end;function l.__unm(p)return Vector3(-p.x,-p.y,-p.z)end;function l.__add(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x+q.x,p.y+q.y,p.z+q.z)elseif r=="table"and s=="number"then return Vector3(p.x+q,p.y+q,p.z+q)elseif r=="number"and s=="table"then return Vector3(p+q.x,p+q.y,p+q.z)end end;function l.__sub(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x-q.x,p.y-q.y,p.z-q.z)elseif r=="table"and s=="number"then return Vector3(p.x-q,p.y-q,p.z-q)elseif r=="number"and s=="table"then return Vector3(p-q.x,p-q.y,p-q.z)end end;function l.__mul(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x*q.x,p.y*q.y,p.z*q.z)elseif r=="table"and s=="number"then return Vector3(p.x*q,p.y*q,p.z*q)elseif r=="number"and s=="table"then return Vector3(p*q.x,p*q.y,p*q.z)end end;function l.__div(p,q)local r=type(p)local s=type(q)if r=="table"and s=="table"then return Vector3(p.x/q.x,p.y/q.y,p.z/q.z)elseif r=="table"and s=="number"then return Vector3(p.x/q,p.y/q,p.z/q)elseif r=="number"and s=="table"then return Vector3(p/q.x,p/q.y,p/q.z)end end;function l.__tostring(p)return"( "..p.x..", "..p.y..", "..p.z.." )"end;function l:clear()self.x=0.0;self.y=0.0;self.z=0.0 end;function l:unpack()return self.x,self.y,self.z end;function l:length_2d_sqr()return self.x*self.x+self.y*self.y end;function l:length_sqr()return self.x*self.x+self.y*self.y+self.z*self.z end;function l:length_2d()return f(self:length_2d_sqr())end;function l:length()return f(self:length_sqr())end;function l:dot(t)return self.x*t.x+self.y*t.y+self.z*t.z end;function l:cross(t)return Vector3(self.y*t.z-self.z*t.y,self.z*t.x-self.x*t.z,self.x*t.y-self.y*t.x)end;function l:dist_to(t)return(t-self):length()end;function l:is_zero(u)u=u or 0.001;if self.x<u and self.x>-u and self.y<u and self.y>-u and self.z<u and self.z>-u then return true end;return false end;function l:normalize()local v=self:length()if v<=0.0 then return 0.0 end;self.x=self.x/v;self.y=self.y/v;self.z=self.z/v;return v end;function l:normalize_no_len()local v=self:length()if v<=0.0 then return end;self.x=self.x/v;self.y=self.y/v;self.z=self.z/v end;function l:normalized()local v=self:length()if v<=0.0 then return Vector3()end;return Vector3(self.x/v,self.y/v,self.z/v)end;function clamp(w,x,y)if w<x then return x elseif w>y then return y end;return w end;function normalize_angle(z)local A;local B;B=tostring(z)if B=="nan"or B=="inf"then return 0.0 end;if z>=-180.0 and z<=180.0 then return z end;A=k(k(z+360.0,360.0),360.0)if A>180.0 then A=A-360.0 end;return A end;function vector_to_angle(C)local v;local D;local E;v=C:length()if v>0.0 then D=d(i(-C.z,v))E=d(i(C.y,C.x))else if C.x>0.0 then D=270.0 else D=90.0 end;E=0.0 end;return Vector3(D,E,0.0)end;function angle_forward(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))return Vector3(G*I,G*H,-F)end;function angle_right(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))local J=g(e(z.z))local K=h(e(z.z))return Vector3(-1.0*J*F*I+-1.0*K*-H,-1.0*J*F*H+-1.0*K*I,-1.0*J*G)end;function angle_up(z)local F=g(e(z.x))local G=h(e(z.x))local H=g(e(z.y))local I=h(e(z.y))local J=g(e(z.z))local K=h(e(z.z))return Vector3(K*F*I+-J*-H,K*F*H+-J*I,K*G)end;function get_FOV(L,M,N)local O;local P;local Q;local R;P=angle_forward(L)Q=(N-M):normalized()R=j(P:dot(Q)/Q:length())return c(0.0,d(R))end

-- UI elements 
local interface = {
    switch = ui.new_checkbox("LUA", "B", "Enable knifebot improvements"),
    options = ui.new_multiselect("LUA", "B", "Knifebot options", { "Disable AA on knife target", "Force DT recharge on knife" }),
    min_dist_slider = ui.new_slider("LUA", "B", "Minimum distance to disable AA", 0, 1500, 600, true, nil, 1, { })
}

local function contains(table, value)
	if table == nil then
		return false
	end
	
    table = ui.get(table)
    for i=0, #table do
        if table[i] == value then
            return true
        end
    end
    return false
end

local function handle_visibility()
    ui.set_visible(interface.min_dist_slider, contains(interface.options, "Disable AA on knife target"))
end

handle_visibility()

local ref = {
    rage_enabled = { ui.reference("RAGE", "Aimbot", "Enabled") },
    aa_enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled")
}

local function get_wpn_class(ent)
    return entity.get_classname(entity.get_player_weapon(ent))
end

local function is_visible(ent)
    local me = entity.get_local_player()
    local l_x, l_y, l_z = entity.hitbox_position(me, 0)
    local e_x, e_y, e_z = entity.hitbox_position(ent, 0)

    local frac, ent = client.trace_line(me, l_x, l_y, l_z, e_x, e_y, e_z)

    return frac > 0.6
end

local function get_ent_dist(ent_1, ent_2)
    local ent1_pos = Vector3(entity.get_prop(ent_1, "m_vecOrigin"))
    local ent2_pos = Vector3(entity.get_prop(ent_2, "m_vecOrigin"))

    local dist = ent1_pos:dist_to(ent2_pos)

    return dist
end

-- Function to check if enemy is using "long ranged" weapon
local function is_long_weapon(ent)
    local ent_wpn = get_wpn_class(ent)

    return ent_wpn ~= "CKnife" and ent_wpn ~= "CC4" and ent_wpn ~= "CMolotovGrenade" and ent_wpn ~= "CSmokeGrenade" and ent_wpn ~= "CHEGrenade"
end

-- Check if local player is damageable by any long-range weapon
local function is_damageable()
    local enemies = entity.get_players(true)

    for i,v in ipairs(enemies) do
        if is_visible(v) and is_long_weapon(v) then return true end
    end

    return false
end

local function disable_aa_on_knife()
    if not ui.get(interface.switch) or not contains(interface.options, "Disable AA on knife target") then
        ui.set(ref.aa_enabled, true)
        return 
    end

    local me = entity.get_local_player()
    local enemies = entity.get_players(true)
    local should_disable_aa = false

    for i,v in ipairs(enemies) do
        if not is_damageable() and get_wpn_class(v) == "CKnife" and is_visible(v) then -- Check if enemy is using knife, visible, and not damageable
            local dist = get_ent_dist(me, v)

            if dist < ui.get(interface.min_dist_slider) then
                ui.set(ref.aa_enabled, false)
                should_disable_aa = true;
            end
        end
    end

    if should_disable_aa == false then
        ui.set(ref.aa_enabled, true)
    end
end

local function force_dt_recharge_knife()
    if not ui.get(interface.switch) or not contains(interface.options, "Force DT recharge on knife") then
        ui.set(ref.rage_enabled[1], true)
        return 
    end

    local me = entity.get_local_player()

    -- this is retarded but if it works it works
    ui.set(ref.rage_enabled[1], get_wpn_class(me) ~= "CKnife")
end

-- Callbacks
ui.set_callback(interface.options, handle_visibility)

client.set_event_callback("setup_command", function(e)
    disable_aa_on_knife()
    force_dt_recharge_knife()
end)