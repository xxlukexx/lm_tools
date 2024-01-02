function tab = tableTryToRemoveVariables(tab, varsToRemove)

    idx_remove = ismember(tab.Properties.VariableNames, varsToRemove);
    tab(:, idx_remove) = [];
    
end