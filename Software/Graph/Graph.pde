import processing.serial.*;
Serial serial;
Serial hwserial;

String stringKalmanX, stringKalmanY;

final int width = 1280;
final int height = 800;

float[] kalmanX = new float[width];
float[] kalmanY = new float[width];

float angleX = 0.00, angleY = 0.00;

boolean drawValues  = false;

int rectX, rectY;      // Position of square button
int rectSize = 60;     // Diameter of rect
color rectColor;
color red = color(200,0,0);
color green = color(0,200,0);
boolean rectOver = false;
boolean clicked = false;


void setup() {
  size(1280, 800, P3D);
  println(Serial.list()); // Use this to print connected serial devices
  serial = new Serial(this, Serial.list()[0], 115200); // Set this to your serial port obtained using the line above
  serial.bufferUntil('\n'); // Buffer until line feed
  hwserial = new Serial(this, Serial.list()[5], 9600); // Set this to your serial port obtained using the line above
  

  for (int i = 0; i < width; i++) { // center all variables
    kalmanX[i] = height/2;
    kalmanY[i] = height/2;
  }

  drawGraph(); // Draw graph at startup
  
  rectColor = red;

  rectX = 0;
  rectY = 0;
  ellipseMode(CENTER);
}

void draw() {
  
  /* Draw Graph */
  if (drawValues) {
    drawValues = false;
    drawGraph();
  }
  
  translate(width/2, height/4, 0);
  rotateX((angleX-20)/65);
  rotateZ(angleY/65);
  //directionalLight(204, 204, 204, width/2, height/2, 20);
  fill(255,255,255);
  stroke(0); 
  box(150, 150, 150);
  beginShape(QUADS);
  fill(200,200,200);
  vertex(-75, -75, -75);
  vertex( 75, -75, -75);
  vertex( 75, -75,  75);
  vertex(-75, -75,  75);
  endShape(); 
}

void drawGraph() {
  background(255); // White
  for (int i = 0; i < width; i++) {
    stroke(200); // Grey
    int o = 0;
    if( i < 6 )  {
      o = 60;
    }
    line(i*10, o, i*10, height);
    line(o, i*10, width, i*10);
  }

  update(mouseX, mouseY);
  stroke(255);
  fill(rectColor);
  rect(rectX, rectY, rectSize, rectSize);

  stroke(0); // Black
  for (int i = 2; i <= 3; i++)
    line(0, height/4*i, width, height/4*i); // Draw line, indicating -90 deg, 0 deg and 90 deg
  
  
  convert();
  //translate(width/2, height/1.5, 0);
  drawAxisX();
  drawAxisY();
}

void serialEvent (Serial serial) {
  // Get the ASCII strings:
  stringKalmanX = serial.readStringUntil('\t');
  stringKalmanY = serial.readStringUntil('\t');

  angleX = float(stringKalmanX);
  angleY = float(stringKalmanY);

  serial.clear(); // Clear buffer
  drawValues = true; // Draw the graph

  //printAxis(); // Used for debugging
}

void printAxis() {
  print(stringKalmanX);

  print('\t');

  print(stringKalmanY);

  println();
}

void update(int x, int y) {
  if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  if (rectOver) {
    if(clicked) {
      rectColor = red;
      clicked = false;
    }
    else {
      rectColor = green;
      clicked = true;
    }
    hwserial.write(65);
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}