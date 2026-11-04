% Generate fig 3b
% Plot residual stress for finte springs
% Compare result from analytical equilibrium, end time of strain test, and
% average stress of oscillation test

clear;

% Load data for calculation with 5% strain
load('ResidualStress_AsymptoticVsFullSoln.mat')

% Plot calculated stress from analytic and asymptotic expressions
figure(7)
plot(TotSprings,ResidualStress_fullsoln,'b')
hold on 
% plot(TotSprings,ResidualStress_asymptotic,'b--')

% Load data points from strain test for comparison
load('./ConstStrainTest_FiniteBath90-110_strain5%_size100_k1_a10_nmax200.mat')
plot(total_springs,stress(:,end),'bs')

% Repeat with undeformed state
load('ResidualStress_AsymptoticVsFullSoln_NoDeform.mat')

% Plot calculated stress from analytic and asymptotic expressions
figure(7)
plot(TotSprings,ResidualStress_fullsoln,'r')
hold on 
% plot(TotSprings,ResidualStress_asymptotic,'r--')

% Load and plot residual/prestress from oscillation tests (mean across all freq)
load("OscillationTest_FiniteBath90-150_StrainAmpl0.01_size100_k1_a10_nmax200.mat")
plot(total_springs,mean(Residual),'r^')

xlabel('Total springs, $M_{tot}$')
ylabel('Residual stress')
legend('Equilibrium, $\epsilon=5\%$','Simulation, $\epsilon=5\%$',...
    'Equilibrium, $\epsilon=0\%$','Oscillation pre-stress')
xlim([90 110])

