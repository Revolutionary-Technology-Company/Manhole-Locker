// =================================================================
// EXTENDED PARAMETRIC SECURITY SPANNER BOLT GENERATOR
// Optimized for deep thread engagement / thick manhole lips
// =================================================================

$fn = 100; // Render resolution smoothness

/* [Bolt Dimensions] */
bolt_diameter    = 16;   // Thread/shank diameter in mm (e.g., M16)
bolt_length      = 100;  // EXTENDED: Total length of the shank/threaded area in mm

/* [Security Head Dimensions] */
head_diameter    = 32;   // Diameter of the security head (Recommend ~2x bolt diameter)
head_height      = 15;   // EXTENDED: Thicker head for deeper tool seating and high torque

/* [Spanner Drive Configuration] */
spanner_hole_dia = 5;    // Diameter of each spanner pin-hole in mm
spanner_distance = 18;   // Center-to-center distance between the two holes in mm
spanner_depth    = 8;    // EXTENDED: Deeper pins to prevent tool slippage under heavy load

// Main execution module
generate_security_bolt();

module generate_security_bolt() {
    difference() {
        union() {
            // Smooth, rounded tamper-proof head
            // The sloping sides make it nearly impossible to grip with locking pliers
            intersection() {
                cylinder(d=head_diameter, h=head_height);
                translate([0, 0, -head_diameter/2 + head_height])
                    sphere(d=head_diameter);
            }
            
            // Long Bolt Shank 
            translate([0, 0, -bolt_length])
                cylinder(d=bolt_diameter, h=bolt_length);
        }
        
        // Subtract the two deep Spanner (Snake Eye) Holes
        translate([spanner_distance / 2, 0, head_height - spanner_depth])
            cylinder(d=spanner_hole_dia, h=spanner_depth + 1);
            
        translate([-spanner_distance / 2, 0, head_height - spanner_depth])
            cylinder(d=spanner_hole_dia, h=spanner_depth + 1);
    }
}
