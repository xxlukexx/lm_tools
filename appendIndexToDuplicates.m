function out = appendIndexToDuplicates(in)

    if ~iscellstr(in)
        error('Input must be cellstr.')
    end
    
    out = in;
    
    [u, i, s] = unique(in);
    
    q = 1;
    while q < length(s)
        idx = find(s(q) == s);
        if length(idx) > 1
            for w = 2:length(idx)
                out{idx(w)} = sprintf('%s_%d', out{idx(w)}, w - 1);
                s(idx) = [];
            end
        end
        q = q + 1;
    end
    
end