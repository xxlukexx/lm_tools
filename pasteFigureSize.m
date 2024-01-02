function pasteFigureSize

    set(gcf, 'position', str2num(clipboard('paste')))
    
end