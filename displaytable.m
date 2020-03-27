function varargout = displaytable(tab)

    str = evalc('disp(tab)');
    
    s1 = strfind(str, '<');
    s2 = strfind(str, '>');
    for i = 1:length(s1)
        str(s1(i):s2(i)) = repmat(char(1000), 1, length(str(s1(i):s2(i))));
    end
    str = strrep(str, char(1000), '');
    
    if nargout == 0
        disp(str)
    else
        varargout = {str};
    end
    
end