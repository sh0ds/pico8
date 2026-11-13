parts = {}

poke(0x5f5c, 255)

function _update()
    if btnp(5) then
        for i=1,20 do
            local angle = rnd(1)
            local speed = (rnd(1.5) + 0.5)
            local dx = (cos(angle) * speed)
            local dy = (sin(angle) * speed)
            local life = rnd(15) + 10
            add_part(64, 64, dx, dy, life)
        end
    end
    tick_parts()
end

function _draw()
    cls(0)
    draw_parts()
end

function add_part(x, y, dx, dy, life)
    add(parts, {
        x = x, 
        y = y, 
        dx = dx, 
        dy = dy, 
        life = life,
        s_life = life
    })
end

function tick_parts()
    for i=#parts,1,-1 do
        parts[i].x = parts[i].x + parts[i].dx
        parts[i].dy = parts[i].dy + 0.15
        parts[i].y = parts[i].y + parts[i].dy
        parts[i].life = parts[i].life - 1

        if parts[i].life <= 0 then
            deli(parts, i)
        end
    end
end

function print_parts()
    for i=1,#parts do
    print("particle "..i)
    print(parts[i].x..", "..parts[i].y..", "..
            parts[i].dx..", "..parts[i].dy..", "..parts[i].life)
    end
end

function draw_parts()
    for i=1,#parts do
        local radius = 2 * parts[i].life / parts[i].s_life
        if radius >= 1 then    
            circfill(parts[i].x, parts[i].y, radius)
        else
            pset(parts[i].x, parts[i].y)
        end
    end
end
