function p = prop(m, dim)
    if nargin == 1
        dim = 1;
        if isvector(m) && size(m, 2) > size(m, 1)
            m = m';
        end
    end
    p = sum(m, dim) / size(m, dim);
end