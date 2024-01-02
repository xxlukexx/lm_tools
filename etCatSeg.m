function seg = etCatSeg(varargin)

    if ~all(cellfun(@isstruct, varargin))
        error('All input arguments must be seg structs.')
    end

    % check filednames match
    fnames = cellfun(@fieldnames, varargin, 'UniformOutput', false);
    if ~all(isequal(fnames{:}))
        error('Mismatched fieldnames between seg structs.')
    end
    
    num = length(varargin);
    seg = varargin{1};
    for i = 2:num
        for f = 1:length(fnames{1})
            seg.(fnames{1}{f}) = [seg.(fnames{1}{f}), varargin{i}.(fnames{1}{f})];
        end
    end
    
    seg.numIDs = length(seg.ids);
    
end