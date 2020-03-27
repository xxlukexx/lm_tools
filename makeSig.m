function [sig, sig_u, sig_i, sig_s, numSig] = makeSig(tab, vars)

    numRows = size(tab, 1);
    numVars = length(vars);
    vals = cellfun(@(x) tab.(x), vars, 'UniformOutput', false);

    sig = cell(numRows, 1);
    for r = 1:numRows
        sig{r} = '';
        for v = 1:numVars
            curVals = vals{v};
            if iscell(curVals)
                sig{r} = [sig{r}, vals{v}{r}, '#'];
            else
                sig{r} = [sig{r}, num2str(vals{v}(r)), '#'];
            end
        end
        sig{r}(end) = [];
    end
    
    [sig_u, sig_i, sig_s] = unique(sig);
    numSig = length(sig_u);

end