function lm_benchmarkPTBVideoDecode(path_vid)

    Screen('Preference', 'SkipSyncTests', 2);
    w = Screen('OpenWindow', 1);
    [m, ~, ~, ~, ~, numFrames] = Screen('OpenMovie', w, path_vid);
    Screen('SetMovieTimeIndex', m, 0)
    
    tx = [];
    t_get = nan(numFrames, 1);
    i = 1;
    for i = 1:numFrames
        t1 = GetSecs;
        tx = Screen('GetMovieImage', w, m);
        t_get(i) = GetSecs - t1;
        i = i + 1;
        if mod(i, 200) == 0
            fprintf('Frame %d of %d...\n', i, numFrames);
            Screen('DrawTexture', w, tx);
            Screen('Flip', w);
        end
        
        if tx > 0
            Screen('Close', tx); 
        end
    end
    
    fprintf('Mean time to decode a frame: %.1fms (SD = %.1fms)\n',...
        nanmean(t_get) * 1000, nanstd(t_get) * 1000);
    subplot(1, 2, 1)
    plot(t_get * 1000);
    subplot(1, 2, 2)
    histogram(t_get * 1000);
    
    sca
    
end