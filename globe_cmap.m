%% Make a custom colormap (land green, sea blue)
%
%  Kiki Kuijjer
%  February 2026
%
%-----------------------------

%% Make custom colormap for globe (meters, shoreline adjustable)

n = 1; % resolution (1 = full)

% min/max AFTER shoreline shift
min_shore = floor(min(ele_shore(:)));
max_shore = ceil(max(ele_shore(:)));

% ensure zero exists in range
min_shore = min(min_shore,0);
max_shore = max(max_shore,0);

% number of colors allocated to sea vs land
Nsea  = abs(min_shore);
Nland = max_shore;

% safety in case dataset is all land or all sea
Nsea  = max(Nsea,1);
Nland = max(Nland,1);

% sea is blue
R = linspace(0/255, 255/255, Nsea);
G = linspace(162/255,255/255, Nsea);
B = linspace(232/255,255/255, Nsea);
cm_sea = [R(:) G(:) B(:)];
cm_sea = cm_sea(1:n:end,:);

% land is green
R = linspace(162/255, 67/255, Nland);
G = linspace(191/255, 96/255, Nland);
B = linspace(106/255, 38/255, Nland);
cm_land = [R(:) G(:) B(:)];
cm_land = cm_land(1:n:end,:);

% combine sea + land
cmap = [cm_sea; cm_land];

colormap(cmap)
caxis([min_shore max_shore])   % map real meters to colors

clear R G B Nsea Nland
%-----------------------------

%% Plot world map

%// Plot figure
fig1 = figure(1); clf
set(fig1,'units','normalized','outerposition',[0.1 0.1 0.8 0.85])
hold on

pcolor(double(lon1),double(lat1),double(ele_shore)); % shifted elevation
shading flat

% coastline at 0 m AFTER shift
% contour(double(lon1),double(lat1),double(ele_shore),[0 0],'k');

set(gca,'Layer','top')
box on
axis equal
xlim([-180 180])
ylim([-90 90])
xticks(-180:60:180)
yticks(-90:30:90)

title(['World map with shoreline at ',num2str(shore),' m'])

colormap(cmap)

%-----------------------------
