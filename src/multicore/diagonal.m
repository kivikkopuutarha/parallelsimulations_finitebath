% A function that diagonalize the total hamiltonian
% vel:  the unitary matrix whose columns are the eigenvectors of H
% el:   the diagonal matrix of the eigenvalues (energies) of H

function [vel, el] = diagonal (H)

H = distributed(H);

spmd
    [vel, el] = eig(H);
end

end