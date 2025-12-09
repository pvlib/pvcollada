<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <title>PVCollada Structural Rules - Element Placement Validation</title>
    
    <ns prefix="pv" uri="http://www.example.com/pvcollada"/>
    <ns prefix="collada" uri="http://www.collada.org/2008/03/COLLADASchema"/>
    
    <!-- Pattern: Technique profile validation -->
    <pattern id="technique_profile">
        <rule context="collada:technique[pv:*]">
            <assert test="@profile='PVCollada-2.0'">
                Technique containing PVCollada elements must have profile='PVCollada-2.0'.
                Found profile='<value-of select="@profile"/>'
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure no duplicate PVCollada techniques in same extra element -->
    <pattern id="no_duplicate_techniques">
        <rule context="collada:extra">
            <assert test="count(collada:technique[@profile='PVCollada-2.0']) &lt;= 1">
                Only one technique with profile='PVCollada-2.0' is allowed per extra element.
                Found <value-of select="count(collada:technique[@profile='PVCollada-2.0'])"/> techniques.
            </assert>
        </rule>
    </pattern>
	
	<!-- Pattern: Ensure up_axis is Z_UP -->
	<pattern id="asset_up_axis_requirement">
		<rule context="collada:COLLADA/collada:asset">
			<assert test="collada:up_axis">
				Asset must contain an up_axis element
			</assert>
			<assert test="collada:up_axis = 'Z_UP'">
				up_axis must have value 'Z_UP'. Found '<value-of select="collada:up_axis"/>'
			</assert>
		</rule>
	</pattern>
    
    <!-- Pattern: Asset-level PVCollada elements placement -->
    <pattern id="asset_pvcollada_placement">
        <rule context="pv:software | pv:project | pv:components | pv:circuit">
            <assert test="parent::collada:technique/parent::collada:extra/parent::collada:asset/parent::collada:COLLADA">
                Element '<name/>' must be inside COLLADA/asset/extra/technique
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure unique top-level PVCollada elements in asset -->
    <pattern id="asset_unique_elements">
        <rule context="collada:technique[@profile='PVCollada-2.0'][parent::collada:extra/parent::collada:asset]">
            <assert test="count(pv:software) &lt;= 1">
                Only one 'software' element is allowed in asset. Found <value-of select="count(pv:software)"/>
            </assert>
            <assert test="count(pv:project) &lt;= 1">
                Only one 'project' element is allowed in asset. Found <value-of select="count(pv:project)"/>
            </assert>
            <assert test="count(pv:components) &lt;= 1">
                Only one 'components' element is allowed in asset. Found <value-of select="count(pv:components)"/>
            </assert>
            <assert test="count(pv:circuit) &lt;= 1">
                Only one 'circuit' element is allowed in asset. Found <value-of select="count(pv:circuit)"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Geometry-level PVCollada elements placement -->
    <pattern id="geometry_pvcollada_placement">
        <rule context="pv:terrain | pv:rack | pv:post | pv:gap | 
                      pv:inverter3d | pv:combiner3d | pv:transformer3d | pv:cable3d">
            <assert test="parent::collada:technique/parent::collada:extra/parent::collada:geometry">
                Element '<name/>' must be inside geometry/extra/technique
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure unique geometry elements -->
    <pattern id="geometry_unique_elements">
        <rule context="collada:technique[@profile='PVCollada-2.0'][parent::collada:extra/parent::collada:geometry]">
            <assert test="count(pv:terrain | pv:rack | pv:post | pv:gap | 
                               pv:inverter3d | pv:combiner3d | pv:transformer3d | pv:cable3d) &lt;= 1">
                Only one terrain, rack, post, gap, inverter3d, combiner3d, transformer3d or cable3d element is allowed per geometry. 
                Found <value-of select="count(pv:terrain | pv:rack | pv:post | pv:gap | 
                                            pv:inverter3d | pv:combiner3d | pv:transformer3d | pv:cable3d)"/> elements.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Instance_geometry-level PVCollada elements placement -->
    <pattern id="instance_geometry_pvcollada_placement">
        <rule context="pv:instance_terrain | pv:instance_rack | pv:instance_post | pv:instance_gap | 
                      pv:instance_inverter3d | pv:instance_combiner3d | pv:instance_transformer3d | pv:instance_cable3d">
            <assert test="parent::collada:technique/parent::collada:extra/parent::collada:instance_geometry">
                Element '<name/>' must be inside instance_geometry/extra/technique
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure unique instance_geometry elements -->
    <pattern id="instance_geometry_unique_elements">
        <rule context="collada:technique[@profile='PVCollada-2.0'][parent::collada:extra/parent::collada:instance_geometry]">
            <assert test="count(pv:instance_terrain | pv:instance_rack | pv:instance_post | pv:instance_gap | 
                               pv:instance_inverter3d | pv:instance_combiner3d | pv:instance_transformer3d | pv:instance_cable3d) &lt;= 1">
                Only one instance_terrain, instance_rack, instance_post, instance_gap, instance_inverter3d, instance_combiner3d, instance_transformer3d or pv:instance_cable3d element is allowed per instance_geometry. 
                Found <value-of select="count(pv:instance_terrain |  pv:instance_rack | pv:instance_post | pv:instance_gap | 
                                            pv:instance_inverter3d | pv:instance_combiner3d | pv:instance_transformer3d | pv:instance_cable3d)"/> elements.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Node-level PVCollada elements placement -->
    <pattern id="node_pvcollada_placement">
        <rule context="pv:table">
            <assert test="parent::collada:technique/parent::collada:extra/parent::collada:node">
                Element 'table' must be inside node/extra/technique
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure unique node elements -->
    <pattern id="node_unique_elements">
        <rule context="collada:technique[@profile='PVCollada-2.0'][parent::collada:extra/parent::collada:node]">
            <assert test="count(pv:table) &lt;= 1">
                Only one 'table' element is allowed per node. Found <value-of select="count(pv:table)"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Instance_node-level PVCollada elements placement -->
    <pattern id="instance_node_pvcollada_placement">
        <rule context="pv:instance_table">
            <assert test="parent::collada:technique/parent::collada:extra/parent::collada:instance_node">
                Element 'instance_table' must be inside instance_node/extra/technique
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure unique instance_node elements -->
    <pattern id="instance_node_unique_elements">
        <rule context="collada:technique[@profile='PVCollada-2.0'][parent::collada:extra/parent::collada:instance_node]">
            <assert test="count(pv:instance_table) &lt;= 1">
                Only one 'instance_table' element is allowed per instance_node. Found <value-of select="count(pv:instance_table)"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Ensure table nodes contain rack instances -->
    <pattern id="table_must_contain_racks">
        <rule context="collada:node[.//pv:table]">
            <assert test=".//pv:instance_rack">
                A node containing a table element must have at least one instance_geometry child with an instance_rack element
            </assert>
        </rule>
    </pattern>
    
</schema>