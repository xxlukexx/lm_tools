function res = assertPosition(val)

    res = isnumeric(val) && isvector(val) && length(val) == 4 &&...
        all(val(1:2) >= 0) && all(val(3:4) >= 1);
    
end
