function s = lm_prejsonencode(s)

    if ~isstruct(s)
        error('Only currently works on structs.')
    end
    
    % replace org.bson.types.ObjectID with Mongo DB string that will
    % recreate one when uploaded
    s = recParseObjectIDs(s);
    
    
end

function s = recParseObjectIDs(s)

    fnames = fieldnames(s);
    num = length(fnames);
     
    for f = 1:num
        
        var = fnames{f};
        val = s.(var);
        
        fprintf('%s\n', var)
        
        if isa(val, 'org.bson.types.ObjectId')
%             s.(fnames{f}) = sprintf('ObjectId("%s")', char(val));
            s.(fnames{f}) = char(val);
        elseif isstruct(val)
            s.(fnames{f}) = recParseObjectIDs(val);
        end
        
    end
    
end