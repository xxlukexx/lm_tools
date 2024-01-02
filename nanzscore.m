function Z = nanzscore(X)

    % if matrix, z-score column-wise
    if ~isvector(X) && ismatrix(X)
        Z = X;
        for c = 1:width(X)
            Z(:, c) = nanzscore(X(:, c));
        end
        return
    end
    
    valWithoutNaNs = X(~isnan(X));
    valMean = mean(valWithoutNaNs);
    valSD = std(valWithoutNaNs);
    Z = (X-valMean)/valSD;
    
end