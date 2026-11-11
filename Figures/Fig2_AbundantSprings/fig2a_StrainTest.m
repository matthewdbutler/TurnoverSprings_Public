% Generate fig 2a
% Plot strain test results for abundant spring supply
% Apply constant strain, calculate stress

clear;
load('./fig2a_StrainTest.mat')

N_sim = length(stress(:,1));
col = parula(N_sim);

% Plot stress/strain as function of time
figure(1)
tskip = 20; %Plot every tskip points
t = time(1:tskip:end);
for i=1:N_sim
    plot(t,stress(i,1:tskip:end)./strain(i,1),'color',col(i,:))
    hold on
end
xlabel('time')
ylabel('stress/strain')
plot(t,exp(-0.2.*t),'k--') % Small deformation prediction

% Loglog plot of evolution towards final value stress-stress(end)/strain
figure(2)
for i=1:N_sim
    semilogy(t,stress(i,1:tskip:end)./strain(i,1) - stress(i,end)./strain(i,1),'color',col(i,:))
    hold on
end
xlabel('time')
ylabel('stress/strain')
axis([0 100 1e-5 1e0])
plot(t,exp(-0.2.*t),'k--') % Small deformation prediction






