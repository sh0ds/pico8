particles = {
    {life = 10},
    {life = 5},
    {life = 8},
    {life = 7},
    {life = 2},
    {life = 4},
    {life = 9},
    {life = 3},
    {life = 6},
    {life = 1}
}

for i=1,10 do
    for j=#particles,1,-1 do
        particles[j].life = particles[j].life - 1

        if particles[j].life <= 0 then
            table.remove(particles, j)
        end
    end

    print("frame "..i)

    for g=1,#particles do
        print(particles[g].life)
    end
end
