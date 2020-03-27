function [unweighted, weighted] = sdpooled(x1, x2)
% calculates the pooled standard deviation, both weighted by sample size
% and unweighted. This uses Cohen's 1998 formulae
%
% Cohen, J. (1988), Statistical Power Analysis for the Behavioral Sciences, 2nd Edition. Hillsdale: Lawrence Erlbaum.
% Hedges L. V., Olkin I. (1985). Statistical methods for meta-analysis. San Diego, CA: Academic Press

    % determine whether there are NaNs in the data 
    hasNans = any(isnan(x1)) || any(isnan(x2));
    if hasNans
        warning('Data has NaN values, will use nanstd instead of std in calculation.')
    end

    % calculate SD for each sample
    if ~hasNans
        sd1 = std(x1);
        sd2 = std(x2);
    else
        sd1 = nanstd(x1);
        sd2 = nanstd(x2);
    end

    % unweighted is the square root of the mean squared SD for each sample
    unweighted = sqrt(((sd1 ^ 2) + (sd2 ^ 2)) / 2);
    
    % weighted is the square root of each squared SD multipled by N
    n1 = length(~isnan(x1));
    n2 = length(~isnan(x2));
    wsd1 = (n1 - 1) * (sd1 ^ 2);
    wsd2 = (n2 - 1) * (sd2 ^ 2);
    weighted = sqrt((wsd1 + wsd2) / (n1 + n2 -2));
    
end