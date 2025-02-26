import sys

from lxml import etree


if __name__ == '__main__':
    assert len(sys.argv) == 3
    xsd_filepath, xml_filepath = sys.argv[1], sys.argv[2]
    with open(xsd_filepath, 'rb') as xsd:
        schema_root = etree.XML(xsd.read())
    with open(xml_filepath, 'rb') as xml:
        xml_doc = etree.XML(xml.read())

    schema = etree.XMLSchema(schema_root)
    if schema.validate(xml_doc):
        print('XML is valid.')
    else:
        print('! XML is invalid.')
        for error in schema.error_log:
            print(' -', error.message)
        exit(1)
