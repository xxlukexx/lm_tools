function tab_s = stratifyTable(tab, num, vars)

    if ischar(vars), vars = {vars}; end
    numVars = length(vars);
    
    % check table variable names exist, and are either char or numeric
    if ~all(ismember(vars, tab.Properties.VariableNames))
        error('Some or all table variable names were not found in the table.')
    end
    
    % calculate sample mean of each variable
    mu_sample = calcSampleMeans(tab, vars);
    
    tab_s = table;
    i = 1;
    while i <= num
        
        if i == 1
            
            % first iteration, choose a random starting sample
            r = randi(size(tab, 1));
            
        else

            % choose a new row to move on the next iteration. for each
            % remaining row in the sample table, calculate the mean of the
            % stratified table IF it were to be moved. Select the row that
            % minimises the distance between the stratified table mean and the
            % sample table mean

                % 1. calculate stratified mean for each row in sample table if
                % it were to be included
                mu_all = nan(size(tab, 1), numVars);
                parfor ii = 1:size(tab, 1)
                    [~, tab_tmp] = sampleOne(tab, tab_s, ii);
                    mu_all(ii, :) = calcSampleMeans(tab_tmp, vars);
                end

                % 2. calculate distance from each of these means to the sample
                % mean. z-score the distances so that we can compare across
                % variables. create an aggregate by summing each z-score across
                % variables
                dist_all = mu_all - mu_sample;
                dist_all_z = abs(zscore(dist_all));
                dist_agg = sum(dist_all_z, 2);

                % 3. find all nearest candidates. select one randomly
                candidates = find(dist_agg == min(dist_agg));
                idx_rnd = randi(length(candidates));
                r = candidates(idx_rnd);
                
        end
        
        % move the selected sample from the sample to the stratified table
        [tab, tab_s] = sampleOne(tab, tab_s, r);        
            
        i = i + 1;
            
    end

end

function mu = calcSampleMeans(tab, vars)

    % check table variables. Convert logical to double, and recode cellstr
    % to numeric. 
    m = nan(size(tab, 1), length(vars));
    for v = 1:length(vars)
        if iscellstr(tab.(vars{v}))
            [~, ~, m(:, v)] = unique(tab.(vars{v}));
        elseif islogical(tab.(vars{v}))
            m(:, v) = double(tab.(vars{v}));
        elseif isnumeric(tab.(vars{v}))
            m(:, v) = tab.(vars{v});
        else
            error('Table variable %s (and maybe others) are not cellstr, numeric or logical.', vars{v})
        end
    end
    
    % make signatures
    [~, ~, idx_sig] = makeSig(tab, vars);
    
    mu = nanmean(m(idx_sig, :), 1);

end

function [tab, tab_s] = sampleOne(tab, tab_s, r)

    tab_s = [tab_s; tab(r, :)];
    tab(r, :) = [];
%     fprintf('Moved row %d.\n', r);
    
end