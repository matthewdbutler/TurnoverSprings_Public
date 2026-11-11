% Generate fig 7b and 7c
% Analytic equilibrium distributions for finite supply, and stress
% Compare with abundant supply (dashed)

clear;
load('EqlData_Finite.mat')

% Calculate analytic solution for abundant supply
n = (1:n_max)';
m = round(stretch0); %reference integer to compare to (arbitrary)
spring_inf = exp(-a_barrier.*(n-m).*(1 - stretch0.^2./n./m ));
spring_inf = spring_inf./sum(spring_inf); %Normalise
stress_inf = -1 + stretch0.*sum(spring_inf./n);

N = length(spring_total);
col = parula(N);

% Plot fig 7b: equilibrium distributions
for i=[1 3 7] % Pick out M=90,100,110
    figure(2)
    plot((80:120),spring_eql(i,80:120),'color',col(i,:))
    hold on
end 
plot((80:120),spring_inf(80:120),'k--') %Abundant
xlabel('Springs per chain, $n$')
ylabel('Chain distribution, $N_n$')
axis([80 120 0 0.25])

% Plot fig 7c: equilibrium stress (compared to abundant)
figure(3)
loglog(spring_total,stress_eql-stress_inf)
xlabel('Total springs, $M_{tot}$')
ylabel('Stress offset, $\sigma-\sigma_\infty$')