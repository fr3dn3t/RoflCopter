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

MPU9250 mpu(SPI_CLOCK, SS_PIN, BITS_DLPF_CFG_5HZ, BITS_DLPF_CFG_5HZ);

void setup() {
	delay(2000);
	
	Serial.begin(115200);

  
	pinMode(INT_PIN, INPUT);
	pinMode(LED, OUTPUT);
	//digitalWrite(LED, HIGH);

  SPI.setMISO(8);
  SPI.setSCK(14);
	SPI.begin();

	Serial.println("Press any key to continue");
	WAITFORINPUT();

	mpu.init(true);

	uint8_t wai = mpu.whoami();
	if (wai == 0x71){
		Serial.println("Successful connection");
	}
	else{
		Serial.print("Failed connection: ");
		Serial.println(wai, HEX);
	}

	uint8_t wai_AK8963 = mpu.AK8963_whoami();
	if (wai_AK8963 == 0x48){
		Serial.println("Successful connection to mag");
	}
	else{
		Serial.print("Failed connection to mag: ");
		Serial.println(wai_AK8963, HEX);
	}

	mpu.calib_acc();
	mpu.calib_mag();

	Serial.println("Send any char to begin main loop.");
	WAITFORINPUT();
}

void loop() {
	// various functions for reading
	mpu.read_acc();
	mpu.read_gyro();
	Serial.print(mpu.gyro_data[0]);   Serial.print('\t');
	Serial.print(mpu.gyro_data[1]);   Serial.print('\t');
	Serial.print(mpu.gyro_data[2]);   Serial.print('\t');Serial.print('\t');
	Serial.print(mpu.accel_data[0]);  Serial.print('\t');
	Serial.print(mpu.accel_data[1]);  Serial.print('\t');
	Serial.print(mpu.accel_data[2]);  Serial.print('\t');
	Serial.println(mpu.temperature);

	delay(10);
}
