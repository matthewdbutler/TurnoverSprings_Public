% Generate fig 1c
% Example addition and removal rates as function of number of springs in
% a given chain

clear;

% Choose parameters
length = 20;    % current domain:spring size
gamma = 1;      % spring stiffness parameter
k = 1;          % background ratio q:p
n_max = 100;    % cutoff

n = (1:n_max)';

% Calculate elastic energy for each n
Energy = n.*(1 - length./n).^2;
Energy_change = (Energy(2:n_max)-Energy(1:n_max-1));

% Energy needed to change elastic energy, but can happen for free
% Rate exponential function of energy change, only if change is positive
p(1:n_max-1) =  exp( - gamma.* heaviside(Energy_change).*Energy_change );
q(2:n_max) = k .* exp( + gamma.* heaviside(-Energy_change).*Energy_change );
p(n_max) = 0; %upper limit on springs
q(1) = 0; %single springs not removed

plot(n./length,p,'b',n./length,q,'r')
xlabel('$n/\lambda$')
legend('$p_n$','$q_n$')
axis([0 2.5 0 1])