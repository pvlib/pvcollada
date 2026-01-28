<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <title>PVsyst extensions for PVCollada - Reference Validation - Ensuring references are correct</title>
    
    <ns prefix="pv" uri="http://www.example.com/pvcollada"/>
    <ns prefix="pvsyst" uri="https://www.pvsyst.com/pvcollada-2.0-extensions"/>
    <ns prefix="collada" uri="http://www.collada.org/2008/03/COLLADASchema"/>
    
    <!-- Pattern: Validate module component references -->
    <pattern id="module_component_references">
        <rule context="pvsyst:module[@module_id]">
            <let name="module_ref" value="@module_id"/>
            <assert test="//pv:module[@id=$module_ref]">
                PVsyst specific module element references non-existent PVCollada module '<value-of select="$module_ref"/>'.
                Must reference a module defined in components/modules of the standard PVCollada part.
            </assert>
        </rule>
    </pattern>

    <!-- Pattern: Validate inverter component references -->
    <pattern id="inverter_component_references">
        <rule context="pvsyst:inverter[@inverter_id]">
            <let name="inverter_ref" value="@inverter_id"/>
            <assert test="//pv:inverter[@id=$inverter_ref]">
                PVsyst specific inverter element references non-existent PVCollada inverter '<value-of select="$inverter_ref"/>'.
                Must reference an inverter defined in components/inverters of the standard PVCollada part.
            </assert>
        </rule>
    </pattern>

    <!-- Pattern: Validate optimizer component references -->
    <pattern id="optimizer_component_references">
        <rule context="pvsyst:optimizer[@optimizer_id]">
            <let name="optimizer_ref" value="@optimizer_id"/>
            <assert test="//pv:optimizer[@id=$optimizer_ref]">
                PVsyst specific optimizer element references non-existent PVCollada optimizer '<value-of select="$optimizer_ref"/>'.
                Must reference an optimizer defined in components/optimizers of the standard PVCollada part.
            </assert>
        </rule>
    </pattern>
    
</schema>
