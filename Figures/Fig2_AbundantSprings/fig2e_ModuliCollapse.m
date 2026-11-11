% Generate fig 2e
% Plot collapse of moduli from analysis
% Load moduli from many oscillation tests and rescale

clear;

% Specify the folder where the files live.
myFolder = './OscillationData';

% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

% Preallocate
Nfiles = length(theFiles);
rms_storage = zeros(Nfiles,1);
rms_loss = zeros(Nfiles,1);
param_num = zeros(Nfiles,1);
timescale = zeros(Nfiles,1);

% Define functions for Maxwell storage & loss
Maxwell_storage = @(x) x.^2./(1+x.^2);
Maxwell_loss = @(x) x./(1+x.^2);

% Colourmap
col = parula(30);

for j = 1:Nfiles

    % Read each file in turn
    baseFileName = theFiles(j).name;
    fullFileName = fullfile(theFiles(j).folder, baseFileName);

    % Load
    load(fullFileName)

    % Calculate parameter
    param_num(j) = a_barrier.*StrainAmpl./stretch0;
    n_param = round(-10*log10(param_num(j)))-10; % crude value for colourmap, replaced later
    timescale(j) = stretch0./2./a_barrier;

    % Plot data with rescaled time
    figure(6)    
    loglog(timescale(j).*StrainFreq,StorageMod,'Color',col(n_param,:))
    hold on
    loglog(timescale(j).*StrainFreq,LossMod,'--','Color',col(n_param,:))

end


% Plot the Maxwell result for comparison
figure(6)
x = logspace(-3,4);
plot(x,Maxwell_storage(x),'k-')
plot(x,Maxwell_loss(x),'k--')
title('Rescaled Moduli plot')
xlabel('$\lambda_0 \omega / 2\gamma$')
ylabel('Moduli')
axis([1e-2 1e2 1e-2 1e0])
