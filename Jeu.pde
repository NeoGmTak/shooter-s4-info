import processing.net.*;
import processing.serial.*;

//int LargeRes;
int xvalue=0;
int yvalue=0;
int fire=0;
int largeur_vaisseau = 70;
int hauteur_vaisseau = 70;
PImage vaisseau;
PImage tir_laser;
Serial port;

Balle maballe = new Balle(100,100);
int nbLaser = 5;
Laser[] laser = new Laser[nbLaser];
int laserIndex = 0;

void setup() {
  vaisseau = loadImage("vaisseau.png");
  tir_laser = loadImage("laser.png");
  vaisseau.resize(hauteur_vaisseau, largeur_vaisseau);
  size(1024,708);
  background(130,130,130);
  println(Serial.list());   //Affiche dans la console la liste des ports série disponibles
  port = new Serial(this, "COM3", 9600); // !!!!!!!!! A CHANGER   !!!!!!!!!!!!!
  port.bufferUntil('\n'); //Attendre arrivée d'un saut de ligne pour générer évène
  fill(0, 0, 0);
  for (int i = 0; i < nbLaser; i++){
    laser[i] = new Laser();
    laser[i].x = -1000;
    laser[i].y = -1000;
  }
}

void draw() {
  fill(130,130,130);
  rect(0,0,width,height);
  noStroke();
  maballe.bouge();
  maballe.testEcran();
  maballe.afficher();
  if(fire == 1){
      shoot();
  }
  for (int i = 0; i < nbLaser; i += 1){
    laser[i].update();
  }
}
void shoot(){
    laser[laserIndex].x = maballe.x;
    laser[laserIndex].y = maballe.y;
    laser[laserIndex].speed = 10;
    laserIndex += 1;
    for (int i = 0; i < nbLaser; i += 1){
      laser[i].afficher();
    }  
    if (laserIndex >= nbLaser)
    {
      laserIndex = 0;
    }
}
void serialEvent(Serial port) {

    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);

    int values[] = int(split(serialStr, ','));

    if( values.length == 5 ) {
        xvalue =calculate( values[0], 333 );
        yvalue = calculate( values[1], 344 );
        fire = values[4];
    }
}

int calculate(int currentValue,int baseValue){
 int diff=currentValue-baseValue;
 int retourner=round(diff/4);
 return retourner;
}