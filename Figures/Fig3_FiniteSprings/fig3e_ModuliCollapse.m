% Generate fig 2e
% Plot collapse of moduli from analysis
% Rescale so storage moduli run from 0 to 1

% Load some data
load('AsymptoticOffset.mat') %for s0,s1
load("OscillationTest_FiniteBath90-150_StrainAmpl0.001_size100_k1_a100_nmax200.mat")

N = length(total_springs);

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