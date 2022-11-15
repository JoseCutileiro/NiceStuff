import peasy.*;

PeasyCam cam;

int BLOCK_SIZE = 20;
int X_DIM = 50;
int Z_DIM = 50;
float minHeight = 1;
float maxHeight = 500;
float noise_change = 0;
float SEA_LEVEL = 300;
int DIV = BLOCK_SIZE * 10;
// Static terrain? Time effect = 0;
float TIME_EFFECT = 0.000001;
boolean STROKE_FLAG = false;

//color GREEN = #78ED73;
//color SAND = #F2F560;
//color COR_MAR = color(0,220,255,100);

// HELL
//color GREEN = #D34444;
//color SAND = #FA1008;
//color COR_MAR = color(255,24,20,170);

// VOID
color GREEN = #000000;
color SAND = #0D060C;
color COR_MAR = color(30,20,10,170);



ArrayList<Block> blocks = new ArrayList<Block>();

class Block {
  float x, y, z;
  float w, h, d;
  
  Block(float _x, float _y, float _z, float _w, float _h, float _d) {
    x = _x;
    y = _y;
    z = _z;
    w = _w; 
    h = _h;
    d = _d;
  }
  
  color getColor()  {
    if (h < maxHeight/2) return color(SAND);
    color c = color(GREEN);
    return c;
  }
  
   void update() {
     color c = getColor();
     fill(c);
     if (STROKE_FLAG) stroke(c);
    ultra_genericBox(w,h,d,x,y,z);
  }
  
  void update_h(float value) {
    h = value;
  }
  
}

void ultra_genericBox(float w, float h,float d, float x, float y, float z) {
   translate(x,y-h/2,z);
   box(w,h,d);
   translate(-x,-y+h/2,-z);
}

void setup() {
  size(600,600,P3D);
  cam = new PeasyCam(this,500);
  
  
  
  int offsetX = 0;
  for (int i = 0; i < X_DIM; i++) {
    int offsetZ = 0;
    for (int j = 0; j < Z_DIM; j++) {
      Block b1 = new Block(offsetX,0,offsetZ,BLOCK_SIZE,0,BLOCK_SIZE);
      offsetZ += BLOCK_SIZE;
      blocks.add(b1);
    }
    offsetX += BLOCK_SIZE;
  }
}

void draw() {
  background(60);
  
  ambientLight(150, 150, 150);
  directionalLight(200, 200, 200, -1, 0.75, -1);
  
  // Corrigir bug do peasy
  translate(-BLOCK_SIZE * X_DIM* 0.5,0,-BLOCK_SIZE * Z_DIM * 0.5);
  
  
  // TERRENO 
  for (Block b : blocks) {
    float noiseValue = noise(b.x/DIV,b.z/DIV,noise_change);
    float updateNoise_consistency = map(noiseValue, 0, 1, minHeight, maxHeight);
    
    b.update_h(updateNoise_consistency);
    noise_change += TIME_EFFECT;
    
    // SOFT RESET 
    if (noise_change == 32.0) {
      noise_change = 0;
    }
    b.update();
  }
   
   
  // TRATAR DO MAR
  // 1
  color mar = COR_MAR;
  fill(mar);
  if (STROKE_FLAG) stroke(mar);
  translate(BLOCK_SIZE*X_DIM*0.5,-2,BLOCK_SIZE*Z_DIM*0.5);  
  ultra_genericBox(BLOCK_SIZE*X_DIM-BLOCK_SIZE*2, SEA_LEVEL,BLOCK_SIZE*Z_DIM-BLOCK_SIZE*2, 0, 0, 0);
  translate(-BLOCK_SIZE*X_DIM*0.5,2,-BLOCK_SIZE*Z_DIM*0.5);
}
