function varargout = nancorr(x, y, varargin)

    idx_missing = isnan(x) | isnan(y);
    x(idx_missing) = [];
    y(idx_missing) = [];
    [varargout{1:nargout}] = corr(x, y, varargin{:});
    
end