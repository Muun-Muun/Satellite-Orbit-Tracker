function [newOE] = oblatenessEffects(OE)
%%% Constants
global mu Re
J2 = 0.001082;

%%% get values from Orbital Elements
% OE = [a,e,i,Omega,w,T0,Period,epochTime]
a = OE(1);
e = OE(2);
i = OE(3);       % deg
RAAN = OE(4);    % deg
w = OE(5);       % deg
T0 = OE(6);
Period = OE(7);
epochTime = OE(8);
n = sqrt(mu/a^3);

%%% calculate Rotational Tensor
K = -(3*n*J2*Re^2)/(2*a^2*(1-e^2)^2);  % RAAN & w Rotation Factor
dRAAN = K*cosd(i);                     % Regression of the nodes
dw = K*(5/2*sind(i)^2-2);              % Advance of the perigee
RAAN = RAAN + dRAAN;                   % update the RAAN
w = w + dw;                            % update the w

%%% update Orbital Elements
newOE = [a,e,i,RAAN,w,T0,Period,epochTime];
end