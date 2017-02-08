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

#define SPI_CLOCK 19000000  // 19MHz clock works.

#define SS_PIN   3
#define INT_PIN  2
#define LED      13

#define WAITFORINPUT(){            \
	while(!Serial.available()){};  \
	while(Serial.available()){     \
		Serial.read();             \
	};                             \
}                                  \

MPU9250 mpu(SPI_CLOCK, SS_PIN, BITS_DLPF_CFG_256HZ_NOLPF2, BITS_DLPF_CFG_256HZ_NOLPF2);

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
  mpu.set_gyro_scale(BITS_FS_1000DPS);
	uint8_t wai = mpu.whoami();
	if (wai == 0x71){
	}
	else{
		Serial.print("Failed connection: ");
		Serial.println(wai, HEX);
	}

}

void loop() {
	// various functions for reading
	mpu.read_gyro();
	int16_t zt = mpu.gyro_data[2]/32.8;
  if(zt < -900) {
    digitalWriteFast(LED, HIGH);
  }
	delay(10);
}
