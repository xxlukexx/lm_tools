function sheets = readAllExcelSheets(path_xl)

    % don't know how many sheets there are or what their names are, so
    % increment sheet index until an error
    sheetIdx = 1;
    allSheetsRead = false;
    sheets = cell(100, 1);
    while ~allSheetsRead
        
        try
            sheets{sheetIdx} = readtable(path_xl,...
                'Sheet', sheetIdx);
            sheetIdx = sheetIdx + 1;
        catch ERR
            switch ERR.identifier
                case 'MATLAB:spreadsheet:book:openSheetIndex'
                    allSheetsRead = true;
                otherwise 
                    rethrow(ERR)
            end
        end
        
    end
    sheets = sheets(1:sheetIdx - 1);

end