function val = dirclean(varargin)
    val = dir(varargin{:});
    idx_rem = ismember({val.name}, {'.', '..', '.DS_Store'});
    val(idx_rem) = [];
end
    