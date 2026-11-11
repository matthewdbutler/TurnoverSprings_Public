% Generate fig 3a
% Plot strain test results for finte springs
% Apply constant strain, calculate stress

clear;
load('./fig3a_StrainTest.mat')

N_sim = length(stress(:,1));
col = parula(N_sim);

% Plot stress/strain as function of time
figure(1)
tskip = 20; %Plot every tskip points
for i=1:N_sim
    plot(time(1:tskip:end),(stress(i,1:tskip:end)-stress0(i))./strain(i,1),'color',col(i,:))
    hold on
end
xlabel('time')
ylabel('stress/strain')

