/**
 * Sample program for the MPU9250 using SPI
 *
 * Sample rate of the AK8963 magnetometer is set at 100Hz. 
 * There are only two options: 8Hz or 100Hz so I've set it at 100Hz
 * in the library. This is set by writing to the CNTL1 register
 * during initialisation.
 *
 * Copyright (C) 2015 Brian Chen
 *
 * Open source under the MIT license. See LICENSE.txt.
 */

#include <SPI.h>
#include <MPU9250.h>
#include "Kalman.h" // Source: https://github.com/TKJElectronics/KalmanFilter
#define RESTRICT_PITCH // Comment out to restrict roll to ±90deg instead - please read: http://www.freescale.com/files/sensors/doc/app_note/AN3461.pdf

#define SPI_CLOCK 19000000  // 19MHz clock works.

#define SS_PIN   3
#define INT_PIN  2
#define LED      13

#define WAITFORINPUT(){            \
	while(!Serial.available()){};  \
	while(Serial.available()){     \
		Serial.read();             \
	};                             \
}  \

Kalman kalmanX, kalmanY; // Create the Kalman instances
MPU9250 mpu(SPI_CLOCK, SS_PIN, BITS_DLPF_CFG_256HZ_NOLPF2, BITS_DLPF_CFG_256HZ_NOLPF2);

/* IMU Data */
int accX, accY, accZ;
int gyroX, gyroY;
int16_t tempRaw;

int roll, pitch; // Roll and pitch are calculated using the accelerometer while yaw is calculated using the magnetometer

double gyroXangle, gyroYangle; // Angle calculate using the gyro only
double kalAngleX, kalAngleY; // Calculated angle using a Kalman filter

uint32_t timer;

void setup() {
	delay(2000);
	
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
	}
	else{
		Serial.print("Failed connection: ");
		Serial.println(wai, HEX);
	}

	mpu.calib_acc();

/* Set Kalman and gyro starting angle */
  updateMPU9250();
  updatePitchRoll();

  kalmanX.setAngle(roll); // First set roll starting angle
  gyroXangle = roll;

  kalmanY.setAngle(pitch); // Then pitch
  gyroYangle = pitch;

  timer = micros(); // Initialize the timer
}

void loop() {
	updateMPU9250();

  double dt = (double)(micros() - timer) / 1000000; // Calculate delta time
  timer = micros();

  /* Roll and pitch estimation */
  updatePitchRoll();
  double gyroXrate = gyroX / 131.0; // Convert to deg/s
  double gyroYrate = gyroY / 131.0; // Convert to deg/s

  // This fixes the transition problem when the accelerometer angle jumps between -180 and 180 degrees
  if ((roll < -90 && kalAngleX > 90) || (roll > 90 && kalAngleX < -90)) {
    kalmanX.setAngle(roll);
    kalAngleX = roll;
    gyroXangle = roll;
  } else
    kalAngleX = kalmanX.getAngle(roll, gyroXrate, dt); // Calculate the angle using a Kalman filter

  if (abs(kalAngleX) > 90)
    gyroYrate = -gyroYrate; // Invert rate, so it fits the restricted accelerometer reading
  kalAngleY = kalmanY.getAngle(pitch, gyroYrate, dt);
  

  // Reset the gyro angles when they has drifted too much
  if (gyroXangle < -180 || gyroXangle > 180)
    gyroXangle = kalAngleX;
  if (gyroYangle < -180 || gyroYangle > 180)
    gyroYangle = kalAngleY;

  Serial.print(kalAngleX); Serial.print("\t");
  Serial.println(kalAngleY);
	delay(10);
}

void updateMPU9250() {
  mpu.read_acc();
  mpu.read_gyro();
  accX = (int16_t)mpu.accel_data[0];
  accY = -(int16_t)mpu.accel_data[1];
  accZ = (int16_t)mpu.accel_data[2];
  tempRaw = mpu.temperature;
  gyroX = -(int16_t)mpu.gyro_data[0];
  gyroY = (int16_t)mpu.gyro_data[1];
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
