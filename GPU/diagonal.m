% GPU VERSION
% A function that diagonalize the total hamiltonian
% vel:  the unitary matrix whose columns are the eigenvectors of H
% el:   the diagonal matrix of the eigenvalues (energies) of H

function [vel, el] = diagonal (H)

H_gpu = gpuArray(H);
[vel, el] = eig(H_gpu);

% UNCOMMENT if you need to gather the results from the GPU
%vel = gather(vel);
%el = gather(el);

end