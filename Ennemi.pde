class Ennemi {
  int x = 50 + (int)(Math.random()*(1024-50)); ;
  int y = 50;
  int r = 50;
  int speed = 1;
  Ennemi(){
  
  }
  void afficher() {
    image(asteroid, x, y);
    ellipse(x, y, r*2, r*2);
    fill(0, 0, 0, 0);
  }
  void update(){
    this.y += this.speed;
  }
  void testCollision(int posX,int posY) {
    if(dist(x, y, posX, posY) < r) {
        ennemi.remove(this);
    } 

  }
}