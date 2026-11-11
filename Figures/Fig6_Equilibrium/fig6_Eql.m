% Generate fig 6
% Plot analytic equilibrium with late time solution
% At fixed wall separation

clear;
load('LongTimeSoln.mat')

% Calculate analytic solution
n = (1:n_max)';
m = round(stretch); %reference integer to compare to (arbitrary)
spring_eql = exp(-gamma_barrier.*(n-m).*(1 - stretch.^2./n./m ));
spring_eql = spring_eql./sum(spring_eql); %Normalise

% Plot
figure(1)
plot(spring_eql,'b') % Analytic
hold on
plot(spring_density(:,end),'k--') %Simulation end distribution

xlabel('Springs per chain, $n$')
ylabel('Chain distribution, $N_n$')
axis([0 50 0 0.15])

  