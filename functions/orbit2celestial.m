function traject_cele = orbit2celestial(OE,traject_orbit)
% OE = [a,e,i,Omega,w,M,Period] : Orbital Elements
% traject_orbit = [p,q,l] : Trajectory on the orbital coordinate system

%%% get values
i = OE(3);
Omega = OE(4);
w = OE(5);

%%% Orbit plane Rotation
R_Omega = [cosd(Omega) sind(Omega) 0 ; -sind(Omega) cosd(Omega) 0 ; 0 0 1];
R_w = [cosd(w) sind(w) 0 ; -sind(w) cosd(w) 0 ; 0 0 1];
R_i = [ 1 0 0 ; 0 cosd(i) sind(i) ; 0 -sind(i) cosd(i)];

%%% final rotation matrix
R_final = (R_Omega'*R_i'*R_w');

%%% Rotate trajectory, orbital coordinate to celestial coordinate
traject_cele = R_final * traject_orbit;

end