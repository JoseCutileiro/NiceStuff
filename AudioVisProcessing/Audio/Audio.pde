// Low: 0-600 Hz; Medium1: 600-3,000 Hz; Medium2: 3,000-6,000 Hz; High: 6,000-20,000 Hz


import processing.sound.*;
SoundFile file;
FFT fft;
int bands = 512;
int my_bands = 8;
float[] spectrum = new float[bands];
float[] my_spectrum = new float[my_bands];

void setup() {
  size(512, 360);
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "intromaster.wav");
  file.play();
  
  // patch the AudioIn
  fft.input(file);
}



void draw() { 
  background(255);
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
    my_spectrum[i] = average*100;
  }
  
  
  
   for(int i = 0; i < my_bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    rect(i*10 + 40, 100, 10, my_spectrum[i]);
  }
  
  // RESET 
  for(int i = 0; i < my_bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    my_spectrum[i] = 0;
  }
}
