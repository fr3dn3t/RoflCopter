//convert all axis
final int minAngle = -90;
final int maxAngle = 90;

void convert() {
   /* Convert the kalman filter x-axis */
  if ((stringKalmanX != null) && (stringKalmanX != "NaN")) {
    stringKalmanX = trim(stringKalmanX); // Trim off any whitespace
    kalmanX[kalmanX.length - 1] = map(float(stringKalmanX), minAngle, maxAngle, height/2, height); // Convert to a float and map to the screen height, then save in buffer
    if(kalmanX[kalmanX.length - 1] > height)  {
      kalmanX[kalmanX.length - 1] = height;
    }
    else if(kalmanX[kalmanX.length - 1] < height/2) {
      kalmanX[kalmanX.length - 1] = height/2;
    }
  }

  /* Convert the kalman filter y-axis */
  if ((stringKalmanY != null) && (stringKalmanY != "NaN")) {
    stringKalmanY = trim(stringKalmanY); // Trim off any whitespace
    kalmanY[kalmanY.length - 1] = map(float(stringKalmanY), minAngle, maxAngle, height/2, height); // Convert to a float and map to the screen height, then save in buffer
    if(kalmanY[kalmanY.length - 1] > height)  {
      kalmanY[kalmanY.length - 1] = height;
    }
    else if(kalmanY[kalmanY.length - 1] < height/2) {
      kalmanY[kalmanY.length - 1] = height/2;
    }
  }
}