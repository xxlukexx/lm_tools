function z_scores = movingAverageZScore(time_series, segment_length, m, fs)
    % time_series: the input time series data
    % segment_length: the length of each segment in seconds
    % m: the number of previous segments to use for calculating mean and std
    % fs: sampling frequency of the time series

    % Ensure time_series is a column vector
    if isrow(time_series)
        time_series = time_series';
    end

    segment_samples = segment_length * fs;  % Convert segment length to samples
    num_segments = floor(length(time_series) / segment_samples);  % Total number of segments
    z_scores = NaN(size(time_series));  % Initialize the z-score array with NaNs

    for i = m+1:num_segments
        % Get the current segment
        current_segment = time_series((i-1)*segment_samples + 1:i*segment_samples);
        
        % Get the previous m segments
        previous_segments = time_series((i-m-1)*segment_samples + 1:(i-1)*segment_samples);
        
        if m == 1
            % If m is 1, previous_segments will be a column vector
            mean_prev = nanmean(previous_segments);
            std_prev = nanstd(previous_segments);
        else
            % Reshape to m columns to calculate mean and std across segments, ignoring NaNs
            previous_segments_matrix = reshape(previous_segments, segment_samples, m);
        
            % Compute mean and std dev of the previous m segments, ignoring NaNs
            mean_prev = nanmean(previous_segments_matrix, 2);
            std_prev = nanstd(previous_segments_matrix, 0, 2);
        end

        % Ensure mean_prev and std_prev are column vectors
        mean_prev = mean_prev(:);
        std_prev = std_prev(:);

        % Handle cases where std_prev is NaN by setting to a small value or zero
        std_prev(isnan(std_prev)) = 1;  % Setting NaNs in std to 1 to avoid division by NaN

        % Z-score the current segment, ignoring NaNs in the current segment
        z_scores((i-1)*segment_samples + 1:i*segment_samples) = ...
            (current_segment - mean_prev) ./ std_prev;
    end
    
    % Handle the initial m segments without enough previous segments (optional)
    % This can be done by setting them to NaN, zero-padding, or using a global mean/std
    z_scores(1:m*segment_samples) = NaN;  % Example: setting to NaN
end
