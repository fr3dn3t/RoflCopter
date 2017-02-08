/* Copyright (C) 2014 Kristian Lauszus, TKJ Electronics. All rights reserved.
 This software may be distributed and modified under the terms of the GNU
 General Public License version 2 (GPL2) as published by the Free Software
 Foundation and appearing in the file GPL2.TXT included in the packaging of
 this file. Please note that GPL2 Section 2[b] requires that all works based
 on this software must also be made publicly available under the terms of
 the GPL2 ("Copyleft").
 Contact information
 -------------------
 Kristian Lauszus, TKJ Electronics
 Web      :  http://www.tkjelectronics.com
 e-mail   :  kristianl@tkjelectronics.com
 */

#include <Wire.h>
#include "Kalman.h" // Source: https://github.com/TKJElectronics/KalmanFilter

#define RESTRICT_PITCH // Comment out to restrict roll to ±90deg instead - please read: http://www.freescale.com/files/sensors/doc/app_note/AN3461.pdf

Kalman kalmanX, kalmanY; // Create the Kalman instances

const uint8_t MPU6050 = 0x68; // If AD0 is logic low on the PCB the address is 0x68, otherwise set this to 0x69

/* IMU Data */
int accX, accY, accZ;
int gyroX, gyroY;
int16_t tempRaw;

int roll, pitch; // Roll and pitch are calculated using the accelerometer while yaw is calculated using the magnetometer

double gyroXangle, gyroYangle; // Angle calculate using the gyro only
double compAngleX, compAngleY; // Calculated angle using a complementary filter
double kalAngleX, kalAngleY; // Calculated angle using a Kalman filter

uint32_t timer;
uint8_t i2cData[14]; // Buffer for I2C data

//Mittlaufende Mittel
  //kal
  int kalAngleBufferSize = 10;
  double kalBufferX[10];
  double kalBufferY[10];
  int kalBufferCounter = 0;
  double kalAngleXBuffered, kalAngleYBuffered;

  //comp
  int compAngleBufferSize = 4;
  double compBufferX[4] = {0,0,0,0};
  double compBufferY[4] = {0,0,0,0};
  int compBufferCounter = 0;
  double compAngleXBuffered, compAngleYBuffered;

  //final
  int finalAngleBufferSize = 20;
  double finalBufferX[20];
  double finalBufferY[20];
  int finalBufferCounter = 0;
  double finalX, finalY;

  int i;
  int microtimer;

void setup() {
  delay(100); // Wait for sensors to get ready

  Serial.begin(115200);
  Wire.begin();
  delay(2000);
  Serial.write("test");
  TWBR = ((F_CPU / 400000L) - 16) / 2; // Set I2C frequency to 400kHz

  i2cData[0] = 7; // Set the sample rate to 1000Hz - 8kHz/(7+1) = 1000Hz
  i2cData[1] = 0x00; // Disable FSYNC and set 260 Hz Acc filtering, 256 Hz Gyro filtering, 8 KHz sampling
  i2cData[2] = 0x00; // Set Gyro Full Scale Range to ±250deg/s
  i2cData[3] = 0x00; // Set Accelerometer Full Scale Range to ±2g
  while (i2cWrite(MPU6050, 0x19, i2cData, 4, false)); // Write to all four registers at once
  while (i2cWrite(MPU6050, 0x6B, 0x01, true)); // PLL with X axis gyroscope reference and disable sleep mode

  while (i2cRead(MPU6050, 0x75, i2cData, 1));
  if (i2cData[0] != 0x68) { // Read "WHO_AM_I" register
    Serial.print(F("Error reading sensor"));
    while (1);
  }

  delay(100); // Wait for sensors to stabilize

  /* Set Kalman and gyro starting angle */
  updateMPU6050();
  updatePitchRoll();

  kalmanX.setAngle(roll); // First set roll starting angle
  gyroXangle = roll;
  compAngleX = roll;

  kalmanY.setAngle(pitch); // Then pitch
  gyroYangle = pitch;
  compAngleY = pitch;

  timer = micros(); // Initialize the timer
}

