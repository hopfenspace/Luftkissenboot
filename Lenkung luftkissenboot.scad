RuderPosition=37.5;
Ruderverschiebung=-10;
Ringradius=65;
Ruderlaenge=Ringradius*2-(1/25*Ringradius);     

Gesamtbreite=40;
Ringdicke=4;
    hoeheBodenplatte=8;
    pinDicke=2;
    Puzzlegroesse=16;
    RadiusBohrloch=2;
module RingUndBodenplatte(Verschiebung,Radius){
    difference(){
    difference(){
         difference(){
               difference(){
    translate([0,Verschiebung,0]){ //DER Ring+ Bodenplatte
        Ring(Radius);
        Bodenplatte(Radius,Gesamtbreite,hoeheBodenplatte);
        
          Stuetzen(Radius);
       
    };
       Haltepin(RuderPosition*Ringradius/70,(Ringradius-Ringdicke-hoeheBodenplatte)*2,pinDicke*1.1);
    };//Loch für rechtes Ruder
        Haltepin(-RuderPosition*Ringradius/70,(Ringradius-Ringdicke-hoeheBodenplatte)*2,pinDicke*1.1);
    };
        Haltepin(0,Ringradius*2,pinDicke*1.1);
     };//Loch für Mittleres Ruder
      translate([0,-Gesamtbreite-Verschiebung,-Ringradius-Ringdicke]){
    Puzzle(Puzzlegroesse);
      };
    };
}   
module Puzzle(groesse){
    rotate([90,45,0]) cylinder(groesse/1.5,groesse,groesse/4,true,$fn=4);
}
module Bodenplatte(laenge,breite,hoehe){
        translate([0,0,-(laenge+hoehe/2)]){
            difference(){
            cube([((laenge+hoehe)*2),breite,hoehe], center=true);   
            union(){
                translate([laenge+2,Gesamtbreite/2-5,0]){
                cylinder(hoeheBodenplatte+2,RadiusBohrloch,RadiusBohrloch,true,$fn=1000);        
                };
                translate([laenge+2,-Gesamtbreite/2+5,0]){
                cylinder(hoeheBodenplatte+2,RadiusBohrloch,RadiusBohrloch,true,$fn=1000);        
                };
                translate([-laenge-2,Gesamtbreite/2-5,0]){
                cylinder(hoeheBodenplatte+2,RadiusBohrloch,RadiusBohrloch,true,$fn=1000);        
                };
                translate([-laenge-2,-Gesamtbreite/2+5,0]){
                cylinder(hoeheBodenplatte+2,RadiusBohrloch,RadiusBohrloch,true,$fn=1000);        
                };
            };
             };
        }
}

module Ring(Radius){
difference() {
            rotate([90,0,0]) cylinder (h = 40, r=Radius+Ringdicke, center = true,      $fn=1000);      
            rotate ([90,0,0]) cylinder (h = 42, r=Radius, center = true,        $fn=1000);
        }
}
module Stuetzen(Radius){
  difference() {//Stütze rechts1
                translate([Radius*0.75,-20,-(Radius+hoeheBodenplatte)]){
            cube([5,10,sin(Radius*0.5)*Radius]);
                 };
                  rotate([90,0,0]) cylinder (h = 42, r=Radius, center = true,      $fn=1000               ); 
                 };
                 difference() {//Stütze rechts 2
                translate([Radius*0.75,10,-(Radius+hoeheBodenplatte)]){
            cube([5,10,sin(Radius*0.75)*Radius]);
                 };
                  rotate([90,0,0]) cylinder (h = 42, r=Radius, center = true,      $fn=1000               ); 
                 };


                 difference() {//Stütze links 1
                translate([-(Radius*0.75+10),-20,-(Radius+hoeheBodenplatte)]){
            cube([5,10,sin(Radius*0.75)*Radius]);
                 };
                  rotate([90,0,0]) cylinder (h = 42, r=Radius, center = true,      $fn=1000               ); 
                 };
                 
                 difference() {//Stütze links 2
                translate([-(Radius*0.75+10),10,-(Radius+hoeheBodenplatte)]){
            cube([5,10,sin(Radius*0.75)*Radius]);
                 };
                  rotate([90,0,0]) cylinder (h = 42, r=Radius, center = true,      $fn=1000               ); 
                 };
                
}
module Servohalterung(Position,Hoehe){
if(Position==0){
        translate([Position-2,20,-(cos(RuderPosition)*Hoehe/2-10)]){ //Servohalterung
            difference(){
                cylinder (h=2, r=2, center=true, $fn=100);
                cylinder (h=2.2, r=1, center=true, $fn=100);
            }   
        }
    
        translate([Position+2,20,-(cos(RuderPosition)*Hoehe/2-10)]){ //Servohalterung
            difference(){
                cylinder (h=2, r=2, center=true, $fn=100);
                cylinder (h=2.2, r=1, center=true, $fn=100);
            }
        }
    }
   
    if(Position>0 ){
        translate([Position-2,20,-(Hoehe/2-10)]){ //Servohalterung
            difference(){
                cylinder (h=2, r=2, center=true, $fn=100);
                cylinder (h=2.2, r=1, center=true, $fn=100);
            }
        }
    }
    if(Position<0){
        translate([Position+2,20,-(Hoehe/2-10)]){ //Servohalterung
            difference(){
                cylinder (h=2, r=2, center=true, $fn=100);
                cylinder (h=2.2, r=1, center=true, $fn=100);
            }
        }
    }
    
    translate([Position,20,0]){ 
        difference(){
            cube([6,40,Hoehe], center=true);
            translate([200.25,20,0]){
                cylinder(Hoehe+2,200,200,center=true,$fn=1000);
            }
            translate([-200.25,20,0]){
                cylinder(Hoehe+2,200,200,center=true,$fn=1000);
            }
        }
    }
}
module Haltepin(Position,Hoehe,Radius){
    translate([Position,0,(Hoehe/2)]){ //Haltepin oben
        cylinder(sin(tan(RuderPosition))*10*Ringradius+10,Radius,Radius, center= true, $fn=100);
    }
    translate([Position,0,-(Hoehe/2)]){ ////Haltepin unten
        cylinder(sin(tan(RuderPosition))*10*Ringradius+10,Radius,Radius ,center= true, $fn=100);   
    }
}
module Ruder(Position,Hoehe){
    Haltepin(Position,Hoehe,pinDicke);
    translate([Position,0,0]){// Ruderrundung
        cylinder(Hoehe,3,3, center= true, $fn=100);
    }
    
   Servohalterung(Position,Hoehe);
}
    
//Ruder(RuderPosition*Ringradius/70,cos(RuderPosition)*Ruderlaenge);  //Ruder rechts
//Ruder(-RuderPosition*Ringradius/70,cos(RuderPosition)*Ruderlaenge);  //Ruder links
//Ruder(0,Ruderlaenge);  //Ruder Mitte
RingUndBodenplatte(Ruderverschiebung,Ringradius); //Ring und Bodenplatte