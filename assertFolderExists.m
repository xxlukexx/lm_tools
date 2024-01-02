function assertFolderExists(varargin)

    ex = cellfun(@(x) exist(x, 'dir'), varargin);
    if any(~ex)
        fprintf('Path(s) not found:\n')
        fprintf('\t%s\n', varargin{~ex})
    end
    
end
