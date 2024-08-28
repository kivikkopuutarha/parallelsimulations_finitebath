% A function that calculates an analytical solution for the GGE

function [nl, omega] = analytical (N, w, gamma)

omega = linspace(0,2*w,1000000);
gavg = (gamma^2)/(3*N);
Omega = w;
nu0 = N/(2*Omega);
rate = pi*nu0*gavg;
nl = 2*gavg./((omega-Omega).^2+(2*rate)^2);

end