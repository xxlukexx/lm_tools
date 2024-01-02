function tabf = filterTableVariables(tab, wantedVars)

    tabf = table;
    vars = tab.Properties.VariableNames';
    numVars = length(wantedVars);
    for v = 1:numVars
        
        if contains(wantedVars{v}, '*')
            found = lm_strcmpWildcard(vars, wantedVars{v});
        else
            found = strcmp(vars, wantedVars{v});
        end
        
        tabf = [tabf, tab(:, found)];
        
    end
        
end