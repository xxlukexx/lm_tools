function out = lm_parentFolder(in)
% takes a relative or absolute path (any string with 'filesep' seperators
% -- either '/' or '\', depending on OS), and removes the last delimited
% element, effectively moving up to the parent folder in a directory tree.
% If the input is already a root folder, returns that root. 
    
    if ~ischar(in) || ~contains(in, filesep)
        error('Input must be a char containing ''%s'' characters.', filesep)
    end

    parts = strsplit(in, filesep);
    
    % detect root folder
    if length(parts) == 1
        out = in; 
        return
    elseif length(parts) > 1
        out = [filesep, fullfile(parts{1:end - 1})];
    elseif isempty(parts)
        % this shouldn't ever happen but catch it in case
        error('No ''%s'' characters found in input.', filesep)
    end 

end