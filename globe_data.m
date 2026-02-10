%% Load globe data
%
%  Kiki Kuijjer
%  February 2026
%
clear, clc;
load('gong');
%
%--------------------------------
%% Load global GEBCO data

% globe_data.m loads variables:
%   lon        : longitude coordinates (degrees)
%   lat        : latitude coordinates (degrees)
%   elevation  : elevation/bathymetry values (meters)
%
% Data source:
%   GEBCO_2024 Grid (global terrain model for ocean + land)
%   - 15 arc-second interval grid (15")
%   - 43200 rows x 86400 columns
%   - pixel-centre registered (val

file_in = ['../DATA/GEBCO_2024/GEBCO_2024.nc'];

ncid = netcdf.open(file_in,'NC_NOWRITE');

varid1 = netcdf.inqVarID(ncid,'elevation');
elevation = netcdf.getVar(ncid,varid1);

varid2 = netcdf.inqVarID(ncid,'lat');
lat = netcdf.getVar(ncid,varid2);

varid3 = netcdf.inqVarID(ncid,'lon');
lon = netcdf.getVar(ncid,varid3);

netcdf.close(ncid);

%sound(y) %// sound gong

clear file_in varid1 varid2 varid3 ncid Fs y 
%--------------------------------

