%% concatdata_neur.m
% Zachary Abzug
% 8/23/2013
clear; clc;
%% Load and crop data
tempdata = {
    'S18R2A0_2463_Sp2';
    'S18R2A0_2464_Sp2';
    'S18R2A0_2465_Sp2'
    };

counter = 1;

%% Preallocate!
Tallh = nan(1, 6000);
Tallv = nan(1, 6000);
Tallsacend = nan(1, 15);
Tallsacstart = nan(1, 15);
Tallspk = nan(1, 100);

for n = 1:length(tempdata);
    load(char(tempdata(n)));
    [r1 c1] = find(allcodes == 1030); % only look at correct trials
    [r2 c2] = find(allcodes == 1901); % only look at leftward choices (for right hemisphere recordings)
    r = intersect(r1, r2);

    numcols = size(allcodes, 2);
    Tallcodes(counter:counter+length(r)-1, 1:numcols) = allcodes(r, 1:numcols); % some files have 25 columns and some have 24, so assume the 25th column doesn't have any important information
    Talltimes(counter:counter+length(r)-1, 1:numcols) = alltimes(r, 1:numcols);
%     for k = 1:length(allspk_clus);
%         Tallspk_clus{k, 1}(counter:counter+length(r)-1, :) = allspk_clus{k, 1}(r, :);
%     end

%% For completeness
    Tallbad(counter:counter+length(r)-1) = allbad(r);
    Talldeleted(counter:counter+length(r)-1) = alldeleted(r);
    Tallh(counter:counter+length(r)-1, :) = allh(r, :);
    Tallnewtrialnums(counter:counter+length(r)-1) = allnewtrialnums(r);
    Talloriginaltrialnums(counter:counter+length(r)-1) = alloriginaltrialnums(r);
    Tallrates(counter:counter+length(r)-1) = allrates(r);
    Tallrew(counter:counter+length(r)-1) = allrew(r);
    Tallsacend(counter:counter+length(r)-1, :) = allsacend(r, :);
    Tallsaclen(counter:counter+length(r)-1) = allsaclen(r);
    Tallsacstart(counter:counter+length(r)-1, :) = allsacstart(r, :);
    Tallspk(counter:counter+length(r)-1, :) = allspk(r, :);
    Tallspkchan(counter:counter+length(r)-1) = allspkchan(r);
    Tallspklen(counter:counter+length(r)-1) = allspklen(r);
    Tallstart(counter:counter+length(r)-1) = allstart(r);
    Talltrigin(counter:counter+length(r)-1) = alltrigin(r);
    Talltrigout(counter:counter+length(r)-1) = alltrigout(r);
    Tallv(counter:counter+length(r)-1, :) = allv(r, :);
    Trexnumtrials = counter + length(r) -1;
    TsaccadeInfo(counter:counter+length(r)-1, :) = saccadeInfo(r, :);

    counter = counter + length(r);
%% code    rule(onright)     tg_loc    type
%  4050    0                 R         SS   */
%  4051    1                 R         SS   */
%  4054    0                 L         SS   */
%  4055    1                 L         SS   */
%  4052    0                 R         INS   */
%  4053    1                 R         INS   */
%  4056    0                 L         INS   */
%  4057    1                 L         INS   */

% rule tgs appear - 465x
% sacc onset      - 505x
% fix pt reappear - 565x

% %% Align to target appearance
% for n = 1:length(r)
%     alignpt = find(floor(allcodes(1, :)./10) == 465)
%     alltimes(n, :) = 

end
