top_speed = 2
drag = 0.1
accel = top_speed * drag
v = 0

for i=1,60 do
    v = v + accel
    v = v - (v * drag)
    print("frame "..i..", v: "..v)
end
