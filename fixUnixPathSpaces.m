function cmd = fixUnixPathSpaces(cmd)
% replaces spaces in paths with '\ ' so that they work in terminal commands

    cmd = strrep(cmd, ' ', '\ ');

end