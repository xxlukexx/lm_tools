function out = tabulatefactorial(tab, rowVar, colVar)

    % get subs row rows and cols, count occurences
    [row_u, ~, row_s] = unique(tab.(rowVar));
    [col_u, ~, col_s] = unique(tab.(colVar));
    m_count = accumarray([row_s, col_s], ones(length(row_s), 1), [], @sum);
    
    % make percentage and format
    m_perc = (m_count ./ sum(m_count, 1) * 100);
    c_perc = arrayfun(@(x) sprintf('%.2f%%', x), m_perc, 'UniformOutput', false);
    
    % convert numeric variable names to string 
    if isnumeric(row_u) || islogical(row_u)
        row_u = arrayfun(@(x) sprintf('val_%d', x), row_u, 'UniformOutput', false);
    end
    
    % make var names
    varNames_count =  arrayfun(@(x) sprintf('N_%d', x), col_u, 'UniformOutput', false);
    varNames_perc =  arrayfun(@(x) sprintf('Perc_%d', x), col_u, 'UniformOutput', false);
    varNames = [varNames_count', varNames_perc'];

    % make output table with counts
    out_count = array2table(m_count, 'VariableNames', varNames_count, 'RowNames', row_u);
    out_perc = cell2table(c_perc, 'VariableNames', varNames_perc, 'RowNames', row_u);
    
    % convert percentages from cell to char columns
    for i = 1:length(varNames_perc)
        out_perc.(varNames_perc{i}) = char(out_perc.(varNames_perc{i}));
    end
    
    out = [out_count, out_perc];

    % sort
    [~, so] = sort(sum(m_count, 2), 'descend');
    out = out(so, :);
    
    if nargin == 0, disp(out), end
    
end