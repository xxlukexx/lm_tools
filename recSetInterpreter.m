function h = recSetInterpreter(h, val)

    for i = 1:numel(h)
        
        props = properties(h(i));
        poss = find(cellfun(@(x) contains(lower(x), 'interpreter'), props));
        for ii = 1:length(poss)
            h(i).(props{ii}) = val;
        end
        
        if isprop(h(i), 'children')
            ch = h(i).Children;
            for iii = 1:length(ch)
                recSetInterpreter(ch, val);
            end
        end
        
    end

end