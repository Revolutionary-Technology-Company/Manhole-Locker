// =================================================================
// FOR TURNING/MACHINING: EXACT NOMINAL DIMENSIONS
// Outputs true-to-size geometry for lathe operators and CNC toolpaths
// =================================================================

$fn = 120;

/* [Select Size Preset] */
bolt_preset = "5/8-11"; // [ "5/8-11", "1/2-13", "3/8-16" ]

function get_nominal_dia(p) = (p=="5/8-11") ? 15.875 : (p=="1/2-13") ? 12.7 : 9.525;
function get_nominal_len(p) = (p=="5/8-11") ? 88.9 : (p=="1/2-13") ? 63.5 : 38.1;

d_nominal = get_nominal_dia(bolt_preset);
l_nominal = get_nominal_len(bolt_preset);

// Wrench head standard scaling
head_dia    = d_nominal * 2.0; 
head_ht     = d_nominal * 0.85;
span_dia    = d_nominal * 0.28;
span_dist   = d_nominal * 1.15;
span_depth  = head_ht * 0.55;

// Output exact geometry for metal turning
difference() {
    union() {
        // True spherical dome (unclamped head geometry)
        intersection() {
            cylinder(d=head_dia, h=head_ht);
            translate([0, 0, -head_dia/2 + head_ht])
                sphere(d=head_dia);
        }
        // Sharp-edge cylindrical shank ready for physical thread cutting dies
        translate([0, 0, -l_nominal])
            cylinder(d=d_nominal, h=l_nominal);
    }
    
    // Exact straight-walled pin drill holes
    translate([span_dist / 2, 0, head_ht - span_depth])
        cylinder(d=span_dia, h=span_depth + 0.5);
        
    translate([-span_dist / 2, 0, head_ht - span_depth])
        cylinder(d=span_dia, h=span_depth + 0.5);
}
