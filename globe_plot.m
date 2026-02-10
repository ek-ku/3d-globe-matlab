%% Plot a shaded-relief 3D globe with adjustable shoreline (sea-level offset)
%
%  Kiki Kuijjer
%  February 2026
%
clear, clc;
%--------------------------------

%% Load data

run('globe_data.m')

%--------------------------------

%% Reduce data resolution
% Downsampling by n keeps every n-th cell
% n = 120 reduces the grid from 15 arc-seconds to 0.5° resolution

n = 120; % 0.5° resolution
%n = 60; % 0.25° resolution
%n = 30; % 0.125° resolution
res_deg = 15*n/3600;

alat = lat(1:n:end,:);
alon = lon(1:n:end,:);
ele1 = double(elevation(1:n:end,1:n:end))';

% Create 2D longitude/latitude grids matching elevation
[lon1,lat1] = meshgrid(alon,alat);

% define min and max elevation
min_ele1 = -8000;
max_ele1 = 6000;

ele1(ele1<min_ele1) = min_ele1;
ele1(ele1>max_ele1) = max_ele1;

%clear lon lat alon alat n elevation
%--------------------------------

%% Set shoreline

prompt = 'Shoreline at depth (in meters):  ';
shore = input(prompt)

min_shore = min(min(ele1));
max_shore = max(max(ele1));
ele_shore = ele1 + (shore);
clear prompt
%--------------------------------

%% Add custom colormap (sea blue, land green)

run('globe_cmap.m')
%--------------------------------

%% Plot globe (meters)

% Exaggerate the elevation
%exag = 50;
exag = 20;

% Earth radius (m)
R = 6371000;

% Convert spherical (lon lat radius) to Cartesian (XYZ coordinates)
[x1,y1,z1] = sph2cart(lon1*pi/180, lat1*pi/180, R + exag*ele1);

% wrap-close the dateline (removes seam)
x1 = [x1, x1(:,1)];
y1 = [y1, y1(:,1)];
z1 = [z1, z1(:,1)];
ele_shore = [ele_shore, ele_shore(:,1)];

% figure 2
fig2 = figure(2);clf
set(fig2,'units','normalized','outerposition',[0.1 0.1 0.8 0.85])
hold on

s1 = surf(x1,y1,z1,ele_shore);
set(s1,'edgecolor','none');
shading interp

title(sprintf('Shaded-relief globe (%.2f°) with shoreline at %d m depth', res_deg, shore))

% change viewing angle (-145,0 for Australia)
view(-145,0) % Australia
%view(100,20) % Europe

% add lighting to globe
lighting gouraud
lightangle(-60,30)
shading interp
set(s1,'AmbientStrength',0.5)

% add colormap
colormap(cmap)
axis equal
clim([min_shore max_shore]) % color scale in meters

% remove axes
set(gca, 'Layer', 'top')
grid off
set(gca,'xtick',[],'ytick',[],'ztick',[])
set(gca,'XColor','none','YColor','none','ZColor','none')
%--------------------------------

%% Save figures

print(fig2,['IMG/globe_',num2str(shore),'m_n',num2str(n)],'-dtiff','-r300');
%--------------------------------


