import sys
from lxml import etree, isoschematron


if __name__ == '__main__':
    assert len(sys.argv) == 4
    xml_filepath, xsd_filepath, sch_filepath = sys.argv[1], sys.argv[2], sys.argv[3]
    
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
    
    # Validate against Schematron
    with open(sch_filepath, 'rb') as sch:
        sch_doc = etree.parse(sch)
    
    # Compile and validate
    schematron = isoschematron.Schematron(sch_doc, store_report=True)
    sch_valid = schematron.validate(xml_doc)
    
    if not sch_valid:
        print('! Schematron validation failed.')
        # Try to get the SVRL report
        svrl = schematron.validation_report
        if svrl is not None:
            # Parse the SVRL report for failed assertions
            for failed in svrl.xpath('//svrl:failed-assert', 
                                     namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'}):
                location = failed.get('location', 'unknown')
                test = failed.get('test', '')
                messages = failed.xpath('svrl:text/text()', 
                                       namespaces={'svrl': 'http://purl.oclc.org/dsdl/svrl'})
                message = messages[0].strip() if messages else 'No message provided'
                print(f' - {location}')
                print(f'   {message}')
        else:
            # Alternative: use schematron error_log if available
            if hasattr(schematron, 'error_log'):
                for error in schematron.error_log:
                    print(f' - {error}')
            else:
                print(' - Validation failed (no detailed error information available)')
    else:
        print('Schematron validation passed.')
    
    # Exit with error if either validation failed
    if not (xsd_valid and sch_valid):
        exit(1)