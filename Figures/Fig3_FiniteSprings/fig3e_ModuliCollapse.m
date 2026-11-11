% Generate fig 2e
% Plot collapse of moduli from analysis
% Rescale so storage moduli run from 0 to 1

clear;

% Load some data
load('./fig3e_ModuliCollapse.mat') %for s0,s1
load('./fig3d_Moduli.mat')

N = length(total_springs);

% Collapse oscillation tests
figure(9)
col = parula(N);
for j=2:N
    semilogx(StrainFreq,(StorageMod(:,j)-(s0(j)-s1(j))./s0(j).^2).*s0(j).^2./s1(j),'Color',col(j,:))
    hold on
    plot(StrainFreq,LossMod(:,j)*s0(j).^2./s1(j),'Color',col(j,:),'LineStyle','--')
end
ylim([0 1])
xlabel('Freq')
ylabel('Rescaled Moduli')