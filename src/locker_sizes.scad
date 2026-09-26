// =================================================================
// EMERGENCY ROLLOUT: PARAMETRIC IMPERIAL SECURITY SPANNER BOLT
// Converts fractional inches directly to clean mm geometries for CNC/3D
// =================================================================

$fn = 120; // High resolution rendering for fabrication

/* [Emergency Preset Selection] */
// Select the target bolt specification
bolt_preset = "5/8-11"; // [ "5/8-11", "1/2-13", "3/8-16", "M16-Coarse" ]

/* [Custom Override Dimensions (Only if Preset is ignored)] */
custom_length_inches = 3.5; 

// --- INTERNAL PRESET CALCULATIONS (Inches converted to mm) ---
function get_diameter(preset) = 
    (preset == "5/8-11")     ? 0.625 * 25.4 :
    (preset == "1/2-13")     ? 0.500 * 25.4 :
    (preset == "3/8-16")     ? 0.375 * 25.4 :
    (preset == "M16-Coarse") ? 16.0 : 0.625 * 25.4;

function get_default_length(preset) = 
    (preset == "5/8-11")     ? 3.5 * 25.4 :  // 3-1/2 inches long
    (preset == "1/2-13")     ? 2.5 * 25.4 :  // 2-1/2 inches long
    (preset == "3/8-16")     ? 1.5 * 25.4 :  // 1-1/2 inches long
    (preset == "M16-Coarse") ? 90.0 : 3.5 * 25.4;

// Dynamic scaling for secure spanner head dimensions based on bolt sizing
bolt_diameter = get_diameter(bolt_preset);
bolt_length   = get_default_length(bolt_preset);

head_diameter = bolt_diameter * 2.0;       // Keeps a flat 2x wrench surface ratio
head_height   = bolt_diameter * 0.85;      // Proportional dome profile height
spanner_depth = head_height * 0.55;       // Keeps bit pins engaged past midway

// Spanner pin sizes scaled safely to prevent driver breakage under torque
spanner_hole_dia = bolt_diameter * 0.28;   
spanner_distance = bolt_diameter * 1.15;   

// Execute model
generate_imperial_security_bolt();

module generate_imperial_security_bolt() {
    echo(str("CURRENTLY GENERATING FASTENER: ", bolt_preset));
    echo(str("Bolt Shank Diameter (mm): ", bolt_diameter));
    echo(str("Bolt Shank Length (mm): ", bolt_length));
    
    difference() {
        union() {
            // Anti-pliers domed head profile
            intersection() {
                cylinder(d=head_diameter, h=head_height);
                translate([0, 0, -head_diameter/2 + head_height])
                    sphere(d=head_diameter);
            }
            
            // Unthreaded shank modeling (tapped/threaded at machine shop level)
            translate([0, 0, -bolt_length])
                cylinder(d=bolt_diameter, h=bolt_length);
        }
        
        // Pin-hole 1
        translate([spanner_distance / 2, 0, head_height - spanner_depth])
            cylinder(d=spanner_hole_dia, h=spanner_depth + 1);
            
        // Pin-hole 2
        translate([-spanner_distance / 2, 0, head_height - spanner_depth])
            cylinder(d=spanner_hole_dia, h=spanner_depth + 1);
    }
}
