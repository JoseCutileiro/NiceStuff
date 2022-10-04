import peasy.*;

// CONSTANTES
final int NUM_BARRAS = 100;
final int SIZE_BARRAS = 10;
int y_inicial = -SIZE_BARRAS*NUM_BARRAS/2;
PeasyCam cam;

ArrayList<Barra> barras = new ArrayList<Barra>();


// BUBBLE SORT
void bubbleSort()
{
    int i, j;
    for (i = 0; i < NUM_BARRAS - 1; i++) {
        for (j = 0; j < NUM_BARRAS - i - 1; j++) {
             
             Barra b1 = barras.get(j);
             Barra b2 = barras.get(j+1);
             if (b1.valor > b2.valor) {
               float temp = b1.valor;
               b1.valor = b2.valor;
               b2.valor = temp;
               return;
             }
        }
    }
    fill(#00FF00);
}

// SELECTION SORT
void selectionSort()
{
    int i, j, min_idx;
 
    // One by one move boundary of
    // unsorted subarray
    for (i = 0; i < NUM_BARRAS-1; i++)
    {
       
        // Find the minimum element in
        // unsorted array
        min_idx = i;
        for (j = i+1; j < NUM_BARRAS; j++)
        if (barras.get(j).valor < barras.get(min_idx).valor)
            min_idx = j;
 
        // Swap the found minimum element
        // with the first element
        if(min_idx!=i) {
           Barra b1 = barras.get(i);
           Barra b2 = barras.get(min_idx);
           float temp = b1.valor;
           b1.valor = b2.valor;
           b2.valor = temp;
           return;
        }
    }
    fill(#00FF00);
}

///////////////////////////////////////////////////////////
//                REAL CODE HERE                         //
///////////////////////////////////////////////////////////
void genericBox(float x, float y, float z,float size) {
  translate(x,y,z);
  box(SIZE_BARRAS,size,SIZE_BARRAS);
  translate(-x,-y,-z);
}

class Barra {
  float valor,x,y;
  
  Barra () {
    valor = random(1,1000);
    y = y_inicial;
    y_inicial += SIZE_BARRAS;
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
  //bubbleSort();
  if (int(random(0,5)) == 0) selectionSort();
}
