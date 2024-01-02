function fixed = fixTableVariableNames(broken)

    if ~iscell(broken)
        broken = {broken}; 
        unCell = true; 
    else
        unCell = false;
    end
    
    broken = cellfun(@matlab.lang.makeValidName, broken, 'UniformOutput', false);
    
    % find and rename dups
    [u, i, s] = unique(broken);
    for q = 1:length(u)
        idx_dup = find(s == q);
        numDups = length(idx_dup);
        if numDups > 1
            for d = 2:numDups
                broken{idx_dup(d)} = sprintf('%s_%0d', broken{idx_dup(d)}, d);
            end
        end
    end
    

%     replace = {...
%         ' ',        '_'     ;...
%         '-',        '_'     ;...
%         '.',        '_'     ;...
%         '>',        ''      ;...
%         '<',        ''      ;...
%         ':',        '_'     ;...
%         '(',        ''      ;...
%         ')',        ''      ;...
%         '/',        '_'     ;...
%         '&',        ''      ;...
%         '|',        ''      ;...
%         '�',        'deg'   ;...
%         '?',        ''      ;...
%         };
%     
%     for r = 1:length(replace)
%         broken = strrep(broken, replace{r, 1}, replace{r, 2});
%     end
%     
%     % find names starting with number
%     firstNum = cellfun(@(x) ~isnan(str2double(x(1))), broken);
%     broken(firstNum) = cellfun(@(x) ['V', x], broken(firstNum),...
%         'uniform', false);
%     
%     % truncate long names
%     tooLong = cellfun(@(x) length(x) > 63, broken);
%     broken(tooLong) = cellfun(@(x) x(1:63), broken(tooLong),...
%         'uniform', false);
%     
%     % add numeric index to duplicates
%     [u, i, s] = unique(broken);
%     if length(u) ~= length(broken)
%         dup_idx = find(~(ismember(1:numel(broken),i)));  
%         numDups = length(dup_idx);
%         broken(dup_idx) = cellfun(@(x, i) sprintf('%s_%d', x, i),...
%             broken(dup_idx), num2cell(1:length(dup_idx)),...
%             'uniform', false);
%     end
    
    if unCell
        fixed = broken{:};
    else
        fixed = broken;
    end
    
end