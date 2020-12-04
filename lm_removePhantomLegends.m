function lm_removePhantomLegends(h)

    % rename 'data' in legend to SEM
    leg = findobj(h, 'type', 'legend');
    num = length(leg);
    for l = 1:num
        found = arrayfun(@(x) x.String, leg(l), 'UniformOutput', false);
        if ~isempty(found)
            found = found{1};
            idx = contains(found, 'data');
            leg(l).String(idx) = [];
        end
    end

end