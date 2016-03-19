class Ennemi {
  float x = 50 + (int)(Math.random()*(1024-50)); // Génération d'un asteroid à un position en x aléatoire
  float y = -50;
  int r = 50;
  float speed =  3.0 + (float)Math.random() * (4.5 - 3.0); //vitesse aléatoire 
  Ennemi(){
  
  }
  void afficher() {
    image(asteroid, x, y);
    ellipse(x+r, y+r, r*2, r*2);  
    fill(0, 0, 0, 0);
  }
  void update(){
    this.y += this.speed;
  }
  // --- teste si l'asteroid est touché par un tir 
  boolean estTouche(float posX,float posY) {  
    float distanceCercleX = abs(x+25 - posX - largeur_tir/2);
    float distanceCercleY = abs(y+50 - posY - hauteur_tir/2);
 
    if (distanceCercleX > (largeur_tir/2 + r)) { 
      return false; 
    }
    if (distanceCercleY > (hauteur_tir/2 + r)) { 
      return false; 
    }
 
    if (distanceCercleX <= (largeur_tir/2)) { 
      return true; 
    }
    if (distanceCercleY <= (hauteur_tir/2)) { 
      return true; 
    }
 
    float distanceCoin = pow(x - largeur_tir/2, 2) + pow(y/2, 2);
 
    return (distanceCoin <= pow(r,2));
  }
}