function out = jdir(path)

    % Store original path for output
    originalPath = path;
    
    % Expand the tilde (~) manually to the user's home directory for internal use
    if startsWith(path, '~')
        path = strrep(path, '~', getenv('HOME'));
    end

    % Make java file object, then get file list
    fo = java.io.File(path);
    fl = fo.listFiles;
    
    % Handle cases where the directory is empty or doesn't exist
    if isempty(fl)
        out = struct('name', {}, 'bytes', {}, 'isdir', {}, 'fullPath', {}, 'parent', {});
        return;
    end
    
    % Extract names and whether each entry is a directory
    name = arrayfun(@(x) char(x.getName), fl, 'UniformOutput', false);
    isDir = arrayfun(@(x) x.isDirectory, fl);
    fullPath = arrayfun(@(x) fullfile(originalPath, char(x.getName)), fl, 'UniformOutput', false);
    parent = repmat({originalPath}, size(name)); % Use original path for parent
    bytes = arrayfun(@(x) x.length, fl);
    
    % Put the results in a struct
    out = struct(...
        'name', name,...
        'bytes', num2cell(bytes),...
        'isdir', num2cell(isDir),...
        'fullPath', fullPath,...
        'parent', parent);
end
