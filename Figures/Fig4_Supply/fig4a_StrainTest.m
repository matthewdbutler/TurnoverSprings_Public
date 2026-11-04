% Generate fig 4a
% Plot strain test results for different supply rates
% Apply constant strain, calculate stress

clear;
load('ConstStrainTest_FiniteBath100_Kadd0-0.1_strain5%_size100_k1_a10_nmax200.mat')

N = length(K_add);
col = parula(N);
tskip = 5;

figure(1)
for i=1:N
    plot(time(1:tskip:end),stress(i,1:tskip:end)./imposed_strain,'color',col(i,:))
    hold on
end

xlabel('time')
ylabel('normalised stress')

