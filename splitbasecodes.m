function [splitcodes] = splitbasecodes(allcodes);
% This function takes in a set of ecodes, and outputs a cell array of the
% same codes, split by the basecode.

[r c] = find(allcodes >= 4000 & allcodes <= 7999, 1);
base_ind = c;
basecodes = unique(allcodes(:, base_ind));
splitcodes = cell(length(basecodes), 1);
for n = 1:length(basecodes);
    [r c] = find(allcodes == basecodes(n));
    tempcodes = allcodes(r, :);
    splitcodes{n, 1} = tempcodes;
end