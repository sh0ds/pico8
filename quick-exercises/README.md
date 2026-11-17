# Quick exercises

Small exercises I do on my work PC when I have 10 to 15 free minutes. I can't install anything there, so it all happens in the browser: plain Lua on the [lua.org demo](https://www.lua.org/demo.html) and PICO-8 on [pico-8-edu.com](https://www.pico-8-edu.com), the free Education Edition.

Every one starts from an empty cart, uses only shapes (no sprites, no map) and fits on one screen of code. The tab can lose everything any time, so I copy the code into a note when I'm done.

My solutions are in here: the plain Lua ones in `lua/`, and one `.p8` cart for each PICO-8 one. Load a cart in PICO-8 with `load quick-exercises/e4-particles.p8`. You can also play them on [sh0ds.dev/exercises](https://sh0ds.dev/exercises/).

## Lua

**L1 · Borders** (`lua/l1-borders.lua`)
A list of five items, the third one gets removed, and everything after it moves down by one, by hand. No `if` needed: reading one past the end gives `nil`, so the last step clears the last slot by itself. `t[3] = nil` is a trap in a list, which is why PICO-8 has `del`. And `del` is a PICO-8 function, so don't use it as a variable name in a cart.

**L2 · Your own `mid`** (`lua/l2-clamp.lua`)
A `clamp(lo, x, hi)` without `math.min` or `math.max`, just `if`s. Below the range gives `lo`, above gives `hi`, inside gives `x`. If `lo` and `hi` come in the wrong way round, swap them first and the same three cases work again. That's why PICO-8's `mid` doesn't care about the order: it gives back whichever of the three is in the middle.

**L3 · Countdown timers** (`lua/l3-timers.lua`)
A table of effect timers (`flash`, `pop`) that count down by one every frame, simulated for 12 frames. Write through `fx[key]`, because `value` is only a copy. Check first, then subtract, and only above 0. One call per frame, the frame loop stays outside.

**L4 · Removing while looping** (`lua/l4-removing.lua`)
Ten particles losing one life per frame, the dead ones get removed inside the loop. Going up skips items, because `table.remove` shifts everything after it down. Going backwards fixes it: those items were already visited. A `for` only counts down if you give it a third number (`-1`), and changing the loop variable inside a `for` does nothing. Test with dead items right next to each other, like `{1, 1, 1, 2, 2, 3}`.

**L5 · Digits without strings** (`lua/l5-digits.lua`)
A number turned into a table of its digits, using only `%` and `//`, no `tostring`. `% 10` gives the last digit, `// 10` drops it, repeat until nothing's left. The digits come out back to front, so each one goes in at index 1 (`table.insert(t, 1, d)`). `repeat ... until` runs at least once, so 0 gives `{0}` instead of an empty table.

**L6 · Eight flags in one number** (`lua/l6-flags.lua`)
Three yes/no facts (door 1 open, key 3 taken, boss beaten) packed into one number, one bit each. `1 << i` is a mask with a single 1 at bit `i`. `|` turns that bit on and leaves the rest alone, so setting it twice changes nothing. `&` keeps only that bit, anything that isn't 0 means on. `~mask` flips every bit, so `n & ~mask` clears just that one. Brackets around `n & mask` before `~= 0`. All three set gives 137 (1 + 8 + 128).

**L7 · Speed that levels off** (`lua/l7-drag.lua`)
60 frames of holding right: a push every frame and drag that takes 10% of the speed. Push first, then drag: the drag also eats 10% of that frame's push, so it levels off at 1.8 instead of 2. Drag first, then push: the push survives whole, and it creeps up to 2. Each frame closes 10% of the remaining gap, so it never quite gets there, which you can't see after about 30 frames. `accel = drag * top_speed` is only exact in the drag-first order.

## PICO-8

**E3 · A moment of colour** (`e3-flash.p8`)
Press ❎: the screen flashes white for 2 frames and the score goes up by 100 and turns orange for 8. `btnp` instead of `btn`, so holding ❎ doesn't flash every frame. `_update` runs before `_draw`, so tick the timers first, then set them, or one frame gets lost. `poke(0x5f5c, 255)` turns off `btnp`'s auto-repeat, found that one myself.

**E4 · Particles** (`e4-particles.p8`)
Press ❎: 20 particles burst out of the middle, fall and shrink until they're gone. Name the fields (`{x = x}`) instead of `[1]`. PICO-8 has no `table` library, it's `add` and `deli`. Angle and speed are separate: `cos(angle) * speed`. A full turn goes from 0 to 1, and `sin` is flipped. Gravity goes on `dy`, not on `y`: adding to `y` is wind, adding to `dy` makes arcs.

**E5 · Shake without a shaky HUD** (`e5-shake.p8`)
Same particles, but now the screen shakes and the counter in the corner stays still. `_draw` runs once per frame, so a loop in there plays the whole shake in one frame. Count down in `_update`, drawing only reads the state. `camera` stays set until the next call: shake, draw the world, `camera()`, then draw the HUD. My own pattern: left, still, right, with `tick` going 0, 1, 2.

**E5b · Random shake** (`e5b-random-shake.p8`)
E5 with a random shake. `shake` is the strength and gets multiplied by 0.8 every frame in `_update`, so it hits hard and calms down smoothly. `_draw` picks a random offset from it, x and y separately. `rnd(0)` is 0, so no `if` needed.

**E7 · A map without the map editor** (`e7-grid.p8`)
A 16×16 map written as strings of 0s and 1s, drawn as 8×8 squares, and a dot that can't go into walls. `sub(s, i, i)` gives back one character, and it's a string (`"1"`, not `1`). Grid to pixel is `(j - 1) * 8`, pixel to grid is `flr(px / 8) + 1`. Check before moving, x and y separately, so you slide along walls instead of sticking. And check the edges of the dot, not its centre. Don't name a table `map`.

**E8 · Wavy text** (`e8-wavy.p8`)
A line of text, centred, every letter bobbing up and down on its own. A letter is 3 pixels wide plus a 1 pixel gap, so the word is `4 * #str - 1` wide and starts at `64 - l / 2`. `sub(str, i, i)` prints one letter at a time, 4 pixels apart. Each letter's y gets `sin(tick/30 + i/8) * 2`: the `i/8` shifts every letter a little, so the wave runs through the word instead of everything moving together. Without the `* 2` it's one pixel and you barely see it.

**E9 · A coin that spins** (`e9-coin.p8`)
An oval whose width follows `abs(cos(tick / 40))`, so it looks like a turning coin. Bigger number, slower spin. `abs` mirrors the negative half, so the coin shows its edge twice per turn, like a real one. `max(1, ...)` keeps it from disappearing. Centre first, then half the width out each way. `sin` only goes from -1 to 1, so multiply it to get a bob you can see.
