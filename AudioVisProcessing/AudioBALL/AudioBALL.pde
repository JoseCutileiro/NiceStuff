// Low: 0-600 Hz; Medium1: 600-3,000 Hz; Medium2: 3,000-6,000 Hz; High: 6,000-20,000 Hz


// EVERY LOOP INTERACTION CREATED
// 1) RECTANGLES
 //for(int i = 0; i < my_bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  //rect(i*10-40, 0, 10, my_spectrum[i]);
//}
// 2) RECTANGLES (3d)
 //for(int i = 0; i < my_bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  //ultra_genericBox(10, my_spectrum[i], 10, i*10-40,0, 0);
//}
// 3) COLORIDOS
    //fill(cor[i]);
   //ultra_genericBox(10, my_spectrum[i], 10, i*10-40,0, 0);

import peasy.*;
import processing.sound.*;

SoundFile file;
FFT fft;
int bands = 512;
int my_bands = 8;
float[] spectrum = new float[bands];
float[] my_spectrum = new float[my_bands];
PeasyCam cam;
float time = 0;
int CONST = 2000;

int[]  cor = {#FFD372,#400D51,#D800A6,#FF7777,#8758FF,#E80F88,#FFFFFF,#31E1F7};

float[] cords_x = new float[CONST];
float[] cords_y = new float[CONST];
float[] cords_z = new float[CONST];


void genericBox(float size, float x, float y, float z) {
   translate(x,y,z);
   box(size);
   translate(-x,-y,-z);
}

void ultra_genericBox(float w, float h,float d, float x, float y, float z) {
   translate(x,y,z);
   box(w,h,d);
   translate(-x,-y,-z);
}

void genericSphere(float size, float x, float y, float z) {
   translate(x,y,z);
   sphere(size);
   translate(-x,-y,-z);
}



void setup() {
  
  size(1536, 980,P3D);
  background(0);
  //delay(5000);
  cam = new PeasyCam(this,500);
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "m1.mp3");
  file.play();
  
  // patch the AudioIn
  fft.input(file);
  
  for (int i = 0; i < CONST; i++) {
    cords_x[i] = random(-500,500);
    cords_z[i] = random(-500,500);
    //cords_y[i] = random(-500,500);
    
    float val = 250000 - cords_x[i]*cords_x[i] - cords_z[i]*cords_z[i];
    if (val < 0) {
      cords_y[i] = -100000;
      continue;
    }
    cords_y[i] = sqrt(val);
  }
}



void draw() { 
  background(0);
  fft.analyze(spectrum);

  int count = 0;
  for (int i = 0; i < my_bands; i++) {
    float average = 0;
    int sampleCount = (int)pow(2,i) * 2;
    
    if (i == my_bands -1) {
      sampleCount += 2;
    }
    
    for (int j = 0; j < sampleCount; j++) {
      average += spectrum[count] * (count + 1);
      count++;
    }
    average/= count;
    my_spectrum[i] += average*40;
  }
  
  
  stroke(255);
   for(int i = 0; i < my_bands; i++){
    fill(cor[i]);
    for (int j = 0; j < 250; j++) {
      genericBox(my_spectrum[i]/(125-j)*0.6,cords_x[j*i+j],cords_y[j*i+j],cords_z[j*i+j]);
      genericBox(my_spectrum[i]/(125-j)*0.6,cords_x[j*i+j],-cords_y[j*i+j],cords_z[j*i+j]);
      
      float per = 0.5;
      
      genericBox(my_spectrum[i]/(125-j)*0.3,cords_x[j*i+j]*per,cords_y[j*i+j]*per,cords_z[j*i+j]*per);
      genericBox(my_spectrum[i]/(125-j)*0.3,cords_x[j*i+j]*per,-cords_y[j*i+j]*per,cords_z[j*i+j]*per);
      
    }
  }
  
  // RESET 
  for(int i = 0; i < my_bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    my_spectrum[i] /= 1.5;
  }
  time += 0.01;
}
