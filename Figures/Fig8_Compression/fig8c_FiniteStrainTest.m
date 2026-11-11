% Generate fig 8c
% Plot compression strain test results for finite spring supply
% Apply constant compressive strain, calculate stress

clear;
load('ConstStrainTest_FiniteBath90-110_strain-5%_size100_k1_a10_nmax200.mat')

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
load('ConstStrainTest_FiniteBath90-110_strain5%_size100_k1_a10_nmax200')
for i=1:2:N_sim
    plot(time(1:tskip:end),stress(i,1:tskip:end)./strain(i,1),'color',col(i,:),'LineStyle','--')
    hold on
end
