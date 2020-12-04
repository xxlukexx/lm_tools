function str = tableTryToCatVariables(tab, varsToCat)

    % find vars to cat that are in the current table
    idx_varIsInTable = ismember(lower(tab.Properties.VariableNames), lower(varsToCat));

    vars = tab.Properties.VariableNames(idx_varIsInTable);
    numVars = length(vars);
    str = cell(size(tab, 1), 1);
    for row = 1:size(tab, 1)
        for v = 1:numVars
            str{row} = [str{row}, tab.(vars{v}){row}];
        end
    end

end