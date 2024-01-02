function y = sem(x, varargin)

    sd = nanstd(x, [], varargin{:});
    n = size(x, varargin{:});
    y = sd ./ sqrt(n);
    
end
    