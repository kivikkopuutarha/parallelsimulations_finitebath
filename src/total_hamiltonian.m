% A function that construct the total Hamiltonian of a single
% qubit with energy gap hbar*w coupled to a finite bath formed of N spins
% with energy gaps ranging between 0 and 2*hbar*w.
% 
% Input variables:
%
% N         The total number of two level systems (TLSs) in the bath.
%           The intially excited state, the qubit, is not considered to be
%           part of the bath. Therefore N+1 is the overall number of TLSs
%
% w         The frequency of the qubit.
%           Take it normalized to 1 for simpler calculations
%
%
% mutual    A flag that indicates the consideration of internal
%           couplings of the TLSs in the bath. Use 0 for no
%           internal coupling, 1 to include internal coupling
%
% gamma     Sets the magnitude of the internal coupling strength.
%           Taken to be w/(5*sqrt(2)) in the example case.
%
% omega_j   a vector with the energy levels of the spins
%
% Output:
%
% H         the total hamiltonian matrix


function H = total_hamiltonian (N, w, mutual, gamma, omega_j)

% BATH

% Constructs an upper triangular N-by-N matrix of uniformly distributed
% random numbers between -(gamma/sqrt(N)) and (gamma/sqrt(N)).
% It represents the normalized by 1/sqrt(N) coupling strength between the
% spins on the bath, the off-diagonal elements of the Hamiltonian matrix.
% Thanks to the symmetry of the coupling between two spins and randomness,
% it is enough to take only the upper triangular matrix.
% g is relevant only if internal coupling is to be considered for the bath
% model (mutual=1), otherwise (mutual=0) it becomes zero.
g = mutual*(triu(-(gamma/sqrt(N)) + 2*(gamma/sqrt(N))*rand(N),1));

% Constructs a symmetric matrix of coupling strengths, by taking the sum of
% the upper triangular coupling strength matrix and its transpose. The
% (Hermitian this way) Hamiltonian is constructed with diagonal elements
% being zero.
H1 = g+g';

% Correct the Hamiltonian by replacing its diagonal elements with the
% energy gaps of the spins of the bath.
H1(1:N+1:end) = omega_j;

% BATH AND QUBIT

% Generates a column vector of uniformly distributed random numbers
% between -(gamma/sqrt(N)) and (gamma/sqrt(N)). It represents the
% normalized by 1/sqrt(N) coupling strength between the qubit and the
% spins on the bath.
% That sets the coupling between the spins and the coupling of the qubit
% with the spins at the same level.
lambda = -(gamma/sqrt(N)) + 2*(gamma/sqrt(N))*rand(N,1);

% Build the total Hamiltonian by concatenating lambda and its transpose
% (due to symmetry) as the last (N+1) column and last (N+1) row, while the
% last diagonal element is the frwquency of the qubit.
H = [H1, lambda; lambda', w];

end