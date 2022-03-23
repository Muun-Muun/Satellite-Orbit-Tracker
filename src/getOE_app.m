function OE = getOE_app(t,i,Omega,e,w,M,n)
%%% get Orbital Elements
% TLEdata = [ t,i,Omega,e,w,M,n ] 
% OE = [a,e,i,Omega,w,T0,Period,epoch_sec]
global mu D2R

%%% get TLE data
e_float = e*1e-7;
M_rad = M*D2R;               % rad
n_rad = n*2*pi/(24*60*60);   % rad/s

%%% calculate Orbital Elements
a = (mu./(n_rad.^2)).^(1/3);
Period = 2*pi./n_rad;
epoch_sec = rem(t,1000)*(24*60*60);   % Time since the beginning of the epoch year [sec]
T0 = epoch_sec - M_rad./n_rad;

OE = [a,e_float,i,Omega,w,T0,Period,epoch_sec];

end