% Calculate the numerical GGE prediction for the populations,
% which is to be compared with the long-time evolution.
% Basically, we just implement a convolution formula.
% 
% Input variables:
% N:    The total number of two level systems (TLSs) in the bath.
%       The intially excited state, the qubit, is not considered to be
%       part of the bath. Therefore N+1 is the overall number of TLSs
% vel:  a matrix with column eigenvectors (from total_hamiltonian)
% 
% Output
% nau:  the result of GGE

function nau = GGE (N, vel)

nau = zeros(1, N+1);
ujt = abs(vel(N+1,:)).^2;
uki = abs(vel).^2;
nau = sum(ujt .* uki, 2)';

end