<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <title>PVCollada Reference Validation - Ensuring references are correct</title>
    
    <ns prefix="pv" uri="http://www.example.com/pvcollada"/>
    <ns prefix="collada" uri="http://www.collada.org/2008/03/COLLADASchema"/>
    
    <!-- Pattern: Validate instance_terrain references -->
    <pattern id="instance_terrain_references">
        <rule context="pv:instance_terrain">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:terrain">
                instance_terrain must be in an instance_geometry that references a geometry containing a terrain element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_rack references -->
    <pattern id="instance_rack_references">
        <rule context="pv:instance_rack">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:rack">
                instance_rack must be in an instance_geometry that references a geometry containing a rack element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_post references -->
    <pattern id="instance_post_references">
        <rule context="pv:instance_post">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:post">
                instance_post must be in an instance_geometry that references a geometry containing a post element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_gap references -->
    <pattern id="instance_gap_references">
        <rule context="pv:instance_gap">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:gap">
                instance_gap must be in an instance_geometry that references a geometry containing a gap element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_inverter3d references -->
    <pattern id="instance_inverter3d_references">
        <rule context="pv:instance_inverter3d">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:inverter3d">
                instance_inverter3d must be in an instance_geometry that references a geometry containing an inverter3d element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_combiner_ac3d references -->
    <pattern id="instance_combiner_ac3d_references">
        <rule context="pv:instance_combiner_ac3d">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:combiner_ac3d">
                instance_combiner_ac3d must be in an instance_geometry that references a geometry containing a combiner_ac3d element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>

    <!-- Pattern: Validate instance_combiner_dc3d references -->
    <pattern id="instance_combiner_dc3d_references">
        <rule context="pv:instance_combiner_dc3d">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:combiner_dc3d">
                instance_combiner_dc3d must be in an instance_geometry that references a geometry containing a combiner_dc3d element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_transformer3d references -->
    <pattern id="instance_transformer3d_references">
        <rule context="pv:instance_transformer3d">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:transformer3d">
                instance_transformer3d must be in an instance_geometry that references a geometry containing a transformer3d element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>
	
    <!-- Pattern: Validate instance_cable3d references -->
    <pattern id="instance_cable3d_references">
        <rule context="pv:instance_cable3d">
            <let name="instance_geom" value="ancestor::collada:instance_geometry"/>
            <let name="geom_url" value="substring-after($instance_geom/@url, '#')"/>
            <let name="referenced_geom" value="//collada:geometry[@id=$geom_url]"/>
            <assert test="$referenced_geom//pv:cable3d">
                instance_cable3d must be in an instance_geometry that references a geometry containing a cable3d element.
                Referenced geometry: <value-of select="$geom_url"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_table references -->
    <pattern id="instance_table_references">
        <rule context="pv:instance_table">
            <let name="instance_node" value="ancestor::collada:instance_node"/>
            <let name="node_url" value="substring-after($instance_node/@url, '#')"/>
            <let name="referenced_node" value="//collada:node[@id=$node_url]"/>
            <assert test="$referenced_node//pv:table">
                instance_table must be in an instance_node that references a node containing a table element.
                Referenced node: <value-of select="$node_url"/>
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate inverter3d component references -->
    <pattern id="inverter3d_component_references">
        <rule context="pv:inverter3d[@inverter_id]">
            <let name="inverter_ref" value="@inverter_id"/>
            <assert test="//pv:inverter[@id=$inverter_ref]">
                inverter3d element references non-existent inverter '<value-of select="$inverter_ref"/>'.
                Must reference an inverter defined in components/inverters.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate transformer3d component references -->
    <pattern id="transformer3d_component_references">
        <rule context="pv:transformer3d[@transformer_id]">
            <let name="transformer_ref" value="@transformer_id"/>
            <assert test="//pv:transformer[@id=$transformer_ref]">
                transformer3d element references non-existent transformer '<value-of select="$transformer_ref"/>'.
                Must reference a transformer defined in components/transformers.
            </assert>
        </rule>
    </pattern>
	   
    <!-- Pattern: Validate combiner_ac3d component references -->
    <pattern id="combiner_ac3d_component_references">
        <rule context="pv:combiner_ac3d[@combiner_ac_id]">
            <let name="combiner_ac_ref" value="@combiner_ac_id"/>
            <assert test="//pv:combiner_ac[@id=$combiner_ac_ref]">
                combiner_ac3d element references non-existent combiner_ac '<value-of select="$combiner_ac_ref"/>'.
                Must reference a combiner_ac defined in components.
            </assert>
        </rule>
    </pattern>
	
    <!-- Pattern: Validate combiner_dc3d component references -->
    <pattern id="combiner_dc3d_component_references">
        <rule context="pv:combiner_dc3d[@combiner_dc_id]">
            <let name="combiner_dc_ref" value="@combiner_dc_id"/>
            <assert test="//pv:combiner_dc[@id=$combiner_dc_ref]">
                combiner_dc3d element references non-existent combiner_dc '<value-of select="$combiner_dc_ref"/>'.
                Must reference a combiner_dc defined in components.
            </assert>
        </rule>
    </pattern>

    <!-- Pattern: Validate cable3d component references -->
    <pattern id="cable3d_component_references">
        <rule context="pv:cable3d[@cable_id]">
            <let name="cable_ref" value="@cable_id"/>
            <assert test="//pv:cable[@id=$cable_ref]">
                cable3d element references non-existent cable '<value-of select="$cable_ref"/>'.
                Must reference a cable defined in components/cables.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_inverter3d circuit references -->
    <pattern id="instance_inverter3d_circuit_references">
        <rule context="pv:instance_inverter3d[@instance_inverter_id]">
            <let name="instance_ref" value="@instance_inverter_id"/>
            <assert test="//pv:instance_inverter[@id=$instance_ref]">
                instance_inverter3d element references non-existent instance_inverter '<value-of select="$instance_ref"/>'.
                Must reference an instance_inverter defined in the circuit.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_transformer3d circuit references -->
    <pattern id="instance_transformer3d_circuit_references">
        <rule context="pv:instance_transformer3d[@instance_transformer_id]">
            <let name="instance_ref" value="@instance_transformer_id"/>
            <assert test="//pv:instance_transformer[@id=$instance_ref]">
                instance_transformer3d element references non-existent instance_transformer '<value-of select="$instance_ref"/>'.
                Must reference an instance_transformer defined in the circuit.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_combiner_ac3d circuit references -->
    <pattern id="instance_combiner_ac3d_circuit_references">
        <rule context="pv:instance_combiner_ac3d[@instance_combiner_ac_id]">
            <let name="instance_ref" value="@instance_combiner_ac_id"/>
            <assert test="//pv:instance_combiner_ac[@id=$instance_ref]">
                instance_combiner_ac3d element references non-existent combiner_ac instance '<value-of select="$instance_ref"/>'.
                Must reference an instance_combiner_ac defined in the circuit.
            </assert>
        </rule>
    </pattern>
	
    <!-- Pattern: Validate instance_combiner_dc3d circuit references -->
    <pattern id="instance_combiner_dc3d_circuit_references">
        <rule context="pv:instance_combiner_dc3d[@instance_combiner_dc_id]">
            <let name="instance_ref" value="@instance_combiner_dc_id"/>
            <assert test="//pv:instance_combiner_dc[@id=$instance_ref]">
                instance_combiner_dc3d element references non-existent combiner_dc instance '<value-of select="$instance_ref"/>'.
                Must reference an instance_combiner_dc defined in the circuit.
            </assert>
        </rule>
    </pattern>

    <!-- Pattern: Validate instance_cable3d circuit references -->
    <pattern id="instance_cable3d_circuit_references">
        <rule context="pv:instance_cable3d[@cable_to_parent_id]">
            <let name="cable_to_parent_ref" value="@cable_to_parent_id"/>
            <assert test="//pv:cable_to_parent[@id=$cable_to_parent_ref]">
                instance_cable3d element references non-existent cable_to_parent '<value-of select="$cable_to_parent_ref"/>'.
                Must reference a cable_to_parent defined in the circuit.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_inverter URL references -->
    <pattern id="instance_inverter_url_references">
        <rule context="pv:instance_inverter[@url]">
            <let name="component_ref" value="substring-after(@url, '#')"/>
            <assert test="//pv:inverter[@id=$component_ref]">
                instance_inverter references non-existent inverter component '<value-of select="@url"/>'.
                Must reference an inverter defined in components/inverters.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_transformer URL references -->
    <pattern id="instance_transformer_url_references">
        <rule context="pv:instance_transformer[@url]">
            <let name="component_ref" value="substring-after(@url, '#')"/>
            <assert test="//pv:transformer[@id=$component_ref]">
                instance_transformer references non-existent transformer component '<value-of select="@url"/>'.
                Must reference a transformer defined in components/transformers.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_combiner_ac URL references -->
    <pattern id="instance_combiner_ac_url_references">
        <rule context="pv:instance_combiner_ac[@url]">
            <let name="component_ref" value="substring-after(@url, '#')"/>
            <assert test="//pv:combiner_ac[@id=$component_ref]">
                instance_combiner_ac references non-existent combiner_ac component '<value-of select="@url"/>'.
                Must reference a combiner_ac defined in components/combiners_ac.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_combiner_dc URL references -->
    <pattern id="instance_combiner_dc_url_references">
        <rule context="pv:instance_combiner_dc[@url]">
            <let name="component_ref" value="substring-after(@url, '#')"/>
            <assert test="//pv:combiner_dc[@id=$component_ref]">
                instance_combiner_dc references non-existent combiner_dc component '<value-of select="@url"/>'.
                Must reference a combiner_dc defined in components/combiners_dc.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate cable_to_parent URL references -->
    <pattern id="cable_to_parent_url_references">
        <rule context="pv:cable_to_parent[@url]">
            <let name="cable_ref" value="substring-after(@url, '#')"/>
            <assert test="//pv:cable[@id=$cable_ref]">
                cable_to_parent references non-existent cable '<value-of select="@url"/>'.
                Must reference a cable defined in components/cables.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate rack module_id references -->
    <pattern id="rack_module_references">
        <rule context="pv:rack/pv:module_id">
            <let name="module_ref" value="."/>
            <assert test="//pv:module[@id=$module_ref]">
                rack references non-existent module '<value-of select="."/>'.
                Must reference a module defined in components/modules.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate instance_rack_ref URL references -->
    <pattern id="instance_rack_ref_url_references">
        <rule context="pv:instance_rack_ref[@url]">
            <let name="rack_ref" value="substring-after(@url, '#')"/>
            <assert test="//pv:instance_rack[@id=$rack_ref]">
                instance_rack_ref references non-existent instance_rack '<value-of select="@url"/>'.
                Must reference an instance_rack defined within a table model.
            </assert>
        </rule>
    </pattern>
    
    <!-- Pattern: Validate module_layout URL references -->
    <pattern id="module_layout_url_references">
        <rule context="pv:module_layout[@url]">
            <let name="rack_ref" value="substring-after(@url, '#')"/>
            <assert test="//pv:instance_rack_ref[@id=$rack_ref]">
                module_layout references non-existent instance_rack_ref '<value-of select="@url"/>'.
                Must reference an instance_rack_ref defined in an instance_table.
            </assert>
        </rule>
    </pattern>
    
</schema>