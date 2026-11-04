--[[
    GLOBAL VARIABLES
--]]

player = {
    x = 64,
    y = 64,
    speed = 30,
    sprite = 0,
    width = 8
}

framerate = 30

--[[
    MAIN LOOP
--]]

function _init()

end

function _update()
    move_player()
    if btnp(4) then sfx(0) end
end

function _draw()
    cls()
    spr(player.sprite, player.x, player.y)
end

--[[
    FUNCTIONS
--]]

function move_player()
    local step = player.speed/framerate

    if btn(0) then player.x -= step end
    if btn(1) then player.x += step end
    if btn(2) then player.y -= step end
    if btn(3) then player.y += step end

    player.x = mid(0, player.x, 128 - player.width)
    player.y = mid(0, player.y, 128 - player.width)
end
