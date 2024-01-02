function findAndPackageDependencies(path_in, path_out)

    files = matlab.codetools.requiredFilesAndProducts(path_in)';
    
    [pth, fil, ext] = fileparts(files);
    parts = cellfun(@(x) strsplit(x, filesep), pth, 'UniformOutput', false);
    [u_pack, i_pack] = unique(cellfun(@(x) x{end}, parts, 'UniformOutput', false));
    path_pack = pth(i_pack);
    c = [path_pack, num2cell(true(length(path_pack), 1))];
    
    %%
    fig = figure('name', 'Select packages', 'Units', 'normalized', 'Position', [0.25, 0.25, 0.5, 0.5]);
    utab = uitable(...
        'parent', fig,...
        'data', c,...
        'Units', 'normalized',...
        'position', [0, 0.1, 1, .9],...
        'ColumnName', {'package', 'include'},...
        'ColumnEditable', [false, true],...
        'CellEditCallback', @tabEdit,...
        'FontSize', 18);
    uitableAutoColumnHeaders(utab)
        
    button = uicontrol('parent', fig, 'Style', 'pushbutton', 'String', 'Package', 'units', 'normalized', 'Position', [0, 0, 1, .1], 'Callback', @doPack);
%     button = uibutton('parent', fig, 'position', [0, 0.9, 1, .1], 'text', 'Package', 'ButtonPushedFcn', @doPack)

    function tabEdit(obj, event)
        c = obj.Data;
    end

    function doPack(obj, event)
        
        idx = cell2mat(c(:, 2));
        c = c(idx, :);
        u_pack = u_pack(idx);
        fprintf('Packaging...\n')
        for i = 1:size(c, 1)
            src = c{i, 1};
            dest = fullfile(path_out, u_pack{i});
            fprintf('\tCopying %s to %s...\n', src, dest);
            copyfile(src, dest)
        end
        
        copyfile(path_in, path_out)
        
    end




end