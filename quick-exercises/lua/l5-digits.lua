function i_to_table(i)
    local tab={}
    repeat
        table.insert(tab, 1, (i % 10))
        i = i // 10
    until i == 0
    return tab
end

n = 2145295
m = 0

n_tab = i_to_table(n)
m_tab = i_to_table(m)

print("{"..table.concat(n_tab, ", ").."}")
print("{"..table.concat(m_tab, ", ").."}")
