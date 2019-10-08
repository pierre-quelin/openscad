/**
 * Drawer dividers
 *
 * Pierre Quélin
 * pierre.quelin.1972@gmail.com
 *
 */

// Inside Box Dimensions
// Box Length (X)
Length=247;
// Box Width (Y)
// TODO 132 + 192 = 324 
Width=192;
// Box Height (Z)
Height=30;

// Number of sections
NbLengthSections=1;
NbWidthSections=4;

// Wall thickness
Thickness=1.6; // Good speed
// Rounding radius
Radius = 5;


// Fix $fn (number of facets used to generate an arc) value
$fn=50;

module round() 
{
    difference()
    {
		cube([Radius, Radius, Height]);
		translate([Radius, Radius, 0]) cylinder(h=(Height+1)*2,r=Radius, center=true);
	}
};

module rounding( stepX, stepY )
{
    if ((stepX !=NbWidthSections) && (stepY !=NbLengthSections))
    {
        translate([stepX*((Length-Thickness)/NbWidthSections)+Thickness, stepY*((Width-Thickness)/NbLengthSections)+Thickness, 0]) round();
    }
     
    if ((stepX !=0) && (stepY !=NbLengthSections))
    {
        translate([stepX*((Length-Thickness)/NbWidthSections), stepY*((Width-Thickness)/NbLengthSections)+Thickness, 0]) rotate([0,0,90]) round();
    }
     
    if ((stepX !=0) && (stepY !=0))
    {
        translate([stepX*((Length-Thickness)/NbWidthSections), stepY*((Width-Thickness)/NbLengthSections), 0]) rotate([0,0,180]) round();
    }
     
    if ((stepX !=NbWidthSections) && (stepY !=0))
    {
        translate([stepX*((Length-Thickness)/NbWidthSections)+Thickness, stepY*((Width-Thickness)/NbLengthSections), 0]) rotate([0,0,270]) round();
    }
}


module drawerdividers()
{
    union()
    {
        // X dividers
        for(x = [1:NbWidthSections-1])
            translate([x*((Length-Thickness)/NbWidthSections), 0, 0]) cube([Thickness, Width, Height]);

        // Y dividers
        for(y = [0:NbLengthSections])
            translate([0, y*((Width-Thickness)/NbLengthSections), 0]) cube([Length, Thickness, Height]);
       
        // Rounding
        for(x = [1:NbWidthSections-1])
            for(y = [0:NbLengthSections])
                rounding(x, y);
    };
};

drawerdividers();