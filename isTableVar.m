function val = isTableVar(tab, var)

    if ~istable(tab)
        error('First input must be a table.')
    end
    
    if ~iscell(var), var = {var}; end
    if ~all(cellfun(@ischar, var))
        error('Second input must be variable name(s), as either char or cellstr.')
    end
    
    if isempty(tab)
        val = [];
        return
    end
    
    varNames = tab.Properties.VariableNames;
    if isempty(varNames)
        val = [];
        return
    end
    
    val = ismember(var, varNames);
    
end