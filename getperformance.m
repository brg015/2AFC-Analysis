function [perf, numtrials] = getperformance(allcodes);
% This function takes in a set of ecodes, and determines performance.
% Performance is the number of trials with the reward code 1030 divided by
% the total number of trials.

[r c] = find(allcodes == 1030);
numcorrect = length(r);
numtrials = size(allcodes, 1);
perf = numcorrect./numtrials;
end