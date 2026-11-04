% Generate fig 4d and 4e
% Plot heatmaps of the moduli across many supply rates and frequencies

clear; close all;

% Specify the folder where the files live.
myFolder = 'OscillationData_WithSupply';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
    uiwait(warndlg(errorMessage));
    myFolder = uigetdir(); % Ask for a new one.
    if myFolder == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
% 
% % Preallocate
Nfiles = length(theFiles);

n=1; % tracks number of datapoints recorded
for j = 1:Nfiles
    bath0 = NaN; % Account for some files not having this (abundant supply)

    baseFileName = theFiles(j).name;
    fullFileName = fullfile(theFiles(j).folder, baseFileName);
    fprintf(1, 'Reading %s\n', baseFileName);

    % Load data
    load(fullFileName)

    % Choose criteria to include data for plotting
    if StrainAmpl==0.001 && k_rate==1 && a_barrier==100
        
        m = length(StrainFreq);
        strainfreq(n+1:n+m) = StrainFreq;
        storage(n+1:n+m) = StorageMod;
        loss(n+1:n+m) = LossMod;
        Kadd(n+1:n+m) = K_add.*ones(m,1);

        n = n+m;
    end
        

end

%%
figure
%subplot(1,3,1)
scatter(strainfreq,Kadd,[],storage./loss,'filled')
title('Storage/Loss')
xscale('log'); yscale('log');
xlabel('Freq')
ylabel ('Supply rate')
ylim([1e-3 1e3])
set(gca,'ColorScale','log')
clim([1e-2 1e2])
colorbar

%subplot(1,3,2)
figure
scatter(strainfreq,Kadd,[],abs(storage+1i.*loss),'filled')
title('Complex Mod')
xscale('log'); yscale('log');
xlabel('Freq')
ylabel ('Supply rate')
ylim([1e-3 1e3])
set(gca,'ColorScale','log')
clim([1e-3 1e0])
colorbar
