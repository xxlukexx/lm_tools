function d = cohensd(x1, x2)
    meanDiff = nanmean(x1) - nanmean(x2);
    sd_pooled = sdpooled(x1, x2);
    d = meanDiff / sd_pooled;
end