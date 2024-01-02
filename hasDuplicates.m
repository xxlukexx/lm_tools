function [has, dup_idx, tab_dup, tab_noDup] = hasDuplicates(tab, vars)

    % make signature form key vars, to allow grouping rows as unique
    % entities
    [sig, ~, sig_i, sig_s] = makeSig(tab, vars);

    % find dups
    has = ~isequal(length(sig), length(sig_i));
    tb = tabulate(sig_s);
    idx = tb(:, 2) > 1;
    dup_idx = ismember(sig_s, tb(idx, 1));
    
    tab_dup = tab(dup_idx, :);
    tab_noDup = tab(~dup_idx, :);

end