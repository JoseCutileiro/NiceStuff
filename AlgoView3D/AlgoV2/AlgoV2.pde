import peasy.*;

// CONSTANTES
final int NUM_BARRAS = 10;

int y_inicial = 0;
PeasyCam cam;

ArrayList<Barra> barras = new ArrayList<Barra>();

void genericBox(float x, float y, float z,float size) {
  translate(x,y,z);
  box(10,size,10);
  translate(-x,-y,-z);
}

class Barra {
  float valor,x,y;
  
  Barra () {
    valor = random(1,100);
    y = y_inicial;
    y_inicial += 10;
  }
  
  void update() {
    genericBox(x,30,y,valor);
  }
  
}

void setup() {
  size(600,600,P3D);
  cam = new PeasyCam(this,500);
  
  for (int i = 0; i < NUM_BARRAS; i++) {
    Barra new_barra = new Barra();
    barras.add(new_barra);
  }
  
}



void draw() {
  background(0);
  for (Barra b : barras) {
    b.update();
  }
}
