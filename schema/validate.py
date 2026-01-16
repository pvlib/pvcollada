"""Validates XML file against an XSD file and multiple Schematron rules.

Ensure the "lxml" package is installed in your environment.

Usage:
    python validate.py                    # Uses hardcoded XML file
    python validate.py myfile.pvc2        # Validates specified file
"""
import sys
import os
from lxml import etree, isoschematron

# Get the directory where this script is located
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

# Default file paths
DEFAULT_XML_FILE = os.path.join(SCRIPT_DIR, os.pardir, "Examples", "05 - VerySimpleFixedPVC2_with_electrical_layout.pvc2")
XSD_FILE_PATH = os.path.join(SCRIPT_DIR, "pvcollada_schema_2.0.xsd")
SCH_STRUCTURE_FILE = os.path.join(SCRIPT_DIR, "pvcollada_structure_2.0.sch")
SCH_REFERENCES_FILE = os.path.join(SCRIPT_DIR, "pvcollada_references_2.0.sch")
SCH_BUSINESS_FILE = os.path.join(SCRIPT_DIR, "pvcollada_business_2.0.sch")
PVSYST_XSD_FILE_PATH = os.path.join(SCRIPT_DIR, "pvsyst-extensions", "pvcollada_2.0_pvsyst_extensions_schema_1.0.xsd")
PVSYST_SCH_STRUCTURE_FILE = os.path.join(SCRIPT_DIR, "pvsyst-extensions", "pvcollada_2.0_pvsyst_extensions_structure_1.0.sch")
PVSYST_SCH_REFERENCES_FILE = os.path.join(SCRIPT_DIR, "pvsyst-extensions", "pvcollada_2.0_pvsyst_extensions_references_1.0.sch")

# Get XML file from command line or use default
if len(sys.argv) > 1:
    XML_FILE_PATH = sys.argv[1]
else:
    XML_FILE_PATH = DEFAULT_XML_FILE

print(f"XML file: {XML_FILE_PATH}")
print(f"XSD file: {XSD_FILE_PATH}")
print(f"SCH structure file: {SCH_STRUCTURE_FILE}")
print(f"SCH references file: {SCH_REFERENCES_FILE}")
print(f"SCH business file: {SCH_BUSINESS_FILE}")
print(f"XSD file (for PVsyst extensions): {PVSYST_XSD_FILE_PATH}")
print(f"SCH structure file (for PVsyst extensions): {PVSYST_SCH_STRUCTURE_FILE}")
print(f"SCH references file (for PVsyst extensions): {PVSYST_SCH_REFERENCES_FILE}")
print("-" * 50)

# Parse XML document once
with open(XML_FILE_PATH, "rb") as xml:
    xml_doc = etree.parse(xml)

# Validate against XSD
with open(XSD_FILE_PATH, "rb") as xsd:
    xsd_doc = etree.parse(xsd)
schema = etree.XMLSchema(xsd_doc)

xsd_valid = schema.validate(xml_doc)
if xsd_valid:
    print("XSD validation passed.")
else:
    print("! XSD validation failed.")
    for error in schema.error_log:
        print("  -", error.message)

# Validate against Structure Schematron
print()
with open(SCH_STRUCTURE_FILE, "rb") as sch:
    sch_doc = etree.parse(sch)

schematron = isoschematron.Schematron(sch_doc, store_report=True)
sch_structure_valid = schematron.validate(xml_doc)

if sch_structure_valid:
    print("Schematron structure validation passed.")
else:
    print("! Schematron structure validation failed.")
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

# Validate against References Schematron
print()
with open(SCH_REFERENCES_FILE, "rb") as sch:
    sch_doc = etree.parse(sch)

schematron = isoschematron.Schematron(sch_doc, store_report=True)
sch_references_valid = schematron.validate(xml_doc)

if sch_references_valid:
    print("Schematron references validation passed.")
else:
    print("! Schematron references validation failed.")
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

# Validate against Business Rules Schematron
print()
with open(SCH_BUSINESS_FILE, "rb") as sch:
    sch_doc = etree.parse(sch)

schematron = isoschematron.Schematron(sch_doc, store_report=True)
sch_business_valid = schematron.validate(xml_doc)

if sch_business_valid:
    print("Schematron business rules validation passed.")
else:
    print("! Schematron business rules validation failed.")
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

# Validate against PVsyst extensions XSD
print()
with open(PVSYST_XSD_FILE_PATH, "rb") as xsd:
    xsd_doc = etree.parse(xsd)
schema = etree.XMLSchema(xsd_doc)

pvsyst_xsd_valid = schema.validate(xml_doc)
if pvsyst_xsd_valid:
    print("XSD validation passed for PVsyst extensions.")
else:
    print("! XSD validation failed for PVsyst extensions.")
    for error in schema.error_log:
        print("  -", error.message)

# Validate against PVsyst extensions Structure Schematron
print()
with open(PVSYST_SCH_STRUCTURE_FILE, "rb") as sch:
    sch_doc = etree.parse(sch)

schematron = isoschematron.Schematron(sch_doc, store_report=True)
pvsyst_sch_structure_valid = schematron.validate(xml_doc)

if pvsyst_sch_structure_valid:
    print("Schematron structure validation passed for PVsyst extensions.")
else:
    print("! Schematron structure validation failed for PVsyst extensions.")
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

# Validate against PVsyst extensions References Schematron
print()
with open(PVSYST_SCH_REFERENCES_FILE, "rb") as sch:
    sch_doc = etree.parse(sch)

schematron = isoschematron.Schematron(sch_doc, store_report=True)
pvsyst_sch_references_valid = schematron.validate(xml_doc)

if pvsyst_sch_references_valid:
    print("Schematron references validation passed for PVsyst extensions.")
else:
    print("! Schematron references validation failed for PVsyst extensions.")
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
if xsd_valid and sch_structure_valid and sch_references_valid and sch_business_valid and pvsyst_xsd_valid and pvsyst_sch_structure_valid and pvsyst_sch_references_valid:
    print("✓ All validations passed")
else:
    print("✗ Validation failed")