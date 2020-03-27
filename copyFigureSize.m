function copyFigureSize

    pos = get(gcf, 'position');
    clipboard('copy', num2str(pos))

end