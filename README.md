# PVCollada

PVCollada uses the COLLADA standard to describe photovoltaic (PV) power systems.

# PVCollada 2.0

PVCollada 2.0 is based on COLLADA 1.5. A PVCollada 2.0 document must be a valid COLLADA 1.5 document.

PVCollada 2.0 uses COLLADA's <extra> elements to provide PV-specific elements that describe the physical components and the electrical and mechanical
relationships among these components. PVCollada elements are located in <technique="pvcollada_20"> structures. PVCollada 2.0 documents can include custom elements in
other <technique> structures.

# PVCollada 1.4.1

PVCollada 1.4.1 is a modification of the COLLADA 1.4.1 schema. A PVCollada 1.4.1 document is not a valid COLLADA document. Modifications from COLLADA 1.4.1 are:

1. The following are optional in PVCollada 1.4.1, but required in COLLADA 1.4.1.

```xml
    <COLLADA><asset><created> (type: xs:dateTime)
    <COLLADA><asset><modified> (type: xs:dateTime)
```

2. The following are string type in PVCollada 1.4.1 but are required to be type xs:ID and xs:NCName, respectively, in COLLADA 1.4.1.

```xml

    <COLLADA><library_visual_scenes><visual_scene><id>
    <COLLADA><library_visual_scenes><visual_scene><name>

```

3. PVCollada 1.4.1 adds the following elements:

```xml

    <COLLADA><library_geometries><geometry><mesh><frame_parameters>
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
    <COLLADA><library_geometries><geometry><mesh><tracker_parameters>
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
 
