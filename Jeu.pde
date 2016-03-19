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
int largeur_tir = 10;
int hauteur_tir = 20;
PImage vaisseau;
PImage tir_laser;
PImage space;
//PImage enemy;
PImage ecran;
PImage asteroid;
PImage vie;
int coeur=3;
PFont titre, police;
int ecranwidth, ecranheight, start;
Serial port;
int demarrage = 0;
int score = 0;

Vaisseau monVaisseau = new Vaisseau(100, 100);

ArrayList<Laser> laser = new ArrayList<Laser>();  //Déclaration d'un ArrayList pour pouvoir gérer plusieurs laser sur l'écran
ArrayList<Ennemi> ennemi = new ArrayList<Ennemi>();  //Déclaration d'un ArrayList pour pouvoir gérer plusieurs ennemi sur l'écran

void setup() {
    // ---- Chargement des images ----
    vaisseau = loadImage("vaisseau.png");
    tir_laser = loadImage("laser.png");
    space = loadImage("espace.jpg");
    asteroid = loadImage("asteroid.png");
    vie = loadImage("coeur.png");
    
    // ---- Redimensionnement du vaisseau du joueur et des tirs laser
    vaisseau.resize(largeur_vaisseau, hauteur_vaisseau);
    size(1024, 708);
    space.resize(1024, 708);
    //enemy.resize(40, 40);
    tir_laser.resize(largeur_tir, hauteur_tir);
    vie.resize(40, 40);
    println(Serial.list()); //Affiche dans la console la liste des ports série disponibles
    port = new Serial(this, "/COM3", 9600); // !!!! !!!!! A CHANGER   !!!!!!!!!!!!!
    port.bufferUntil('\n'); //Attendre arrivée d'un saut de ligne pour générer évène
    fill(0, 0, 0);
    ecran = loadImage("start.jpg");
    ecran.resize(1024, 708);
    police = loadFont("Bit-Darling10-sRB-48.vlw");
    textFont(police, 20);
    noStroke();
    
    // ---- Fichier son  !!! Ne marche pas en 64 bit !!!
    //file = new SoundFile(this, "Dragonforce.mp3");
    //file.play();
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
        // ---- Affichage des vies restantes 
        for(int i=0;i<coeur;i++) {
          image(vie,55*i + 20,10,40,40);
        }
        textAlign(CENTER);
        fill(255, 255, 255);
        text("Score "+score, 850, 40);
        
        // ---- frameCount renvoie la le nombre de rechargement de la méthode Draw(). On affice ici des ennemis à intervalles réguliers en utilisant modulo 
        if (frameCount % 20 == 0) {
         ennemi.add(new Ennemi());
        }
        
        monVaisseau.bouge(); // Fait bouge le vaisseau en fonction de la "manette"
        monVaisseau.testEcran(); // empêche la vaisseau de sortir de la fenêtre
        monVaisseau.afficher();
        for (int i = 0; i < ennemi.size(); i++) { // on parcours l'ArrayList pour afficher la position de chaque astéroid
          ennemi.get(i).update();   
          ennemi.get(i).afficher();
          if(monVaisseau.testCollision(ennemi.get(i).x, ennemi.get(i).y)){ //test de collision d'un astéroid avec le vaisseau 
            ennemi.remove(i); //retire l'astéroid de l'ArrayList
            coeur--;  
            if(coeur == 0){
              demarrage = 2;
            }
          } 
        }
        if (fire == 1) {
            shoot();
        }
        // --- test si un asteroid est touché par un laser, si oui l'asteroid et le laser sont enlevé de l'arraylist
        for (int j = 0; j < ennemi.size(); j++) {  
          for (int i = 0; i < laser.size(); i++) {
            if(ennemi.get(j).estTouche(laser.get(i).x, laser.get(i).y)){
              ennemi.remove(j);
              laser.remove(i);
              score += 1;
            } else if(ennemi.get(j).y > 758){ // Si l'asteroid sort de l'écran il est enlévé de l'arraylist 
              ennemi.remove(j);
            }
          }
        }
        // -- on affiche la position des laser à l'écran et si un laser sort de l'écran il est enlevé de l'arraulist pour ne pas surcharger le processeur
        for (int i = 0; i < laser.size(); i++) {
            laser.get(i).update();
            laser.get(i).afficher();
            if(laser.get(i).y < -5){
              laser.remove(i);
            }
        }
        
        
        
    } else {
      
        textAlign(CENTER);
        fill(0,0,0);
        rect(0,0,width,height);
        fill(255, 255, 255);
        textFont(police, 60);
        text("GAME OVER ", 520, 300);
        textFont(police, 30);
        text("Votre score est de ", 510, 350);
        textAlign(CENTER);
        text(score, 520, 400);
        if (fire == 1) {
            demarrage = 1;
            score = 0;
            coeur = 3;
        }
     
    }
  }
  
// Création et affichage d'un laser à la position actuelle du vaisseau lors de l'appui sur le bouton 
void shoot() {
    laser.add(new Laser());
    laser.get(laser.size()-1).x = monVaisseau.x;
    laser.get(laser.size()-1).y = monVaisseau.y;
    laser.get(laser.size()-1).afficher(); 
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