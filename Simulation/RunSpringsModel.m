% An example showing the evolution of the ODE system

% Evolve a spring density according to reaction rates that increase or
% decrease the number of springs by one from a bath of springs

% Have options for imposing either strain or stress as functions of time
% Options to choose between abundant supply and finite supply

% Equation being solved is for distribution of spring chains N:
% dN/dt = tridiag(p,-(p+q),q) N

%% INPUTS
% RATE PARAMETERS
% k_rate        ratio of background reaction rates, k = kq/kp 
% a_barrier     dimensionless spring stiffness/elastic energy barrier (assume same for p & q)

% GRID CHOICE
% n_max         cutoff number of springs
% dt            timestep for forward Euler
% t_end         end time at which simulations terminated
% time_record   number of recorded points

% BOUNDARY CONDITIONS
% Chosen from presented options (imposed strain or stress or growth)
% stress_or_strain  chooses between options (1=strain, 2=stress, 3=growth)
% strainstressfn    the imposed function setting the domain size or applied force as function of time
% stiffness         spring stiffness of coupled spring in growth model

% INITIAL CONDITIONS
% stretch0      initial size of domain compared to a spring length
% spring0       initial distribution of springs (n_max x 1)

% ABUNDANT VS FINITE
% FiniteBath_flag = 0 if abundant available springs, = 1 if finite number (including external supply case)
% total_springs     (initial) total number of springs per chain in reservoir + chains (if finite supply)
% K_add             supply rate to the reservoir
% K_remove          clearance rate from the reservoir (per reservoir concentration)

% for abundant supply:  params = [k_rate;a_barrier;stretch0];
% for finite supply:    params = [k_rate;a_barrier;stretch0;total_springs;K_add;K_remove];

%% OUTPUTS
% time                  Time             
% spring_density(i,j)   Proportion of chains which have i springs at timestep j
% stretch               Length of the domain relative to a single spring at given time
% stress                Global stress at a given time
% bath                  Number of springs in environment (if finite number)

%% Parameters
a_barrier = 10;
k_rate = 1;
stretch0 = 100;
params = [k_rate;a_barrier;stretch0];

n_max = 2*stretch0; %cutoff

% Choose abundant supply (0) or finite supply (1)
FiniteBath_flag = 0;

% Extra parameters if want finite bath (with or without supply)
if FiniteBath_flag
    total_springs = 101;
    K_add = 1;
    K_remove = 1;
    params = [k_rate;a_barrier;stretch0;total_springs;K_add;K_remove];

    bath_fn = @(M) M./(1+M);
else
    bath_fn = 0; % not needed for calculation, but must be set
end

% Set initial distribution of chains 
% Note that for finite bath, must have fewer springs in chains than total_springs
spring0 = zeros(n_max,1);
spring0(round(stretch0)) = 1; % all chains have same length, integer closest to stretch0

% Set applied strain
strain_or_stress = 1; % applied strain
imposed_strain = 0.01;
strainstressfn = @(L0,time) L0.*(1 + imposed_strain); % constant deformation


%% Timestepping
t_end = 1e2;    % endtime

% Timestepping params
dt = 1e-3/max([1 params(1)]); %timestep (Roughly expect should be smaller than O(1/stretch^2), need smaller steps when k_rate is large)
time_record = 1e3;  % number of timepoints to record

m_time = length(0:dt:t_end); %number timepoints
time_record = min(time_record,m_time+1); %cannot record more points than timesteps

% Store in one vector for compactness
timegrid = [dt;t_end;time_record;m_time];


%% Evolve solution
if FiniteBath_flag
    % Evolve with finite spring supply
    [time,spring_density,stretch,stress,bath] = EvolveSpringsModel_FiniteBath(spring0,params,strain_or_stress,strainstressfn,bath_fn,timegrid);
else % Infinite spring supply
    [time,spring_density,stretch,stress] = EvolveSpringsModel(spring0,params,strain_or_stress,strainstressfn,timegrid);
end

%% Plotting

% Plot distribution at different time intervals
figure(1)
plot(1:n_max,spring_density(:,1:200:end))
xlim([90 110])

% Plot stress as function of time
figure(2)
plot(time,stress)
xlabel('time')
ylabel('stress')