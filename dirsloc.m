function sl = dirsloc(pth)

    allFiles = recdir(pth);
    [~, ~, ext] = cellfun(@fileparts, allFiles, 'UniformOutput', false);
    allFiles = allFiles(strcmpi(ext, '.m'));
    sl = 0;
    for i = 1:length(allFiles)
        try
            sl = sl + sloc(allFiles{i});
        catch ERR
            fprintf('Could not read SLOC on: %s\n', allFiles{i});
        end
    end
    
end