function tab_s = stratifyTableCategorically(tab, num, vars)

    if ischar(vars), vars = {vars}; end
    numVars = length(vars);
    
    % check table variable names exist, and are either char or numeric
    if ~all(ismember(vars, tab.Properties.VariableNames))
        error('Some or all table variable names were not found in the table.')
    end
    
    % make signatures
    [tab.sig, sig_u, sig_i, sig_s, numSig] = makeSig(tab, vars);

    cnt_sig = 1;
    i = 1;
    tab_s = table;
    r = nan(num, 1);
    taken = false(size(tab, 1), 1);
    while i <= num
        
        % get index of all candidate signatures matching current
        cand = find(sig_s == cnt_sig & ~taken);
        
        % increment signature counter
        cnt_sig = cnt_sig + 1;
        if cnt_sig > numSig, cnt_sig = 1; end        
        
        % if none left, move to next signature 
        if isempty(cand), continue, end
        
        % pick a random one, record that it is taken
        idx_rnd = randi(length(cand));
        r(i) = cand(idx_rnd);
        taken(r(i)) = true;
        
        i = i + 1;
        
    end
    
    tab_s = tab(r, :);

end