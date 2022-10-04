import peasy.*;

int y_inicial = 0;
PeasyCam cam;
Barra teste = new Barra();

void genericBox(float x, float y, float z,float size) {
  translate(x,y,z);
  box(10,size,10);
  translate(-x,-y,-z);
}

class Barra {
  float valor,x,y;
  
  Barra () {
    valor = random(0,100);
    y = y_inicial;
    y_inicial += 10;
  }
  
  void update() {
    genericBox(x,y,30,valor);
  }
  
}

void setup() {
  size(600,600,P3D);
  cam = new PeasyCam(this,500);
}

void draw() {
  background(0);
  teste.update();
}
