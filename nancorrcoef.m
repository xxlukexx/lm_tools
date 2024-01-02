function out = nancorrcoef(x, y)

    idx_nan = isnan(x) | isnan(y);
    x(idx_nan) = [];
    y(idx_nan) = [];
    fprintf('Ignored %d (%.1f) elements of [x, y] because at least one contained a NaN.\n',...
        sum(idx_nan), sum(idx_nan) / length(idx_nan))
    out = corrcoef(x, y);
    
end
        