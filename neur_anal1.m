%% neur_anal1.m
% Zachary Abzug
% 8/20/2013
clear; clc;
%% Load and crop data
load('S18R2A0_2463_Sp2')
[r1 c1] = find(allcodes == 1030); % only look at correct trials
[r2 c2] = find(allcodes == 1901); % only look at leftward choices (for right hemisphere recordings)
r = intersect(r1, r2);

allcodes = allcodes(r, :);
alltimes = alltimes(r, :);
for n = 1:length(allspk_clus);
    allspk_clus{n, 1} = allspk_clus{n, 1}(r, :);
end

%% For completeness
allbad = allbad(r);
alldeleted = alldeleted(r);
allh = allh(r, :);
allnewtrialnums = allnewtrialnums(r);
alloriginaltrialnums = alloriginaltrialnums(r);
allrates = allrates(r);
allrew = allrew(r);
allsacend = allsacend(r, :);
allsaclen = allsaclen(r);
allsacstart = allsacstart(r, :);
allspk = allspk(r, :);
allspkchan = allspkchan(r);
allspklen = allspklen(r);
allstart = allstart(r);
alltrigin = alltrigin(r);
alltrigout = alltrigout(r);
allv = allv(r, :);
rexnumtrials = length(r);
saccadeInfo = saccadeInfo(r, :);

save('S18R2A0_2463_Sp2_new')

%% code    rule(onright)     tg_loc    type
%  4050    0                 R         SS   */
%  4051    1                 R         SS   */
%  4052    0                 L         SS   */
%  4053    1                 L         SS   */
%  4054    0                 R         INS   */
%  4055    1                 R         INS   */
%  4056    0                 L         INS   */
%  4057    1                 L         INS   */

% rule tgs appear - 465x
% sacc onset      - 505x
% fix pt reappear - 565x

% %% Align to target appearance
% for n = 1:length(r)
%     alignpt = find(floor(allcodes(1, :)./10) == 465)
%     alltimes(n, :) = 
