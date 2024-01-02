function out = cell2char(in, replaceChar)

    if isempty(in), out = []; return, end
        
    if ~exist('replaceChar', 'var') || isempty(replaceChar)
        replaceChar = '_';
    end

    if ischar(in), out = in; return, end
    if ~iscell(in), error('Input must be cell.'), end

    out = '';
    for i = 1:length(in)
        val = in{i};
        if ischar(val)
            out = [out, replaceChar, val];
        elseif isnumeric(val)
            for ii = 1:length(val)
                out = [out, replaceChar, num2str(val(ii))];
            end
        elseif iscell(val)
            subVal = cell2char(val);
            out = [out, replaceChar, subVal];
        end
    end
    
    if strcmpi(out(1:length(replaceChar)), replaceChar), out = out(length(replaceChar) + 1:end); end

end