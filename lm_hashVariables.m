function hash = lm_hashVariables(varargin)

    numVars = length(varargin);
    ser = cell(numVars, 1);
    for i = 1:length(varargin)
        ser{i} = getByteStreamFromArray(varargin{i});
    end
    ser = horzcat(ser{:});
    hash = CalcMD5(ser);

end