% Generate fig 3d
% Plot storage and loss moduli for finite springs
% Moduli calculated from fitting to stress from oscillating strain tests

clear;
load('./OscillationTest_FiniteBath90-150_StrainAmpl0.001_size100_k1_a100_nmax200.mat')

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
load('OscillationTest_StrainAmpl0.001_size100_k1_a100_nmax200.mat')
loglog(StrainFreq,StorageMod,'k-',StrainFreq,LossMod,'k--')


