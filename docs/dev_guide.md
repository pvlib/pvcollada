# Developer Guide: Using `pvcollada_schema_0.1.xsd`

This guide explains how to use the `pvcollada_schema_0.1.xsd` XML schema file in the [pvlib/pvcollada](https://github.com/pvlib/pvcollada) repository to validate PVCollada XML files. The schema ensures that your XML files conform to the structure and enumerated types expected by the PVCollada format.

---

## 1. Schema Location

The schema file is located at:
```
schema/pvcollada_schema_2.0.xsd
```

This schema imports the COLLADA schema (`collada_schema_1_5.xsd`) and defines enumerations and types specific to photovoltaic (PV) system design.

---

## 2. What Does the Schema Define?

The schema:
- **Imports** the COLLADA 1.5 schema.
- **Defines enumerations** such as cell material, architecture, conductor material, power type, module type, inverter type, module orientation, and table type.  
  Example:
  ```xml
  <xs:simpleType name="cell_material_enum">
    <xs:restriction base="xs:string">
      <xs:enumeration value="monoSi" />
      <xs:enumeration value="polySi" />
      ...
    </xs:restriction>
  </xs:simpleType>
  ```

---

## 3. Validating XML Files Against the Schema

### Manually (using Python)

A Python script is provided at `schema/validate.py` that uses `lxml` to validate an XML file.  
**Example usage:**
```python
from lxml import etree

XML_FILE_PATH = "../Examples/05 - VerySimpleFixedPVC2_with_electrical_layout.pvc2"
XSD_FILE_PATH = "pvcollada_schema_2.0.xsd"

with open(XML_FILE_PATH, "rb") as xml:
    xml_doc = etree.XML(xml.read())
with open(XSD_FILE_PATH, "rb") as xsd:
    schema_root = etree.XML(xsd.read())

schema = etree.XMLSchema(schema_root)

if schema.validate(xml_doc):
    print("XML is valid.")
else:
    print("! XML is invalid.")
    for error in schema.error_log:
        print("  -", error.message)
```
- Ensure you have `lxml` installed:  
  ```
  pip install lxml
  ```

### Automatically (using GitHub Actions)

The repository includes a GitHub Actions workflow:  
`.github/workflows/validate_xml_with_xsd.yml`

This workflow automatically validates example PVCollada XML files on every push or pull request affecting relevant files.

Key steps:
- Installs Python and `lxml`.
- Checks out the schema and example XML files.
- Runs the validation script.

---

## 4. Example XML File

Example XMLs are found in the `Examples/` directory.  
Example:  
`Examples/05 - VerySimpleFixedPVC2_with_electrical_layout.pvc2`

---

## 5. Extending the Schema

If you need to add new enumerations or elements:
- Edit `schema/pvcollada_schema_2.0.xsd`.
- Ensure new values are added as `<xs:enumeration value="..."/>` or new types as needed.
- Update or add example XML files to reflect the changes.
- Run the validation script to confirm correctness.

---

## 6. References

- [pvcollada_schema_2.0.xsd (GitHub link)](https://github.com/pvlib/pvcollada/blob/main/schema/pvcollada_schema_2.0.xsd)
- [validate.py](https://github.com/pvlib/pvcollada/blob/main/schema/validate.py)
- [Validation Workflow](https://github.com/pvlib/pvcollada/blob/main/.github/workflows/validate_xml_with_xsd.yml)
- [Browse more files in the repository](https://github.com/pvlib/pvcollada)

---

## 7. Troubleshooting

- Make sure all XML files reference the correct schema location and namespace.
- If validation fails, review the error messages—they typically indicate the offending element or attribute.
- For more information, see the [lxml documentation](https://lxml.de/).

---

*Note: This guide is based on a partial code search. For more details, explore the [pvlib/pvcollada repository](https://github.com/pvlib/pvcollada).*