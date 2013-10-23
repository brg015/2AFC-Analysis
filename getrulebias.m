function [rulebias] = getrulebias(allcodes)
% This function takes in a set of 2AFC ecodes and outputs the subject's
% rule selection bias, the percentage of completed SS trials where the
% subject selected rule 0.

[r c] = find(allcodes == 1700);
SStrials = allcodes(r, :);
totalSS = length(r);

[r c] = find(SStrials == 1800);
rule0pix = length(r);

rulebias = rule0pix./totalSS;
end
