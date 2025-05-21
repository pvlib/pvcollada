"""Validates XML file against an XSD file.

Ensure the "lxml" package is installed in your environment.
"""
from lxml import etree

XML_FILE_PATH = "D:\PVCollada\pvsyst_circuit2\\05 - VerySimpleFixedPVC2_with_electrical_layout_v3_cwh.pvc"
XSD_FILE_PATH = "pvcollada_schema_0.1.xsd"
print(f"XML file: {XML_FILE_PATH}")
print(f"XSD file: {XSD_FILE_PATH}")

with open(XML_FILE_PATH, "rb") as xml:
    xml_doc = etree.XML(xml.read())
with open(XSD_FILE_PATH, "rb") as xsd:
    schema_root = etree.XML(xsd.read())

schema = etree.XMLSchema(schema_root)

#%%
if schema.validate(xml_doc):
    print("XML is valid.")
else:
    print("! XML is invalid.")
    for error in schema.error_log:
        print("  -", error.message)
