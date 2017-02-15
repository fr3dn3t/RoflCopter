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
  kalmanX = new float[table.getRowCount()];
  kalmanY = new float[table.getRowCount()];
  rpm = new int[table.getRowCount()];
  
  for (int i = 0; i < numberOfData; i++) { // center all variables
    kalmanX[i] = height/2;
    kalmanY[i] = height/2;
  }

  
  
  rectColor = red;

  rectX = 0;
  rectY = 0;
  ellipseMode(CENTER);
  
  drawGraph(); // Draw graph at startup
}

boolean run = true;
void draw() {  
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
  if(run) {
   for(int i = 0; i<numberOfData;i++) {
    readTable();
   }
   run=false;
  }
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

void readTable() {
  for (TableRow row : table.rows()) {
    angleX = row.getFloat(0);
    angleY = row.getFloat(1);
    println(angleX + "-" + angleY);
    drawGraph();
  }
  
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