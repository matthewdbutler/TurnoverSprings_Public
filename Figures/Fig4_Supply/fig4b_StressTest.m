% Generate fig 4a
% Plot stress test results for different supply rates
% Apply constant stress, calculate strain

clear;
load('ConstStressTest_FiniteBath100_Kadd0-0.1_stress0.01_size100_k1_a10_nmax200.mat')
N = length(K_add);
col = parula(N);
tskip = 5;

figure(2)
for i=1:N
    plot(time(1:tskip:end),strain(i,1:tskip:end)./imposed_stress,'color',col(i,:))
    hold on
end

xlabel('time')
ylabel('normalised strain')

