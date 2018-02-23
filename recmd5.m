function hash = recmd5(pth)

    % get files and file info
    files = recdir(pth, '-silent');
    info = cellfun(@dir, files, 'uniform', false);
    
    % check for empty (as in, non-readable) file info
    nonRead = cellfun(@isempty, info);
    info(nonRead) = [];
    
    % get sizes and dates
    sizes = cellfun(@(x) x.bytes, info);
    datetimes = cellfun(@(x) x.datenum, info);
    
    % hash sizes and dates
    hash = CalcMD5(num2str([sizes; datetimes]), 'Char');
    
end