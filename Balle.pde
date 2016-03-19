class Balle {
  int x;
  int y;
  
 Balle (int nouvX, int nouvY) {
  
  x=nouvX;
  y=nouvY;
}

void afficher() {
  image(vaisseau, x, y);
  fill(0, 0, 0, 0);
  //fill(255, 255, 255);
  rect(x, y, largeur_vaisseau, hauteur_vaisseau);
  /*fill(couleur);
  ellipse(x,y,rb,rb);*/
}

void bouge() {
  
  x = x + xvalue;
  y = y + yvalue;
}

boolean testCollision(float posX, float posY)
{
    posX += 50;
    posY += 50;
    float circleDistanceX = abs(posX - x - largeur_vaisseau/2);
    float circleDistanceY = abs(posY - y - hauteur_vaisseau/2);
 
    if (circleDistanceX > (largeur_vaisseau/2 + 50)) { return false; }
    if (circleDistanceY > (hauteur_vaisseau/2 + 50)) { return false; }
 
    if (circleDistanceX <= (largeur_vaisseau/2)) { return true; }
    if (circleDistanceY <= (hauteur_vaisseau/2)) { return true; }
 
    float cornerDistance = pow(posX - largeur_vaisseau/2, 2) + pow(posY/2, 2);
 
    return (cornerDistance <= pow(50,2));
}

void testEcran() {
  
  if(x < 0 || x > width-largeur_vaisseau) {
   
    x= x-xvalue;

}
  if(y < 0 || y > height-hauteur_vaisseau) {
   
    y= y-yvalue;


  }
}
}