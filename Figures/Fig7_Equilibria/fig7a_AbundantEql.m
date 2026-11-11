% Generate fig 7a
% Analytic equilibrium distributions for abundant supply

clear;
load('fig7a_AbundantEql.mat')

figure(1)
plot(spring0(:,1:100)')
xlabel('Springs per chain, $n$')
ylabel('Chain distribution, $N_n$')
axis([0 60 0 0.3])

