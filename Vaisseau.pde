class Vaisseau {
  int x;
  int y;
  
 Vaisseau (int nouvX, int nouvY) {
  
  x=nouvX;
  y=nouvY;
  }
  
  void afficher() {
    image(vaisseau, x, y);
    fill(0, 0, 0, 0);
    rect(x, y, largeur_vaisseau, hauteur_vaisseau);
  }
  
  void bouge() {
    
    x = x + xvalue;
    y = y + yvalue;
  }
  // test la collision du vaisseau avec un asteroid
  boolean testCollision(float posX, float posY)
  {
      posX += 50;
      posY += 50;
      float distanceCercleX = abs(posX - x - largeur_vaisseau/2);
      float distanceCercleY = abs(posY - y - hauteur_vaisseau/2);
   
      if (distanceCercleX > (largeur_vaisseau/2 + 50)) { 
        return false; 
      }
      if (distanceCercleY > (hauteur_vaisseau/2 + 50)) { 
        return false; 
      }
   
      if (distanceCercleX <= (largeur_vaisseau/2)) { 
        return true; 
      }
      if (distanceCercleY <= (hauteur_vaisseau/2)) { 
        return true; 
      }
   
      float distanceCoin = pow(posX - largeur_vaisseau/2, 2) + pow(posY/2, 2);
   
      return (distanceCoin <= pow(50,2));
  }
  // force le vaisseau a rester su l'écran
  void testEcran() {
    
    if(x < 0 || x > width-largeur_vaisseau) {
      x= x-xvalue;
    }
    if(y < 0 || y > height-hauteur_vaisseau) { 
      y= y-yvalue;
    }
  }
}