// =================================================================
// 3D ISOMETRIC VIEWPORT RENDER PACK
// Forces OpenSCAD into an un-sectioned solid 3D presentation view
// =================================================================

// --- AUTOMATED CAM VIEWPORT CONTROLS ---
$vpr =;      // Forces a standard 3D isometric rotation tilt
$vpt =;       // Translates the target camera focus to center-head
$vpd = 160;              // Viewport distance zoom factor
$fn  = 120;              // Smooth circles for clean 3D visual auditing

/* [Fastener Sizing Parameters] */
bolt_diameter    = 15.875; // 5/8" nominal shank size in mm
bolt_length      = 88.9;   // 3.5" length profile 
head_diameter    = 31.75;  // 1.25" wide anti-pry perimeter dome
head_height      = 13.5;   // Extended high-torque head thickness

/* [Snake-Eyes Security Configuration] */
spanner_hole_dia = 4.5;    // 0.177" drill bit hole size
spanner_distance = 18.25;  // 0.718" center-to-center pin spacing
spanner_depth    = 7.15;   // Deep-well anti-strip drive holes

// MAIN GEOMETRY DISPLAY
color("LightSilver") {
    generate_solid_isometric_view();
}

module generate_solid_isometric_view() {
    difference() {
        union() {
            // Un-sectioned Solid Spherical Security Head 
            intersection() {
                cylinder(d=head_diameter, h=head_height);
                translate([0, 0, -head_diameter/2 + head_height])
                    sphere(d=head_diameter);
            }
            
            // Solid Shank (Machine shops add physical threads here)
            translate([0, 0, -bolt_length])
                cylinder(d=bolt_diameter, h=bolt_length);
        }
        
        // Exact Blind "Snake Eye" Recesses (No slots, completely isolated)
        translate([spanner_distance / 2, 0, head_height - spanner_depth])
            cylinder(d=spanner_hole_dia, h=spanner_depth + 1);
            
        translate([-spanner_distance / 2, 0, head_height - spanner_depth])
            cylinder(d=spanner_hole_dia, h=spanner_depth + 1);
    }
}
