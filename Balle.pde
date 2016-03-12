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
  rect(x, y, largeur_vaisseau, hauteur_vaisseau);
  /*fill(couleur);
  ellipse(x,y,rb,rb);*/
}

void bouge() {
  
  x = x + xvalue;
  y = y + yvalue;
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