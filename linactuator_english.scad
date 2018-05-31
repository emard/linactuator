up=1; // make the upper part, enable with 1, disable with 0
down=1; // make the bottom, enable with 1, disable with 0
cut=1; // visualize the interior, enable with 1, disable with 0
tiles=1; // spacers with different thickness, enable with 1, disable with 0

lifter_xy=17;

screw_xy=11;
screw_thread_d=2.3; // hole for screw thread
screw_thread_h=15; // upper hole depth
screw_passage_d=2.5; // cover
screw_tiles_d=2.1;
// screw_h=10; // depth of the hole for the screw
screw_thread_d_down=1.8; // down for a little screw
screw_thread_h_down=15; // lower depth of the hole

circle_d=10;
circle_h=2;

cut_h=4; // length of the cut part
cut_d=0.1; // the size of the cut

nut_d=6.5;  // a 6-angular hole of the hole that the nut passes smoothly. The nuts are 6.0 mm wide
entrance_nut_h=0.6; // depth of the extended input for the nut
entrance_nut_d=nut_d+2*entrance_nut_h; // the size of the extended input
//nut_h=22.4; // depth of hole for 2 nuts and feder (1 nuts is 8.1 mm long, unloaded feder is 8 mm)
nut_h=2*8+17-4; // feder 17 mm
lifter_h=nut_h+7.6;
rod_d=4.5; // hole for the threaded rod, a lot of lufts
transition_h=nut_d-rod_d; // the height of the conical 6-angular transition from the nut to the hole for the bar to avoid falling down the layers

if(up > 0.5 || down > 0.5)
union()
{
  difference()
  {
    union()
    {
      cube([lifter_xy, lifter_xy,lifter_h],center=true);
      translate([0,0,lifter_h/2+circle_h/2])
        cylinder(d=circle_d,h=circle_h,$fn=50,center=true);
    }  
    union()
    {
      // screw through everything
      for(i=[0:3])
        rotate([0,0,90*i])
        {
          // screw thread (up)
          translate([screw_xy/2,screw_xy/2,lifter_h/2-screw_thread_h/2])
            cylinder(d=screw_thread_d,h=screw_thread_h+0.001,$fn=50,center=true);
          // screw thread (down)
          translate([screw_xy/2,screw_xy/2,-lifter_h/2+screw_thread_h_down/2])
            cylinder(d=screw_thread_d_down,h=screw_thread_h_down+0.001,$fn=50,center=true);
          // hole through the lower part cut
          translate([screw_xy/2,screw_xy/2,-lifter_h/2+cut_h/2])
            cylinder(d=screw_passage_d,h=cut_h+0.001,$fn=50,center=true);
  
        }
      // a cut that separates 2 parts of the half
      translate([0,0,-lifter_h/2+cut_h])
        cube([lifter_xy,lifter_xy,cut_d],center=true);

      // the cortex will remove the lower part
      if( down == 0 )
      {
        translate([0,0,-lifter_h/2+cut_h/2])
          cube([lifter_xy+0.001,lifter_xy+0.001,cut_h+0.001],center=true);
      }

      // the cortex will remove the lower part
      if( up == 0 )
      {
        translate([0,0,-lifter_h/2+cut_h+(lifter_h+circle_h-cut_h)/2])
          cube([lifter_xy+0.001,lifter_xy+0.001,(lifter_h+circle_h-cut_h)+0.001],center=true);
      }

      // hole for threaded rod
      cylinder(d=rod_d,h=2*lifter_h,$fn=50,center=true);

      // 6-angular hole nuts
      translate([0,0,(-lifter_h/2+cut_h)+nut_h/2])
        cylinder(d=nut_d*2/sqrt(3),h=nut_h+0.001,$fn=6,center=true);

      // conical 6-angular extended input for nuts
      translate([0,0,(-lifter_h/2+cut_h)+entrance_nut_h/2])
        cylinder(d1=entrance_nut_d*2/sqrt(3),d2=nut_d*2/sqrt(3),h=entrance_nut_h+0.001,$fn=6,center=true);

      // conical 6-angular transition from nut to hole,
      // that the printed layers do not fall
      translate([0,0,(-lifter_h/2+cut_h)+nut_h+transition_h/2])
        cylinder(d1=nut_d*2/sqrt(3),d2=rod_d,h=transition_h+0.001,$fn=6,center=true);
      
      // a cube for the intersection to visualize the interior
      if(cut)
      translate([lifter_xy/2,0,0])
      cube([lifter_xy,lifter_xy+0.01,lifter_h*2],center=true);
    }
  }
}

module spacers()
{
  d=[0.5,1,2];
  for(i = [0:len(d)-1])
  {
    translate([lifter_xy*1.5*(i-1),0,d[i]/2])
      difference()
      {
        cube([lifter_xy,lifter_xy,d[i]],center=true);
        // 6-angular holes for the nut
        cylinder(d=nut_d*2/sqrt(3),h=d[i]+0.001,$fn=6,center=true);
      // screw through everything
        for(j=[0:3])
          rotate([0,0,90*j])
          {
          translate([screw_xy/2,screw_xy/2,0])
            cylinder(d=screw_tiles_d,h=d[i]+0.001,$fn=50,center=true);
              // 
          }
      }
  }
}

if(tiles > 0.5)
    spacers();

