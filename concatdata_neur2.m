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

%% Store everything in cells!
for n = 1:length(tempdata);
    load(char(tempdata(n)));
    [r1 c1] = find(allcodes == 1030); % only look at correct trials
    [r2 c2] = find(allcodes == 1901); % only look at leftward choices (for right hemisphere recordings)
    r = intersect(r1, r2);

    Tallcodes{n} = allcodes(r, :); % some files have 25 columns and some have 24, so assume the 25th column doesn't have any important information
    Talltimes{n} = alltimes(r, :);
%     for k = 1:length(allspk_clus);
%         Tallspk_clus{k, 1}(counter:counter+length(r)-1, :) = allspk_clus{k, 1}(r, :);
%     end

%% For completeness
    Tallbad{n} = allbad(r);
    Talldeleted{n} = alldeleted(r);
    Tallh{n} = allh(r, :);
    Tallnewtrialnums{n} = allnewtrialnums(r);
    Talloriginaltrialnums{n} = alloriginaltrialnums(r);
    Tallrates{n} = allrates(r);
    Tallrew{n} = allrew(r);
    Tallsacend{n} = allsacend(r, :);
    Tallsaclen{n} = allsaclen(r);
    Tallsacstart{n} = allsacstart(r, :);
    Tallspk{n} = allspk(r, :);
    Tallspkchan{n} = allspkchan(r);
    Tallspklen{n} = allspklen(r);
    Tallstart{n} = allstart(r);
    Talltrigin{n} = alltrigin(r);
    Talltrigout{n} = alltrigout(r);
    Tallv{n} = allv(r, :);
    Trexnumtrials{n} = length(r);
    TsaccadeInfo{n} = saccadeInfo(r, :);

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

end

%% Preallocate matrices!
rexnumtrials = sum([Trexnumtrials{:}]);
allh = nan(rexnumtrials, max(cellfun(@max, cellfun(@size, Tallh, 'UniformOutput', 0))));
allsacend = nan(rexnumtrials, max(cell2mat(cellfun(@numel, Tallsacend, 'UniformOutput', 0))./cell2mat(cellfun(@length, Tallsacend, 'UniformOutput', 0))));
allsacstart = nan(rexnumtrials, max(cell2mat(cellfun(@numel, Tallsacstart, 'UniformOutput', 0))./cell2mat(cellfun(@length, Tallsacstart, 'UniformOutput', 0))));
allspk = nan(rexnumtrials, 200);% max(cellfun(@max, cellfun(@size, Tallspk, 'UniformOutput', 0))));
allv = nan(rexnumtrials, max(cellfun(@max, cellfun(@size, Tallv, 'UniformOutput', 0))));

allbad = [Tallbad{:}];
alldeleted = [Talldeleted{:}];
allnewtrialnums = [Tallnewtrialnums{:}];
alloriginaltrialnums = [Talloriginaltrialnums{:}];
allrates = [Tallrates{:}];
allrew = [Tallrew{:}];
allsaclen = [Tallsaclen{:}];
allspkchan = [Tallspkchan{:}];
allspklen = [Tallspklen{:}];
allstart = [Tallstart{:}];
alltrigin = [Talltrigin{:}];
alltrigout = [Talltrigout{:}];

allcodes = vertcat(Tallcodes{:});
alltimes = vertcat(Talltimes{:});

structtemp = struct('status', [], 'starttime', [], 'endtime', [], 'duration', [], 'amplitude', [], 'direction', [], 'peakVelocity', [], 'peakAcceleration', [], 'latency', []);
counter = 1;
for n = 1:length(tempdata);
    allh(counter:counter + Trexnumtrials{n} -1, 1:size(Tallh{n}, 2)) = Tallh{n};
    allv(counter:counter + Trexnumtrials{n} - 1, 1:size(Tallv{n}, 2)) = Tallv{n};
    allsacend(counter:counter + Trexnumtrials{n} - 1, 1:size(Tallsacend{n}, 2)) = Tallsacend{n};
    allsacstart(counter:counter + Trexnumtrials{n} - 1, 1:size(Tallsacstart{n}, 2)) = Tallsacstart{n};
    allspk(counter:counter + Trexnumtrials{n} - 1, 1:size(Tallspk{n}, 2)) = Tallspk{n};
    stmattemp = repmat(structtemp, Trexnumtrials{n}, 1);
    if n == 1 || n == 2;
        TsaccadeInfo{n} = [TsaccadeInfo{n} stmattemp stmattemp];
    end
    counter = counter + Trexnumtrials{n};
end

saccadeInfo = vertcat(TsaccadeInfo{:});

rexname = 'S18R2A0_full_Sp2';
savefolder = '/Users/zmabzug/Desktop/zackdata/processed/Shuffles/';
save(strcat(savefolder, rexname))