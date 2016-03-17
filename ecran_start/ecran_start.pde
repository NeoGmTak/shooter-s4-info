PImage ecran;
PFont titre,police;
int ecranwidth,ecranheight,start;

void setup() {
  size(1024,708);
  ecran = loadImage("start.jpg");
  ecran.resize(1024,708);
  police = loadFont("Bit-Darling10-sRB-48.vlw");
  textFont(police,20);


}

void draw(){
  image(ecran, 0, 0);
  textAlign(CENTER);
  text("Jeu MMI S4 Info",520,560);
  text("Pour commencer appuyez sur le boutton !",520,600);
  
  
 
  
}