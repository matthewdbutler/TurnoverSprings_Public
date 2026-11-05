function [time,spring_density,stretch,stress] = EvolveSpringsModel(spring0,params,strain_or_stress,strainstressfn,timegrid)
% Evolves spring system from an initial distribution and domain size, using
% given mechanical boundary conditions (applied stress or strain)

% Domain size
n_max = length(spring0);

% Unpack parameters
k = params(1); % ratio of background reaction rates, k = kq/kp
a = params(2); % sensitivity to energy change (assume same for p & q)
stretch0 = params(3); % initial domain size
if strain_or_stress ==3
    stiffness = params(4); % spring stiffness for growth model (if selected)
end

% Unpack timestepping
dt = timegrid(1); 
t_end = timegrid(2);
time_record = timegrid(3);
m_time = timegrid(4);

sample_rate = max(floor((m_time-1)/time_record),1); % how many steps to take before recording sample (round down)
N_sample = ceil(m_time./sample_rate); % number of timepoints that will be recorded

if strain_or_stress == 1 %Imposed strain
    strainfn = strainstressfn;
elseif strain_or_stress == 2 %Imposed stress
    stressfn = strainstressfn;
elseif strain_or_stress == 3 %Growth model
    growthfn = strainstressfn;
end


%% Pre-allocate
n = (1:n_max)';
time = zeros(1,N_sample);
spring_density = zeros(n_max,N_sample); % recorded spring density N
springs_now = spring0; % current spring density N
stretch = zeros(1,N_sample); % recorded global deformation lambda
stretch_now = stretch0; % current global deformation lambda
stress = zeros(1,N_sample); % recorded current stress
j = 1; % number of next recording

%% Evolve
for i=1:m_time-1

    if mod(i,sample_rate) == 1 || sample_rate == 1 %Record values
        spring_density(:,j) = springs_now;
        time(j) = (i-1).*dt;

        if strain_or_stress == 1 %Imposed strain
            % Determine current stretch
            stretch(j) = strainfn(stretch0,time(j));

            % Calculate stress
            stiff_vector = (stretch(j)./n' - 1);
            stress(j) = stiff_vector*springs_now;

        elseif strain_or_stress == 2 %Imposed stress
            % Determine current stretch
            stretch(j) = (stressfn(time(j)) + sum(springs_now))./sum(springs_now./n);

            stress(j) = stressfn(time(j));

        elseif strain_or_stress == 3 %Growth model

            stretch(j) = stretch_now;
            stress(j) = stiffness.*(growthfn(stretch0,time(j))-stretch_now); % Balances spring force
        end

        j=j+1;
    end


    % Calculate rates and evolution matrix
    [Rate_matrix,p,q] = RateFunction(stretch_now,k,a,n_max);


    % Approx check for stability of scheme
    % Need 0<det(I + dt*Rate_matrix)<1
    % For small dt, this should look like 1 + dt*trace(Rate_matrix)
    dt_lim = -1/trace(Rate_matrix);
    if dt>dt_lim
        fprintf(['Step size should be reduced  below dt=' num2str(dt_lim)  '\n'])
        return
    end


    % Evolve
    dspring_dt = Rate_matrix * springs_now;

    springs_now = springs_now + (dspring_dt .* dt); % Forward Euler

    if strain_or_stress == 1 %Imposed strain
        stretch_now = strainfn(stretch0,i*dt);

    elseif strain_or_stress == 2 %Imposed stress
        stretch_now = (stressfn(i*dt) + sum(springs_now))./sum(springs_now./n);

    elseif strain_or_stress == 3 %Growth model
        stretch_now = (sum(springs_now) + stiffness.*growthfn(stretch0,i*dt))./(sum(springs_now./n)+stiffness);
    end

end

%% Record final values
time(end) = i*dt;
spring_density(:,end) = springs_now;
if strain_or_stress ==1

    stretch(end) = strainfn(stretch0,t_end);

    stiff_vector = (stretch(end)./n' - 1);
    stress(end) = stiff_vector*springs_now;

elseif strain_or_stress ==2

    stress(end) = stressfn(t_end);
    stretch(end) = (stress(end) + sum(springs_now))./sum(springs_now./n);

elseif strain_or_stress ==3

    stretch(end) = (sum(springs_now) + stiffness.*growthfn(stretch0,t_end))./(sum(springs_now./n)+stiffness);
    stress(end) = stiffness.*(growthfn(stretch0,t_end)-stretch_now);

end


end