// =================================================================
// HOLLOW-POINT SECURITY HEX (ALLEN) DRIVER BIT
// Features a center clearance hole to bypass the security post
// =================================================================

$fn = 120; // High resolution rendering

/* [Select Size Preset] */
bolt_preset = "5/8-11"; // [ "5/8-11", "1/2-13", "3/8-16" ]

function get_nominal_dia(p) = (p=="5/8-11") ? 15.875 : (p=="1/2-13") ? 12.7 : 9.525;

d_nominal = get_nominal_dia(bolt_preset);

// Wrench Dimensions Scaled to the Hex Bolt Parameters
hex_size     = d_nominal * 0.60;   // Nominal width across flats
clearance    = 0.08;               // 0.08mm tolerance gap for easy tool fitment
hex_size_fit = hex_size - clearance; 

pin_dia      = d_nominal * 0.24;   // Center security post diameter from bolt
pin_hole_dia = pin_dia + 0.15;     // Extra clearance so road grime doesn't jam it

tool_body_ht = 35.0;               // Total length of the wrench bit tool
pin_hole_dep = 12.0;               // How deep the center hole is drilled
drive_sq_dia = 12.7;               // 1/2" square socket drive for impact wrenches

generate_security_hex_wrench();

module generate_security_hex_wrench() {
1QzQaa    difference() {
        union() {
            // Hexagonal Driver Body (6-sided prism)
            linear_extrude(height = tool_body_ht) {
                circle(d = hex_size_fit / cos(30), $fn = 6);
            }
        }
        
        // Subtract the Center Pin Clearance Hole (Hollow Point)
        translate([0, 0, tool_body_ht - pin_hole_dep])
            cylinder(d = pin_hole_dia, h = pin_hole_dep + 0.1);
            
        // Subtract standard 1/2" square socket cutout at the base 
        // This allows field crews to click it directly into standard service truck impacts
        translate([-drive_sq_dia/2, -drive_sq_dia/2, -0.1])
            cube([drive_sq_dia, drive_sq_dia, 15]);
    }
}
