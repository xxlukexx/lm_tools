function [found] = findFilename(fileName, filePath)

    d = dir(filePath);
    found = [];
    
    for curFile = 1:size(d, 1)
        
        if ~d(curFile).isdir
            
            res = strfind(d(curFile).name, fileName);
            if ~isempty(res)
                found = [found; [filePath, filesep, d(curFile).name]];
            end
            
        end
        
    end
    
end