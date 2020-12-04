function lm_format_scatter(h)

    if ~isa(h, 'matlab.graphics.axis.Axes')
        error('Must pass a valid handle to axes.')
    end
    
    ch = h.Children;
    idx_isScatter = arrayfun(@(x)...
        strcmpi(class(x), 'matlab.graphics.chart.primitive.Scatter'), ch);
    if ~any(idx_isScatter)
        error('At least one child of the axes must be scatter (matlab.graphics.chart.primitive.Scatter).')
    end
    
    ch(~idx_isScatter) = [];
    num = length(ch);
    for s = 1:num
        ch(s).MarkerFaceColor = ch(s).MarkerEdgeColor;
        ch(s).MarkerFaceAlpha = 1 / num;
        ch(s).SizeData = 64;
    end
    
    try

        h.XAxis.FontSize = 18;
        h.YAxis.FontSize = 18;
        h.Title.FontSize = 18;
        h.XAxis.Label.FontSize = 18;
        h.YAxis.Label.FontSize = 18;
        h.Legend.FontSize = 18;

        h.XAxis.Label.Interpreter = 'none';
        h.YAxis.Label.Interpreter = 'none';
        h.Title.Interpreter = 'none';
        h.Legend.Interpreter = 'none';
        
    catch ERR
        
        warning(ERR.identifier, 'Error when formatting: %s', ERR.message);
        
    end

end