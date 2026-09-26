// =================================================================
// FOR CASTING MOLDS: PARAMETRIC PATTERN GENERATOR
// Includes 1.5-degree draft angles and dynamic shrinkage scaling
// =================================================================

$fn = 120;

/* [Casting Configuration] */
// Adjust based on your foundry metal (1.02 adds a 2% oversize for iron/steel shrinkage)
shrinkage_factor = 1.02; 

/* [Select Size Preset] */
bolt_preset = "5/8-11"; // [ "5/8-11", "1/2-13", "3/8-16" ]

// Base Imperial calculations (in mm before shrinkage)
function get_dia(p) = (p=="5/8-11") ? 15.875 : (p=="1/2-13") ? 12.7 : 9.525;
function get_len(p) = (p=="5/8-11") ? 88.9 : (p=="1/2-13") ? 63.5 : 38.1; // 3.5", 2.5", 1.5"

// Scaled Dimensions based on Foundry Shrinkage
d_shank = get_dia(bolt_preset) * shrinkage_factor;
l_shank = get_len(bolt_preset) * shrinkage_factor;
d_head  = (get_dia(bolt_preset) * 2.0) * shrinkage_factor;
h_head  = (get_dia(bolt_preset) * 0.85) * shrinkage_factor;

// Spanner pin configurations (Slightly oversized to allow clean bit fitment after casting)
spanner_dia  = (get_dia(bolt_preset) * 0.30) * shrinkage_factor;
spanner_dist = (get_dia(bolt_preset) * 1.15) * shrinkage_factor;
spanner_dep  = (h_head * 0.55) * shrinkage_factor;

// Compile the casting pattern
scale([shrinkage_factor, shrinkage_factor, shrinkage_factor]) {
    generate_casting_pattern();
}

module generate_casting_pattern() {
    difference() {
        union() {
            // Head with a smooth spherical top
            intersection() {
                cylinder(d=d_head/shrinkage_factor, h=h_head/shrinkage_factor);
                translate([0, 0, -(d_head/2) + h_head]/shrinkage_factor)
                    sphere(d=d_head/shrinkage_factor);
            }
            // Shank with a 1.5-degree draft angle for easy mold extraction
            translate([0, 0, -l_shank/shrinkage_factor])
                cylinder(d1=d_shank*0.95/shrinkage_factor, d2=d_shank/shrinkage_factor, h=l_shank/shrinkage_factor);
        }
        
        // Pin 1 (Cone-shaped bottom to help sand cores drop out clean)
        translate([spanner_dist/2, 0, h_head - spanner_dep]/shrinkage_factor)
            cylinder(d1=spanner_dia*0.9/shrinkage_factor, d2=spanner_dia/shrinkage_factor, h=(spanner_dep + 1)/shrinkage_factor);
            
        // Pin 2
        translate([-spanner_dist/2, 0, h_head - spanner_dep]/shrinkage_factor)
            cylinder(d1=spanner_dia*0.9/shrinkage_factor, d2=spanner_dia/shrinkage_factor, h=(spanner_dep + 1)/shrinkage_factor);
    }
}
