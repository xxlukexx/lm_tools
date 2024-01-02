function r = rankorder(m)

    sz = size(m);
    m = reshape(m, 1, []);

    [~, ii] = sort(m, 'Descend');
    [~, r] = sort(ii);
    
    r = reshape(r, sz);

end