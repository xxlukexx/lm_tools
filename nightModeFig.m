function switchToNightMode(figHandle)
    if nargin < 1
        figHandle = gcf;
    end
    
    % Get all children handles in the figure
    allHandles = findall(figHandle);
    
    % Define night mode color scheme
    backgroundColor = [0.15 0.15 0.15];
    textColor = [0.8 0.8 0.8];
    axisColor = [0.5 0.5 0.5];
    lineColor = [0.8 0.8 0.8];
    
    % Loop over each handle and update properties depending on its type
    for i = 1:length(allHandles)
        handle = allHandles(i);
        
        if isa(handle, 'matlab.graphics.axis.Axes')
            set(handle, 'Color', backgroundColor);
            set(handle, 'XColor', axisColor);
            set(handle, 'YColor', axisColor);
            set(handle, 'ZColor', axisColor);
            set(handle, 'GridColor', axisColor);
            set(handle, 'MinorGridColor', axisColor*0.5);
            
        elseif isa(handle, 'matlab.graphics.chart.primitive.Line')
            set(handle, 'Color', lineColor);
            
        elseif isa(handle, 'matlab.graphics.primitive.Text')
            set(handle, 'Color', textColor);
            
        elseif isa(handle, 'matlab.graphics.chart.primitive.Bar') || ...
               isa(handle, 'matlab.graphics.chart.primitive.Histogram')
            set(handle, 'FaceColor', lineColor);
        
        elseif isa(handle, 'matlab.graphics.chart.HeatmapChart')
            set(handle, 'FontColor', textColor);
            set(handle, 'GridVisible', 'on');
            
            % Adjust properties specific to the heatmap here, for example:
            % set(handle, 'Colormap', nightModeColormap);
            % where nightModeColormap is a colormap suitable for night mode.
            
        % Add more conditions here for other object types as necessary
        end
    end
    
    % Set figure background color
    set(figHandle, 'Color', backgroundColor*0.7);
end
