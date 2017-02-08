#include <i2c_t3.h>
#include <math.h>
#include <Servo.h>
#include "Kalman.h" // Source: https://github.com/TKJElectronics/KalmanFilter

#define RESTRICT_PITCH // Comment out to restrict roll to ±90deg instead - please read: http://www.freescale.com/files/sensors/doc/app_note/AN3461.pdf


Kalman kalmanX, kalmanY; // Create the Kalman instances

//Variablen für die Lageerkennung
  const uint8_t MPU6050 = 0x68; // If AD0 is logic low on the PCB the address is 0x68, otherwise set this to 0x69

  //Variablen für die Lageerkennung
  int accX, accY, accZ;
  int gyroX, gyroY;
  int16_t tempRaw;

  int roll, pitch; // Roll and pitch are calculated using the accelerometer while yaw is calculated using the magnetometer

  double gyroXangle, gyroYangle; // Angle calculate using the gyro only
  double kalAngleX, kalAngleY; // Calculated angle using a Kalman filter

  uint32_t IMUtimer;
  uint8_t i2cData[14]; // Buffer for I2C data

  int IST[2];

//Pinbelegungen
  int IR = 22;
  int LED = 13;

  //Servos und Regler
  Servo regler0;  
  Servo regler1;
  Servo servo0;  
  Servo servo1;

  //Servos um 20° anstellen
  int s0n = 120; //neutral bei 100
  int s1n = 109; //neutral bei 89
 
  //Definieren der Empfängerpins
  int ch1 = 14;
  int ch2 = 15;
  int ch3 = 16;
  int ch4 = 17;
  //int ch5 = 20;

  //Klappen
  const int klappe0 = 23;
  const int klappe1 = 21;

//rotating time
long lastTurnTimestamp = 0.00;
double diffTime;
double rotSpeed;

//klappen Zeiten
boolean rotor0down = false;
boolean rotor1down = false;

unsigned long klappenTimer = 0;
boolean rotor0first = false;

long zeitBisZumAnstellen;
long anstellZeit;

//shared IRtimer
  volatile uint32_t IRtimer = 0;

//shared misc. vars
  volatile boolean on = false;
  volatile boolean onPre = true;

  //Initialisieren der Empfängerdaten Variablen
  volatile uint32_t ch1Data=121;
  volatile uint32_t ch2Data=0;
  volatile uint32_t ch3Data=0;
  volatile uint32_t ch4Data=0;
  //volatile uint32_t ch5Data=0;
  
  //Initialisieren der Zeitvariablen für die Empfänger Interrupts
  volatile uint32_t ch1Pre=0;
  volatile uint32_t ch2Pre=0;
  volatile uint32_t ch3Pre=0;
  volatile uint32_t ch4Pre=0;
  //volatile uint32_t ch5Pre=0;

  
