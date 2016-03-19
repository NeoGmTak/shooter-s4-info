class Laser {
    int x;
    int y;
    int speed = 10;
    Laser () {
      
    }
    void afficher() {
      image(tir_laser, x+30, y-20); // on place le laser au centre du vaisseau pour donner l'illusion que les tirs viennent du vaisseau
    }
    void update(){
      this.y -= this.speed;
    }
  
  
}