% Generate fig 8c
% Plot compression strain test results for finite spring supply
% Apply constant compressive strain, calculate stress

clear;
load('fig8c_FiniteStrainTest_compress.mat')

N_sim = length(stress(:,1));
col = parula(N_sim);

% Plot stress/strain as function of time
figure(4)
tskip = 20; %Plot every tskip points
for i=1:2:N_sim
    plot(time(1:tskip:end),stress(i,1:tskip:end)./strain(i,1),'color',col(i,:))
    hold on
end
xlabel('time')
ylabel('stress/strain')


% Load and plot extension for comparison
load('fig8c_FiniteStrainTest.mat')
for i=1:2:N_sim
    plot(time(1:tskip:end),stress(i,1:tskip:end)./strain(i,1),'color',col(i,:),'LineStyle','--')
    hold on
end
