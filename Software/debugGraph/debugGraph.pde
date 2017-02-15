String stringKalmanX, stringKalmanY;

final int width = 1280;
final int height = 800;

float[] kalmanX;
float[] kalmanY;
int[] rpm;

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
  println(table.getRowCount() + " total rows in table"); 

  numberOfData = table.getRowCount();
  println(numberOfData);
  delay(2000);
  kalmanX = new float[numberOfData];
  kalmanY = new float[numberOfData];
  rpm = new int[numberOfData];
  
  for (int i = 0; i < numberOfData; i++) { // center all variables
    kalmanX[i] = height/2;
    kalmanY[i] = height/2;
  }

  ellipseMode(CENTER);
  
  drawGraph(); // Draw graph at startup
}

boolean run = true;
void draw() {  
  if(run) {
   readTable();
   run=false;
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
  delay(100);
}

void drawGraph() {
  background(255); // White
  for (int i = 0; i < width; i++) {
    stroke(200); // Grey
    line(i*10, 0, i*10, height);
    line(0, i*10, width, i*10);
  }

  stroke(0); // Black
  for (int i = 2; i <= 3; i++)
    line(0, height/4*i, width, height/4*i); // Draw line, indicating -90 deg, 0 deg and 90 deg
  
  if(run) {
    convert();
    //translate(width/2, height/1.5, 0);
    drawAxisX(true);
    drawAxisY(true);
  }
  else {
    drawAxisX(false);
    drawAxisY(false);
  }
  
}

void readTable() {
  for (TableRow row : table.rows()) {
    angleX = row.getFloat(0);
    stringKalmanX = row.getString(0);
    angleY = row.getFloat(1);
    stringKalmanY = row.getString(1);
    println(angleX + "-" + angleY);
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