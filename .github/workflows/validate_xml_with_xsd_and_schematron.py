import sys
from lxml import etree, isoschematron


if __name__ == '__main__':
    assert len(sys.argv) == 5
    xml_filepath, xsd_filepath, sch_structure_filepath, sch_references_filepath = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
    
    # Parse XML document once
    with open(xml_filepath, 'rb') as xml:
        xml_doc = etree.parse(xml)
    
    # Validate against XSD
    with open(xsd_filepath, 'rb') as xsd:
        xsd_doc = etree.parse(xsd)
    schema = etree.XMLSchema(xsd_doc)
    xsd_valid = schema.validate(xml_doc)
    
    if not xsd_valid:
        print('! XSD validation failed.')
        for error in schema.error_log:
            print(' -', error.message)
    else:
        print('XSD validation passed.')
    
    # Validate against Structure Schematron
    with open(sch_structure_filepath, 'rb') as sch:
        sch_doc = etree.parse(sch)
    schematron = isoschematron.Schematron(sch_doc, store_report=True)
    sch_structure_valid = schematron.validate(xml_doc)
    
    if not sch_structure_valid:
        print('! Schematron structure validation failed.')
        svrl = schematron.validation_report
        if svrl is not None:
            for failed in svrl.xpath('//svrl:failed-assert', 
                                     namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'}):
                location = failed.get('location', 'unknown')
                messages = failed.xpath('svrl:text/text()', 
                                       namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'})
                message = messages[0].strip() if messages else 'No message provided'
                print(f' - {location}: {message}')
    else:
        print('Schematron structure validation passed.')
    
    # Validate against References Schematron
    with open(sch_references_filepath, 'rb') as sch:
        sch_doc = etree.parse(sch)
    schematron = isoschematron.Schematron(sch_doc, store_report=True)
    sch_references_valid = schematron.validate(xml_doc)
    
    if not sch_references_valid:
        print('! Schematron references validation failed.')
        svrl = schematron.validation_report
        if svrl is not None:
            for failed in svrl.xpath('//svrl:failed-assert', 
                                     namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'}):
                location = failed.get('location', 'unknown')
                messages = failed.xpath('svrl:text/text()', 
                                       namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'})
                message = messages[0].strip() if messages else 'No message provided'
                print(f' - {location}: {message}')
    else:
        print('Schematron references validation passed.')
    
    # Exit with error if any validation failed
    if not (xsd_valid and sch_structure_valid and sch_references_valid):
        exit(1)