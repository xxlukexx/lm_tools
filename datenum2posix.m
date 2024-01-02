function posix = datenum2posix(days)

    matlab_epoch = datenum(0,1,0); % January 0, 0000
    date = matlab_epoch + days;

    % Convert to POSIX timestamp 
    posix = date - datenum(1970,1,1);
    posix = posix * 24 * 60 * 60; % Convert to seconds
    
end