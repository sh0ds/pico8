pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
tick = 0

function _init()

end

function _update60()
    tick += 1
end

function _draw()
	cls(0)
	wavy_text("this is wavy text :)")
end

function wavy_text(str)
    local l = 4 * #str - 1
    local x = 64 - l / 2
    local y = 62
    for i=1, #str do
        print(sub(str, i, i), x, (y + sin(tick/30 + i/8) * 2), 7)
        x += 4
    end
end
