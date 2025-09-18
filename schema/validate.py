"""Validates XML file against an XSD file and Schematron rules.

Ensure the "lxml" package is installed in your environment.

Usage:
    python validate.py                    # Uses hardcoded XML file
    python validate.py myfile.pvc         # Validates specified file
"""
import sys
import os
from lxml import etree, isoschematron

# Get the directory where this script is located
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

# Default file paths
DEFAULT_XML_FILE = os.path.join(SCRIPT_DIR, "../Examples/05 - VerySimpleFixedPVC2_with_electrical_layout.pv2")
XSD_FILE_PATH = os.path.join(SCRIPT_DIR, "pvcollada_schema_0.1.xsd")
SCH_FILE_PATH = os.path.join(SCRIPT_DIR, "pvcollada_structure_2.0.sch")

# Get XML file from command line or use default
if len(sys.argv) > 1:
    XML_FILE_PATH = sys.argv[1]
else:
    XML_FILE_PATH = DEFAULT_XML_FILE

print(f"XML file: {XML_FILE_PATH}")
print(f"XSD file: {XSD_FILE_PATH}")
print(f"SCH file: {SCH_FILE_PATH}")
print("-" * 50)

# Parse XML document once
with open(XML_FILE_PATH, "rb") as xml:
    xml_doc = etree.parse(xml)

# Validate against XSD
with open(XSD_FILE_PATH, "rb") as xsd:
    xsd_doc = etree.parse(xsd)
schema = etree.XMLSchema(xsd_doc)

if schema.validate(xml_doc):
    print("XSD validation passed.")
else:
    print("! XSD validation failed.")
    for error in schema.error_log:
        print("  -", error.message)

# Validate against Schematron
print()
with open(SCH_FILE_PATH, "rb") as sch:
    sch_doc = etree.parse(sch)

schematron = isoschematron.Schematron(sch_doc, store_report=True)
sch_valid = schematron.validate(xml_doc)

if sch_valid:
    print("Schematron validation passed.")
else:
    print("! Schematron validation failed.")
    svrl = schematron.validation_report
    if svrl is not None:
        for failed in svrl.xpath('//svrl:failed-assert', 
                                 namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'}):
            location = failed.get('location', 'unknown')
            messages = failed.xpath('svrl:text/text()', 
                                   namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'})
            message = messages[0].strip() if messages else 'No message provided'
            print(f"  - {location}")
            print(f"    {message}")

# Summary
print()
print("=" * 50)
if schema.validate(xml_doc) and sch_valid:
    print("✓ All validations passed")
else:
    print("✗ Validation failed")