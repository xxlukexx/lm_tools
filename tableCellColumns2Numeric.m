function tab = tableCellColumns2Numeric(tab)
% finds any columns that are cell arrays with all elements being non-empty
% and numeric, and converts them to numeric

    varNames = tab.Properties.VariableNames;
    for i = 1:size(tab, 2)
        
        col = tab{:, i};
        if iscell(col) && all(cellfun(@(x) isnumeric(x) && ~isempty(x), col))
            tab.(varNames{i}) = cell2mat(col);
        end

    end
    
end