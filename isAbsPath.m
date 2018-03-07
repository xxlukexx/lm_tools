function isAbs = isAbsPath(pth)

    % make test path, by appending path to pwd, then test path as passed to
    % this function, and the test path, to see if they exist
    pth_test = fullfile(pwd, pth);
    ex_pth = exist(pth, 'dir');
    ex_test = exist(pth_test, 'dir');
    % interpret
    if ex_pth && ex_test
        % both the path and the test path exist, this means the path was
        % relative (since appending the path to pwd effectively converts a
        % relative path to an absolute path)
        isAbs = false;
    elseif ex_pth && ~ex_test
        % only the path exists, but the test path does not. This means that
        % the path must be absolute (since appending pwd to an absolute
        % path makes no sense)
        isAbs = true;
    elseif ~ex_pth && ~ex_test
        % neither path exists - throw and error
        error('Path not found.')
    end
    
end