h = 24
t = 20
g = 2 * h / t^2
v = 2 * h / t

-- move first, then gravity: tops out at 25.2
y = 0
vy = -v

for i = 1, t do
    y = y + vy
    vy = vy + g
    print("frame "..i..", vy = "..vy..", y = "..y)
end

-- gravity first, then move: tops out at 22.8
y = 0
vy = -v

for i = 1, t do
    vy = vy + g
    y = y + vy
    print("frame "..i..", vy = "..vy..", y = "..y)
end
