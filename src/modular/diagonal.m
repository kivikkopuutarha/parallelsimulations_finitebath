% MODULAR VERSION

% A function that diagonalize the total hamiltonian
% vel:  the unitary matrix whose columns are the eigenvectors of H
% el:   the diagonal matrix of the eigenvalues (energies) of H

function [vel, el] = diagonal (H)

[vel, el] = eig(H);

end