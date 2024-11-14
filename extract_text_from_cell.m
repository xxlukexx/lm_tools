function str = extract_text_from_cell(c)
% extracts any text elements of a cell array and returns a concatenated
% string with underscore delimiters. Numeric cell elements are converted to
% string. Non-text, non-numeric cells are converted to their class and
% concatenated

n = numel(c);
strs = {};

for k = 1:n
    elem = c{k};
    if ischar(elem) || isstring(elem)
        % Text element, extract as string
        strs{end+1} = char(elem);
    elseif isnumeric(elem)
        % Numeric cell elements are converted to string
        strs{end+1} = num2str(elem);
    else
        % Non-text, non-numeric cells are converted to their class
        strs{end+1} = class(elem);
    end
end

str = strjoin(strs, '_');
end
