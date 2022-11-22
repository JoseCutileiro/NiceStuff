float angle = 0;

PVector[] points  = new PVector[4];

float[][] projection = {
  {1,0,0},
  {0,1,0}
}; 

void setup() {
  size(600, 400);
  
  points[0] = new PVector(-50,-50,0);
  points[1] = new PVector(-50,50,0);
  points[2] = new PVector(50,-50,0);
  points[3] = new PVector(50,50,0);
  
}

void draw() {
  background(0);
  translate(width/2, height/2);
  stroke(255);
  strokeWeight(4);
  noFill();
  
  
  float[][] rotation = {
    {cos(angle),-sin(angle),0},
    {sin(angle),cos(angle),0}
  };
  
  for (PVector v : points) {
    
      float ror_x = x * rotation[0][0] + y * rotation[0][1];
      float ror_y = x * rotation[1][0] + y * rotation[1][1];
    
      float x = v.x * projection[0][0] + v.y * projection[0][1] + v.z * projection[0][2];
      float y = v.x * projection[1][0] + v.y * projection[1][1] + v.z * projection[1][2];
      

      
      
      line(ror_x,ror_y,x,y);
      point(ror_x,ror_y);
  }
  
  angle += 0.01;
  //projection[1][1] -= 0.01;
  
}
