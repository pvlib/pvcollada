# PVCollada

Welcome to the PVCollada project!  

## What is PVCollada?

PVCollada is an extension for the COLLADA data exchange format, designed for representing PV system layouts, components, and electrical configurations.  
XML schemas and example files are provided to help users model PV systems in a standardized way. Files are available at [GitHub repository](https://github.com/pvlib/pvcollada).

## Repository Contents

- **schema/**: XML schemas for PVCollada and COLLADA.
- **schema/extensions/**: XML schemas for platform-specific extensions of the PVCollada schema.
- **Examples/**: Example PVCollada XML files.

## How to Use

1. Clone the repository.
2. Use the XML schemas and examples to author PVCollada files.
3. Validate PVCollada files using the schema. A python script is provided at **schema/validate.py**.
4. See the [Developer Guide](dev_guide.md) for more details.

## Documentation

- [Coordinate system and tranformation](pvcollada_coordinate_transformation_with_diagram.md)

## License

This project is licensed under the MIT License.
