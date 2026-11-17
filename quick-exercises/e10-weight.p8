pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
dot = {
    x = 64,
    y = 64,
    r = 4,
    top_speed = 2.5,
    drag = 0.4,
    brake = 0.3,
    v = 0
}

dot.accel = dot.top_speed * dot.drag

function _update()
    move_dot()
end

function _draw()
    cls()
    circfill(dot.x, dot.y, dot.r)
end

function move_dot()
    local dir = 0
    if btn(0) then dir -= 1 end   
    if btn(1) then dir += 1 end   

    local d = dot.drag
    if dir == 0 then d = dot.brake end
    dot.v -= dot.v * d
    dot.v += dir * dot.accel    
    dot.x += dot.v                 
end
