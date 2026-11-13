grid = {
    "1111111111111111",
    "1000000000000001",
    "1000000000000001",
    "1000000000000001",
    "1000000000000001",
    "1000010001000001",
    "1000000000000001",
    "1000010000000001",
    "1000000000000001",
    "1000010000000001",
    "1000000000000001",
    "1000000000000001",
    "1000000001000001",
    "1000000000000001",
    "1000000000000001",
    "1111111111111111"
}

circ = {
    x= 70,
    y = 70,
    s = 0.5,
    r = 4
}

function _update()
    move_circ()
end

function _draw()
    cls(0)
    draw_grid()
    circfill(circ.x, circ.y, circ.r)
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

function move_circ()

    -- movement variables
    local mx, my = 0, 0

    -- store movement
    if btn(0) then
        mx = -circ.s end
    if btn(1) then
        mx = circ.s end
    if btn(2) then
        my = -circ.s end
    if btn(3) then
        my = circ.s end
    if mx == 0 and my == 0 then return end

    --calculate proposed circ position
    local px = circ.x + mx
    local py = circ.y + my

    if not(circ_coll(px, circ.y, circ.r)) then
        circ.x = px
    end

    if not(circ_coll(circ.x, py, circ.r)) then
        circ.y = py
    end
end

function circ_coll(x, y, r)
    return (is_wall(x + r, y)
    or is_wall(x - r, y)
    or is_wall(x, y + r)
    or is_wall(x, y - r))
end
