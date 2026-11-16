local DOOR1, KEY3, BOSS = 0, 3, 7
n = 0

function set_flag(n, i)
    local mask = 1 << i
    return n | mask
end

function get_flag(n, i)
    local mask = 1 << i
    return (n & mask) ~= 0
end

function clear_flag(n, i)
    local mask = 1 << i
    return n & ~mask
end

n = set_flag(n, DOOR1)
n = set_flag(n, KEY3)
n = set_flag(n, BOSS)

print(n)

n = set_flag(n, BOSS)

print(n)

print(get_flag(n, KEY3))

n = clear_flag(n, KEY3)

print(get_flag(n, KEY3))
