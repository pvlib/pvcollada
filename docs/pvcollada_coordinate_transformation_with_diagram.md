
# Guide to Coordinates and Coordinate Transformations

## ENU Coordinate Frame

PVCollada uses a local, topocentric **East‑North‑Up (ENU)** coordinate system:

- **x** → East  
- **y** → North  
- **z** → Up  

The topocentric origin `(0,0,0)` corresponds to the point described by the
latitude, longitude and altitude stored in the COLLADA document.

## Example Geometry

We'll illustrate coordinates and transformations using a cube defined in PVCollada's local coordinates:

- lower corner `(1,1,1)`
- size `(3,2,1)`

![PVCollada cube](pvcollada_cube_diagram.png)


## From Local ENU to Geographic Coordinates

Assume that the topocentric coordinate origin is at this geolocation in the WGS84 datum:

- Albuquerque, NM, USA  
- Latitude `35.0845`  
- Longitude `-106.651`
- Altitude `1619`
- Projection `EPSG:4326`

EPSG:4326 is the identifier for the WGS-84 geographic coordinate system.

The WGS-84 geocoordinates of the cube can be computed using either the pymap3d or pyproj.

### Using pymap3d

```python

import pandas as pd
import pymap3d as pm

lat0 = 35.0845
lon0 = -106.651
alt0 = 1619.0

# Local coordinates of corners of the cube
topocentric_coords = pd.DataFrame(
    columns=['x', 'y', 'z'],
    data=[[1., 1., 1.],
          [4., 1., 1.],
          [1., 3., 1.],
          [4., 3., 1.],
          [1., 1., 2.],
          [4., 1., 2.],
          [1., 3., 2.],
          [4., 3., 2.]]
    )

# Translate the cube to geocoordinates
# pymap3d.enu2geodetic uses WGS-84 by default. We'll specify a datum to show how
# it is done.

datum = pm.Ellipsoid.from_name('wgs84')

lat, lon, alt = pm.enu2geodetic(coords['y'], coords['x'], coords['z'],
                                lat0, lon0, alt0, ell=datum)

geodetic_coords = pd.DataFrame({'lat': lat, 'lon': lon, 'alt': alt})

print('Topocentric to Geodetic coordinates using pymap3d')
print(geodetic_coords.to_markdown(index=False, floatfmt=".8f"))

```
Topocentric to Geodetic coordinates using pymap3d
|         lat |           lon |           alt |
|------------:|--------------:|--------------:|
| 35.08450901 | -106.65098904 | 1620.00000016 |
| 35.08453605 | -106.65098904 | 1620.00000134 |
| 35.08450901 | -106.65096711 | 1620.00000078 |
| 35.08453605 | -106.65096711 | 1620.00000196 |
| 35.08450901 | -106.65098904 | 1621.00000016 |
| 35.08453605 | -106.65098904 | 1621.00000134 |
| 35.08450901 | -106.65096711 | 1621.00000078 |
| 35.08453605 | -106.65096711 | 1621.00000196 |

### Using pyproj

```python

import pandas as pd
import pyproj


# 1. Define the origin of your local topocentric system (tangent plane)
lat_0 = 35.0845   # Latitude of origin (degrees)
lon_0 = -106.651 # Longitude of origin (degrees)
h_0 = 1619.0      # Ellipsoidal height of origin (meters)

# 2. Build an inverse PROJ pipeline conversion string
# We use +inv because we are starting with topocentric coordinates and going backward
pipeline_str = (
    f"+proj=pipeline "
    f"+step +inv +proj=topocentric +lat_0={lat_0} +lon_0={lon_0} +h_0={h_0} +ellps=WGS84 "
    f"+step +inv +proj=cart +ellps=WGS84 "
    f"+step +proj=unitconvert +xy_in=rad +xy_out=deg "
    f"+step +proj=axisswap +order=2,1"
)

# 3. Create the transformer from the pipeline definition
transformer = pyproj.Transformer.from_pipeline(pipeline_str)

# 4. Input topocentric local data (East, North, Up in meters)
coords = pd.DataFrame(
    columns=['x', 'y', 'z'],
    data=[[1., 1., 1.],
          [4., 1., 1.],
          [1., 3., 1.],
          [4., 3., 1.],
          [1., 1., 2.],
          [4., 1., 2.],
          [1., 3., 2.],
          [4., 3., 2.]]
    )

# Translate the cube to geocoordinates

# 5. Transform the coordinates
# Note: The output layout matches traditional GIS structure (Longitude, Latitude, Height)
lon, lat, alt = transformer.transform(
    coords['x'], coords['y'], coords['z'])

geodetic_coords = pd.DataFrame({'lat': lat, 'lon': lon, 'alt': alt})

print('Topocentric to Geodetic coordinates using pymap3d')
print(geodetic_coords.to_markdown(index=False, floatfmt=".8f"))

```

## From Geographic or Projected Coordinates to PVCollada ENU

We'll show how we can reverse the above transformation, from WGS-84 geographic coordinates to PVCollada's ENU coordinates,
using either pymap3d or pyproj.

### Using pymap3d

```python

import numpy as np
import pandas as pd
import pymap3d as pm


geocoords = pd.DataFrame(
    columns=['lat', 'lon', 'alt'],
    data = np.array(
	    [[35.08450901, -106.65098904, 1620.00000016],
         [35.08453605, -106.65098904, 1620.00000134],
         [35.08450901, -106.65096711, 1620.00000078],
         [35.08453605, -106.65096711, 1620.00000196],
         [35.08450901, -106.65098904, 1621.00000016],
         [35.08453605, -106.65098904, 1621.00000134],
         [35.08450901, -106.65096711, 1621.00000078],
         [35.08453605, -106.65096711, 1621.00000196]]
        )
    )

# origin of ENU coordinates
lat0 = 35.0845
lon0 = -106.651
alt0 = 1619.0
datum = pm.Ellipsoid.from_name('wgs84')

x, y, z = pm.geodetic2enu(
    geocoords['lat'], geocoords['lon'], geocoords['alt'], 
    lat0, lon0, alt0, ell=datum
	)

# put x, y, z into a DataFrame for convenient printing
enucoords = pd.DataFrame({'x': x, 'y': y, 'z': z})

print('Geodetic to Topocentric coordinates using pymap3d')
print(coords.to_markdown(index=False, floatfmt=".8f"))

```

