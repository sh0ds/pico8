# Pocket exercises: 10 to 15 minutes on any PC

Small exercises I do on my work PC in spare minutes, in the browser (lua.org demo and pico-8-edu.com). My solutions are in this folder: `lua/` for the plain Lua ones, a `.p8` cart for each PICO-8 one (`e3-flash.p8`, `e4-particles.p8`, `e5-shake.p8`, `e5b-random-shake.p8`, `e7-grid.p8`, and `e7-grid-movement.p8`, my own variant of E7). Load a cart with `load quick-exercises/e4-particles.p8`.

For free moments away from home, on a PC where you can't install anything. These aren't plan steps and don't replace a sitting: they make the next sitting faster. Every one practises something a real step needs, and the step is named so you know why.

**Two tools, both in the browser:**
- **[lua.org/demo.html](https://www.lua.org/demo.html):** plain Lua 5.4, text output only. For the L exercises.
- **[pico-8-edu.com](https://www.pico-8-edu.com):** PICO-8 Education Edition, free. For the E exercises. Press Esc to switch between the code editor and running, and type `run` to start.

**Assume the tab can lose everything.** Every exercise starts from an empty cart, uses only shapes (`circfill`, `rectfill`, `print`), no sprites or map, and fits on one screen of code. If you want to keep one, select all the code (Ctrl+A, Ctrl+C) and paste it into a note.

Hints only, as always. Each one has a **done when**: stop there, even if you want to keep going.

---

## Lua (lua.org demo)

**L1 · Borders (P3 step 3, items).** Make a table with five items, set the third one to `nil`, and print `#t`. Then do the same with `del`-style removal: shift everything after it down by one, by hand. *Done when* you can say in one sentence why PICO-8 has `del` and why `t[3] = nil` is a trap in a list.

**L2 · Your own `mid` (P2, P3).** Write `clamp(lo, x, hi)` without `math.min` or `math.max`. Test it with x below, inside and above the range, and with lo and hi swapped. *Done when* you know what PICO-8's `mid` does if lo is bigger than hi (it's in the manual).

**L3 · Countdown timers (P3 step 3, P5).** A table `fx = {flash = 0, pop = 0}`. Write `tick_fx()` that counts every value above 0 down by one. Simulate 12 "frames" with a `for` loop: set `flash = 2` at frame 3 and `pop = 8` at frame 5, and print both each frame. *Done when* the printout shows exactly 2 frames of flash and 8 of pop.

**L4 · Removing while looping (P5 step 3).** A list of 10 particles, each `{life = n}` with n from 1 to 10. Each "frame", subtract 1 from every life and remove the ones at 0, using `table.remove` inside a numeric `for` loop going up. Print how many are left after each frame. Something's wrong: find it. *Done when* you can remove dead particles in a loop without skipping any (two different fixes exist).

**L5 · Digits without strings (B4, the Game Boy score).** Write `digits(n)` that returns a table of digits for n = 4071, using only `%` and `//` (integer division). No `tostring`. *Done when* it works for 0 and for 100, too. On the Game Boy there's no division at all, so think about how you'd do it with only subtraction.

**L6 · Eight flags in one number (P8 step 3, saves).** Lua 5.4 has `&`, `|` and `<<`. Write `set_flag(n, i)`, `get_flag(n, i)` and `clear_flag(n, i)` for bits 0 to 7. Pack "door 1 open, key 3 taken, boss beaten" into one number and print it. *Done when* setting the same flag twice doesn't change the number.

---

## PICO-8 (Education Edition)

**E1 · A dot that stays home (P2, P3).** A `circfill` that moves with the arrow keys at a speed that's a variable, and never leaves the 128×128 screen. *Done when* it stops exactly at every edge, with the whole circle visible.

**E2 · One clock for everything (game feel, part 1).** A `tick` counter. Use it to make some text blink (on longer than it's off) and a circle cycle through three colours, changing every 4 frames. *Done when* both run off the same `tick` and nothing else counts time.

**E3 · A moment of colour (P3 step 3, game feel part 1).** Press ❎: the screen flashes white for 2 frames, and a score goes up by 100 and turns yellow for 8 frames. *Done when* holding ❎ down doesn't flash every frame. Which function is the difference?

**E4 · Particles (P5 step 3, game feel part 2).** Press ❎: 20 particles burst from the middle in random directions, slow down or fall, and shrink until they're gone. Use `cos(a)` and `sin(a)` with `a = rnd(1)`. *Done when* the list is empty again a second later (print `#parts` to check).

**E5 · Shake without a shaky HUD (P5 step 3, game feel part 3).** Press ❎ to shake the screen: an offset that's multiplied by something below 1 every frame. Draw a "score" in the corner that never shakes. *Done when* the shake dies out by itself and the score stays perfectly still.

**E6 · A wall, checked first (P3 step 2).** E1's dot and one `rectfill` wall in the middle. Before moving, check where you'd end up, X and Y separately. *Done when* you can slide along the wall while pushing diagonally into it, instead of sticking.

**E7 · A map without the map editor (P3 steps 1 and 2).** A 16×16 table of 0s and 1s (write it as strings like `"1111111111111111"` and read them with `sub`), drawn as 8×8 `rectfill` squares. The dot can't enter a 1. *Done when* you can turn a pixel position into a grid position and back, and the dot collides at all four corners.

**E8 · Wavy text (P6 step 2, game feel part 7).** Print a word one letter at a time, each letter bobbing with `sin(tick/30 + i/8)`, centred on the screen. *Done when* the wave runs through the word instead of all letters moving together. What does changing the 8 do?

**E9 · A coin that spins (P5 step 3, game feel part 5).** An `ovalfill` whose width follows `abs(cos(tick/40))`, centred on one spot. *Done when* it looks like it's turning, not like it's squashing to one side.

---

**Where they lead:** L1, L3, E3 and E7 are the warm-up for P3, your current step. L4, E4, E5 and E9 are P5. L6 is P8. L5 waits for the Game Boy.

---

## Your solutions

Your own final versions, as you wrote them, with one line on what each one taught. Read them back before the step they lead to.

### L1 · Borders (2026-11-10)

Shifting everything after the removed item down by one. No `if` needed: reading one past the end gives `nil`, so the last step clears the last slot by itself.

```lua
t = {1, 2, 3, 4, 5}
del = 3
for i=del,#t do
    t[i] = t[i+1]
end
print(#t)
```

Learned: compare positions (`i ~= #t`), not values. And `del` is a PICO-8 function, so don't use it as a variable name in a cart.

### L3 · Countdown timers (2026-11-10)

```lua
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
    tick_fx(12)
end
```

Learned: write through `fx[key]`, because `value` is only a copy. Test before you subtract, and only subtract above 0. One call per frame, with the frame loop outside. Leftovers: the unused `12`, and `0,frames` runs 13 times.

### E3 · A moment of colour (2026-11-10)

```lua
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
```

Learned: `_update` runs before `_draw`, so tick first, then set. Otherwise one frame is lost before anything is drawn. `poke(0x5f5c, 255)` switches off `btnp`'s auto-repeat (your own find; give it a comment).

### E7 · A map without the map editor (2026-11-11)

```lua
grid = {
    "1111111111111111",
    "1000000000000001",
    "1000000000000001",
    "1000000000000001",
    "1000000000000001",
    "1000010000000001",
    "1000010000000001",
    "1000010000000001",
    "1000010000000001",
    "1000010000000001",
    "1000000000000001",
    "1000000000000001",
    "1000000000000001",
    "1000000000000001",
    "1000000000000001",
    "1111111111111111"
}

dot = {
    x= 70,
    y = 70,
    s = 1,
    r = 2
}

function _update()
    move_dot()
end

function _draw()
    cls(0)
    draw_grid()
    circfill(dot.x, dot.y, dot.r)
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

function move_dot()

    -- movement variables
    local mx, my = 0, 0

    -- store movement
    if btn(0) then 
        mx = -dot.s end
    if btn(1) then 
        mx = dot.s end
    if btn(2) then 
        my = -dot.s end
    if btn(3) then 
        my = dot.s end
    if mx == 0 and my == 0 then return end

    --calculate proposed dot position
    local px = dot.x + mx
    local py = dot.y + my

    if not(circ_coll(px, dot.y, dot.r)) then
        dot.x = px
    end

    if not(circ_coll(dot.x, py, dot.r)) then
        dot.y = py
    end
end

function circ_coll(x, y, r)
    return (is_wall(x + r, y)
    or is_wall(x - r, y)
    or is_wall(x, y + r)
    or is_wall(x, y - r))
end
```

Learned: a list keeps its order, `pairs` over names doesn't. `sub(s, i, i)` returns one character, and it's a string (`"1"`, not `1`). Grid to pixel is `(j - 1) * 8`, and pixel to grid is `flr(px / 8) + 1`. Check before moving, X and Y separately, and check the edges of the dot, not its centre. Don't name a table `map`. For P3: `mget` and `fget` replace `sub` and `== "1"`, and PICO-8's map starts at 0, so drop the `+ 1`. Open question for P5: why is diagonal movement faster?

**Your variant** (`e7-grid-movement.p8`): the same code with scattered pillars instead of one wall, the dot renamed `circ`, speed 0.5 and radius 4. Careful: `circ` is a PICO-8 drawing function, the same trap as `del` and `map`, so a table with that name hides it.

### L4 · Removing while looping (2026-11-12)

```lua
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
```

Learned: `table.remove` shifts only the items after it, and walking backwards you've already visited those. A `for` counts up unless you give a third number (`-1`). Changing the loop variable inside a `for` does nothing. Test with dead items next to each other (`{1, 1, 1, 2, 2, 3}`).

### E4 · Particles (2026-11-13)

```lua
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
```

Learned: name the fields (`{x = x}`), not `[1]`, and no `self` inside `{ }`. PICO-8 has no `table` library: use `add` and `deli`. Angle and speed are separate: `cos(angle) * speed`. Angles go from 0 to 1 for a full turn, and `sin` is flipped. Gravity changes `dy`, not `y`: adding to `y` is wind, adding to `dy` makes arcs.

### E5 · Shake without a shaky HUD (2026-11-13)

```lua
parts = {}

shake = 0
tick = 0

poke(0x5f5c, 255)

function _update()
    if btnp(5) then
        shake = 6
        for i=1,20 do
            local angle = rnd(1)
            local speed = (rnd(1.5) + 0.5)
            local dx = (cos(angle) * speed)
            local dy = (sin(angle) * speed)
            local life = rnd(15) + 10
            add_part(64, 64, dx, dy, life)
        end
    end
    if tick < 2 then
        tick = tick + 1
    else
        tick = 0
    end
    if shake > 0 then
        shake = shake - 1
    end
    tick_parts()
end

function _draw()
    cls(0)
    if shake > 0 then
        if tick == 0 then
            camera(shake, 0)
        elseif tick == 2 then
            camera(-shake, 0)
        else
            camera(0,0)
        end
    end
    draw_parts()
    camera(0,0)
    draw_hud()
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

function draw_parts()
    color(7)
    for i=1,#parts do
        local radius = 2 * parts[i].life / parts[i].s_life
        if radius >= 1 then    
            circfill(parts[i].x, parts[i].y, radius)
        else
            pset(parts[i].x, parts[i].y)
        end
    end
end

function draw_hud()
    if shake > 0 then
        print("parts: "..#parts,2,2,3)
    else
        print("parts: "..#parts,2,2,7)
    end
end
```

Learned: `_draw` runs once per frame, so a loop inside it plays the whole shake in one frame. Spread it over frames, and count down in `_update`, because drawing only reads the state. `camera` is a setting that stays until the next call: shake, draw the world, `camera()`, draw the HUD. Your own pattern (left, still, right) with `tick` cycling 0, 1, 2. Still to try: `rnd(shake) - shake / 2` and `shake * 0.8`.

### E5b · Random shake (2026-11-13)

The same cart with the random version. Only `_update` and `_draw` changed:

```lua
function _update()
    if btnp(5) then
        shake = 6
        for i=1,20 do
            local angle = rnd(1)
            local speed = (rnd(1.5) + 0.5)
            local dx = (cos(angle) * speed)
            local dy = (sin(angle) * speed)
            local life = rnd(15) + 10
            add_part(64, 64, dx, dy, life)
        end
    end
    if shake > 0 then
        if shake < 0.3 then
            shake = 0
        else
            shake = shake * 0.8
        end
    end
    tick_parts()
end

function _draw()
    cls(0)
    
    local ox = rnd(shake) - shake/2
    local oy = rnd(shake) - shake/2
    camera(ox, oy)

    draw_parts()
    camera(0,0)
    draw_hud()
end
```

Learned: `shake` is the strength and fades in `_update` by multiplying, so it hits hard and calms down smoothly. The offset is worked out from it in `_draw`, separately for x and y. `rnd(0)` is 0, so no `if` is needed. The `tick = 0` at the top is left over.