//Interrupt Funktion
  void irFALLING () {
    IRtimer = micros()+810;//den IMUtimer um 810us (1 duetycycle) nach hinten verschieben
    if(!on) {
      //calc rotSpeed
      diffTime = micros()-lastTurnTimestamp;
      lastTurnTimestamp = micros();
      rotSpeed=60*(1000000/diffTime);//(String)60*(1/(diffTime/1000000));
      on=true;//die variable on auf true setzen, da ja etwas empfangen wurde
    }
  }

  //CH1 = Lage auf X
  void ch1RISING () {
  ch1Pre = micros();
  detachInterrupt(digitalPinToInterrupt(ch1)); 
  attachInterrupt(digitalPinToInterrupt(ch1), ch1FALLING, FALLING);
  }
  
  void ch1FALLING () {
    ch1Data = map(micros()-ch1Pre,987,2010,-45,45);
    detachInterrupt(digitalPinToInterrupt(ch1)); 
    attachInterrupt(digitalPinToInterrupt(ch1), ch1RISING, RISING);  
  }

  //CH2 Lage auf Y
  void ch2RISING () {
    ch2Pre = micros();
    detachInterrupt(digitalPinToInterrupt(ch2)); 
    attachInterrupt(digitalPinToInterrupt(ch2), ch2FALLING, FALLING);
  }
  
  void ch2FALLING () {
    ch2Data = map(micros()-ch2Pre,987,2010,-45,45);
    detachInterrupt(digitalPinToInterrupt(ch2)); 
    attachInterrupt(digitalPinToInterrupt(ch2), ch2RISING, RISING); 
  }

  //CH3 collective pitch
  void ch3RISING () {
    ch3Pre = micros();
    detachInterrupt(digitalPinToInterrupt(ch3));
    attachInterrupt(digitalPinToInterrupt(ch3), ch3FALLING, FALLING); 
  }
  
  void ch3FALLING () {
    ch3Data = map(micros()-ch3Pre,987,2010,0,25);
    detachInterrupt(digitalPinToInterrupt(ch3)); 
    attachInterrupt(digitalPinToInterrupt(ch3), ch3RISING, RISING); 
  }

  //CH4 Motordrehzahl
  void ch4RISING () {
    ch4Pre = micros();
    detachInterrupt(digitalPinToInterrupt(ch4)); 
    attachInterrupt(digitalPinToInterrupt(ch4), ch4FALLING, FALLING);
  }
  
  void ch4FALLING () {
    ch4Data = map(micros()-ch4Pre,987,2010,0,180);
    detachInterrupt(digitalPinToInterrupt(ch4)); 
    attachInterrupt(digitalPinToInterrupt(ch4), ch4RISING, RISING); 
  }
  //Bei Bedarf den letzten Kanal hinzunehmen
  /*
  void ch5RISING () {
    ch5Pre = micros();
    detachInterrupt(digitalPinToInterrupt(ch5)); 
    attachInterrupt(digitalPinToInterrupt(ch5), ch5FALLING, FALLING);
  }
  
  void ch5FALLING () {
    ch5Data = micros()-ch5Pre;
    detachInterrupt(digitalPinToInterrupt(ch5)); 
    attachInterrupt(digitalPinToInterrupt(ch5), ch5RISING, RISING); 
  }
  */

//Funktionsdefinition
  //Funktionen für die Winkelwahl
    double cosPSpitz(double pSkalarprodukt, double pDiffVektorLaenge) {
      double result = sqrt(pSkalarprodukt*pSkalarprodukt)/pDiffVektorLaenge; //refVektorLaenge*diffVektorLaenge = 1*diffVektorLaenge
      return result;
    }
    
    double cosPStumpf(double pSkalarprodukt, double pDiffVektorLaenge) {
      double result = pSkalarprodukt/pDiffVektorLaenge; //refVektorLaenge*diffVektorLaenge = 1*diffVektorLaenge
      return result;
    }

    
  
void setup() {
  delay(500);//wait for everything

  //I2C initialise
    Wire.begin(I2C_MASTER, 0x00, I2C_PINS_18_19, I2C_PULLUP_EXT, I2C_RATE_600);
    Wire.setDefaultTimeout(1000);

    i2cData[0] = 7; // Set the sample rate to 1000Hz - 8kHz/(7+1) = 1000Hz
    i2cData[1] = 0x00; // Disable FSYNC and set 260 Hz Acc filtering, 256 Hz Gyro filtering, 8 KHz sampling
    i2cData[2] = 0x03; // Set Gyro Full Scale Range to ±250deg/s
    i2cData[3] = 0x03; // Set Accelerometer Full Scale Range to ±2g
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
  
    kalmanY.setAngle(pitch); // Then pitch
    gyroYangle = pitch;
  
    IMUtimer = micros(); // Initialize the IMUtimer
  
  //IR initialise
    pinMode(IR, INPUT);
    attachInterrupt(digitalPinToInterrupt(IR), irFALLING, FALLING);

  //Empfängerpins auf input
    pinMode(ch1,INPUT);
    pinMode(ch2,INPUT);
    pinMode(ch3,INPUT);
    pinMode(ch4,INPUT);
    //pinMode(ch5,INPUT);

  //Klappenpins auf output
  pinMode(klappe0, OUTPUT);
  pinMode(klappe1, OUTPUT);

  //Regler Attach
  regler0.attach(4);
  regler1.attach(5);
  regler0.write(0);
  regler1.write(0);

  //ServoAttach
  servo0.attach(6);
  servo1.attach(3);
  servo0.write(s0n);
  servo1.write(s1n);
  
  //Interrupts für die Fernsteuerung
    attachInterrupt(digitalPinToInterrupt(ch1), ch1RISING, RISING); //CH1 Lage auf X
    attachInterrupt(digitalPinToInterrupt(ch2), ch2RISING, RISING); //CH2 Lage auf Y
    attachInterrupt(digitalPinToInterrupt(ch3), ch3RISING, RISING); //CH3 collective Pitch
    attachInterrupt(digitalPinToInterrupt(ch4), ch4RISING, RISING); //CH4 motordrehzahl
    //Bei Bedarf den letzten Kanal hinzunehmen 
      //attachInterrupt(digitalPinToInterrupt(ch5), ch5RISING, RISING); 

}

