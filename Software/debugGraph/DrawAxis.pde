void drawAxisX(boolean back) {

  /* Draw kalman filter x-axis */
  noFill();
  stroke(255, 0, 0);// Red
  // Redraw everything
  beginShape();
  vertex(0, kalmanX[0]);
  for (int i = 1; i < kalmanX.length; i++) {
    if ((kalmanX[i] < height/4 && kalmanX[i - 1] > height/4*3) || (kalmanX[i] > height/4*3 && kalmanX[i - 1] < height/4)) {
      endShape();
      beginShape();
    }
    vertex((i)*(width/(kalmanX.length-2)), kalmanX[i]);
  }
  endShape();
  if(back) {
    // Put all data one array back
    for (int i = 1; i < kalmanX.length; i++)
      kalmanX[i-1] = kalmanX[i];
  }
}

void drawAxisY(boolean back) {

  /* Draw kalman filter y-axis */
  noFill();
  stroke(0, 0, 0); // Black
  // Redraw everything
  beginShape();
  vertex(0, kalmanY[0]);
  for (int i = 1; i < kalmanY.length; i++) {
    if ((kalmanY[i] < height/4 && kalmanY[i - 1] > height/4*3) || (kalmanY[i] > height/4*3 && kalmanY[i - 1] < height/4)) {
      endShape();
      beginShape();
    }
    vertex((i)*(width/(kalmanY.length-2)), kalmanY[i]);
  }
  endShape();
  if(back) {
    // Put all data one array back
    for (int i = 1; i<kalmanY.length;i++)
      kalmanY[i-1] = kalmanY[i];
  }
}