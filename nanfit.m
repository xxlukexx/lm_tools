function [f, gof, stats] = nanfit(x, y, varargin)

    idx_nan = isnan(x) | isnan(y);
    x(idx_nan) = [];
    y(idx_nan) = [];
    fprintf('Ignored %d (%.1f%%) elements of [x, y] because at least one contained a NaN.\n',...
        sum(idx_nan), (sum(idx_nan) / length(idx_nan) * 100))
    [f, gof, stats] = fit(x, y, varargin{:});
    
end 
        