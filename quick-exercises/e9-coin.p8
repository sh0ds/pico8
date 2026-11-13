pico-8 cartridge // http://www.pico-8.com
version 43
__lua__

tick = 0

function _init()

end

function _update()
    tick = tick + 1
    coin()
end

function _draw()
	cls(0)
	print("tick: "..tick, 2, 2)
	print("width: "..w,2,10)
	ovalfill(x0, y0, x1, y1, 10)
end

function coin()
    w = max(1,abs(cos(tick / 40)) * 8)
    x0 = 64 - (w / 2)
    x1 = 64 + (w / 2)
    y0 = (sin(tick / 40) * 2) + 60
    y1 = (sin(tick / 40) * 2) + 68
end
