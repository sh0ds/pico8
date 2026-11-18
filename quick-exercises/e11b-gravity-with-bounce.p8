pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
	dot = {
        x = 40,
        y = 20,
        r= 4,
        vy = 0,
        grounded = false,
        bounce = 0.4
	}

    dot2 = {
        x = 64,
        y = 20,
        r= 4,
        vy = 0,
        grounded = false,
        bounce = 0.6
    }

    dot3 = {
        x = 88,
        y = 20,
        r= 4,
        vy = 0,
        grounded = false,
        bounce = 0.8
    }

	g = 0.3
end

function _update60()
	dot_movement(dot)
    dot_movement(dot2)
    dot_movement(dot3)
end

function _draw()
    cls(0)
    rectfill(0, 118, 128, 128, 7)
    circfill(dot.x, dot.y, dot.r, 7)
    circfill(dot2.x, dot2.y, dot2.r, 7)
    circfill(dot3.x, dot3.y, dot3.r, 7)
    print(dot.bounce, dot.x-5, dot.y-12, 7)
    print(dot2.bounce, dot2.x-5, dot2.y-12, 7)
    print(dot3.bounce, dot3.x-5, dot3.y-12, 7)
end

function dot_movement(d)
    if d.grounded == false then
        d.vy += g
        d.y += d.vy
    end
    if d.y > 114 then
        d.y = 114
        d.vy = -d.vy * d.bounce

        if abs(d.vy) < 0.5 then
            d.vy = 0
            d.grounded = true
        end
    end
    if d.grounded == true and btn(5) then
        d.grounded = false
        d.vy = -7
    end
end
