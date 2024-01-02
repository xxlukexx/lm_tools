function tab_agg = aggregateTable(tab, breakVars, aggVals, fcn)

    if ~iscell(breakVars)
        breakVars = {breakVars};
    end
    
    if ~iscell(aggVals)
        aggVals = {aggVals};
    end
    
    % determine if one fcn for all vals, or separate
    if iscell(fcn) 
        if ~isequal(length(fcn), length(aggVals))
            error('Must specify one function for all values, or one function for each value.')
        end
    else
        % put fcn into cell array and replicate for each val
        fcn = repmat({fcn}, size(aggVals));
    end
    
    numVars = length(breakVars);
    numRows = size(tab, 1);
    numVals = length(aggVals);
    
    % make a copy of the original table. We'll use this to build the
    % aggregated table, filling in any non-break and non-aggregated
    % variables by taking the first occurence from this table 
    tab_orig = tab;
    
    % convert number columns to string
    for v = 1:numVars
        if isnumeric(tab.(breakVars{v}))
            tab.(breakVars{v}) = num2str(tab.(breakVars{v}));
        end
    end    

    % check that all values are numeric or logical
    for v = 1:numVals
        if iscell(tab.(aggVals{v})) && all(cellfun(@isnumeric, tab.(aggVals{v})))
            tab.(aggVals{v}) = cell2mat(tab.(aggVals{v}));
        elseif iscell(tab.(aggVals{v})) && ~all(cellfun(@isnumeric, tab.(aggVals{v})))
            error('Table value variable ''%s'' is a cell array, but its contents is non-numeric - cannot aggregate.',...
                aggVals{v})
        end
    end
    
    % make sig if needed
    if numVars > 1
        
        vals = cellfun(@(x) cellstr(tab.(x)), breakVars, 'UniformOutput', false);
        sig = cell(numRows, 1);
        for v = 1:numVars
            for r = 1:numRows
                sig{r} = sprintf('%s_%s', sig{r}, vals{v}{r});
                sig{r} = strrep(sig{r}, ' ', '');
            end
        end
        
    else
        
        sig = tab.(breakVars{1});
        if isnumeric(sig)
            sig = num2cell(sig);
        elseif ischar(sig)
            sig = cellstr(sig);
        end
        
    end
        
    % make subs
    [sig_u, sig_i, sig_s] = unique(sig);
    
    % aggregate and tabulate
    tab_agg = table;
    for tv = 1:numVals
        
        m = accumarray(sig_s, tab.(aggVals{tv}), [], fcn{tv});
        varName = aggVals{tv};
%         varName = sprintf('%s_%s', tabVals{tv}, func2str(fcn));
        tab_agg.(varName) = m;
        
    end
    
    % take first occurrence of each unique sig row from original table
    tab_first = tab(sig_i, :);
    
    % remove table values that have been aggregated
    for tv = 1:numVals
        tab_first.(aggVals{tv}) = [];
    end
    
    for v = 1:numVars
        tab_first.(breakVars{v}) = tab_orig.(breakVars{v})(sig_i);
    end
    
    % join tables
    tab_agg = [tab_first, tab_agg];
    
end