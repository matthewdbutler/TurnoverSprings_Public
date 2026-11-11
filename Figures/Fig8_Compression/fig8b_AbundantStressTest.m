% Generate fig 8b
% Plot compression stress test results for abundant spring supply
% Apply constant compressive stress, calculate strain

load('ConstStressTest_stress-0.1--0.01_size100_k1_a10_nmax200_compress.mat')

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

% Load and plot extension for comparison
load('ConstStressTest_FiniteTime_stress0.01-0.1_size100_k1_a10_nmax200.mat')
for i=1:N_sim
    plot(time(1:tskip:end),strain(i,1:tskip:end)./stress(i,1),'color',col(i,:),'LineStyle','--')
    hold on
end

% Plot dashed line to show where stress removed
plot([50 50],[0 10],'k--')