function [hasDup, dupIdx, allDupIdx, dupTable] = findDuplicateTableRows(t, vars)
    
    % by default use all variables, but they can be specified
    if ~exist('vars', 'var') || isempty(vars)
        vars = t.Properties.VariableNames;
    end

    % serialise
    ser = cell(size(t, 1), 1);
    for row = 1:size(t, 1)
        ser{row} = getByteStreamFromArray(t(row, vars));
    end
    % convert to char
    ch = cellfun(@char, ser, 'uniform', false);
    % find dups
    [u, i, s] = unique(ch);
    hasDup = size(u, 1) < size(ch, 1);
    dupIdx = setdiff(1:size(ch, 1), i);
    

    dupCounts = accumarray(s, 1); % count the occurrences of each unique value
    idx_dupCount = find(dupCounts > 1); % find indices of duplicated values
    allDupIdx = find(ismember(s, idx_dupCount)); % find indices of duplicated values in original vector
    
    dupTable = t(allDupIdx, :);

end