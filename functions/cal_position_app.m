function [x,y,z] = cal_position_app(t,OE)
%%% calculate position
[r,nu] = cal_Orbit_app(t,OE);

%%% calculate position (at the orbital coordinate system)
pos_orbital = [r*cos(nu);r*sin(nu);0];

%%% calculate position (at the celestial coordinate system)
pos_celestial = orbit2celestial(OE,pos_orbital)'; 
x = pos_celestial(1);
y = pos_celestial(2);
z = pos_celestial(3);
end