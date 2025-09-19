import sys
import argparse
from lxml import etree, isoschematron


def validate_xsd(xml_doc, xsd_filepath):
    """Validate XML document against XSD schema."""
    with open(xsd_filepath, 'rb') as xsd:
        xsd_doc = etree.parse(xsd)
    schema = etree.XMLSchema(xsd_doc)
    xsd_valid = schema.validate(xml_doc)
    
    if not xsd_valid:
        print('! XSD validation failed.')
        for error in schema.error_log:
            print(' -', error.message)
        return False
    else:
        print('XSD validation passed.')
        return True


def validate_schematron(xml_doc, sch_filepath, validation_type):
    """Validate XML document against Schematron schema."""
    with open(sch_filepath, 'rb') as sch:
        sch_doc = etree.parse(sch)
    schematron = isoschematron.Schematron(sch_doc, store_report=True)
    sch_valid = schematron.validate(xml_doc)
    
    if not sch_valid:
        print(f'! Schematron {validation_type} validation failed.')
        svrl = schematron.validation_report
        if svrl is not None:
            for failed in svrl.xpath('//svrl:failed-assert', 
                                   namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'}):
                location = failed.get('location', 'unknown')
                messages = failed.xpath('svrl:text/text()', 
                                      namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'})
                message = messages[0].strip() if messages else 'No message provided'
                print(f' - {location}: {message}')
        return False
    else:
        print(f'Schematron {validation_type} validation passed.')
        return True


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Validate XML against XSD and Schematron schemas')
    parser.add_argument('xml_file', help='Path to XML file to validate')
    parser.add_argument('--xsd', help='Path to XSD schema file')
    parser.add_argument('--schematron', help='Path to Schematron schema file')
    
    args = parser.parse_args()
    
    if not args.xsd and not args.schematron:
        print('Error: Either --xsd or --schematron must be specified')
        sys.exit(1)
    
    # Parse XML document once
    with open(args.xml_file, 'rb') as xml:
        xml_doc = etree.parse(xml)
    
    validation_passed = True
    
    # Validate against XSD if specified
    if args.xsd:
        validation_passed = validate_xsd(xml_doc, args.xsd)
    
    # Validate against Schematron if specified
    if args.schematron:
        # Determine validation type from filename
        validation_type = "unknown"
        if "structure" in args.schematron.lower():
            validation_type = "structure"
        elif "references" in args.schematron.lower():
            validation_type = "references"
        elif "business" in args.schematron.lower():
            validation_type = "business"
        
        schematron_result = validate_schematron(xml_doc, args.schematron, validation_type)
        validation_passed = validation_passed and schematron_result
    
    # Exit with error if validation failed
    if not validation_passed:
        sys.exit(1)