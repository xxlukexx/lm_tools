function t = tscore(x)

warning('Not sure if this works - check!')

    n = length(x);
    mu = mean(x);
    sd = std(x);
    t = (x - mu) / (sd / sqrt(n));

end