% A script that can be used to run the simulation of N spins bath in
% various level of parallelisation (modular linear, GPU parallel, multicore
% CPU parallel). It should run from inside the src folder.

% Reset the system
clearvars
close all
clc

% Enable long format for higher accuracy in the calculations
format long

% Initialize the random number generator based on the current time
rng("shuffle");

% Define parallelisation type. Accepted values are 'modular', 'GPU',
% 'multicore'.
type = 'modular';

% Add the folders of the parallelisation in the path
addpath(fullfile(pwd, type));

% Begin timing
tic;

% Defining example variables of the problem

% The total number of two level systems (TLSs) in the bath.
% The intially excited state, the qubit, is not considered to be
% part of the bath. Therefore N+1 is the overall number of TLSs
N = 1500;

% Number of independent, random iterations
Nr = 25;

% The frequency of the qubit.
% Take it normalized to 1 for simpler calculations
w = 1;

% The reduced Planck's constant.
% Take it normalized to 1 for simpler calculations
hbar = 1;

% A flag that indicates the consideration of internal
% couplings of the TLSs in the bath. Use 0 for no
% internal coupling, 1 to include internal coupling
mutual = 1;

% Sets the magnitude of the internal coupling strength.
% Taken to be w/(5*sqrt(2)) in the example case.
% For weak coupling regime, smaller of the frequency of the qubit,
% but is it enough small? Physical explanation for the choosen value?
gamma = w/(5*sqrt(2));

% The final time at which the populations are calculated.
tmax = 8000000000;

% Construct a N-by-1 column vector with (sorted) uniformly distributed
% random numbers in [0, 2*hbar*w]. It will be the diagonal elements of
% the bath Hamiltonian, representing the energy levels hbar*frequencies
% of the spins of the bath hbar*omega_j where j is in [1, N].
% The energy levels are sorted to reflect the ordered energy spectrum of
% the physical systems.
% This is a constant random vector during the iterations.
omega_j = sort(2*hbar*w*rand(N,1));

% The initial state of the system, bath in the ground state
% and qubit excited
rho0 = zeros(N+1);
rho0(N+1, N+1) = 1; 

% The array for collecting the results of long time evolution
te_results = zeros(N, Nr);

% The array for collecting the results of the GGE prediction
gge_results = zeros(N+1, Nr);


if strcmp(type, 'multicore')
    % Initiate the parallel poll. In local environment uncomment the next line...
    % parpool
    % ... and comment the next line.
    initParPool()
    % Initialize the random number generator with the Multiplicative lagged
    % Fibonacci generator, for multiple workers in parallel
    s = RandStream.create('mlfg6331_64','NumStreams', Nr,'Seed',...
    'shuffle', 'CellOutput',true);
    % Iterrate Nr times
    parfor idx = 1:Nr
    RandStream.setGlobalStream(s{idx});
    H = total_hamiltonian (N,w,mutual,gamma, omega_j);
    [vel, el] = diagonal (H);
    E1 = time_evolution (N, hbar, tmax, vel, el, rho0);
    nau = GGE (N, vel);

    te_results(:, idx) = E1;
    gge_results(:, idx) = nau;
    end
else
    % Iterrate Nr times
    for idx = 1:Nr
    H = total_hamiltonian (N,w,mutual,gamma, omega_j);
    [vel, el] = diagonal (H);
    E1 = time_evolution (N, hbar, tmax, vel, el, rho0);
    nau = GGE (N, vel);

    te_results(:, idx) = E1;
    gge_results(:, idx) = nau;
    end
end

% Get the mean of the iterations
te_results_mean = sum(te_results, 2) / Nr;
gge_results_mean = sum(gge_results, 2) / Nr;

% The analytical GGE prediction for the populations
[nl, omega] = analytical (N, w, gamma);

% Plotting
% (i) Numerical long-time evolution
% (ii) Numerical GGE
% (iii) Analytical

a1 = semilogy(omega_j, te_results_mean, 'o', "Color", 'b');
hold on
a2 = plot(omega_j, gge_results(1:N), 'x', "LineWidth", 1.1, "Color","g");
a3 = plot(omega, nl, "LineWidth", 1.2, "Color", "r");

out1 = sprintf('Long-time evolution for %d spins with %d iterations', N, Nr);
xlabel("$\omega/\Omega$", 'Interpreter',"latex", 'FontSize',18)
ylabel("$n$", 'Interpreter',"latex", 'FontSize',18)
title(out1);
legend([a1(1), a2(1), a3(1)], 'Long-time evolution', 'Numerical GGE', ...
    'Analytical GGE', 'location', "northwest")
%ylim([0.5*10^(-5),10^(-1)])
hold off

% Save the image
relativeFolder = 'output';
filename = sprintf('time_evolution_%d_%d.png', N, Nr);
fullFolderPath = fullfile(pwd, relativeFolder);
fullFilePath = fullfile(fullFolderPath, filename);

% Ensure the directory exists
if ~exist(fullFolderPath, 'dir')
    mkdir(fullFolderPath);
end

% Define characteristics for the image
exportgraphics(gcf, fullFilePath, 'Resolution', 300);

% Output display
disp('The simulation for')
disp(out1)
disp(['was completed in:', ' ', num2str(toc), ' seconds'])
disp(['using parallelisation type', ' ', type])
disp(['with', ' ', getenv('SLURM_CPUS_PER_TASK'), ' ', 'CPUs'])