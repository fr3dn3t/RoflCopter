#include <Servo.h>
#include <SPI.h>
#include <MPU9250.h>
#include "Kalman.h" // Source: https://github.com/TKJElectronics/KalmanFilter


//HM-11 BLE 
  #define HWSERIAL Serial2

//SPI for MPU9250
  #define SPI_CLOCK 19000000  // 19MHz clock works.

//pins
  //LED
    #define LED      13
  //Flaps
    #define flap0    15
    #define flap1    17
  //RX  
    #define rx       23
  //IMU
    #define SS_PIN    3
    #define INT_PIN   2
  //IR
    #define ir       22
  //servo
    #define servoPin 19
  //esc
    #define escPin   18

//rx channels
  #define liftRx        0
  #define rollRx        1
  #define pitchRx       2
  #define throttleRx    3
  #define safetySwRx    4
  #define killSwRx      5

//instances
  //Servo instance                         
    Servo regler;
    Servo servo;
  //IMU instance
    MPU9250 mpu(SPI_CLOCK, SS_PIN, BITS_DLPF_CFG_256HZ_NOLPF2, BITS_DLPF_CFG_256HZ_NOLPF2);
  //Kalman instance
    Kalman kalmanX, kalmanY;


//global variables
  //RX variables
    //Array in which the channel values are stored
      volatile int32_t rxData[] = {0,0,0,0,0,0,0,0};
    //int in whicht the time difference to the last pulse is stored
      volatile uint32_t rxPre = 1;
    //int in which the current challel number to read out is stored
      volatile uint8_t channelNr = 0; 
  //IMU Data  
    //variables for raw values
      int accX, accY, accZ;
      int gyroX, gyroY, gyroZ;
      int16_t tempRaw;
    //pitch and roll values
      int roll, pitch; // Roll and pitch are calculated using the accelerometer
    //calculated angle values
      double gyroXangle, gyroYangle; // Angle calculate using the gyro only
      double kalAngleX, kalAngleY; // Calculated angle using a Kalman filter
    //timer variable 
      uint32_t timer;

//interrupt functions
  //IR
    void IRFalling() {
      controlProcess();
    }
    
  //PPM
    void rxFALLING() {
      if(micros()-rxPre > 8000) {
        channelNr = 0;
      }
      else {
        rxData[channelNr] = micros()-rxPre;
        channelNr++;
      }
      rxPre = micros(); 
      //if(rxData[killSwRx] < 1000) killAll();  ------------reactivate for practical use!!!!!!!!
    }
    
void setup() {
  delay(2000);
  //start serial for debugging purposes
    Serial.begin(115200);
    HWSERIAL.begin(9600);
  
  //initialise pins
    //inputs
      pinMode(INT_PIN, INPUT);
      pinMode(rx,INPUT);
      pinMode(ir, INPUT);
  
    //outputs
      pinMode(flap0, OUTPUT);
        digitalWriteFast(flap0, LOW);
      pinMode(flap1, OUTPUT);
        digitalWriteFast(flap1, LOW);
      pinMode(LED, OUTPUT);

  //initialise servos
    servo.attach(servoPin);
    servo.write(90);
  //initialise esc
    regler.attach(escPin);
    regler.write(0);

  //SPI for IMU
    SPI.setMISO(8);
    SPI.setSCK(14);
    SPI.begin();
  //initialise IMU
    mpu.init(true);

    uint8_t wai = mpu.whoami();
      if (wai != 0x71) {
        HWSERIAL.print("Failed connection: ");
        HWSERIAL.println(wai, HEX);
        while(1) {
          digitalWrite(LED,HIGH);
          delay(500);
          digitalWrite(LED,LOW);
          delay(500);
        }
      }

    mpu.calib_acc();
    
  //interrupts
    //rx
      attachInterrupt(digitalPinToInterrupt(rx), rxFALLING, FALLING);
    //ir
      attachInterrupt(digitalPinToInterrupt(ir), IRFalling, FALLING);

  HWSERIAL.println("Ready when you are!");
  
  //wait for start spin
    //waitForStartSpin(); //----------reactivate for practical use!!!!!!

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
  
}

void killAll() {
  regler.write(0);
  servo.write(90);
  digitalWriteFast(LED, LOW);
  while(1);
}

void controlMotors() {
  //Motor nur starten, wenn failsave switch off
  if(rxData[4] < 1000) {
    regler.write(map(rxData[throttleRx], 990, 2010, 0, 180));
  }
  else {
    regler.write(0);
  }
}

//Start and Landing foo
  void waitForStartSpin() {
    int16_t zt = 0;
    mpu.set_gyro_scale(BITS_FS_1000DPS);
    while(zt > -900) {
      mpu.read_gyro();
      zt = mpu.gyro_data[2]/32.8;
    }
    digitalWriteFast(LED, HIGH);
    mpu.set_gyro_scale(BITS_FS_250DPS);
  }
  
  void zAccPeak() {
    float zt = 0;
    mpu.set_acc_scale(BITS_FS_8G);
    while(zt < 5) {
      mpu.read_acc();
      zt = mpu.accel_data[2]/4096;
    }
    digitalWriteFast(LED, HIGH);
    mpu.set_acc_scale(BITS_FS_2G);
  }

void controlProcess() {
//the control Process will be here soon
}

void updateAngle() {
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

