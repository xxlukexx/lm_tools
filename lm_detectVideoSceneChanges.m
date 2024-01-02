function [onsets, path_seg] = lm_detectVideoSceneChanges(path_video, path_out)
% reads all frames from a video, calculates inter-frame sum of squared
% distances. Finds outliers (large changes across all three RGB colour
% channels) where z > 5 and marks these as scene transitions. Returns frame
% indices of each scene onset.
%
% optionally segments the input video to an output video, if path_out is
% specified

    % read all frames, downsample by 10x
    vr = VideoReader(path_video);
    w = round(vr.Width / 10);
    h = round(vr.Height / 10);
    numFrames = vr.NumFrames;
    fr = zeros(h, w, 3, numFrames);
    fr_full = zeros(vr.Height, vr.Width, 3, numFrames, 'uint8');
    f = 1;
    while vr.hasFrame
        fr_full(:, :, :, f) = vr.readFrame;
        fr(:, :, :, f) = imresize(fr_full(:, :, :, f), [h, w]);
        f = f + 1;
    end
    clear vr

    % calculate sum of squared distances between frames
    ssd = diff(fr, [], 4) .^ 2;

    % find mean inter-frame SSDs on each RGB channel
    md = nan(size(ssd, 4), 3);
    for i = 1:size(ssd, 4)
        md(i, 1) = mean(mean(ssd(:, :, 1, i)));
        md(i, 2) = mean(mean(ssd(:, :, 2, i)));
        md(i, 3) = mean(mean(ssd(:, :, 3, i)));
    end
    
    % z-score mean differences
    zmd = zscore(md);
    
    % threshold mean differences to find onsets
    ct = findcontig2(all(zmd > 5, 2));
    onsets = ct(:, 1);
    offsets = [ct(2:end, 1); numFrames];
    
    % optionally write video segments out to new files
    if exist('path_out', 'var') && ~isempty(path_out)
        tryToMakePath(path_out);
        
        numSegs = size(ct, 1);
        path_seg = cell(numSegs, 1);
        for i = 1:numSegs
            path_seg{i} = fullfile(path_out, sprintf('scene%02d.mp4', i));
        end
        
        parfor i = 1:numSegs
            fprintf('Scene %d of %d: %s\n', i, numSegs, path_seg{i});
            vw = VideoWriter(path_seg{i}, 'MPEG-4');
            open(vw)
            f1 = onsets(i);
            f2 = offsets(i);
            for f = f1:f2
                writeVideo(vw, fr_full(:, :, :, f))
            end
            close(vw)
        end
        
    end

end
    
    
% path_out = '/users/luke/desktop/saltmp';
% nsp = numSubplots(size(ct, 1));
% figure('WindowStyle', 'docked')
% parfor i = 1:size(ct, 1) - 1
%     
%     file_out = fullfile(path_out, sprintf('scene%02d.mp4', i));
%     fprintf('Scene %d of %d: %s\n', i, size(ct, 1) - 1, file_out);
%     vw = VideoWriter(file_out, 'MPEG-4');
%     open(vw)
%     f1 = ct(i, 1);
%     f2 = ct(i + 1, 1);
%     for f = f1:f2
%         writeVideo(vw, fr(:, :, :, f))
%     end
%     close(vw)
%     
%     
% %     subplot(nsp(1), nsp(2), i)
% %     imshow(fr(:, :, :, ct(i, 1)))
% end
% 
% 
% for f1 = 1:100:size(fr, 4)
%     figure('WindowStyle', 'docked')
%     idx = 1;
%     for f = f1:f1+99
%         subplot(10, 10, idx)
%         imagesc(ssd(:, :, 1, f))
%         idx = idx + 1;
%     end
% end