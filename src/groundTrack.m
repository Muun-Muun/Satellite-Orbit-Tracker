function [lon,lat] = groundTrack(t,x,y,z,nu,OE)
global w_e

%%% get values from Orbital Elements
% OE = [a,e,i,Omega,w,T0,Period]
i = OE(3);  % deg
w = OE(5);  % deg
 
% %%% calculate the Longitude & Latitude
% lon = atand(sind(90-i)/tand(90-(w+nu)));
% lat = atand(cosd(90-i)*cosd(lon)/tand(90-(w+nu)));

% 지구자전
w_earth = w_e*t;
Rt_earth = [cosd(w_earth) sind(w_earth) 0;-sind(w_earth) cosd(w_earth) 0;0,0,1];
pos_earth = Rt_earth*[x;y;z];

lat = asin(pos_earth(3)/norm(pos_earth))*180/pi; % 위도

if (pos_earth(2) >0)
  lon = acos(pos_earth(1)/norm(pos_earth)/cosd(lat))*180/pi;  % 경도  
else
  lon = -acos(pos_earth(1)/norm(pos_earth)/cosd(lat))*180/pi;
end
end