function match = compare_folders(path_ses, path_gaze)
% Compare the contents of two folders, matching files by name and MD5 hash.

% Get a list of files in each folder.
files_ses = dir(fullfile(path_ses, '*'));
files_gaze = dir(fullfile(path_gaze, '*'));

% Exclude directories from the file lists.
files_ses = files_ses(~[files_ses.isdir]);
files_gaze = files_gaze(~[files_gaze.isdir]);

% Sort the file lists by name.
[~, sort_ses] = sort({files_ses.name});
files_ses = files_ses(sort_ses);
[~, sort_gaze] = sort({files_gaze.name});
files_gaze = files_gaze(sort_gaze);

% Check if the two folders contain the same number of files.
if numel(files_ses) ~= numel(files_gaze)
    match = false;
    return;
end

% Compare each file in the two folders by name and MD5 hash.
for i = 1:numel(files_ses)
    if ~strcmp(files_ses(i).name, files_gaze(i).name)
        match = false;
        return;
    end
    file_ses = fullfile(path_ses, files_ses(i).name);
    file_gaze = fullfile(path_gaze, files_gaze(i).name);
    md5_ses = CalcMD5(file_ses, 'File');
    md5_gaze = CalcMD5(file_gaze, 'File');
    if ~strcmp(md5_ses, md5_gaze)
        match = false;
        return;
    end
end

% If we reach this point, the two folders contain the same files with the same MD5 hashes.
match = true;
end
