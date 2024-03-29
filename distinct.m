function cols = distinct(num)

    cols = [...
        230, 25, 75;...
        60, 180, 75;...
        255, 225, 25;...
        0, 130, 200;...
        245, 130, 48;...
        145, 30, 180;...
        70, 240, 240;...
        240, 50, 230;...
        210, 245, 60;...
        250, 190, 190;...
        0, 128, 128;...
        230, 190, 255;...
        170, 110, 40;...
        255, 250, 200;...
        128, 0, 0;...
        170, 255, 195;...
        128, 128, 0;...
        255, 215, 180;...
        0, 0, 128];
    
    cols = cols ./ 255;
    
    if num < size(cols, 1)
        cols = cols(1:num, :);
    else
        numReps = floor((num / size(cols, 1)));
        rem = mod(num, size(cols, 1));
        cols = [repmat(cols, numReps, 1); cols(1:rem, :)];
    end
    
end

