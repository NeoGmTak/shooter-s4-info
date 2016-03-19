class Ennemi {
  float x = 50 + (int)(Math.random()*(1024-50)); ;
  float y = -50;
  int r = 50;
  float speed =  0.5 + (float)Math.random() * (1.5 - 0.5);
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
  boolean testCollision(float posX,float posY) {
    if(dist(x, y, posX, posY) < r) {
      return true;
    } else {
      return false;
    }
  }
}