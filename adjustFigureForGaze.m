function adjustFigureForGaze(h)

    if ~exist('h', 'var') || isempty(h)
        h = gca;
    end
    
    xlim(h, [0, 1])
    ylim(h, [0, 1])
    set(h, 'ydir', 'reverse')
    
end

    