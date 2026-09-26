// =================================================================
// FLAT-FACED COUNTERSUNK SPANNER WRENCH BIT
// Designed to clear recessed pockets in manhole covers
// =================================================================

$fn = 120;

// Dimensions matching the countersunk 5/8" bolt configuration
tool_outer_dia   = 24.0;  // Must be smaller than the manhole pocket diameter
tool_body_height = 25.0;  // Main body height
drive_square_dia = 12.7;  // Standard 1/2" socket drive cutout

pin_diameter     = 3.90;  // Scaled for the countersunk hole size (with 0.05mm clearance)
pin_distance     = 17.45; // Exact center-to-center matching distance
pin_length       = 4.5;   // Length corresponding to the shorter countersunk head depth

generate_flat_spanner_tool();

module generate_flat_spanner_tool() {
    difference() {
        union() {
            // Perfectly flat cylindrical face to make flush contact with the bolt
            cylinder(d=tool_outer_dia, h=tool_body_height);
            
            // Heavy-duty straight pins protruding from the flat face
            translate([pin_distance / 2, 0, tool_body_height])
                cylinder(d=pin_diameter, h=pin_length);
                
            translate([-pin_distance / 2, 0, tool_body_height])
                cylinder(d=pin_diameter, h=pin_length);
        }
        
        // 1/2" Square drive receptacle for standard field ratchets or breaker bars
        translate([-drive_square_dia/2, -drive_square_dia/2, -0.1])
            cube([drive_square_dia, drive_square_dia, 15]);
    }
}
