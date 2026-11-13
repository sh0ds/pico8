fx = {
    flash = 0,
    pop = 0
}

score = {
    value = 0,
    color = 7
}

poke(0x5f5c, 255)

function _init()
end

function _update()
    tick_fx()
	if btnp(5) then
		fx.flash = 2
        fx.pop = 8
        score.value = score.value + 100
    end
end

function _draw()
    cls(0)
	draw_fx()
    draw_score()
end

function tick_fx()
    for key, value in pairs(fx) do
        if fx[key] > 0 then
            fx[key] = fx[key] - 1
        end
    end
end

function draw_fx()
	if fx.flash > 0 then
        cls(7)
    end
    if fx.pop > 0 then
        score.color = 9
    else
        score.color = 7
    end
end

function draw_score()
    print("Score: "..score.value, 60, 60, score.color)
end
