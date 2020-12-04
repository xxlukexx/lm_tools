function histspline(vals, varargin)

    [heights, centres] = hist(vals, 30);
    n = length(centres);
    w = centres(2)-centres(1);
    t = linspace(centres(1)-w/2,centres(end)+w/2,n+1);
    dt = diff(t);
    Fvals = cumsum([0,heights.*dt]);                
    F = spline(t, [0, Fvals, 0]);
    DF = fnder(F);
    pts = fnplt(DF, 'r', 2);
    
    bar(centres, heights)
%     plot(pts(1, :), pts(2, :), varargin{:});         
%     area(pts(1, :), pts(2, :), 'facecolor', cols(c, :),...
%         'linestyle', 'none', 'facealpha', 1 / (numComp))
%                 set(gca, 'XTickLabels', [])
    set(gca, 'YTickLabels', [])
    yl = ylim;
    if yl(2) < max(pts(2, :))
        yl(2) = max(pts(2, :));
    end
    ylim([0, yl(2)])
    ax = get(gca, 'XAxis');
    set(ax, 'LineWidth', 2)
    ax = get(gca, 'YAxis');
    set(ax, 'LineWidth', 2)
    set(gca, 'ytick', [])                
                
end