function cmap = customColorMap(numSteps, varargin)

    % Check if number of arguments is even
    if mod(length(varargin),2) ~= 0
        error('Arguments should come in pairs of a set point and a RGB triplet');
    end
    
    setPoints = cell2mat(varargin(1:2:end))';
    setCols = cell2mat(varargin(2:2:end)');
    
    setPoints = [0; setPoints; 1];
    setCols = [setCols(1, :); setCols; setCols(end, :)];
    
    steps_prop = linspace(0, 1, numSteps);
    
    cmap = interp1(setPoints, setCols, steps_prop');
    

%     % Get the number of color transition points
%     nColors = length(varargin)/2;
% 
%     % Initialize arrays to store set points and RGB values
%     setPoints = zeros(1, nColors);
%     rgbValues = zeros(nColors, 3);
% 
%     % Fill setPoints and rgbValues from varargin
%     for i = 1:nColors
%         setPoints(i) = varargin{2*i - 1};
%         rgbValues(i, :) = varargin{2*i};
%     end
% 
%     % Generate a list of steps
%     steps = linspace(0, 1, numSteps);
% 
%     % Interpolate each color channel separately using interp1
%     cmap = zeros(numSteps, 3);
%     for i = 1:3
%         cmap(:, i) = interp1(setPoints, rgbValues(:, i), steps);
%     end
end
