% Generate fig 2d
% Plot storage and loss moduli for abundant spring supply
% Moduli calculated from fitting to stress from oscillating strain tests

clear;
load('./fig2d_Moduli.mat')

% Plot storage and loss moduli
figure(5)
loglog(StrainFreq,StorageMod,'b')
hold on
plot(StrainFreq,LossMod,'b--')

% Plot Maxwell result
x = logspace(-2,2);
plot(x,x.^2./(1+x.^2),'r')
plot(x,x./(1+x.^2),'r--')