fx = {
    ["flash"] = 0,
    ["pop"] = 0
}

frames = 12

function tick_fx()
    for key, value in pairs(fx) do
        if fx[key] > 0 then
            print(key)
            fx[key] = fx[key] - 1
        end
    end
end
for i=0,frames do
    print("frame "..i)
    if i == 2 then
        fx["flash"] = 2
    end
    if i == 5 then
        fx["pop"] = 8
    end
    tick_fx()
end
