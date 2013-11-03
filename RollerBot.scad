/*
 * Author:  Mark Hanford
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     
 */

include <utils/build_plate.scad>;
include <utils/arduino.scad>;
include <utils/battery-pack-contact-nuts.scad>;

/* [Common] */
part = "lowerbody"; // [lowerbody:Lower Body]

/* [Printer] */
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 150; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 110; //[100:400]

/* [Hidden] */
// helper constants
x=0;y=1;z=2;

// Jitter
j = 0.01;

// General thickness
t = 2;

main_body_size = [80, 80, 2];


module body()
{
	translate([main_body_size[x] * -0.5, main_body_size[y] * -0.5, 0])
	union()
	{
		difference()
		{
			linear_extrude(height = 20, convexity = 10, twist = 0)
			{
				polygon( 
					points = 
					[ 
						[0, 0], // bottom-left
						[main_body_size[x]-10, 0],
						[main_body_size[x], 10],
						[main_body_size[x], main_body_size[y]-10],
						[main_body_size[x]-10, main_body_size[y]],
						[0, main_body_size[y]]
					]
				);
			}
				
			translate([0, 0, t])
			linear_extrude(height = 20, convexity = 10, twist = 0)
			{
				polygon( 
					points = 
					[
						[t, 2*t],
						[2*t, t],
						[main_body_size[x]-t-9, 2],
						[main_body_size[x]-t, 11],
						
						[main_body_size[x]-t, main_body_size[y]*0.5-t],
						[main_body_size[x]-t*2, main_body_size[y]*0.5-t],
						[main_body_size[x]-t*2, main_body_size[y]*0.5+t],
						[main_body_size[x]-t, main_body_size[y]*0.5+t],
					
						[main_body_size[x]-t, main_body_size[y]-11],
						[main_body_size[x]-t-9, main_body_size[y]-t],
						[2*t, main_body_size[y]-t],
						[t, main_body_size[y]-2*t],
					],
					convexity = 10
				);
			}

			// carve out some holes for the Arduino
			translate([22, 65, 3])
			Arduino(1, 0, 1);	
		}
		translate([22, 65, 3])
		%Arduino(0, 0, 0);	
	}
}

module printPart()
{
	if (part == "lowerbody")
	{
		body();
	}
}


printPart();

// Draw a build-plate for scale
%build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);
