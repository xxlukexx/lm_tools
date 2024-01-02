function img = checkloadimage(in)

    if ischar(in)
        try
            img = imread(in);
        catch ERR
            img = [];
        end
    elseif isnumeric(in)
        img = in;
    end
    
end