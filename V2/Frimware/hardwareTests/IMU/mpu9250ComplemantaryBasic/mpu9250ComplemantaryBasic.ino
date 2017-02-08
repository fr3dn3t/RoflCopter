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

#define SS_PIN   3
#define INT_PIN  2
#define LED      13

MPU9250 mpu(SPI_CLOCK, SS_PIN);


/* IMU Data */
int accX, accY, accZ;
int gyroX, gyroY;
int16_t tempRaw;

int roll, pitch; // Roll and pitch are calculated using the accelerometer while yaw is calculated using the magnetometer

double gyroXangle, gyroYangle; // Angle calculate using the gyro only
double compAngleX, compAngleY; // Calculated angle using a complementary filter

uint32_t timer;

  int microtimer;

void setup() {
  delay(100); // Wait for sensors to get ready

  Serial.begin(115200);
  pinMode(INT_PIN, INPUT);
  pinMode(LED, OUTPUT);
  //digitalWrite(LED, HIGH);

  SPI.setMISO(8);
  SPI.setSCK(14);
  SPI.begin();

  mpu.init(true);
    uint8_t wai = mpu.whoami();
  if (wai == 0x71){
    Serial.println("Successful connection");
  }
  
  mpu.calib_acc();

  delay(100); // Wait for sensors to stabilize

  /* Set Kalman and gyro starting angle */
  updateMPU9250();
  updatePitchRoll();
  
  compAngleX = roll;

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
  if ((roll < -90) || (roll > 90)) {
    compAngleX = roll;
    gyroXangle = roll;
  }
  /* Estimate angles using gyro only */
  gyroXangle += gyroXrate * dt; // Calculate gyro angle without any filter
  gyroYangle += gyroYrate * dt;
  //gyroXangle += kalmanX.getRate() * dt; // Calculate gyro angle using the unbiased rate from the Kalman filter
  //gyroYangle += kalmanY.getRate() * dt;

  /* Estimate angles using complimentary filter */
  compAngleX = 0.93 * (compAngleX + gyroXrate * dt) + 0.07 * roll; // Calculate the angle using a Complimentary filter
  compAngleY = 0.93 * (compAngleY + gyroYrate * dt) + 0.07 * pitch;

  Serial.print(round(compAngleX)); Serial.print("\t");
  Serial.print(round(compAngleY)); Serial.print("\t");

  Serial.println();
delay(100);
}

void updateMPU9250() {
  mpu.read_all(); 
  gyroX = (int16_t)mpu.gyro_data[0];
  gyroY = (int16_t)mpu.gyro_data[1];
  accX = (int16_t)mpu.accel_data[0];
  accY =(int16_t)mpu.accel_data[1];
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
