function hash = lm_hashClass(varargin)
% reads each property of a class and hashes it. Then hashes all of the
% property hashes. This avoids the situation where a saved-then-loaded
% class has a different hash when calculated on the object (despite having
% identical hashes at the property level). 

    numVars = length(varargin);
    hashes = cell(numVars, 1);
    for i = 1:numVars
        hashes = hashProps(varargin{i});
    end
    hashes = vertcat(hashes{:});
    hash = CalcMD5(hashes);

end

function hashes = hashProps(obj)
    props = sort(properties(obj));
    hashes = cellfun(@(x) lm_hashVariables(obj.(x)), props,...
        'UniformOutput', false);
    
%     tab = table;
%     tab.prop = props;
%     tab.val = cellfun(@(x) obj.(x), props, 'UniformOutput', false);
%     tab.hashes = hashes;
%     disp(tab)
end