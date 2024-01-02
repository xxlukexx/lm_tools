function s = catstruct(s1, s2, fieldPrefix)

    if length(s1) ~= length(s2)
        error('Cannot merge structs with unequal number of elements.')
    end
    
    f1 = fieldnames(s1);
    f2 = fieldnames(s2);
    numElements = length(s1);
    
    if exist('fieldPrefix', 'var') && ~isempty(fieldPrefix) 
        if ~ischar(fieldPrefix)
            error('''fieldPrefix'' must be char');
        end
        f2_new = cellfun(@(x) sprintf('%s_%s', fieldPrefix, x), f2,...
            'UniformOutput', false);
    else
        f2_new = f2;
    end
    
    for i = 1:numElements
        for f = 1:length(f1)
            s(i).(f1{f}) = s1(i).(f1{f});
        end
        for f = 1:length(f2)
            s(i).(f2_new{f}) = s2(i).(f2{f});
        end
    end
    
end