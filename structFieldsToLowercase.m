function s = structFieldsToLowercase(s)
% make struct fieldnames lowercase, by converting to cell, adjusting the
% fieldnames, then converting the cell back to struct

    fnames_orig = fieldnames(s);                                            % get original fieldnames
    fnames_lower = lower(fnames_orig); 
    
    % rename duplicates
    fnames_lower = appendIndexToDuplicates(fnames_lower);
    
    for i = 1:length(fnames_orig)
        s = renameStructField(s, fnames_orig{i}, fnames_lower{i});
    end
    
%     % detect hstruct
%     ishstruct = isa(s, 'hstruct');
%     c = struct2cell(s);
%     s = cell2struct(c, fnames_lower);
%     if ishstruct, s = hstruct(s); end
    
end