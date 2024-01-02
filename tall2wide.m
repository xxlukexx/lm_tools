function out = tall2wide(in, cond, dv, key)

    out = table;
    
    % get unique conditions and subscripts for condition
    [cond_u, ~, cond_s] = unique(in.(cond));
    numCond = length(cond_u);
    
    % get subscripts for key (ID)
    [key_u, ~, key_s] = unique(in.(key));
    
    for c = 1:numCond
        
        % filter for this cond
        tmp = in(cond_s == c, :);
        
        % rename dv
        if iscell(in.(cond))
            varName = sprintf('%s_%s', dv, cond_u{c});
        else
            varName = sprintf('%s_%d', dv, cond_u(c));
        end
        tmp.Properties.VariableNames(dv) = {varName};
        
        tmp = tmp(:, {varName, key});
        
        if c == 1
            out = tmp;
        else
            out = outerjoin(out, tmp, 'Keys', 'ID');
            
        end
        
    end

end