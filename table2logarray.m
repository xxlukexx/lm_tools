function la = table2logarray(tab)
    s = table2struct(tab);
    la = arrayfun(@(x) x, s, 'UniformOutput', false);
end