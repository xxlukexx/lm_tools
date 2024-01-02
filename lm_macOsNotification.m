function lm_macOsNotification(msg)
    if ~ismac, error('This only works on macOS.'); end
    setenv('PATH', [getenv('PATH') ':/usr/local/bin']);
    cmd = sprintf('terminal-notifier -message %s', msg);
    system(cmd)
end