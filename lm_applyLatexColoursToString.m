function [latexString] = lm_applyLatexColoursToString(string, rgbTriplet)
    latexString = ['{\color[rgb]{' num2str(rgbTriplet(1)) ' ' num2str(rgbTriplet(2)) ' ' num2str(rgbTriplet(3)) '}' string '}'];
end