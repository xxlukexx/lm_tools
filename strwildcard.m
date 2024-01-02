function val = strwildcard(str, mask)

    % if multiple search items, call myself for each element
    if iscellstr(str)
        val = cellfun(@(x) strwildcard(x, mask), str);
        return
    end
    
    % determine mask type
    if ischar(mask)
        if ~instr(mask, '*')
            % straight match - no wildcard
            maskType = 1;
            % no regexp needed
            maskRegExp = [];
        else
            % wildcard
            maskType = 2;
            % prepare regexp expression
            maskRegExp = regexptranslate('wildcard', mask);
        end
    else
        error('''mask'' must be string (e.g. ''eeg*.mat''.')
    end
    
    if ~ischar(str)
        error('Search value must be string.')
    end
        
    % search
    if maskType == 1
        % straight search
        val = strcmpi(str, mask);
    elseif maskType == 2
        res = regexp(str, maskRegExp);
        val = ~isempty(res) && res == 1;
    end

end