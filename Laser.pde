class Laser {
    int x;
    int y;
    int speed = 10;
    Laser () {
      
    }
    void afficher() {
      image(tir_laser, x+33, y);
    }
    void update(){
      this.y -= this.speed;
    }
  
  
}