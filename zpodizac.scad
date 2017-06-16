podizac_xy=17;
podizac_h=30;

sarafi_xy=11;
sarafi_navoj_d=2.0; // rupa za navoj sarafa
sarafi_prolaz_d=3.0;
// sarafi_h=10; // dubina rupe za saraf

krug_d=10;
krug_h=2;

rez_h=4; // dužina odrezanog dijela
rez_d=0.1; // veličina samog reza

matica_d=7;  // veličina 6-kutne rupe za maticu = otvor ključa
matica_h=20.2; // dubina rupe za 2 matice (svaka 10 mm)

sipka_d=5.5; // rupa za navojnu šipku, dosta lufta

gore=1; // napravi gornji dio
dolje=1; // napravi donji dio

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
      // rez koji odvaja 2 dijela polovice
      translate([0,0,-podizac_h/2+rez_h])
        cube([podizac_xy,podizac_xy,rez_d],center=true);

      // skorz uklonit donji dio
      if( dolje == 0 )
      {
        translate([0,0,-podizac_h/2+rez_h/2])
          cube([podizac_xy,podizac_xy,rez_h+0.001],center=true);
      }

      // skorz uklonit gornji dio
      if( gore == 0 )
      {
        translate([0,0,-podizac_h/2+rez_h+(podizac_h+krug_h-rez_h)/2])
          cube([podizac_xy,podizac_xy,(podizac_h+krug_h-rez_h)+0.001],center=true);
      }

      // rupa za navojnu šipku
      cylinder(d=sipka_d,h=2*podizac_h,$fn=50,center=true);
      // 6-kutna rupa za matice
      translate([0,0,(-podizac_h/2+rez_h)+matica_h/2])
        cylinder(d=matica_d*2/sqrt(3),h=matica_h+0.001,$fn=6,center=true);
    }
  }
}


if(0)
{

}