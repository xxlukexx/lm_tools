function names = listFolders(path_folder)

    if ~exist(path_folder, 'dir')
        error('Path not found: %s', path_folder)
    end
    
    d = dir(path_folder);
    idx_rem = ~[d.isdir];
    idx_rem = idx_rem | ismember({d.name}, {'.', '..'});
    d(idx_rem) = [];
    names = {d.name}';

end