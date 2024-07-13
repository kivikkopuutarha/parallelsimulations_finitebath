% A function that time-evolve the initial density matrix and calculates
% the resulting populations.
% 
% Input variables:
% 
% N:    The total number of two level systems (TLSs) in the bath.
%       The intially excited state, the qubit, is not considered to be
%       part of the bath. Therefore N+1 is the overall number of TLSs
% tmax: The final time at which the populations are calculated. Taken to be
%       8000000000 in the example case
% vel:  a matrix with column eigenvectors (from total_hamiltonian)
% el:   diagonal matrix of eigenvalues (from total_hamiltonian)
% rho0:  The initial state of the system, bath in the ground state
%       and qubit excited
% 
% Output:
% 
% E1:   the result of time evolution


function E1 = time_evolution (N, hbar, tmax, vel, el, rho0)

% Time-evolution operator U(t)=exp(-iHt/hbar)
% in the eigenbasis of the Hamiltonian
U_t = expm((-1i/hbar)*tmax*el);

% Spectral decomposition of the time-evolution operator
U_op = vel*U_t*(vel');

% Formal solution of Liouville-von Neumann equation
% rho(t) = U(t)*rho(0)*U(t)^dagger
rho_t = U_op*rho0*(U_op');

% A column (N+1) vector with the diagonal elements (probabilities of
% occupying the eigenstates) of the evolved density matrix
e1 = diag(rho_t);

% The part of the bath only, i.e. N
E1 = gather(e1(1:N));

end
