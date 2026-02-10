%% Create textured 3D globe
%
%  Kiki Kuijjer
%  February 2026
%
clear, clc;
%-------------------------------------

%% Load data

run('globe_data.m')

%-------------------------------------

%% Reduce data resolution
% Downsampling by n keeps every n-th cell
% n = 120 reduces the grid from 15 arc-seconds to 0.5° resolution

n = 120; 

alat = lat(1:n:end,:);
alon = lon(1:n:end,:);
ele1 = double(elevation(1:n:end,1:n:end))';

% Create 2D longitude/latitude grids matching elevation
[lon1,lat1] = meshgrid(alon,alat);

%-------------------------------------

%% Convert (lon,lat,radius) to Cartesian XYZ

exag = 50;   % Vertical exaggeration factor applied to elevation (meters)
R = 6371000; % Mean Earth radius (meters)

% Convert spherical coordinates to Cartesian coordinates.
% sph2cart inputs:
%   azimuth   = longitude in radians
%   elevation = latitude  in radians
%   radius    = R + (exaggerated elevation)
%
% Result:
%   x1,y1,z1 are coordinate grids for the globe surface mesh.

[x1,y1,z1] = sph2cart(lon1*pi/180, lat1*pi/180, R + exag*ele1);

% wrap-close the dateline (removes seam + makes STL watertight)
x1 = [x1, x1(:,1)];
y1 = [y1, y1(:,1)];
z1 = [z1, z1(:,1)];

%-------------------------------------

%% Convert gridded surface (x1,y1,z1) into a triangle mesh
%   F : faces (triangle vertex indices)
%   V : vertices (Nx3 coordinates)

[F, V] = surf2patch(x1,y1,z1,'triangles');

% Scale mesh for printing (target ~8 cm diameter)
target_diam_mm = 80;                 % 80 mm globe
target_R = target_diam_mm/2;         % 40 mm radius

% Current radius of mesh (max distance from origin)
r_now = max(sqrt(sum(V.^2,2)));

% Scale vertices so globe radius matches target
s = target_R / r_now;
V = V * s;

% Quick visual check
figure
trisurf(F, V(:,1), V(:,2), V(:,3),'EdgeColor','none')   % Plot triangular surface
colormap(gray)
axis equal 
xlabel X; ylabel Y; zlabel Z

% write stl file
TR = triangulation(F, V);  % Triangulation object used for export
filename = sprintf("OUTPUT/globe_%dexag_%dmm.stl", exag, target_diam_mm);
stlwrite(TR, filename); % export

%-------------------------------------

