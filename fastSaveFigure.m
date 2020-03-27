function fastSaveFigure(fig, file_out)

    fr = getframe(fig);
    im = frame2im(fr);
    imwrite(im, file_out);
    
end