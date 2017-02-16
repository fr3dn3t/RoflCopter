String stringKalmanX, stringKalmanY, stringRPM;

final int width = 1280;
final int height = 800;

float[] kalmanX;
float[] kalmanY;
float[] rpm;

float angleX = 0.00, angleY = 0.00;

boolean drawValues  = false;

int rectX, rectY;      // Position of square button
int rectSize = 60;     // Diameter of rect
color rectColor;
color red = color(200,0,0);
color green = color(0,200,0);
boolean rectOver = false;
boolean clicked = false;

Table table;

int numberOfData;

void setup() {
  size(1280, 800, P3D);
  
  table = loadTable("debug.csv");

  numberOfData = table.getRowCount();
  println(numberOfData);

  kalmanX = new float[numberOfData];
  kalmanY = new float[numberOfData];
  rpm = new float[numberOfData];
  for (int i = 0; i < numberOfData; i++) { // center all variables
    kalmanX[i] = height/2;
    kalmanY[i] = height/2;
    rpm[i] = height/2;
  }

  ellipseMode(CENTER);
  
  drawGraph(); // Draw graph at startup
}
int currentValue = 0;
boolean run = true;
void draw() { 
  
  if(run) {
   readTable();
   run=false;
  }
  else {
    drawGraph();
  }
  
  fill(150,150,150);
  textSize(20);
  text("currentCount", 10, 30); 
  text(currentValue, 140, 30); 
  text("angleX", 10, 60); 
  text(table.getInt(currentValue+1, 2), 140, 60); 
  text("angleY", 10, 90); 
  text(table.getInt(currentValue+1, 3), 140, 90); 
  text("RPM", 10, 120); 
  text(table.getInt(currentValue+1, 1), 140, 120); 

  stroke(80, 80, 80);// Red
  line(currentValue*(width/(kalmanX.length-2)),height/2,currentValue*(width/(kalmanX.length-2)),height);
  stroke(0,0,0);
  


  
  translate(width/2, height/4, 0);
  //if(currentValue != 0) {
    rotateX(table.getInt(currentValue+1, 2));
    rotateZ(table.getInt(currentValue+1, 3));
 // }
 
  //directionalLight(204, 204, 204, width/2, height/2, 20);
  fill(100,100,100);
  stroke(0); 
  box(150, 150, 150);
  beginShape(QUADS);
  vertex(-75, -75, -75);
  vertex( 75, -75, -75);
  vertex( 75, -75,  75);
  vertex(-75, -75,  75);
  endShape(); 
  delay(100);
}

void drawGraph() {
  background(255); // White
  for (int i = 0; i < width; i++) {
    stroke(200); // Grey
    line(i*10, height/2, i*10, height);
    line(0, height/2+i*10, width, height/2+i*10);
  }

  stroke(0); // Black
  for (int i = 2; i <= 3; i++)
    line(0, height/4*i, width, height/4*i); // Draw line, indicating -90 deg, 0 deg and 90 deg
  
  if(run) {
    convert();
    //translate(width/2, height/1.5, 0);
    drawAxisX(true);
    drawAxisY(true);
    drawAxisRPM(true);
  }
  else {
    drawAxisX(false);
    drawAxisY(false);
    drawAxisRPM(false);
  }
  
}

void readTable() {
  for (TableRow row : table.rows()) {
      angleX = row.getFloat(2);
      stringKalmanX = row.getString(2);
      angleY = row.getFloat(3);
      stringKalmanY = row.getString(3);
      stringRPM = row.getString(1);
      drawGraph();
  }
  
  //drawValues = true; // Draw the graph

  //printAxis(); // Used for debugging
}

void printAxis() {
  print(stringKalmanX);

  print('\t');

  print(stringKalmanY);

  println();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      if(currentValue != 0) {
        currentValue--;
      }
    } else if (keyCode == RIGHT) {
      if(currentValue != numberOfData-2) {
        currentValue++;
      }
    } 
  } 
}