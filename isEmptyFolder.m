function empty = isEmptyFolder(folderName)
% ISFOLDEREMPTY Check if a folder is empty
%
%   empty = ISFOLDEREMPTY(folderName) returns a boolean value indicating
%   whether the specified folder is empty or not. The input argument
%   'folderName' should be a string specifying the name of the folder to
%   be checked.
%
%   Example:
%   empty = isFolderEmpty('myFolder');
%   if empty
%       disp('Folder is empty');
%   else
%       disp('Folder is not empty');
%   end

% Get directory listing for the folder
folderContents = dir(folderName);

% Check if the folder is empty
if numel(folderContents) == 2 % If folder is empty, only '.' and '..' are present
    empty = true;
else
    empty = false;
end

end
