// =================================================================
// FLAT COUNTERSUNK SECURITY SPANNER BOLT GENERATOR
// Eliminates tripping hazards and snowplow damage for roadways
// =================================================================

$fn = 120; // High resolution rendering

/* [Select Size Preset] */
bolt_preset = "5/8-11"; // [ "5/8-11", "1/2-13", "3/8-16" ]

function get_nominal_dia(p) = (p=="5/8-11") ? 15.875 : (p=="1/2-13") ? 12.7 : 9.525;
function get_nominal_len(p) = (p=="5/8-11") ? 88.9 : (p=="1/2-13") ? 63.5 : 38.1;

d_nominal = get_nominal_dia(bolt_preset);
l_nominal = get_nominal_len(bolt_preset);

// Standard 82-degree countersink head dimensions
head_dia    = d_nominal * 1.85; 
head_ht     = (head_dia - d_nominal) / 2; // Derived height for an 82-degree angle
span_dia    = d_nominal * 0.25;
span_dist   = d_nominal * 1.10;
span_depth  = head_ht * 0.65;

// Output flat-head geometry
difference() {
    union() {
        // Flat countersunk head (82-degree taper cone)
        cylinder(d1=d_nominal, d2=head_dia, h=head_ht);
        
        // Shank extension
        translate([0, 0, -l_nominal])
            cylinder(d=d_nominal, h=l_nominal);
    }
    
    // Flat top surface plane alignment check
    translate([0,0,-0.01]) {
        // Blind Pin Hole 1
        translate([span_dist / 2, 0, head_ht - span_depth])
            cylinder(d=span_dia, h=span_depth + 0.5);
            
        // Blind Pin Hole 2
        translate([-span_dist / 2, 0, head_ht - span_depth])
            cylinder(d=span_dia, h=span_depth + 0.5);
    }
}
