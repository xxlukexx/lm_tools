function [percNum, percStr] = perc(val)
    percNum = (sum(val) / length(val)) * 100;
    percStr = sprintf('%.2f%%', percNum);
end
    