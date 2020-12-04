function tab = tableTryToRenameVariables(tab, currentVars, newVars)

    if ~iscell(currentVars)
        currentVars = {currentVars};
    end

    if ~iscell(newVars)
        newVars = {newVars};
    end

    for i = 1:size(currentVars, 1)
        idx = find(strcmp(currentVars{i}, tab.Properties.VariableNames), 1);
        if ~isempty(idx)
            tab.Properties.VariableNames{idx} = newVars{i};
        end
    end
    
end