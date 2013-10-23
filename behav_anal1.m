%% behav_anal1.m
% Zachary Abzug
% Created 7/1/2013

% Behavioral analysis for multiple sessions, individually.
clear;
%% Run through analysis for multiple days
datasets = {
    'S16R2P1_1793_REX';
    'S17R2P2_cat';
    'S18R2A0_cat';
    'S20130621b_REX';
    'S20130624a_REX';
    'S20R2A1_1823_REX';
    'S21R2P2_1203_REX';
    'S22R2A0_cat';
    'S23R2P1_2383_REX';
    'S20130702a_REX';
    'S20130703c_REX';
	'S20130725a_REX';
    'S20130726a_REX';
    'S20130730a_REX';
    'S20130731a_REX';
    };

% datasets = {
%     'S20130702a_REX';
%     };

for n = 1:length(datasets);
    [truncodes, truntimes] = findcompleted(char(datasets(n))); % pull out completed trials
    splitcodes = splitbasecodes(truncodes);
%     for cond = 1:length(splitcodes);
%         [perf, numtrials] = getperformance(splitcodes{cond});
%         bigperf(cond, n) = perf;
%     end
    lilsplits = cell(4, 1); % get rid of correct target location as a variable
    lilsplits{1} = [splitcodes{1}; splitcodes{5}]; % SS - Rule 0
    lilsplits{2} = [splitcodes{2}; splitcodes{6}]; % SS - Rule 1
    lilsplits{3} = [splitcodes{3}; splitcodes{7}]; % INS - Rule 0
    lilsplits{4} = [splitcodes{4}; splitcodes{8}]; % INS - Rule 1
    for cond = 1:length(lilsplits);
        [perf, numtrials] = getperformance(lilsplits{cond});
        bigperf(cond, n) = perf;
    end
    rule0bias(n) = getrulebias(truncodes);
    sideRbias(n) = getsidebias(truncodes);
    sideRbias_cont(n) = getsidebias_cont(truncodes);
end

bigperfvec = reshape(bigperf.',[],1);
tasktype = cell(length(bigperfvec), 1);
tgloc = cell(length(bigperfvec), 1);
rule = cell(length(bigperfvec), 1);
for n = 1:length(bigperfvec)
    if n >= 1;
        tasktype{n} = 'SS';
        tgloc{n} = 'R';
        rule{n} = '0';
    end
    if n >= 16;
        tasktype{n} = 'SS';
        tgloc{n} = 'R';
        rule{n} = '1';
    end
    if n >= 31;
        tasktype{n} = 'SS';
        tgloc{n} = 'L';
        rule{n} = '0';
    end
    if n >= 46;
        tasktype{n} = 'SS';
        tgloc{n} = 'L';
        rule{n} = '1';
    end
    if n >= 61;
        tasktype{n} = 'INS';
        tgloc{n} = 'R';
        rule{n} = '0';
    end
    if n >= 76;
        tasktype{n} = 'INS';
        tgloc{n} = 'R';
        rule{n} = '1';
    end
    if n >= 91;
        tasktype{n} = 'INS';
        tgloc{n} = 'L';
        rule{n} = '0';
    end
    if n >= 106;
        tasktype{n} = 'INS';
        tgloc{n} = 'L';
        rule{n} = '1';
    end
end
[pglobal, table] = anovan(bigperfvec, {tasktype tgloc rule}, 'model', 'full');

[h, pchance] = ttest(bigperf', 0.5);

% smallperf = [bigperf(1, :) bigperf(3, :);
%     bigperf(2, :) bigperf(4, :);
%     bigperf(5, :) bigperf(7, :);
%     bigperf(6, :) bigperf(8, :)];
