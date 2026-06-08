
# PVCollada Coordinate Transformation Guide

## ENU Coordinate Frame

PVCollada uses a local, topocentric **East‑North‑Up (ENU)** coordinate system:

- **x** → East  
- **y** → North  
- **z** → Up  

The topocentric origin `(0,0,0)` corresponds to the point described by the
latitude, longitude and altitude stored in the COLLADA document.

## Example Geometry

Cube definition in local coordinates:

- lower corner `(1,1,1)`
- size `(3,2,1)`

Assume that the topocentric coordinate origin is at the this geolocation:

- Albuquerque, NM, USA  
- Latitude `35.0845`  
- Longitude `-106.651`
- Altitude `1619`
- Projection `EPSG:32613`

## Diagram

![PVCollada cube](pvcollada_cube_diagram.png)

The diagram shows the cube in the local coordinate system along with the ENU axes.

## Computed Geographic Coordinates

The geocoordinate of the cube are computed using the python library pymap3d.

|          x |          y |          z |    latitude |     longitude |      altitude |
|-----------:|-----------:|-----------:|------------:|--------------:|--------------:|
| 1.00000000 | 1.00000000 | 1.00000000 | 35.08450901 | -106.65098904 | 1620.00000016 |
| 4.00000000 | 1.00000000 | 1.00000000 | 35.08453605 | -106.65098904 | 1620.00000134 |
| 1.00000000 | 3.00000000 | 1.00000000 | 35.08450901 | -106.65096711 | 1620.00000078 |
| 4.00000000 | 3.00000000 | 1.00000000 | 35.08453605 | -106.65096711 | 1620.00000196 |
| 1.00000000 | 1.00000000 | 2.00000000 | 35.08450901 | -106.65098904 | 1621.00000016 |
| 4.00000000 | 1.00000000 | 2.00000000 | 35.08453605 | -106.65098904 | 1621.00000134 |
| 1.00000000 | 3.00000000 | 2.00000000 | 35.08450901 | -106.65096711 | 1621.00000078 |
| 4.00000000 | 3.00000000 | 2.00000000 | 35.08453605 | -106.65096711 | 1621.00000196 |
 
## Python Examples

```python
# Using pymap3d

import pandas as pd
import pymap3d as pm

lat0 = 35.0845
lon0 = -106.651
alt0 = 1619.0

# Local coordinates of corners of the cube
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

lat, lon, alt = pm.enu2geodetic(coords['y'], coords['x'], coords['z'],
                                lat0, lon0, alt0)

coords['lat'] = lat
coords['lon'] = lon
coords['alt'] = alt

print('Topocentric to Geodetic coordinates')
print(coords.to_markdown(index=False))

```

```python
# Using pyproj

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

coords['latitude'] = lat
coords['longitude'] = lon
coords['altitude'] = alt

print('Topocentric to Geodetic coordinates')
print(coords.to_markdown(index=False, floatfmt=".8f"))

```
