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


#include "kayman.h" // Source: https://github.com/TKJElectronics/KalmanFilter
#include <SPI.h>
#include <MPU9250.h>

#define RESTRICT_PITCH // Comment out to restrict roll to ±90deg instead - please read: http://www.freescale.com/files/sensors/doc/app_note/AN3461.pdf

#define SPI_CLOCK 8000000  // 19MHz clock works.

#define SS_PIN   10 
#define INT_PIN  3
#define LED      13

MPU9250 mpu(SPI_CLOCK, SS_PIN);

Kalman kalmanX, kalmanY; // Create the Kalman instances

/* IMU Data */
int accX, accY, accZ;
int gyroX, gyroY;
int16_t tempRaw;

int roll, pitch; // Roll and pitch are calculated using the accelerometer while yaw is calculated using the magnetometer

double gyroXangle, gyroYangle; // Angle calculate using the gyro only
double compAngleX, compAngleY; // Calculated angle using a complementary filter
double kalAngleX, kalAngleY; // Calculated angle using a Kalman filter

uint32_t timer;

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
  pinMode(INT_PIN, INPUT);
  pinMode(LED, OUTPUT);
  //digitalWrite(LED, HIGH);

  SPI.begin();

  mpu.init(true);
  mpu.set_gyro_scale(BITS_FS_2000DPS);
  mpu.set_acc_scale(BITS_FS_16G);
  
  uint8_t wai = mpu.whoami();
  if (wai == 0x71){
    Serial.println("Successful connection");
  }
  
  mpu.calib_acc();

  delay(100); // Wait for sensors to stabilize

  /* Set Kalman and gyro starting angle */
  updateMPU9250();
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
  updateMPU9250();

  double dt = (double)(micros() - timer) / 1000000; // Calculate delta time
  timer = micros();


  /* Roll and pitch estimation */
  updatePitchRoll();
  double gyroXrate = gyroX / 131.0; // Convert to deg/setAngle
  double gyroYrate = gyroY / 131.0; // Convert to deg/s
//Serial.println(gyroYrate);

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
delay(10);
}

void updateMPU9250() {
  mpu.read_all(); 
  gyroX = -(int16_t)mpu.gyro_data[0];
  gyroY = (int16_t)mpu.gyro_data[1];
  accX = (int16_t)mpu.accel_data[0];
  accY = -(int16_t)mpu.accel_data[1];
  accZ = (int16_t)mpu.accel_data[2];
  tempRaw = mpu.temperature;
  //Serial.println(accZ);
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
