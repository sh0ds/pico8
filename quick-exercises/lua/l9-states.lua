states = {}

states.title = {
    name = "title",
    update = function(input)
        if input == "x" then
            state = states.play
        end
    end
}

states.play = {
    name = "play",
    update = function(input)
        if input == "die" then
            state = states.over
        end
        if input == "p" then
            state = states.pause
        end
    end
}

states.over = {
    name = "over",
    update = function(input)
        if input == "x" then
            state = states.title
        end
    end
}

states.pause = {
    name = "pause",
    update = function(input)
        if input == "p" then
            state = states.play
        end
    end
}

inputs = {"none", "x", "none", "p", "p", "die", "x"}

state = states.title

for i = 1, #inputs do
    state.update(inputs[i])
    print("frame "..i..", state: "..state.name)
end
