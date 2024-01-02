function h_scatter = scatterWithFitLine(x, y, cols, varargin)

    h_scatter = scatter(x, y, [], cols, 'markerfacecolor', 'flat');
    
    hold on
    mdl = fitlm(x, y);
    pl = plot(mdl);
    
    h_fit = findobj(pl, 'DisplayName', 'Fit');
    h_fit.Color = cols;
    h_fit.LineWidth = 3;
    
    h_ci = findobj(pl, 'Type', 'Line');
    arrayfun(@(x) set(x, 'Color', cols), h_ci)
    arrayfun(@(x) set(x, 'LineWidth', 3), h_ci)
    
    delete(findobj(pl, 'DisplayName', 'Data'))
    delete(findobj(gcf, 'Type', 'Legend'))
    delete(findobj(gca, 'LineStyle', ':'))    
    
end