void loop() {
  microtimer=micros();
  /* Update all the IMU values */
  updateMPU6050();

  double dt = (double)(micros() - timer) / 1000000; // Calculate delta time
  timer = micros();


  /* Roll and pitch estimation */
  updatePitchRoll();
  double gyroXrate = gyroX / 131.0; // Convert to deg/s
  double gyroYrate = gyroY / 131.0; // Convert to deg/s


  // This fixes the transition problem when the accelerometer angle jumps between -180 and 180 degrees
  if ((roll < -90 && kalAngleX > 90) || (roll > 90 && kalAngleX < -90)) {
    kalmanX.setAngle(roll);
    compAngleX = roll;
    kalAngleX = roll;
    gyroXangle = roll;
  } else
    kalAngleX = kalmanX.getAngle(roll, gyroXrate, dt); // Calculate the angle using a Kalman filter

  if (abs(kalAngleX) > 90)
    gyroYrate = -gyroYrate; // Invert rate, so it fits the restricted accelerometer reading
  kalAngleY = kalmanY.getAngle(pitch, gyroYrate, dt);
  

  /* Estimate angles using gyro only */
  gyroXangle += gyroXrate * dt; // Calculate gyro angle without any filter
  gyroYangle += gyroYrate * dt;
  //gyroXangle += kalmanX.getRate() * dt; // Calculate gyro angle using the unbiased rate from the Kalman filter
  //gyroYangle += kalmanY.getRate() * dt;

  /* Estimate angles using complimentary filter */
  compAngleX = 0.93 * (compAngleX + gyroXrate * dt) + 0.07 * roll; // Calculate the angle using a Complimentary filter
  compAngleY = 0.93 * (compAngleY + gyroYrate * dt) + 0.07 * pitch;

  // Reset the gyro angles when they has drifted too much
  if (gyroXangle < -180 || gyroXangle > 180)
    gyroXangle = kalAngleX;
  if (gyroYangle < -180 || gyroYangle > 180)
    gyroYangle = kalAngleY;


  //Mittlaufendes Mittel
  //KalX
  kalBufferX[kalBufferCounter] = round(kalAngleX);
  kalAngleXBuffered = 0;
  for(i=0; i<kalAngleBufferSize; i++) {
    kalAngleXBuffered = kalAngleXBuffered+kalBufferX[i]; 
  }
  kalAngleXBuffered = kalAngleXBuffered/kalAngleBufferSize;

  //KalY
  kalBufferY[kalBufferCounter] = round(kalAngleY);
  kalAngleYBuffered = 0;
  for(i=0; i<kalAngleBufferSize; i++) {
    kalAngleYBuffered = kalAngleYBuffered+kalBufferY[i]; 
  }
  kalAngleYBuffered = kalAngleYBuffered/kalAngleBufferSize;

  kalBufferCounter++;
  if(kalBufferCounter > kalAngleBufferSize-1) kalBufferCounter=0;

  //CompX
  compBufferX[compBufferCounter] = round(compAngleX);
  compAngleXBuffered = 0;
  for(i=0; i<compAngleBufferSize; i++) {
    compAngleXBuffered = compAngleXBuffered+compBufferX[i]; 
  }
  compAngleXBuffered = compAngleXBuffered/compAngleBufferSize;

  //CompY
  compBufferY[compBufferCounter] = round(compAngleY);
  compAngleYBuffered = 0;
  for(i=0; i<compAngleBufferSize; i++) {
    compAngleYBuffered = compAngleYBuffered+compBufferY[i]; 
  }
  compAngleYBuffered = compAngleYBuffered/compAngleBufferSize;

  compBufferCounter++;
  if(compBufferCounter > compAngleBufferSize-1) compBufferCounter=0;

  //Calculate final values
  finalBufferX[finalBufferCounter] = ((kalAngleXBuffered*1.1+compAngleXBuffered)/4);
  finalX = 0;
  for(i=0; i<finalAngleBufferSize; i++) {
    finalX = round(finalX+finalBufferX[i]); 
  }
  finalX = finalX/finalAngleBufferSize;

  //finalY
  finalBufferY[finalBufferCounter] = ((kalAngleYBuffered*1.1+compAngleYBuffered)/4);
  finalY = 0;
  for(i=0; i<finalAngleBufferSize; i++) {
    finalY = finalY+finalBufferY[i]; 
  }
  finalY = finalY/finalAngleBufferSize;

  finalBufferCounter++;
  if(finalBufferCounter > finalAngleBufferSize-1) finalBufferCounter=0;
  //Print Data 


  Serial.print(round(finalX)); Serial.print("\t");
  Serial.print(round(finalY)); Serial.print("\t");
  /*
  Serial.print(kalAngleX); Serial.print("\t");
  Serial.print(kalAngleY); Serial.print("\t");  

  Serial.print(compAngleX); Serial.print("\t");
  Serial.print(compAngleY); Serial.print("\t");
  */
  //Serial.print(micros()-microtimer); Serial.print("\t");
  Serial.println();

}

