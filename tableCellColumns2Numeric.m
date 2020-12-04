function tab = tableCellColumns2Numeric(tab)
% finds any columns that are cell arrays with all elements being non-empty
% and numeric, and converts them to numeric

    varNames = tab.Properties.VariableNames;
    for i = 1:size(tab, 2)
        
        col = tab{:, i};
        if iscell(col) && isscalar(col)
            
            % replace empty with nan
            idx_empty = cellfun(@(x) isempty(x) & isnumeric(x), col);
            col(idx_empty) = repmat({nan}, sum(idx_empty), 1);
            
            
            isNum = all(cellfun(@isnumeric, col));
            notEmpty = all(~cellfun(@isempty, col));
            containsScalars = all(cellfun(@isscalar, col));

            if isvector(col) && isNum && notEmpty && containsScalars
                tab.(varNames{i}) = cell2mat(col);
            end
        end

    end
    
end