/**
 * Customizable screw box
 *
 * Pierre Quélin
 * pierre.quelin.1972@gmail.com
 *
 * Thanks to dedalo1
 * - http://www.thingiverse.com/thing:2222574
 * and all others for design and ideas !
 * - https://www.thingiverse.com/thing:684948
 * - https://www.thingiverse.com/thing:3187230
 * - ...
 */

// Outside Box Dimensions
// Box Length 
finalBoxLength=60;
// Box Width
finalBoxWidth=40;
// Box Height1
finalBoxHeight=40;

// Wall thickness
wallThickness=1.6; // Good speed
// Chamfer ?
boxRadius =4;

// Number of sections
numSections=1;
// Merge sections (make one side bigger, use 2 or more to merge, 0 or 1 to normal)
mergeSections=1;

// With or without edge (0: without 1:with)
isStackable=1;
// If needed, adjustement between the top and bottom boxes so that they can be stacked.
adjustment=0.8;
// Calculate the box Length (without the edge and the adjustement)
boxLength=finalBoxLength-isStackable*(adjustment+2*wallThickness);
// Box Width
boxWidth=finalBoxWidth-isStackable*(adjustment+2*wallThickness);
// Box Height
boxHeight=finalBoxHeight-isStackable*(wallThickness);

// With or without label (0: without 1:with)
isLabel=1;
// Label width
labelWidth=10;
sectionWidth=(boxLength - (numSections+1)*wallThickness)/numSections;
// 1) Label length = 30% * sectionWidth
// labelLength=0.3*sectionWidth;
// 2) Label length = constant
labelLength=20;

// Fix $fn (number of facets used to generate an arc) value
$fn=50;

// Hidden
dividerCount=mergeSections?numSections-mergeSections:numSections-1;

module cube_c(length, width, height, radius){
   difference() {
      minkowski() {
         cube( [length- 2*radius, width-2*radius, height], center=true );
         cylinder(r=radius, h=2*radius, center=true);
      }
      translate( [0,0,(height+radius)/2] ) cube( [length, width, radius], center=true );
      translate( [0,0,-(height+radius)/2] ) cube( [length, width, radius], center=true );
   }
}

module cube_s(length, width, height, radius){
   minkowski() {
      cube( [length- 2*radius, width-2*radius, height-2*radius], center=true );
      sphere(radius); 
   }
}

// Obsolete. Poor finish 
module obsolete_label_box(height, width, length){
   alpha=asin(width/height);
   d=sqrt(pow(height,2)-pow(width,2));
   translate([0,0,-length/2])
      linear_extrude(height=length)
         polygon(points=[[0,0],[0,height],[-sin(alpha)*d,cos(alpha)*d]], path=[[0,1,2]]);
}

module label_box(height, width, length){
   alpha=asin(width/height);
   d=sqrt(pow(height,2)-pow(width,2));
   translate([0,0,-length/2])
      linear_extrude(height=length)
         // Provisioning of 1mm for the thickness of the real label
         polygon(points=[[0,height-width-0.8-1],[0,height-1],[-width,height-1],[-width,height-0.8-1]], path=[[0,1,2,3]]);
}

module edge(/* TODO parameters */) {
   rotate([180,0,0])
      difference() {
         translate([0,0,0.5*wallThickness])
            cube_c(boxLength+2*wallThickness+adjustment, boxWidth+2*wallThickness+adjustment, 3*wallThickness, boxRadius);
         union() {
            translate([0,0,0.5*wallThickness])
               cube_c(boxLength, boxWidth, wallThickness*3+1, boxRadius);
            translate([0,0,-wallThickness/2])
               cube_c(boxLength+adjustment, boxWidth+adjustment, wallThickness, boxRadius);
         }
         // 45 degrees for edge support
          translate([0, (boxWidth+wallThickness)/2, 2*wallThickness]) 
            rotate([45,0,0])
               cube([boxLength+2*wallThickness+1, 2*wallThickness, 6*wallThickness], center=true);
         translate([0,-(boxWidth+wallThickness)/2, 2*wallThickness]) 
            rotate([-45,0,0])
               cube([boxLength+2*wallThickness+1, 2*wallThickness, 6*wallThickness],center=true);
         translate([(boxLength+wallThickness)/2, 0, 2*wallThickness]) 
            rotate([0,-45,0])
               cube([2*wallThickness, boxWidth+2*wallThickness+1, 6*wallThickness],center=true);
         translate([-(boxLength+wallThickness)/2, 0, 2*wallThickness]) 
            rotate([0,45,0])
               cube([2*wallThickness, boxWidth+2*wallThickness+1, 6*wallThickness],center=true);
      }
}

module screwBox() {
   // The box
   difference() {
      translate([0,0,boxHeight/2])
         // Outside
         cube_c(boxLength, boxWidth, boxHeight, boxRadius);
      translate([0,0,(boxHeight-wallThickness+boxRadius)/2+wallThickness]) 
         // Inside
         cube_s(boxLength-wallThickness*2,boxWidth-wallThickness*2,boxHeight-wallThickness+boxRadius, boxRadius);
   }
   
   // The dividers
   for (id=[0:dividerCount]) {
      if (id!=0){
         origin=(boxLength-wallThickness)/2;
         offset=(boxLength-wallThickness)/numSections;
         translate([origin-id*offset,0,0])
            translate([0,0,boxHeight/2])
               cube([wallThickness,boxWidth,boxHeight],center=true);
      }
   }
   
   // The labels
   if (isLabel==1){
      for (id=[0:dividerCount]) {
         origin=boxLength/2-wallThickness - sectionWidth/2;
         offset=sectionWidth+wallThickness;
         translate([origin-id*offset,0,0])
            translate([0, (boxWidth/2)-wallThickness, 0 ])
                  rotate([90,0,90])
                     label_box(boxHeight, labelWidth, labelLength);
       }
    }
    
   // The edge
   if (isStackable==1){
      translate([0,0,boxHeight])
         edge();
   }
}

screwBox();
