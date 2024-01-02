function fastSaveFig(file_out)

    fr = getframe(gcf);
    img = frame2im(fr);
    imwrite(img, file_out);

end