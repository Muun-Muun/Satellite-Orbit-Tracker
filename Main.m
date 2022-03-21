%%% Constants
global mu dt D2R Re w_e
G = 6.67384e-11;      % gravitational constant
Me = 5.9742e24;       % Mass of Earth
Re = 6371e+3;
mu = G*Me;
D2R = pi/180;
w_e = 360/(24*60*60); % Angular Velocity of Earth [deg/s]

t = 21312.58334491 ;
n = 15.69855487;
e = 0003878;
M = 261.6680;
i = 69.9990;
RAAN = 330.8867;
w = 293.7652;

num_cycle = 5;  % Calculate trajectory for 5 cycles

OE = getOE_app(t,i,RAAN,e,w,M,n);
[r_curr,nu_curr] = cal_Orbit_app(t,OE);
[x_curr,y_curr,z_curr] = cal_position_app(t,OE);

%%% get orbits of satellites
epoch_time = OE(8);
Period = OE(7);
t = epoch_time;
dt = 1;
for i = 1 : num_cycle * Period + 1
    t = t + dt;
    [OE(i+1,:)] = oblatenessEffects(OE(i,:));
    [r(i,1),nu(i,1)] = cal_Orbit_app(t,OE(i+1,:));
    [x(i,1),y(i,1),z(i,1)] = cal_position_app(t,OE(i+1,:));
    [lon(i,1),lat(i,1)] = groundTrack(t,x(i,1),y(i,1),z(i,1),nu(i,1),OE(i+1,:));
end

figure(1)
            p1 = polarplot(nu,r,'LineWidth',1);
            p1.Color = '#D95319';

% 
% k = 0;
% while(1)
%     k = k+1;
%     p.ThetaData = nu(k);
%     p.RData = r(k);
% 
%     if k == length(x)
%         k = 0;
%     end
%     drawnow
% end
% 

earth_fig = figure('Color','black');
% Satellite Orbits at the Celestial Coordinate
p = plot3(x,y,z,'LineWidth',0.5);
p.Color = '#00FFFF';
grid on; hold on;

% Satellite Position at the Celestial Coordinate
c = plot3(x_curr,y_curr,z_curr,'o','MarkerSize',9,'MarkerFaceColor','#EDB120','MarkerEdgeColor','#EDB120')
hold on;


% Create the Earth
load topo topo topomap1;    % load data 
whos('topo','topomap1');
[x_s,y_s,z_s] = sphere(50);          % create a sphere 
s = surface(x_s*Re,y_s*Re,z_s*Re);   hold on;         % plot spherical surface
s.FaceColor = 'texturemap';    % use texture mapping
s.CData = topo;                % set color data to topographic data
s.EdgeColor = 'black';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light
light('Position',[-1 0 1])     % add a light
axis square off                % set axis to square and remove axis
view([-30,30])                 % set the viewing angle

Earth_grid = 'On'
if strcmpi(Earth_grid,'On') == 1
    s.EdgeColor = 'black';
else
    s.EdgeColor = 'none';
end

% q = 0;
% while(1)
%     q = q+1;
%     c.XData = x(q);
%     c.YData = y(q);
%     c.ZData = z(q);
%     if q == length(x)
%         q = 0;
%     end
%     drawnow
% end

figure('Color','White')
geolimits([-90 90],[-180 180]);
geobasemap('satellite');
hold on
plot(lat,lon,'.g')





