function [sidebias] = getsidebias(allcodes)
% This function takes in a set of 2AFC ecodes and outputs the subject's
% side selection bias, the percentage of completed SS trials where the
% subject selected the rule target on the right side.

[r c] = find(allcodes == 1700);
SStrials = allcodes(r, :);
totalSS = length(r);

[r c] = find(SStrials == 1900);
sideRpix = length(r);

sidebias = sideRpix./totalSS;
end
