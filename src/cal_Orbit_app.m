function [r,nu] = cal_Orbit_app(t,Orbital_Elements)
%%% get r(Distance) & nu(True Anomaly)
global mu

% Orbital_Elements = [a,e,i,Omega,w,T0,Period,epocTime_sec]
a = Orbital_Elements(1);
e =  Orbital_Elements(2);
n = sqrt(mu/a^3);
T0 = Orbital_Elements(6);

M = n*(t - T0);                           % Mean Anomaly
E = M + e*sin(M);                         % Eccentric Anomaly, rad
nu = 2*atan(sqrt((1+e)/(1-e))*tan(E/2));  % True Anomaly, rad
r = a.*(1-e^2)./(1+e.*cos(nu));           % Distance, m

end