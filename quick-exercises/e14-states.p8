pico-8 cartridge // http://www.pico-8.com
version 43
__lua__

blink = 0

text = {
    title = "paddle game",
    pressx = "press x to start",
    over = "game over",
    restart = "press x to restart",
    score = "score: "
}

title = {
name = "title",
update = function()
    blink += 1
    if btnp(5) then
        reset()
        state = play
    end
end,
draw = function()
    print(text.title, center(text.title), 50, 7)
    if blink % 60 < 30 then
        print(text.pressx, center(text.pressx), 78, 7)
    end
end
}

play = {
name = "play",
update = function()
    paddle_move()
    dot_update()
end,
draw = function()
    print(text.score..score,4,4,7)
    rectfill(paddle.x - paddle.width / 2, paddle.y, paddle.x + paddle.width / 2, paddle.y + paddle.thickness, 7)
    circfill(dot.x, dot.y, dot.r, 7)
end
}

over = {
name = "over",
update = function(input)
    blink += 1
    if btnp(5) then state = title end
end,
draw = function()
    print(text.over, center(text.over), 50, 7)
    print(text.score..score, center(text.score..score), 64, 7)
    if blink % 60 < 30 then
        print(text.restart, center(text.restart), 78, 7)
    end
end
}

function _init()
state = title
end

function _update60()
state.update()
end

function _draw()
cls(0)
state.draw()
end

function paddle_move()
    if btn(0) then paddle.x -= paddle.speed end
    if btn(1) then paddle.x += paddle.speed end
    paddle.x = mid(0+paddle.width/2,paddle.x,128-paddle.width/2)
end

function dot_update()
    dot.y += dot.speed
    if dot.y + dot.r + 1 >= paddle.y and dot.y <= paddle.y + paddle.thickness then
        if dot.x < paddle.x + paddle.width / 2 and dot.x > paddle.x - paddle.width / 2 then
            score += 1
            dot.x = mid(0+dot.r,rnd(128),128-dot.r)
            dot.y = 0 + dot.r
        end
    end
    if dot.y - dot.r > 128 then state = over end
end

function center(str)
    local width = 4 * #str - 1
    return 64 - width / 2
end

function reset()
    score = 0

    paddle = {
        x = 64,
        y= 118,
        width = 14,
        thickness = 3,
        speed = 1
    }

    dot = {
        x = 0,
        y = 0,
        r = 2,
        speed = 1
    }
    dot.x = mid(0+dot.r,rnd(128),128-dot.r)
    dot.y = 0 + dot.r
end
