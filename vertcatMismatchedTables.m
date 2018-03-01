function joinedTable = vertcatMismatchedTables(varargin)

    % check input args
    if nargin < 2
        error('Must pass at least two tables as input arguments.')
    end
    if ~all(cellfun(@istable, varargin))
        error('All inputs must be tables.')
    end
    if any(cellfun(@isempty, varargin))
        error('No tables can be empty.')
    end
    
    t = varargin;
    
    % get unique variables
    allVars = cellfun(@(x) x.Properties.VariableNames, t, 'uniform', false);
    allVars = unique(horzcat(allVars{:}));
    
    % harmonise variables
    for i = 1:nargin
        % harmonise
        colMissing = setdiff(allVars, t{i}.Properties.VariableNames);
        t{i} = [t{i}, array2table(nan(height(t{i}), numel(colMissing)),...
            'VariableNames', colMissing)];
        % check for cell mismatch
        for colname = colMissing
            % find variables that are cells in any table
            varIsCell = cellfun(@(x) ismember(colname{1}, x.Properties.VariableNames) && iscell(x.(colname{1})), t);
            % if any were, convert NaN to cell
            if any(varIsCell)
                t{i}.(colname{1}) = cell(height(t{i}), 1);
            end
        end
    end
    
    joinedTable = vertcat(t{:});
    
end