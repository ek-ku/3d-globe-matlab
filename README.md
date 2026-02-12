# 3D Globe Generator (MATLAB)

MATLAB scripts to generate a shaded-relief 3D globe from GEBCO global terrain data, with adjustable sea level and export to a watertight STL for 3D printing.

## Overview

This project visualises global bathymetry and topography on a spherical Earth model and can export a printable 3D globe mesh. Elevation can be vertically exaggerated and the shoreline adjusted by shifting mean sea level.

## Files

- `globe.m`  
  Plot a shaded-relief 3D globe with adjustable sea level.  
  Generate a globe mesh and export an STL for 3D printing.

- `globe_data.m`  
  Loads GEBCO longitude, latitude, and elevation data.

- `globe_cmap.m`  
  Custom colour map for land/sea visualisation.

## Requirements

- MATLAB
- GEBCO 2024 global grid (NetCDF format)

Download GEBCO data from:  
https://www.gebco.net/data_and_products/gridded_bathymetry_data/

Place the dataset in:

```
../DATA/GEBCO/
```

or update the file path inside `globe_data.m`.

## Usage

In MATLAB, set your working directory to this repository and run:

```matlab
globe
```

to generate a visualisation and to export a printable STL globe.

Adjust parameters inside the scripts to control:

- resolution downsampling
- vertical exaggeration
- sea level offset
- output globe size

## Output

- 3D visualisation figures
- STL files for 3D printing

## Notes

- The STL mesh is wrap-closed at the dateline to avoid seams.
- Large datasets (GEBCO NetCDF) are not included in this repository.

## Author

Kiki Kuijjer

## Licence

MIT Licence
