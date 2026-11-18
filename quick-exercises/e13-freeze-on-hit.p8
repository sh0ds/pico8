pico-8 cartridge // http://www.pico-8.com
version 43
__lua__

function _init()
    dot = {
        x = 32,
        y = 64,
        r = 4,
        top_speed = 2,
        drag = 0.25,
        brake = 0.45,
        vx = 0
    }

    dot2 = {
        x = 96,
        y = 64,
        r = 4,
        vx = 0,
        drag = 0.25
    }

    dot.accel = dot.top_speed * dot.drag

    freeze = 5
    fc = 0
end

function _update60()
    if fc <= 0 then
        move_dot()
    else
        fc -= 1
    end
    wrap(dot)
    wrap(dot2)
end

function _draw()
    cls()
    circfill(dot.x, dot.y, dot.r, 7)
    circfill(dot2.x, dot2.y, dot2.r, 7)
end

function move_dot()
    -- X
    local dir = 0
    if btn(0) then dir -= 1 end
    if btn(1) then dir += 1 end

    local d = dot.drag
    if dir == 0 then d = dot.brake end
    dot.vx -= dot.vx * d
    dot.vx += dir * dot.accel
    dot2.vx -= dot2.vx * dot2.drag

    dot.x += dot.vx
    dot2.x += dot2.vx

    ds = sgn(dot.x - dot2.x)

    if circ_circ_coll(dot, dot2) then
        dot.vx = ds * 3
        dot2.vx = -ds * 6   -- push away
        fc = freeze
    end
end

function wrap(c)
    if c.x - c.r > 128 then c.x = 0 end
    if c.x + c.r < 0 then c.x = 128 end
end

function circ_circ_coll(c1, c2)
    local dx,dy,rsum = c2.x-c1.x, c2.y-c1.y, c1.r+c2.r
    return dx*dx+dy*dy <= rsum*rsum
  end
