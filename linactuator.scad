gore=1; // napravi gornji dio
dolje=0; // napravi donji dio
presjek=0; // vizualiziraj unutrasnjost
plocice=0;

podizac_xy=17;

sarafi_xy=11;
sarafi_navoj_d=2.3; // rupa za navoj sarafa
sarafi_navoj_h=15; // gornja dubina rupe
sarafi_prolaz_d=2.5; // poklopac
sarafi_plocice_d=2.1;
// sarafi_h=10; // dubina rupe za saraf
sarafi_navoj_d_dolje=1.8; // dolje za mali saraf
sarafi_navoj_h_dolje=15; // donja dubina rupe

krug_d=10;
krug_h=2;

rez_h=4; // dužina odrezanog dijela
rez_d=0.1; // veličina samog reza

matica_d=6.5;  // šitina 6-kutne rupe da matica lagano prođe. Matica je široka 6.0 mm
ulaz_matica_h=0.6; // dubina proširenog ulaza za maticu
ulaz_matica_d=matica_d+2*ulaz_matica_h; // veličina proširenog ulaza
//matica_h=22.4; // dubina rupe za 2 matice i feder (1 matica je dugačka 8.1 mm, neopterećen feder je 8 mm)
matica_h=2*8+17-4; // feder 17 mm
podizac_h=matica_h+7.6;
sipka_d=4.5; // rupa za navojnu šipku, dosta lufta
prijelaz_h=matica_d-sipka_d; // visina konusnog 6-kutnog prijelaza od matice prema rupi za šipku da ne padnu slojevi

if(gore > 0.5 || dolje > 0.5)
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
          // navoj sarafa (gore)
          translate([sarafi_xy/2,sarafi_xy/2,podizac_h/2-sarafi_navoj_h/2])
            cylinder(d=sarafi_navoj_d,h=sarafi_navoj_h+0.001,$fn=50,center=true);
          // navoj sarafa (dolje)
          translate([sarafi_xy/2,sarafi_xy/2,-podizac_h/2+sarafi_navoj_h_dolje/2])
            cylinder(d=sarafi_navoj_d_dolje,h=sarafi_navoj_h_dolje+0.001,$fn=50,center=true);
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
          cube([podizac_xy+0.001,podizac_xy+0.001,rez_h+0.001],center=true);
      }

      // skorz uklonit gornji dio
      if( gore == 0 )
      {
        translate([0,0,-podizac_h/2+rez_h+(podizac_h+krug_h-rez_h)/2])
          cube([podizac_xy+0.001,podizac_xy+0.001,(podizac_h+krug_h-rez_h)+0.001],center=true);
      }

      // rupa za navojnu šipku
      cylinder(d=sipka_d,h=2*podizac_h,$fn=50,center=true);

      // 6-kutna rupa za matice
      translate([0,0,(-podizac_h/2+rez_h)+matica_h/2])
        cylinder(d=matica_d*2/sqrt(3),h=matica_h+0.001,$fn=6,center=true);

      // konusni 6-kutni prošireni ulaz za matice
      translate([0,0,(-podizac_h/2+rez_h)+ulaz_matica_h/2])
        cylinder(d1=ulaz_matica_d*2/sqrt(3),d2=matica_d*2/sqrt(3),h=ulaz_matica_h+0.001,$fn=6,center=true);

      // konusni 6-kutni prijelaz od matice prema rupi,
      // da ne padnu isprintani slojevi
      translate([0,0,(-podizac_h/2+rez_h)+matica_h+prijelaz_h/2])
        cylinder(d1=matica_d*2/sqrt(3),d2=sipka_d,h=prijelaz_h+0.001,$fn=6,center=true);
      
      // kocka za presjek radi vizualizacije unutrasnjosti
      if(presjek)
      translate([podizac_xy/2,0,0])
      cube([podizac_xy,podizac_xy+0.01,podizac_h*2],center=true);
    }
  }
}

module spaceri()
{
  d=[0.5,1,2];
  for(i = [0:len(d)-1])
  {
    translate([podizac_xy*1.5*(i-1),0,d[i]/2])
      difference()
      {
        cube([podizac_xy,podizac_xy,d[i]],center=true);
        // 6-kutne rupe za maticu
        cylinder(d=matica_d*2/sqrt(3),h=d[i]+0.001,$fn=6,center=true);
      // sarafi kroz sve
        for(j=[0:3])
          rotate([0,0,90*j])
          {
          translate([sarafi_xy/2,sarafi_xy/2,0])
            cylinder(d=sarafi_plocice_d,h=d[i]+0.001,$fn=50,center=true);
              // 
          }
      }
  }
}

if(plocice > 0.5)
    spaceri();

