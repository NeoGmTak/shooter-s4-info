import processing.net.*;
import processing.serial.*;
import processing.sound.*;
SoundFile file;

//int LargeRes;
int xvalue = 0;
int yvalue = 0;
int fire = 0;
int largeur_vaisseau = 70;
int hauteur_vaisseau = 70;
PImage vaisseau;
PImage tir_laser;
PImage space;
PImage enemy;
PImage ecran;
PImage vie;
int coeur=3;
PFont titre, police;
int ecranwidth, ecranheight, start;
Serial port;
int demarrage = 0;

Balle maballe = new Balle(100, 100);
int nbLaser = 5;
Laser[] laser = new Laser[nbLaser];
int laserIndex = 0;

void setup() {
    vaisseau = loadImage("vaisseau.png");
    tir_laser = loadImage("laser.png");
    space = loadImage("espace.jpg");
    enemy = loadImage("enemy.png");
    vie = loadImage("coeur.png");
    vaisseau.resize(hauteur_vaisseau, largeur_vaisseau);
    size(1024, 708);
    space.resize(1024, 708);
    enemy.resize(40, 40);
    tir_laser.resize(10, 20);
    vie.resize(40, 40);
    println(Serial.list()); //Affiche dans la console la liste des ports série disponibles
    port = new Serial(this, "/dev/cu.usbmodem1411", 9600); // !!!! !!!!! A CHANGER   !!!!!!!!!!!!!
    port.bufferUntil('\n'); //Attendre arrivée d'un saut de ligne pour générer évène
    fill(0, 0, 0);
    for (int i = 0; i < nbLaser; i++) {
        laser[i] = new Laser();
        laser[i].x = -1000;
        laser[i].y = -1000;
    }
    ecran = loadImage("start.jpg");
    ecran.resize(1024, 708);
    police = loadFont("Bit-Darling10-sRB-48.vlw");
    textFont(police, 20);
    file = new SoundFile(this, "Dragonforce.mp3");
        file.play();
}

void draw() {

if (demarrage == 0) {

        image(ecran, 0, 0);
        textAlign(CENTER);
        text("Jeu MMI S4 Info", 520, 560);
        text("Pour commencer appuyez sur le boutton !", 520, 600);
        fill(255, 255, 255);

        if (fire == 1) {
            demarrage = 1;
        }


    }
    else if(demarrage ==1) {
        image(space, 0, 0);
        for(int i=0;i<coeur;i++) {
        image(vie,55*i + 20,10,40,40);
        textAlign(CENTER);
        text("Score ", 850, 40);
        fill(255, 255, 255);
        }
        //fill(130,130,130);
        //rect(0,0,width,height);
        noStroke();
        maballe.bouge();
        maballe.testEcran();
        maballe.afficher();
        if (fire == 1) {
            shoot();
        }
        for (int i = 0; i < nbLaser; i += 1) {
            laser[i].update();
            laser[i].afficher();
        }
    }
    else {
      
        textAlign(CENTER);
        fill(0,0,0);
        rect(0,0,width,height);
        fill(255, 255, 255);
        textFont(police, 60);
        text("GAME OVER ", 520, 300);
        textFont(police, 30);
        text("Votre score est de", 520, 400);
      
      
    }
  }
void shoot() {
    laser[laserIndex].x = maballe.x;
    laser[laserIndex].y = maballe.y;
    laser[laserIndex].speed = 10;
    laserIndex += 1;
    for (int i = 0; i < nbLaser; i += 1) {
        laser[i].afficher();
    }
    if (laserIndex >= nbLaser) {
        laserIndex = 0;
    }
}
void serialEvent(Serial port) {

    String serialStr = port.readStringUntil('\n');
    serialStr = trim(serialStr);

    int values[] = int(split(serialStr, ','));

    if (values.length == 5) {
        xvalue = calculate(values[0], 333);
        yvalue = calculate(values[1], 344);
        fire = values[4];
    }
}

int calculate(int currentValue, int baseValue) {
    int diff = currentValue - baseValue;
    int retourner = round(diff / 4);
    return retourner;
}