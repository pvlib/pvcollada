# PVCollada

The PVCollada schema is an adaptation of the COLLADA schema for photovoltaic (PV) power systems.

# PVCollada 1.4.1

PVCollada 1.4.1 is a modification of the COLLADA 1.4.1 schema. A PVCollada 1.4.1 document is not a valid COLLADA document. Modifications from COLLADA 1.4.1 are:

1. <COLLADA><asset><created> (type: xs:dateTime) and <COLLADA><asset><modified> (type: xs:dateTime) are optional in PVCollada 1.4.1, but required in COLLADA 1.4.1.
2. <COLLADA><library_visual_scenes><visual_scene><id> is a string (may be empty) in PVCollada 1.4.1, but is required to be a valid xs:ID in COLLADA 1.4.1.
3. <COLLADA><library_visual_scenes><visual_scene><name> is a string (may be empty) in PVCollada 1.4.1, but is required to be a valid xs:NCName in COLLADA 1.4.1.
4. PVCollada 1.4.1 adds the following elements:

```xml

  - <COLLADA><library_geometries><geometry><mesh><frame_parameters>
        <xs:element name="frame_parameters" minOccurs="0">
            <xs:complexType>
                <xs:sequence>
                    <xs:element name="module_width" type="float" minOccurs="1"/>
                    <xs:element name="module_height" type="float" minOccurs="1"/>
                    <xs:element name="module_x_spacing" type="float" minOccurs="1"/>
                    <xs:element name="module_y_spacing" type="float" minOccurs="1"/>
                    <xs:element name="module_manufacturer" type="string" minOccurs="1"/>
                    <xs:element name="module_name" type="string" minOccurs="1"/>
                </xs:sequence>
            </xs:complexType>
        </xs:element>
  - <COLLADA><library_geometries><geometry><mesh><tracker_parameters>
        <xs:element name="tracker_parameters" minOccurs="0">
            <xs:complexType>
                <xs:sequence>
                    <xs:element name="module_width" type="float" minOccurs="1"/>
                    <xs:element name="module_height" type="float" minOccurs="1"/>
                    <xs:element name="module_x_spacing" type="float" minOccurs="1"/>
                    <xs:element name="module_y_spacing" type="float" minOccurs="1"/>
                    <xs:element name="module_manufacturer" type="string" minOccurs="1"/>
                    <xs:element name="module_name" type="string" minOccurs="1"/>
                    <xs:element name="tracker_type" type="string" minOccurs="1"/>
                    <xs:element name="axis_vertices" minOccurs="1">
                        <xs:complexType>
                            <xs:sequence>
                                <xs:element ref="float_array" minOccurs="2" maxOccurs="2">
                                    <xs:annotation>
                                        <xs:documentation>
                                        The source element shall contain two float_arrays.
                                        </xs:documentation>
                                    </xs:annotation>
                                </xs:element>
                            </xs:sequence>
                        </xs:complexType>
                    </xs:element>
                    <xs:element name="min_phi" type="float" minOccurs="1"/>
                    <xs:element name="max_phi" type="float" minOccurs="1"/>
                    <xs:element name="min_theta" type="float" minOccurs="1"/>
                    <xs:element name="max_theta" type="float" minOccurs="1"/>
                </xs:sequence>
            </xs:complexType>
        </xs:element>

```
 
