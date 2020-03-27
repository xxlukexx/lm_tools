function [ width, height ] = MonitorSizeFromDiagonal( diaganol, xRatio, yRatio )
% MonitorSizeFromDiagonal takes the diaganol length of a monitor screen, and
% the aspect ratio, and returns the width and height.
%   If you have the ratio in the form of, e.g. '4:3' then '4' is the xRatio
%   and '9' is the yRatio. If you have it in the form of, e.g. '1.777' then
%   '1.777' is the xRatio and '1' is the yRatio

height=(diaganol*yRatio)/sqrt((xRatio^2)+(yRatio^2));
width=(xRatio/yRatio)*height;
end

