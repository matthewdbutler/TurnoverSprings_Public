% Generate fig 3c
% Plot stress test results for finte springs
% Apply constant stress, calculate strain

clear;
load('./fig3c_StressTest.mat')

N_sim = length(stress(:,1));
col = parula(N_sim);

% Plot stress/strain as function of time
figure(3)
tskip = 20; %Plot every tskip points
for i=1:N_sim
    plot(time(1:tskip:end),strain(i,1:tskip:end)./stress(i,1),'color',col(i,:))
    hold on
end
xlabel('time')
ylabel('strain/stress')

% Plot dashed line to show where stress removed
plot([50 50],[-4 4],'k--')

