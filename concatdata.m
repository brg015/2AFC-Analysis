function [] = concatdata(file1, file2, newname);
% This function takes two files (file1 and file2), concatenates allcodes
% and alltimes, and saves them as a new datafile, newname.

tempdata = {
    file1;
    file2};

counter = 1;

for n = 1:length(tempdata);
    load(char(tempdata(n)));
    numcols = size(allcodes, 2);
    Tallcodes(counter:counter+rexnumtrials-1, 1:numcols) = allcodes(:, 1:numcols); % some files have 25 columns and some have 24, so assume the 25th column doesn't have any important information
    Talltimes(counter:counter+rexnumtrials-1, 1:numcols) = alltimes(:, 1:numcols);
    counter = counter + rexnumtrials;
end

clear allcodes alltimes
allcodes = Tallcodes;
alltimes = Talltimes;

savefolder = '/Users/zacharyabzug/Desktop/zackdata/processed/Shuffles/';

save(strcat(savefolder, newname), 'allcodes', 'alltimes');