void loop() {//Hauptschleife
  
  //Wenn die Zeit größer als der gewünschte Zeitstempel ist
  if((micros() >= IRtimer)&& (IRtimer != 0)) { //IRtimer = 0 = disabled
   on=false;
   onPre=true;
   IRtimer = 0;
  }
  
  if(on && onPre) {//Wenn Infrarotsignal empfangen
    //onPre auf false setzen, da die Funktion nur einmal bei sichtkontakt ausgeführt werden soll
      onPre=false;
      
    //Variablen für die Steuerberrechnung
      int SOLL[2] = {0,0};
    //  boolean skipThisRound = false;
      int bx=1;
    //Vektoren
      //Differenz Vektor
        int diffVektor[2];
        double skalarprodukt = 0.00;
        double diffVektorLaenge = 0.00;
    //arccos2
      double cosP = 0.00;
    //Winkel
      int winkelBisZumVektor = 0;
      int anstellWinkel = 0;
      int winkelBisZumAnstellen = 0;     
        
  
    //IST Zustand einlesen
      getCopterAngle();
      
    //SOLL Zustand für diese umdrehung speichern, damit er  nich von den Interrupts überschieben wird [X,Y]
      SOLL[0] = map(ch1Data, 0, 180, -45, 45); //evtl. auf 90 erhöhen
      SOLL[1] = map(ch2Data, 0, 180, -45, 45); //evtl. auf 90 erhöhen
      
    //Vektorrechnung
      diffVektor[0] = IST[0]-SOLL[0]; //X-Wert des Differnz Vektors
      diffVektor[1] = IST[1]-SOLL[1]; //Y-Wert des Differnz Vektors
      
      skalarprodukt = diffVektor[0]; //refVektor[0]*diffVektor[0]+refVektor[1]*diffVektor[1] = 1*diffVektor[0]+0*diffVektor[1] = diffVektor[0]
      diffVektorLaenge = sqrt(diffVektor[0]*diffVektor[0]+diffVektor[1]*diffVektor[1]); //Länge des Differenzvektors

    //Berrechnungen für die einzelnen Quadranten
    //oberhalb der X-Achse bei Y>0
      if(diffVektor[1] > 0) { 
        rotor0first = true; //oberhalb der X Achse kann nur der R0 der erste Rotor sein, der die Klappe anstellen muss
          if(diffVektor[0] > 0) {
            //1. Quadrant --> stumpfer Winkel für R0
              cosP = cosPStumpf(skalarprodukt, diffVektorLaenge);
          }
          else if(diffVektor[0] < 0) {
            //2. Quadrant --> spitzer Winkel für R0
              cosP = cosPSpitz(skalarprodukt, diffVektorLaenge);
          }
          else {
            //X=0 --> Winkel von 90° für R0
              cosP=0;
          }
      }

    //unterhalb der X-Achse bei Y < 0
      else if(diffVektor[1] < 0) { 
        rotor0first = false;
          if(diffVektor[0] < 0) {
            //3. Quadrant --> stumpfer Wikel für R1
              cosP = cosPStumpf(skalarprodukt, diffVektorLaenge);
          }
          else if(diffVektor[0] > 0) {
            //4. Quadrant --> spitzer Winkel für R1
              cosP = cosPSpitz(skalarprodukt, diffVektorLaenge);
          }
          else {
            //X=0 --> Winkel von 90° für R1
              cosP=0;
          }
      }

    //Auf der X-Achse bei Y = 0
      else {
        if(diffVektor[0] > 0) {
          //Achse zwischen 1 und 4 Quadranten --> R0 anstellen, da R1 bereits auf dieser Position ist
            cosP = -1; //180°
            rotor0first = true;
        }
        else if(diffVektor[0] < 0) {
          //Achse zwischen 2 und 3 Quadranten --> R1 anstellen, da R0 bereits auf dieser Position ist
            cosP = -1; //180°
            rotor0first = false;
        }
        else {
          //Vektor zeigt auf (0|0) --> nichts tun
          //skipThisRound = true;
        }
      }

    //Winkel berrechnen

      winkelBisZumVektor = round(acos(cosP));
      anstellWinkel = diffVektorLaenge*bx; //bx ist variabler Faktor (ggf. exponentiell)
      winkelBisZumAnstellen = winkelBisZumVektor-(1/2*(anstellWinkel));
      
    //Zeiten berrechnen
      zeitBisZumAnstellen = diffTime/(360*winkelBisZumAnstellen);
      anstellZeit = diffTime/(360*anstellWinkel);

      klappenTimer = zeitBisZumAnstellen;
  }

  if((micros() >= klappenTimer) && klappenTimer != 0) {
    if(!rotor0down && !rotor1down) {//wenn keine Klappe angestellt 
      if(rotor0first) {//entweder rotor0 anstellen
        rotor0first = false;
        rotor0down = true;
        rotor1down = false;
        klappenTimer = micros()+anstellZeit; //timer setzen, wenn klappe wieder runter soll
        digitalWrite(klappe0, HIGH);
      }
      else {// oder rotor1 anstellen
        rotor0first = true;
        rotor1down = true;
        rotor0down = false;
        klappenTimer = micros()+anstellZeit; //timer setzen, wenn klappe wieder runter soll
        digitalWrite(klappe1, HIGH);
      } 
    }
    else if(rotor0down) {//wenn rotor0 angestellt ist
      digitalWrite(klappe0, LOW);//lösen
      rotor0down = false;
      rotor1down = false;
      klappenTimer = micros()+(diffTime/2)-anstellZeit; //die selbe bewegung mit dem anderen Rotor nach der Zeit für 180° - anstellZeit wieder ausführen
    }
    else if(rotor1down) {//wenn rotor0 angestellt ist
      digitalWrite(klappe1, LOW);//lösen
      rotor0down = false;
      rotor1down = false;
      klappenTimer = micros()+(diffTime/2)-anstellZeit; //die selbe bewegung mit dem anderen Rotor nach der Zeit für 180° - anstellZeit wieder ausführen
    }
  }

  //Regler und Servos neu stellen
  servo0.write(s0n+ch3Data);
  servo1.write(s1n+ch3Data);
  
  regler0.write(ch4Data);
  regler1.write(ch4Data);
}
  

void getCopterAngle() {
  //Mittlaufende Mittel
  //kal
  int kalAngleBufferSize = 6;
  double kalBufferX[6];
  double kalBufferY[6];
  int kalBufferCounter = 0;
  double kalAngleXBuffered, kalAngleYBuffered;

  int i;
  
  /* Update all the IMU values */
  updateMPU6050();

  double dt = (double)(micros() - IMUtimer) / 1000000; // Calculate delta time
  IMUtimer = micros();


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

  if (abs(kalAngleX) > 90) {
    gyroYrate = -gyroYrate; // Invert rate, so it fits the restricted accelerometer reading
  kalAngleY = kalmanY.getAngle(pitch, gyroYrate, dt);
  }

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

