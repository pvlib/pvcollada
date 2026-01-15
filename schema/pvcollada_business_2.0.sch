<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <title>PVCollada Business Rules - Conditional requirements and domain logic</title>
    
    <ns prefix="pv" uri="http://www.example.com/pvcollada"/>
    <ns prefix="collada" uri="http://www.collada.org/2008/03/COLLADASchema"/>
    
    <!-- Pattern: Rack field requirements based on rack_type -->
    <pattern id="rack_fixed_tilt_requirements">
        <rule context="pv:rack[pv:rack_type='fixed_tilt']">
            <!-- Required fields for fixed_tilt -->
            <assert test="pv:azimuth">
                Fixed tilt rack must have azimuth element
            </assert>
            <assert test="pv:tilt">
                Fixed tilt rack must have tilt element
            </assert>
            
            <!-- Forbidden fields for fixed_tilt -->
            <assert test="not(pv:tracker_azimuth)">
                Fixed tilt rack must not have tracker_azimuth element
            </assert>
            <assert test="not(pv:tracker_slope)">
                Fixed tilt rack must not have tracker_slope element
            </assert>
            <assert test="not(pv:tracker_height)">
                Fixed tilt rack must not have tracker_height element
            </assert>
        </rule>
    </pattern>
    
    <pattern id="rack_tracker_requirements">
        <rule context="pv:rack[pv:rack_type='tracker']">
            <!-- Required fields for tracker -->
            <assert test="pv:tracker_azimuth">
                Tracker rack must have tracker_azimuth element
            </assert>
            
            <!-- Forbidden fields for tracker -->
            <assert test="not(pv:tilt)">
                Tracker rack must not have tilt element
            </assert>
            <assert test="not(pv:azimuth)">
                Tracker rack must not have azimuth element
            </assert>
            <assert test="not(pv:slope)">
                Tracker rack must not have slope element
            </assert>
            <assert test="not(pv:height_above_ground)">
                Tracker rack must not have height_above_ground element
            </assert>
        </rule>
    </pattern>
	
    <!-- Pattern: Validate mppt URL uniqueness within mppts container -->
    <!-- All mppt url values within a single mppts element must be distinct -->
    <pattern id="mppt_url_uniqueness">
        <rule context="pv:instance_inverter/pv:mppts/pv:mppt[@url]">
            <!-- Check that no preceding sibling mppt has the same url -->
            <assert test="not(preceding-sibling::pv:mppt[@url = current()/@url])">
                Duplicate mppt url '<value-of select="@url"/>' found within instance_inverter '<value-of select="ancestor::pv:instance_inverter/@id"/>'.
                All mppt url values must be distinct within the same mppts container.
            </assert>
        </rule>
    </pattern>
    
</schema>