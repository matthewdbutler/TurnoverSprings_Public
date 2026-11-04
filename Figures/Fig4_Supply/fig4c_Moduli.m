% Generate fig 4c
% Plot storage and loss moduli for different supply rates
% Moduli calculated from fitting to stress from oscillating strain tests

clear;
load('OscillationTest_SupplyRate0.01-100_size100_k1_a100_nmax200.mat')

N = length(K_add);
col = parula(N);

% Plot storage and loss moduli
figure(3)
for i=1:N
    loglog(StrainFreq,StorageMod(:,i),'Color',col(i,:))
    hold on
    plot(StrainFreq,LossMod(:,i),'Color',col(i,:),'LineStyle','--')
end