void updateMPU6050() {
  while (i2cRead(MPU6050, 0x3B, i2cData, 14)); // Get accelerometer and gyroscope values
  accX = (int16_t)((i2cData[0] << 8) | i2cData[1]);
  accY = -(int16_t)((i2cData[2] << 8) | i2cData[3]);
  accZ = (int16_t)((i2cData[4] << 8) | i2cData[5]);
  tempRaw = (i2cData[6] << 8) | i2cData[7];
  gyroX = -(int16_t)(i2cData[8] << 8) | i2cData[9];
  gyroY = (int16_t)(i2cData[10] << 8) | i2cData[11];
}


void updatePitchRoll() {
  // Source: http://www.freescale.com/files/sensors/doc/app_note/AN3461.pdf eq. 25 and eq. 26
  // atan2 outputs the value of -π to π (radians) - see http://en.wikipedia.org/wiki/Atan2
  // It is then converted from radians to degrees
#ifdef RESTRICT_PITCH // Eq. 25 and 26
  roll = atan2(accY, accZ) * RAD_TO_DEG;
  pitch = atan(-accX / sqrt(accY * accY + accZ * accZ)) * RAD_TO_DEG;
#else // Eq. 28 and 29
  roll = atan(accY / sqrt(accX * accX + accZ * accZ)) * RAD_TO_DEG;
  pitch = atan2(-accX, accZ) * RAD_TO_DEG;
#endif
}


const uint16_t I2C_TIMEOUT = 1000; // Used to check for errors in I2C communication

uint8_t i2cWrite(uint8_t address, uint8_t registerAddress, uint8_t data, bool sendStop) {
  return i2cWrite(address, registerAddress, &data, 1, sendStop); // Returns 0 on success
}

uint8_t i2cWrite(uint8_t address, uint8_t registerAddress, uint8_t *data, uint8_t length, bool sendStop) {
  Wire.beginTransmission(address);
  Wire.write(registerAddress);
  Wire.write(data, length);
  uint8_t rcode = Wire.endTransmission(sendStop); // Returns 0 on success
  if (rcode) {
    Serial.print(F("i2cWrite failed: "));
    Serial.println(rcode);
  }
  return rcode; // See: http://arduino.cc/en/Reference/WireEndTransmission
}

uint8_t i2cRead(uint8_t address, uint8_t registerAddress, uint8_t *data, uint8_t nbytes) {
  uint32_t timeOutTimer;
  Wire.beginTransmission(address);
  Wire.write(registerAddress);
  uint8_t rcode = Wire.endTransmission(false); // Don't release the bus
  if (rcode) {
    Serial.print(F("i2cRead failed: "));
    Serial.println(rcode);
    return rcode; // See: http://arduino.cc/en/Reference/WireEndTransmission
  }
  Wire.requestFrom(address, nbytes, (uint8_t)true); // Send a repeated start and then release the bus after reading
  for (uint8_t i = 0; i < nbytes; i++) {
    if (Wire.available())
      data[i] = Wire.read();
    else {
      timeOutTimer = micros();
      while (((micros() - timeOutTimer) < I2C_TIMEOUT) && !Wire.available());
      if (Wire.available())
        data[i] = Wire.read();
      else {
        Serial.println(F("i2cRead timeout"));
        return 5; // This error value is not already taken by endTransmission
      }
    }
  }
  return 0; // Success
}

