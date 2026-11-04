% Generate fig 2b
% Plot stress test results for abundant spring supply
% Apply constant stress, calculate strain

clear;
load('./ConstStressTest_Stress0.01-0.1_size100_k1_a10_nmax200.mat')

N_sim = length(stress(:,1));
col = parula(N_sim);

% Plot stress/strain as function of time
figure(3)
tskip = 5; %Plot every tskip points
t = time(1:tskip:end);
for i=1:N_sim
    plot(t,strain(i,1:tskip:end)./stress(i,1),'color',col(i,:))
    hold on
end
xlabel('time')
ylabel('strain/stress')

% Plot dashed line to show where stress removed
plot([50 50],[0 12],'k:')

plot(t(t<50.001),1+0.2.*t(t<50.001),'k--') % Small deformation prediction
plot([50 50 100],[11 10 10],'k--') % Small deformation prediction
ylim([0 12])
