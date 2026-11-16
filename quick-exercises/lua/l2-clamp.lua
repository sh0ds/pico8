function clamp(lo, x, hi)
    if lo > hi then
        lo, hi = hi, lo
    end
    if x < lo then
        return lo
    elseif x > hi then
        return hi
    else
        return x
    end
end

print(clamp(5, 3, 10))
print(clamp(5, 12, 10))
print(clamp(5, 8, 10))
print(clamp(10, 12, 5))
