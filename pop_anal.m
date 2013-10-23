%% pop_anal.m
% Zachary Abzug
% 8/25/2013

clear; clc;

%% Load data: RuleStim or Refix, contra or pooled

datasets = {
    'S12R2A0_3703_Sp2_Clus1_Refix_SDFs';
    'S12R2A0_3703_Sp2_Clus2_Refix_SDFs';
    'S16R2P1_1793_Sp2_Clus1_Refix_SDFs';
    'S17R2P2_2053_Sp2_Clus1_Refix_SDFs';
    'S18R2A0_2463_Sp2_Clus1_Refix_SDFs';
    'S18R2A0_2463_Sp2_Clus2_Refix_SDFs';
    'S20R2A1_1823_Sp2_Clus1_Refix_SDFs';
    'S20R2A1_1823_Sp2_Clus2_Refix_SDFs';
    'S21R2P2_1203_Sp2_Clus1_Refix_SDFs';
    'S21R2P2_1204_Sp2_Clus1_Refix_SDFs';
    'S22R2A0_2373_Sp2_Clus1_Refix_SDFs';
    'S23R2P1_2383_Sp2_Clus1_Refix_SDFs';
    'S23R2P1_2383_Sp2_Clus2_Refix_SDFs';
    };

for n = 1:length(datasets);
    load(char(datasets(n)));
    allSS(n, :) = allsdf{1};
    allINS(n, :) = allsdf{2};
    allR0(n, :) = allsdf{3};
    allR1(n, :) = allsdf{4};
end

time = -400:1000;
avgSS = mean(allSS);
seSS = std(allSS)./sqrt(length(datasets));
avgINS = mean(allINS);
seINS = std(allINS)./sqrt(length(datasets));
avgR0 = mean(allR0);
seR0 = std(allR0)./sqrt(length(datasets));
avgR1 = mean(allR1);
seR1 = std(allR1)./sqrt(length(datasets));

figure(1)
plot(time, avgSS, 'b-', 'LineWidth', 1.8)
hold on
plot(time, avgSS+seSS, 'b:', time, avgSS-seSS, 'b:')
plot(time, avgINS, 'r-', 'LineWidth', 1.8)
plot(time, avgINS+seINS, 'r:', time, avgINS-seINS, 'r:')
hold off
ylabel('Firing rate (spikes/s)','FontName','calibri','FontSize',12)
ylim([0 10])
legend('SS', '', '', 'INS', '', '')
title('Population SS vs INS, aligned to Refix, contra only')

figure(2)
plot(time, avgR0, 'b-', 'LineWidth', 1.8)
hold on
plot(time, avgR0+seR0, 'b:', time, avgR0-seR0, 'b:')
plot(time, avgR1, 'r-', 'LineWidth', 1.8)
plot(time, avgR1+seR1, 'r:', time, avgR1-seR1, 'r:')
hold off
ylabel('Firing rate (spikes/s)','FontName','calibri','FontSize',12)
ylim([0 10])
legend('R0', '', '', 'R1', '', '')
title('Population R0 vs R1, aligned to Refix, contra only')
