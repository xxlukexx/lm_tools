function struct2ws(s)

    fnames = fieldnames(s);
    for i = 1:length(fnames)
        evalin('caller', [fnames{i} '=s.' fnames{i}])
    end

end
