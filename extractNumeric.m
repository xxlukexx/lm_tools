function c = extractNumeric(c)

    % check input is cell array
    if ~iscell(c)
        error('Input must be cell array')
    end
    
    % make index of char elements
    if ~iscellstr(c)
        ch = cellfun(@ischar, c);
    else
        ch = true(size(c));
    end
    
    % process
    c(ch) = cellfun(@(x) str2double(regexp(x, '\d*', 'match')), c(ch),...
        'uniform', false);
    
    % convert numeric to cell
    nm = cellfun(@isnumeric, c);
    c(nm) = cellfun(@num2cell, c(nm), 'uniform', false);
    
end