function [expPath, dataPath, googleDrivePath, serverPath, devPath] =...
    getExperimentsPath

    %% experiments
    posExp = {...
            '/Users/luke/code/Experiments',...
            '/Users/lukemason/code/Experiments',...
            'C:\Users\lmason\code\Experiments',...
        };
    
    ex = cellfun(@(x) exist(x, 'dir'), posExp);
    ex = ex ~= 0;
    
    if sum(ex) > 1
        expPath = posExp(ex(1));
    else
        expPath = posExp{ex};
    end
    
    %% data
    posData = {...
            'n:\',...
            '/Volumes/Data2_New-1',...
            '/Volumes/LUKEM_1TB_USB',...
            '/Volumes/Projects',...
        };
    
    ex = cellfun(@(x) exist(x, 'dir'), posData);
    ex = ex ~= 0;
    
    if isempty(ex) || all(~ex)
        dataPath = [];
    elseif sum(ex) > 1
        dataPath = posData{find(ex, 1, 'last')};
    else
        dataPath = posData{ex};
    end
    
    %% code
    posData = {...
            '/users/luke/code',...
            '/Users/lukemason/code',...
            'C:\Users\lmason\code',...
        };
    
    ex = cellfun(@(x) exist(x, 'dir'), posData);
    ex = ex ~= 0;
    
    if isempty(ex) || all(~ex)
        googleDrivePath = [];
    elseif sum(ex) > 1
        googleDrivePath = posData(ex(1));
    else
        googleDrivePath = posData{ex};
    end
    
    %% server path
    posData = {...
            '/Volumes/BASIS Data Archive',...
        };
    
    ex = cellfun(@(x) exist(x, 'dir'), posData);
    ex = ex ~= 0;
    
    if isempty(ex) || all(~ex)
        serverPath = [];
    elseif sum(ex) > 1
        serverPath = posData(ex(1));
    else
        serverPath = posData{ex};
    end
    
    %% dev
    posDev = {...
            '/Users/luke/code/dev',...
            '/Users/lukemason/code/dev',...
            'C:\Users\lmason\code\dev',...
        };
    
    ex = cellfun(@(x) exist(x, 'dir'), posDev);
    ex = ex ~= 0;
    
    if sum(ex) > 1
        devPath = posDev(ex(1));
    else
        devPath = posDev{ex};
    end
    
end