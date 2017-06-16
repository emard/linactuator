podizac_xy=20;
podizac_h=30;

sarafi_xy=15;
sarafi_navoj_d=2.0; // rupa za navoj sarafa
sarafi_prolaz_d=3.0;
sarafi_h=10; // dubina rupe za saraf

krug_d=12;
krug_h=2;

rez_h=6; // dužina odrezanog dijela
rez_d=2; // veličina samog reza

matica_d=6;  // veličina 6-kutne rupe za maticu = otvor ključa
matica_h=15; // dužina rupe za 2 matice

sipka_d=5; // rupa za navojnu šipku, dosta lufta

union()
{
  difference()
  {
    union()
    {
      cube([podizac_xy, podizac_xy,podizac_h],center=true);
      translate([0,0,podizac_h/2+krug_h/2])
        cylinder(d=krug_d,h=krug_h,$fn=50,center=true);
    }  
    union()
    {
      // sarafi kroz sve
      for(i=[0:3])
        rotate([0,0,90*i])
        {
          // navoj sarafa
          translate([sarafi_xy/2,sarafi_xy/2,0])
            cylinder(d=sarafi_navoj_d,h=podizac_h+0.001,$fn=50,center=true);
          // rupa kroz donji odrezani dio
          translate([sarafi_xy/2,sarafi_xy/2,-podizac_h/2+rez_h/2])
            cylinder(d=sarafi_prolaz_d,h=rez_h+0.001,$fn=50,center=true);
  
        }
      // rez donjeg dijela polovice
      translate([0,0,-podizac_h/2+rez_h])
        cube([podizac_xy,podizac_xy,rez_d],center=true);
      // rupa za navojnu šipku
      cylinder(d=sipka_d,h=2*podizac_h,$fn=50,center=true);
      // 6-kutna rupa za matice
      translate([0,0,-podizac_h/2+rez_h+matica_h/2])
        cylinder(d=matica_d*2/sqrt(3),h=matica_h+0.001,$fn=6,center=true);
    }
  }
}


