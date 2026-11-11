% Generate fig 8d
% Plot compression stress test results for finite spring supply
% Apply constant compressive stress, calculate strain

clear;
load('fig8d_FiniteStressTest_compress.mat')

N_sim = length(stress(:,1));
col = parula(N_sim);

% Plot stress/strain as function of time
figure(5)
tskip = 20; %Plot every tskip points
for i=1:2:N_sim
    plot(time(1:tskip:end),strain(i,1:tskip:end)./stress(i,1),'color',col(i,:))
    hold on
end
xlabel('time')
ylabel('strain/stress')

% Load and plot extension for comparison
load('fig8d_FiniteStressTest.mat')
for i=1:2:N_sim
    plot(time(1:tskip:end),strain(i,1:tskip:end)./stress(i,1),'color',col(i,:),'LineStyle','--')
    hold on
end

% Plot dashed line to show where stress removed
plot([50 50],[-5 10],'k--')