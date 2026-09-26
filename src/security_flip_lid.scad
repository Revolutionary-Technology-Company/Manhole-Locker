// =================================================================
// PARAMETRIC HIGH-SECURITY FLIP LID WITH INTERNAL SOLENOID POCKET
// Includes integrated hinge pivot and roadway-safe flush clearance
// =================================================================

$fn = 120; // High-resolution rendering

/* [Lid Dimensions] */
lid_diameter     = 650;  // Standard municipal traffic cover diameter (mm)
lid_thickness    = 35;   // Main structural cast thickness (mm)
skirt_depth      = 50;   // Reinforcement skirt ring depth on undercarriage

/* [Hinge Configuration] */
hinge_width      = 80;   // Width of the integrated pivot block
hinge_pin_dia    = 20;   // Heavy-duty hinge pin diameter

/* [Solenoid Vault Pocket] */
vault_width      = 120;  // Housing width for electronic slam-latch
vault_length     = 160;  // Housing length for locking mechanics
vault_depth      = 60;   // Clearance depth beneath the lid face

// EXECUTE ASSEMBLY
generate_security_flip_lid();

module generate_security_flip_lid() {
    difference() {
        union() {
            // Main traffic-grade top platter
            cylinder(d=lid_diameter, h=lid_thickness);
            
            // Undercarriage structural reinforcement ring (skirt)
            translate([0, 0, -skirt_depth])
                difference() {
                    cylinder(d=lid_diameter - 20, h=skirt_depth);
                    translate([0, 0, -0.1])
                        cylinder(d=lid_diameter - 50, h=skirt_depth + 0.2);
                }
                
            // Integrated Hinge Pivot Block (Mounted on outer rim)
            translate([lid_diameter/2 - 10, -hinge_width/2, -skirt_depth])
                cube([40, hinge_width, skirt_depth + lid_thickness]);
                
            // Solid Enclosure Vault for the Locking Solenoid & Sensors
            translate([-lid_diameter/2 + 30, -vault_width/2, -vault_depth])
                cube([vault_length, vault_width, vault_depth]);
        }
        
        // Drill the Hinge Pin Center Axis
        translate([lid_diameter/2 + 10, 0, -skirt_depth/2])
            rotate([90, 0, 0])
                cylinder(d=hinge_pin_dia, h=hinge_width + 10, center=true);
                
        // Hollow out the Solenoid Vault from the bottom
        translate([-lid_diameter/2 + 40, -(vault_width-20)/2, -vault_depth - 0.1])
            cube([vault_length - 20, vault_width - 20, vault_depth]);
            
        // Emergency Manual Override Hole (Countersunk Pin-in-Hex)
        translate([-lid_diameter/2 + 80, 0, -0.1]) {
            cylinder(d1=16, d2=32, h=lid_thickness + 0.2); // 82-degree flush taper
        }
    }
}
