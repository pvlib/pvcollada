<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <title>PVsyst extensions for PVCollada - Structural Rules - Element Placement Validation</title>
    
    <ns prefix="pvsyst" uri="https://www.pvsyst.com/pvcollada-2.0-extensions"/>
    <ns prefix="collada" uri="http://www.collada.org/2008/03/COLLADASchema"/>
    
    <!-- Pattern: Technique profile validation -->
    <pattern id="technique_profile">
        <rule context="collada:technique[pvsyst:*]">
            <assert test="@profile='PVCollada-2.0-PVsyst-extensions'">
                Technique containing PVsyst specific elements must have profile='PVCollada-2.0-PVsyst-extensions'.
                Found profile='<value-of select="@profile"/>'
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure no duplicate PVsyst techniques in same extra element -->
    <pattern id="no_duplicate_techniques">
        <rule context="collada:extra">
            <assert test="count(collada:technique[@profile='PVCollada-2.0-PVsyst-extensions']) &lt;= 1">
                Only one technique with profile='PVCollada-2.0-PVsyst-extensions' is allowed per extra element.
                Found <value-of select="count(collada:technique[@profile='PVCollada-2.0-PVsyst-extensions'])"/> techniques.
            </assert>
        </rule>
    </pattern>
   
    <!-- Pattern: Asset-level PVsyst specific elements placement -->
    <pattern id="asset_pvsyst_placement">
        <rule context="pvsyst:components">
            <assert test="parent::collada:technique/parent::collada:extra/parent::collada:asset/parent::collada:COLLADA">
                Element '<name/>' must be inside COLLADA/asset/extra/technique
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure unique top-level PVsyst specific elements in asset -->
    <pattern id="asset_unique_elements">
        <rule context="collada:technique[@profile='PVCollada-2.0-PVsyst-extensions'][parent::collada:extra/parent::collada:asset]">
            <assert test="count(pvsyst:components) &lt;= 1">
                Only one 'components' element is allowed in asset. Found <value-of select="count(pvsyst:components)"/>
            </assert>
        </rule>
    </pattern>

	<!-- Pattern: Validate only known PVsyst specific elements in asset -->
	<pattern id="valid_asset_pvsyst_elements">
		<rule context="collada:technique[@profile='PVCollada-2.0-PVsyst-extensions'][parent::collada:extra/parent::collada:asset]/pvsyst:*">
			<assert test="self::pvsyst:components">
				Unknown PVsyst element '<name/>' in asset technique. 
				Allowed elements: components.
			</assert>
		</rule>
	</pattern>
    
</schema>