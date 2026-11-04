% Generate fig 2e
% Plot collapse of moduli from analysis
% Rescale so storage moduli run from 0 to 1

% Load some data
load("OscillationTest_FiniteBath90-150_StrainAmpl0.001_size100_k1_a100_nmax200.mat")

% Solve nonlinear equation twice (no strain and with strain)
N = length(total_springs);
s0 = zeros(N,1);
root = zeros(N,1);
for i=1:N
    s0(i)=EqlStress_FiniteBath_AsympApprox(stretch0,a_barrier,1,total_springs(i));
    root(i)=EqlStress_FiniteBath_AsympApprox(stretch0,a_barrier,1+StrainAmpl,total_springs(i));
end
s1=(root-s0)./StrainAmpl;

% Collapse oscillation tests
figure(9)
col = parula(N);
for j=2:N
    semilogx(StrainFreq,(StorageMod(:,j)-(s0(j)-s1(j))./s0(j).^2).*s0(j).^2./s1(j),'Color',col(j,:))
    hold on
    plot(StrainFreq,LossMod(:,j)*s0(j).^2./s1(j),'Color',col(j,:),'LineStyle','--')
end
ylim([0 1])
xlabel('Freq')
ylabel('Rescaled Moduli')