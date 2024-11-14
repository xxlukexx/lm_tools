function d_child = lm_get_child_folders(path_parent)
% list only subfolders within a folder

    filter_out = {...
        '.', '..', '.Trashes', '.fseventsd', '.TemporaryItems'};

    d_child = dir(path_parent);
    
    % detect files
    idx_file = ~[d_child.isdir];
    
    % detect file system crap like '.', '..' etc
    idx_crap = false(1, length(d_child));
    for i = 1:length(d_child)
        
        % does it match the filters we defined above?
        idx_matches_filter = ismember(d_child(i).name, filter_out);
        
        % does the filename start with underscore or dot?
        idx_ignore = ismember(d_child(i).name(1), {'_', '.'});
        idx_crap(i) = idx_matches_filter | idx_ignore;
        
    end
    
    % remove any files or crap, thus just returning folders
    d_child(idx_file | idx_crap) = [];
    
end