pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
	dot = {
	x = 64,
	y = 20,
	r= 4,
	vy = 0,
	grounded = false
	}

	g = 0.3
end

function _update60()
	dot_movement()
end

function _draw()
	cls(0)
	rectfill(0, 118, 128, 128, 7)
	circfill(dot.x, dot.y, dot.r, 7)
end

function dot_movement()
    if dot.grounded == false then
        dot.vy += g
        dot.y += dot.vy
    end
    if dot.y > 114 then
        dot.y = 114
        dot.vy = 0
        dot.grounded = true
    end
    if dot.grounded == true and btn(5) then
        dot.grounded = false
        dot.vy = -4
    end
end
