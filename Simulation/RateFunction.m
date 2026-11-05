function [Rate_matrix,p,q] = RateFunction(stretch,k,a,n_max)
%RATEFUNCTION generates the rates p,q for adding/removing springs and the
% matrix use to evolve the ODE system
% Uses the rate functions in the paper, based on the change in elastic energy

% INPUTS
% stretch   current global deformation, given by ratio: domain length/spring size
% k         ratio of background reaction rates, k = kq/kp 
% a         sensitivity to energy change (assume same for p & q)
% n_max     cutoff number of springs

n = (1:n_max)';

% Calculate elastic energy for each n
Energy = n.*(1 - stretch./n).^2;
Energy_change = (Energy(2:n_max)-Energy(1:n_max-1));

% Energy needed to change elastic energy, but can happen for free
% Rate exponential function of energy change, only if change is positive
p(1:n_max-1) =  exp( - a.* heaviside(Energy_change).*Energy_change );
q(2:n_max) = k .* exp( + a.* heaviside(-Energy_change).*Energy_change );

p(n_max) = 0; %upper limit on springs
q(1) = 0; %single springs not removed

% Generate matrix to be used in series of ODEs dx/dt = Ax
Rate_matrix = diag(-(p+q)) + diag(p(1:end-1),-1) + diag(q(2:end),1);

% Exploit sparsity of matrix
Rate_matrix = sparse(Rate_matrix);


end