t = {1, 2, 3, 4, 5}
del = 3
for i=del,#t do
    t[i] = t[i+1]
end
print(#t)
