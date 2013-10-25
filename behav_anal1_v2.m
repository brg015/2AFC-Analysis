%% behav_anal1.m
% Zachary Abzug
% Created 7/1/2013
%
clear; clc; close all;
ANOVA_ON=0;
save_dir='C:\Users\brg13\Downloads\AFC_AnalysisCode\';
%=========================================================================%
% Important Codes
%=========================================================================%
TT_col=2;
TT1=1700; TT1_idx=[];
TT2=1800; TT2_idx=[];
% SS or INS (column 2)
% 1700 => SS trial
% 1701 => INS trial
R_col=14;
R0=1800; R0_idx=[];
R1=1801; R1_idx=[];
% Rule Choice (column 14)
% 1800 => Rule0 trial (Size)
% 1801 => Rule1 trial (Contrast)
S_col=17;
% Side Choice (column 17)
% 1900 => Right Side
% 1901 => Left Side
C_col=4;
% Trial Type
% 4050 => SS - Correct Right - Rule0 (Rule presented on right)
% 4051 => SS - Correct Right - Rule1 (Rule presented on left)
% 4054 => SS - Correct Left - Rule0 (Rule presented on right)
% 4055 => SS - Correct Left - Rule1 (Rule presented on left)
% 4052 => INS - Correct Right - Rule0 (Size)
% 4053 => INS - Correct Right - Rule1 (Contrast)
% 4056 => INS - Correct Left - Rule0 (Size)
% 4057 => INS - Correct Left - Rule1 (Contrast)
% Size/Contrast
% 16XY where X=> Size and Y=> Contrast
T1_col=15; T2_col=16;
con_idx=4; siz_idx=3;
% Accuracy
ACC_col=26; 
ACC=1030; ACC_idx=[];
%=========================================================================%
% Pick Dataset
%=========================================================================%
% Behavioral analysis for multiple sessions, individually.

set_name='custom'; % Allow for loading variable datasets

% Run through analysis for multiple days
switch set_name
    case 'Zach1'
        wrk_dir=pwd; % Assume run in working directory
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
    case 'Zach2'
        wrk_dir=pwd;
        datasets = {
            'S20130702a_REX';
            };
            case 'custom'
        wrk_dir='C:\Users\The Doctor\Data\processed\Shuffles';
        datasets={'S18R2A0_2463_Sp2.mat'};
end
%=========================================================================%
% Code Start
%=========================================================================%

for n = 1:length(datasets);
    % Returns codes for correct trials
    % truncodes => [Trials X Codes]
    % truntimes => [Trials X Codes] (Timestamps)
    [truncodes, truntimes] = findcompleted(char(datasets(n))); % pull out completed trials
    % splits based upon base codes (for direction)
    splitcodes = splitbasecodes(truncodes);
    % combines based upon splits - seems as if 8 cells are always returned
    % and indexed identically froms split codes
    lilsplits = cell(4, 1); % get rid of correct target location as a variable
    lilsplits{1} = [splitcodes{1}; splitcodes{3}]; % SS - Rule0
    lilsplits{2} = [splitcodes{2}; splitcodes{4}]; % SS - Rule1
    lilsplits{3} = [splitcodes{5}; splitcodes{7}]; % INS - Rule0
    lilsplits{4} = [splitcodes{6}; splitcodes{8}]; % INS - Rule1
    % for each conditon time return perf and number of trials
    for cond = 1:length(lilsplits);
        [perf, numtrials] = getperformance(lilsplits{cond});
        bigperf(cond, n) = perf;
    end
    rule0bias(n) = getrulebias(truncodes);
    sideRbias(n) = getsidebias(truncodes);
    sideRbias_cont(n) = getsidebias_cont(truncodes);
%=========================================================================%
% Geib Edits to create size/contrast surface maps
%=========================================================================%
    TT1_idx=find(truncodes(:,TT_col)==TT1); % SS
    TT2_idx=find(truncodes(:,TT_col)==TT2); % INS
    TT_idx=union(TT1_idx,TT2_idx);
    R0_idx=find(truncodes(:,R_col)==R0); % Size
    R1_idx=find(truncodes(:,R_col)==R1); % Contrast
    ACC_idx=find(truncodes(:,ACC_col)==ACC); % Contrast

    T1_str=num2str(truncodes(:,T1_col));
    T1_contrast=str2num(T1_str(:,con_idx));
    T1_size=str2num(T1_str(:,siz_idx));
    
    T2_str=num2str(truncodes(:,T2_col));
    T2_contrast=str2num(T2_str(:,con_idx));
    T2_size=str2num(T2_str(:,siz_idx));
      
    for Map_Type=1:4
        % Determine trials to pull from based upon the map wanted
        switch Map_Type
            case 1, Get_Trials=intersect(TT_idx,R0_idx); 
                    T1_Trials=T1_size;
                    T2_Trials=T2_size;
                    Title_var='R0-Size';
            case 2, Get_Trials=intersect(TT_idx,R0_idx); % SS Contrast
                    T1_Trials=T1_contrast;
                    T2_Trials=T2_contrast;
                    Title_var='R0-Contrast';
            case 3, Get_Trials=intersect(TT_idx,R1_idx); % INS Size
                    T1_Trials=T1_size;
                    T2_Trials=T2_size;
                    Title_var='R1-Size';
            case 4, Get_Trials=intersect(TT_idx,R1_idx); % INS Contrast
                    T1_Trials=T1_contrast;
                    T2_Trials=T2_contrast;
                    Title_var='R1-Contrast';
        end
        
        % 0->6 Determined based upon contrast/size range
        Surface_Map=[]; h=figure(1);
        for ii=0:6 % T1 loop
            for jj=0:6 % T2 loop
                % Find targets 1 == ii
                T1_idx=find(T1_Trials==ii);
                % Find targets 2 == jj
                T2_idx=find(T2_Trials==jj);
                % The intersection of these represents the trials we're
                % interested in
                T_idx=intersect(T1_idx, T2_idx);
                % The trials we actually want are furthermore an
                % intersection of the correct sizes and the wanted trials
                Trials=intersect(Get_Trials,T_idx);
                Trial_N=length(Trials);
                Corr_N=length(find(truncodes(Trials,ACC_col)==ACC));
                Surface_Map(ii+1,jj+1)=Corr_N/Trial_N;
                clear T1_idx T2_idx T_idx       
            end
        end
        subplot(2,2,Map_Type)
        pcolor(0:6,0:6,Surface_Map)
        colorbar; title(Title_var);
    end
    print(gcf,'-djpeg',[save_dir set_name '_SurfacePlots.jpg']);
end

%% For Zacks Anova Generation
if ANOVA_ON==1,
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
end
