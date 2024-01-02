function val = lm_strcmpWildcard(str, pattern, mask)

    if ~isempty(pattern) && ~contains(pattern, '*')
        val = strcmp(str, pattern);
        return
    end
    
    % optionally use a pre-made regexp mask (saves time calculating one
    % when searching a number of items, if the same pattern is used on each
    % search we only want to calculate once)
    if nargin <= 2 || isempty(mask)
        mask = regexptranslate('wildcard', pattern);
    end
    
    % if scalar char search, place into cell array
    if ischar(str), str = {str}; end
    
    % find any cell columns that are not char, treat as char and
    % concatenate so that we search within any text across columns
    search = str;
    val = false(size(search, 1), 1);
    for r = 1:height(str)
        
%         if all(cellfun(@iscell, str(r, :))) && length(str(r, :)) > 1
%             isChar = cellfun(@ischar, str{r});
            search{r} = cell2char(str(r, :));
%         end
        
        res = regexp(search{r}, mask);
        val(r) = ~isempty(res) && isnumeric(res) && res == 1;        
        
    end
    
end