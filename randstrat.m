function tab = randstrat(tab, groupVar, matchVars, idVar)

% preproc vars

    % extract matching vars
    c = table2cell(tab(:, matchVars));
    
    % recode string vars to numeric
    m = nan(size(c));
    for col = 1:size(c, 2)
        if iscellstr(c(:, col))
            [~, ~, recodedVals] = unique(c(:, col));
            m(:, col) = recodedVals;
        elseif all(cellfun(@isnumeric, c(:, col)))
            m(:, col) = cell2mat(c(:, col));
        else
            error('Matching variable %s is not cell string or numeric.',...
                matchVars{c})
        end
    end
    
    % zscore
    mz = zscore(m);
    
    % put in table
    tmp = array2table(mz, 'VariableNames', matchVars);
    tmp.id = tab.(idVar);
    
    % randomise order
    so = randperm(size(tmp, 1));
    tmp = tmp(so, :);
    tab = tab(so, :);
        
% discover groups

    [grp_u, ~, tmp.grp_s] = unique(tab.(groupVar));
    numGroups = length(grp_u);
    fprintf('Found %d groups according to the grouping variable ''%s''.\n',...
        numGroups, groupVar);
    
    % find smallest group
    tbl_grp = tabulate(tab.(groupVar));
    [~, so] = sort(tbl_grp(:, 1));
    tbl_grp = tbl_grp(so, :);
    grp_n = cell2mat(tbl_grp(:, 2));
    idx_ref = find(grp_n == min(grp_n));
    fprintf('Smallest group was ''%s'' with %d samples. This will be the reference group.\n',...
        grp_u{idx_ref}, grp_n(idx_ref));
        
% match

    % default output index is 0 - this means drop this case because it
    % wasn't matched 
    idx = zeros(size(tmp, 1), 1);
    
    % extract z-scored matching values as matrix for faster computation
    mz = tmp{:, matchVars};
    
    for s = 1:size(tmp, 1)
        
        if tmp.grp_s(s) == idx_ref
            
            % calculate distance from this sample to all other samples
            dis = sum((mz(s, :) - mz) .^ 2, 2);
            
            for g = 1:numGroups
                
                % don't look within the ref group
                if g == idx_ref, continue, end
                
                % find nearest match for this group, against ref group
                dis_grp = dis;
                dis_grp(s) = inf;
                dis_grp(tmp.grp_s ~= g | idx ~= 0) = inf;
                idx_match = find(dis_grp == min(dis_grp));
                
                % if more than one match, choose randomly
                if length(idx_match) > 1
                    idx_match = idx_match(randi(length(idx_match)));
                end
                
                idx(s) = idx_match;
                idx(idx_match) = s;
                
%                 idx2 = idx(idx ~= 0);
%                 disp(tab(idx2, :))
                
                
            end
  
        end

    end
    
% plot

    figure
    nsp = numSubplots(length(matchVars) * 2);
    cnt = 1;
    for v = 1:length(matchVars)
        subplot(nsp(1), nsp(2), cnt)
        cnt = cnt + 1;
        bw = (max(m(:, v)) - min(m(:, v))) / 10;
        for g = 1:numGroups
            idx_plot = tmp.grp_s == g & idx ~= 0;
            histogram(m(idx_plot, v), 'BinWidth', bw)
            hold on
        end
        title(sprintf('MATCHED - %s', matchVars{v}))
        legend(grp_u)
        
        subplot(nsp(1), nsp(2), cnt)
        cnt = cnt + 1;
        for g = 1:numGroups
            idx_plot = tmp.grp_s == g;
            histogram(m(idx_plot, v), 'BinWidth', bw)
            hold on
        end
        title(sprintf('ORIGINAL - %s', matchVars{v}))
        legend(grp_u)
    end
    
    idx2 = idx(idx ~= 0);
    tab = tab(idx2, :);

end