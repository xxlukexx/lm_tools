function out = cell2char(in)

    if ischar(in), out = in; return, end
    if ~iscell(in), error('Input must be cell.'), end

    out = '';
    for i = 1:length(in)
        val = in{i};
        if ischar(val)
            out = [out, '_', val];
        elseif isnumeric(val)
            out = [out, '_', num2str(val)];
        elseif iscell(val)
            subVal = cell2char(val);
            out = [out, '_', subval];
        end
    end
    
    if strcmpi(out(1), '_'), out = out(2:end); end

end