function [tab_r, tab_p] = partialcorrtab(data, covariates)
    % Extract variable names from the data table
    vars = data.Properties.VariableNames;
    
    % Create empty correlation and p-value tables
    tab_r = array2table(nan(numel(vars), numel(vars)), 'VariableNames', vars, 'RowNames', vars);
    tab_p = array2table(nan(numel(vars), numel(vars)), 'VariableNames', vars, 'RowNames', vars);
    
    % Compute partial correlations and p-values
    for i = 1:numel(vars)
        for j = i:numel(vars)
            var1 = data.(vars{i});
            var2 = data.(vars{j});
            
            % Compute partial correlation
            [r, pval] = partialcorr(var1, var2, covariates);
            tab_r{vars{i}, vars{j}} = pval;
            
            % Bonferroni correction
            adjusted_pval = pval * numel(vars) * (numel(vars) - 1) / 2;
            tab_p{vars{i}, vars{j}} = adjusted_pval;
            
            % Set as NaN if not significant
            if adjusted_pval > 0.05
                tab_r{vars{i}, vars{j}} = NaN;
                tab_p{vars{i}, vars{j}} = NaN;
            end
        end
    end
end
