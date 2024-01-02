function s_flat = lm_flattenStruct(s, parentField)

    if ~isstruct(s)
        error('Must pass a struct to this function.')
    end
    
    fnames = fieldnames(s);
    numFields = length(fnames);
    s_flat = struct;
    for f = 1:numFields
        
        if isstruct(s.(fnames{f}))
            
            s_flat_rec = lm_flattenStruct(s.(fnames{f}), fnames{f});
            s_flat = catstruct(s_flat, s_flat_rec);
            
        else
            
            if isempty(parentField)
                s_flat.(fnames{f}) = s.(fnames{f});
            else
                f_flat = sprintf('%s_%s', parentField, fnames{f});
                s_flat.(f_flat) = s.(fnames{f});
            end
            
        end
        
    end

end