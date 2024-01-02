function subplotylim(yl)
% sets all subplot axes ylmits to yl, or if yl is omitted, automatically
% sets them to the min/max across all subplots

    h = findall(gcf, 'type', 'axes');
    yl_now = arrayfun(@ylim, h, 'UniformOutput', false);
    yl_now = vertcat(yl_now{:});
    
    if ~exist('yl', 'var') || isempty(yl)
        yl = [min(yl_now(:, 1)), max(yl_now(:, 2))];
    end
    
    arrayfun(@(x) ylim(x, yl), h)

end