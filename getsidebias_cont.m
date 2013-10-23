function [sidebias_cont] = getsidebias_cont(allcodes)
% This function takes in a set of 2AFC ecodes and outputs the subject's
% side selection bias, the percentage of completed INS trials where the
% subject selected the rule target on the right side.

[r c] = find(allcodes == 1701);
INStrials = allcodes(r, :);
totalINS = length(r);

[r c] = find(INStrials == 1900);
sideRpix = length(r);

sidebias_cont = sideRpix./totalINS;
end
