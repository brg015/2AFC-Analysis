function [truncodes, truntimes] = findcompleted(filename);
% This function takes in a processed 2AFC mat-file, and outputs allcodes and alltimes, but only with rows of completed
% trials. Correct trials have a 1030 code, and incorrect trials have a
% 17386 code.

load(filename);
[r c] = find(allcodes == 1030 | allcodes == 17386);
truncodes = allcodes(r, :);
truntimes = alltimes(r, :);
% trunspk = allspk(r, :);
% for n = 1:length(allspk_clus);
%     trunspk_clus{n, 1} = allspk_clus{n, 1}(r, :);
% end
end