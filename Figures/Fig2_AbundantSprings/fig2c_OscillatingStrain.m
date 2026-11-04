% Generate fig 2c
% Plot oscillation test results for abundant spring supply
% Apply oscillating strain, calculate stress

clear;
load('./OscillationExample')

N = length(StrainFreq);
col = parula(N);

figure(4)
for i=1:N
    plot(StrainFreq(i).*data.time(i,:)./(2*pi),data.stress(i,:),'Color',col(i,:))
    hold on
end
xlabel('$\omega t/ 2\pi$')
ylabel('stress')

t = 8:0.01:10;
plot(t,0.01.*sin(2*pi*t),'k--')

axis([8 10 -0.015 0.015])