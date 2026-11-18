pico-8 cartridge // http://www.pico-8.com
version 43

__lua__

function _init()

    grid = {
        "1111111111111111",
        "1000000000000001",
        "1000000000000001",
        "1000000000000001",
        "1000000000000001",
        "1000000000000001",
        "1011110000000001",
        "1000000000000001",
        "1000000000000001",
        "1000000000000001",
        "1000000000111101",
        "1000000000000001",
        "1001111000000001",
        "1000000000000001",
        "1000000000000001",
        "1111111111111111"
    }

    dot = {
	-- radius
	r = 4,

	-- position
	x = 64,
	y = 20,

	-- movement per frame (in pixels)
	-- y goes down
	vx = 0,
	vy = 0,

	-- jump strength (more minus = higher)
	jump = -5,

	-- on the ground (only collision sets this)
	grounded = false,

	-- max speed (in pixels)
	top_speed = 2,

	-- slowdown while holding
	drag = 0.2,

	-- slowdown after letting go
	brake = 0.45,

    -- short hop check
    short_hop = false,

    -- coyote time
    c_max = 5
    }

    -- set coyote timer
    dot.coyote = dot.c_max

    -- speed added per frame
    dot.accel = dot.top_speed * dot.drag

    -- gravity per frame
    g = 0.3

end

function _update60()
	dot_movement()
end

function _draw()
	cls(0)
	draw_grid()
	circfill(dot.x, dot.y, dot.r, 7)
	print(dot.vy, 10, 10)
end

function dot_movement()

    -- 1. work out speed

    -- X
    local dir = 0
    if btn(0) then dir -= 1 end
    if btn(1) then dir += 1 end

    local d = dot.drag
    if dir == 0 then d = dot.brake end
    dot.vx -= dot.vx * d
    dot.vx += dir * dot.accel

    -- Y
    local grav = g
    if dot.vy > 0 then grav = g * 1.3 end
    if dot.vy < 0 and not(btn(5)) and dot.short_hop == false then
        dot.short_hop = true
        dot.vy /= 2
    end
    dot.vy += grav
    if dot.coyote > 0 and btnp(5) then
        dot.vy = dot.jump
        dot.coyote = 0
    end

    -- 2. move x
    local px = dot.x + dot.vx
    if circ_coll(px, dot.y, dot.r) then
        local step = sgn(dot.vx)
        while not circ_coll(dot.x + step, dot.y, dot.r) do
            dot.x += step
        end
        dot.vx = 0
    else
        dot.x = px
    end

    -- 3. move y
    local py = dot.y + dot.vy
    if circ_coll(dot.x, py, dot.r) then
        local step = sgn(dot.vy)
        while not circ_coll(dot.x, dot.y + step, dot.r) do
            dot.y += step
        end
        if dot.vy > 0 then
            dot.grounded = true
            dot.short_hop = false
            dot.coyote = dot.c_max
        end
        dot.vy = 0
    else
        dot.y = py
        dot.grounded = false
        dot.coyote -= 1
    end
end

function draw_grid()
    for i=1,#grid do
        for j=1,#grid[i] do
            if sub(grid[i], j, j) == "1" then
                local x = (j - 1) * 8
                local y = (i - 1) * 8
                rectfill(x, y, x+7, y+7)
            end
        end
    end
end

function is_wall(px, py)
    local gx = flr((px / 8) + 1)
    local gy = flr((py / 8) + 1)
    return (sub(grid[gy], gx, gx) == "1")
end

function circ_coll(x, y, r)
    return (is_wall(x + r, y)
    or is_wall(x - r, y)
    or is_wall(x, y + r)
    or is_wall(x, y - r))
end
