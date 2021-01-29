function [tab, t_cell, d_cell, td_cell, grp_desc] = factcomp(tab, measure, varargin)

    parser      =   inputParser;
    checkField  =   @(x) any(strcmpi(tab.Properties.VariableNames, x)   );
    addRequired(    parser, 'tab',                              @istable        )
    addRequired(    parser, 'measure',                          checkField      )
    addParameter(   parser, 'compare',              []                          )
    addParameter(   parser, 'rows',                 [],         checkField      )
    addParameter(   parser, 'cols',                 [],         checkField      )
    
    parse(          parser, tab, measure, varargin{:});
    tab         =   parser.Results.tab;
    measure     =   parser.Results.measure;
    compare     =   parser.Results.compare;
    rows        =   parser.Results.rows;
    cols        =   parser.Results.cols;
    
    % set up values of compare, stack, rows and cols variables
    [comp_u, comp_s, numComp] = prepareVariable(tab, compare);
    [row_u, row_s, numRow] = prepareVariable(tab, rows);
    [col_u, col_s, numCol] = prepareVariable(tab, cols);
    
    % only works on two-sample comparisons
    if numComp ~= 2
        error('This function only works on two-sample comparisons. The variable %s has %d levels.',...
            compare, numComp)
    end

%% t-test
    
    p = [];
    meanDiff = [];
    mu = [];
    sd = [];
    df = [];
    tstat = [];
    effect = {};
    CI = [];
        
    % do t-test for each row/col
    p = nan(numRow, numCol);
    for c = 1:numCol
        for r = 1:numRow

            % filter table for this row, col
            idx_filt = row_s == r & col_s == c;
            tmp = tab(idx_filt, :);

            % make subs for comparison
            [comp_u, ~, comp_s] = unique(tmp.(compare));
            numComp = length(comp_u);

            % t-test
            x = tmp.(measure)(comp_s == 1);
            y = tmp.(measure)(comp_s == 2);
            [~, p(r, c), ~, stats_tmp] = ttest2(x, y);
            df(r, c) = stats_tmp.df;
            tstat(r, c) = stats_tmp.tstat;
            
            % effect label
            if numRow == 1 && numCol == 1
                effect{r, c} = sprintf('%s vs %s', comp_u{1}, comp_u{2});
            elseif numRow > 1 && numCol == 1
                effect{r, c} = sprintf('%s: %s vs %s', row_u{r}, comp_u{1}, comp_u{2});
            else
                warning('Results table not calculated for rows and cols - fix this!')
            end
            
            % 95% CI
            for cmp = 1:numComp
                CI(r, c, cmp, :) = ci(tmp.(measure)(comp_s == cmp));
            end
        end
    end

    % convert p values to cell array of string
    t_cell = arrayfun(@(df, t, p) sprintf('t(%d)=%.2f, p=%.3f', df, t, p), df, tstat, p, 'uniform', false);

    % find any p values <.001 (which will display as p=0.000) and
    % replace with p<.001
    idx_low = p < .001;
    t_cell(idx_low) = strrep(t_cell(idx_low), 'p=0.000', 'p<.001');

    % format results in table
    tab_t = cell2table(t_cell, 'RowNames', row_u, 'VariableNames', col_u);      

%% cohen's d
        
    % calculate d for each row/col
    d = nan(numRow, numCol);
    for c = 1:numCol
        for r = 1:numRow

            % filter table for this row, col
            idx_filt = row_s == r & col_s == c;
            tmp = tab(idx_filt, :);

            % make subs for comparison
            [comp_u, ~, comp_s] = unique(tmp.(compare));
            numComp = length(comp_u);

            % calculate mean and SEM for each comparison
            m_mu = accumarray(comp_s, tmp.(measure), [], @nanmean);
            mu(r, c, :) = m_mu;
            meanDiff(r, c) = diff(m_mu);

            % pooled SD
            x1 = tmp.(measure)(comp_s == 1);
            x2 = tmp.(measure)(comp_s == 2);
            [~, sdp(r, c)] = sdpooled(x1, x2);
            sd(r, c, 1) = nanstd(x1);
            sd(r, c, 2) = nanstd(x2);

            % calculate cohen's d
            d(r, c) = abs(meanDiff(r, c) / sdp(r, c));

        end
    end
    

%% summarise results

    % make table
    tab = table;
    tab.effect = reshape(effect, [], 1);
    
    tab.(sprintf('mean_%s', comp_u{1})) = reshape(mu(:, :, 1), [], 1);
    tab.(sprintf('mean_%s', comp_u{2})) = reshape(mu(:, :, 2), [], 1);
    tab.(sprintf('sd_%s', comp_u{1})) = reshape(sd(:, :, 1), [], 1);
    tab.(sprintf('sd_%s', comp_u{2})) = reshape(sd(:, :, 2), [], 1);    
    
    tab.(sprintf('CI05_%s', comp_u{1})) = reshape(CI(:, :, 1, 1), [], 1);
    tab.(sprintf('CI95_%s', comp_u{1})) = reshape(CI(:, :, 1, 2), [], 1);
    tab.(sprintf('CI05_%s', comp_u{2})) = reshape(CI(:, :, 2, 1), [], 1);
    tab.(sprintf('CI95_%s', comp_u{2})) = reshape(CI(:, :, 2, 2), [], 1);
    
    tab.mean_diff = reshape(meanDiff, [], 1);
    tab.sd_pooled = reshape(sdp, [], 1);
    tab.t = reshape(tstat, [], 1);
    tab.df = reshape(df, [], 1);
    tab.p = reshape(p, [], 1);
    tab.d = reshape(d, [], 1);
    
    d_cell = arrayfun(@(d) sprintf('d=%.2f', d), d, 'uniform', false);
    td_cell = arrayfun(@(df, t, p, d) sprintf('t(%d)=%.2f, p=%.3f, d=%.2f', df, t, p, d), df, tstat, p, d, 'uniform', false);
    
    if length(t_cell) == 1
        t_cell = t_cell{1};
    end
    
    if length(d_cell) == 1
        d_cell = d_cell{1};
    end
    
    if length(td_cell) == 1
        td_cell = td_cell{1};
    end
    
%% table of stats for each group

    for cmp = 1:numComp
        grp_desc{cmp} = sprintf('%s: Mean=%.3f, SD=%.3f, 95%% CI=%.3f-%.3f',...
            comp_u{cmp},...
            reshape(mu(:, :, cmp), [], 1),...
            reshape(sd(:, :, cmp), [], 1),...
            reshape(CI(:, :, cmp, 1), [], 1),...
            reshape(CI(:, :, cmp, 2), [], 1));
    end

end

function [u, s, num] = prepareVariable(tab, var)

    if isempty(var)
        
        % if var is empty, return 'NONE' as a single unique value, and
        % vector of ones as the subscripts
        u = {'NONE'};
        numData = size(tab, 1);
        s = ones(numData, 1);
        num = 1;
        
    else
        
        % find unique vals of var, and subscripts, and do not sort (so that
        % pre-sorted tables can retain their ordering)
        [u, ~, s] = unique(tab.(var), 'stable');
        num = length(u);
        
        % if numeric, convert to cellstr
        if isnumeric(u) || islogical(u)
            u = arrayfun(@num2str, u, 'UniformOutput', false);
        end
        
        % convert any individual values that are numeric to string
        idx_isnum = cellfun(@isnumeric, u);
        u(idx_isnum) = cellfun(@num2str, u(idx_isnum),...
            'UniformOutput', false);  
    end
    
end