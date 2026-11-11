% Generate fig 3d
% Plot storage and loss moduli for finite springs
% Moduli calculated from fitting to stress from oscillating strain tests

clear;
load('./fig3d_Moduli.mat')

N = length(total_springs);
col = parula(N);

% Plot storage and loss moduli
figure(6)
for i=1:N
    loglog(StrainFreq,StorageMod(:,i),'Color',col(i,:))
    hold on
    plot(StrainFreq,LossMod(:,i),'Color',col(i,:),'LineStyle','--')
end

% Plot abundant spring result for comparison
load('./fig3d_Abundant.mat')
loglog(StrainFreq,StorageMod,'k-',StrainFreq,LossMod,'k--')
ylim([1e-3 1.2])

