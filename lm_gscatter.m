function lm_gscatter(x, y, g, varargin)

    hold on
    [u, ~, s] = unique(g);
    numGrp = length(u);
    for g = 1:numGrp
        scatter(x(s == g), y(s == g), varargin{:})
        if numGrp == 2
            [r, p] = corr(x(s == g), y(s == g));
            u{g} = [u{g}, sprintf(' | r=%.2f, p=%.3f', r, p)];
        end
    end
    legend(u, 'Location', 'best')
    
end