function AssertValueIsInList(val, list, varargin)
    
    caseSensitive = ismember('casesensitive', varargin);
    
    if ~iscell(list)
        list = {list};
    end
    
    % ensure that at least on element of the list we are searching is the
    % same class as the value we are searching for
    idx_matchingClass = cellfun(@(x) isequal(class(val), class(x)), list);
    if ~any(idx_matchingClass)
        error('At least one element of the list must be of the same class (%s) as the value being sought.',...
            class(val))
    end
    
    % (optionally, by default) make any text lower case
    if ~caseSensitive
        idx_char = cellfun(@ischar, list);
        list(idx_char) = cellfun(@lower, list(idx_char), 'UniformOutput', false);
    end
    
    if ~ismember(val, list(idx_matchingClass))
        fprintf(2, 'Value must be one of:\n');
        fprintf(2, '\t%s\n', list{:});
        error('Value was not valid.') 
    end
    
end
    
    