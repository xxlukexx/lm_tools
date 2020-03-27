function sem = nansem(X, varargin)

    sd  = nanstd(X, varargin{:});
    N   = length(X);
    sem = sd / sqrt(N);
    
end