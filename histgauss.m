function histgauss(x, varargin)

%     binSize = round((max(x) - min(x)) / 10);
%     [vals, edges, ~] =...
%         histcounts(x, 'Normalization', 'probability', 'binwidth', binSize);                     
%     bar(edges(2:end), vals, 1, 'EdgeColor', 'none', 'FaceAlpha', .4);
%     hold on

    [vals, edges, ~] =...
        histcounts(x, 30, 'Normalization', 'pdf');                    
    edges = edges(2:end) - (edges(2)-edges(1))/2;

    % fit gaussian 
    [f, ~] = fit(edges', vals', 'gauss1');

    % plot
%     set(gca, 'colororderindex', comp)
    plot(edges, f(edges), varargin{:})
    
    set(gca, 'YTickLabels', [])
    yl = ylim;
    if yl(2) < max(vals)
        yl(2) = max(vals);
    end
    ylim([0, yl(2)])
    ax = get(gca, 'XAxis');
    set(ax, 'LineWidth', 2)
    ax = get(gca, 'YAxis');
    set(ax, 'LineWidth', 2)
    set(gca, 'ytick', [])     

end