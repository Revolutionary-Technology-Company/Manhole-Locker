// =================================================================
// FLAT COUNTERSUNK PIN-IN-HEX (SECURITY ALLEN) BOLT
// Combines high-torque hex drive with an anti-bypass center pin
// =================================================================

$fn = 120; // High resolution rendering

/* [Select Size Preset] */
bolt_preset = "5/8-11"; // [ "5/8-11", "1/2-13", "3/8-16" ]

function get_nominal_dia(p) = (p=="5/8-11") ? 15.875 : (p=="1/2-13") ? 12.7 : 9.525;
function get_nominal_len(p) = (p=="5/8-11") ? 88.9 : (p=="1/2-13") ? 63.5 : 38.1;

d_nominal = get_nominal_dia(bolt_preset);
l_nominal = get_nominal_len(bolt_preset);

// 82-Degree Countersunk Head Scaling for flush roadway alignment
head_dia    = d_nominal * 1.85; 
head_ht     = (head_dia - d_nominal) / 2; 

/* [Security Hex Parameters] */
hex_size    = d_nominal * 0.60;  // Width across flats of the hex socket
hex_depth   = head_ht * 0.65;    // Deep socket wall engagement
pin_dia     = d_nominal * 0.24;  // Center security post diameter

difference() {
    union() {
        // Flat countersunk head cone
        cylinder(d1=d_nominal, d2=head_dia, h=head_ht);
        
        // Unthreaded bolt shank (threads cut natively by machine shop lathe)
        translate([0, 0, -l_nominal])
            cylinder(d=d_nominal, h=l_nominal);
    }
    
    // Subtract the Hexagonal Socket Recess
    translate([0, 0, head_ht - hex_depth]) {
        difference() {
            // Hexagon cutout (6-sided polygon)
            linear_extrude(height = hex_depth + 0.1) {
                circle(d = hex_size / cos(30), $fn = 6);
            }
            
            // ANTI-BYPASS PIN: Leaving a solid metal cylinder in the center
            // This prevents a standard, solid Allen socket from seating
            translate([0, 0, -0.05])
                cylinder(d=pin_dia, h=hex_depth + 0.2);
        }
    }
}
