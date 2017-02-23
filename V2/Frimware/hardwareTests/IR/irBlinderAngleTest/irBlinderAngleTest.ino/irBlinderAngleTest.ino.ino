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
    //Timer for the servo
      IntervalTimer servoTimer;
      IntervalTimer blinker;
      IntervalTimer killCheck;
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
    //indicates if the data in the channel value array are reliable e.g. there have been two sync breaks, so in the array there are only "real" values synced to the correspondinc channel number
      volatile uint8_t firstRoundCounter = 2;
      volatile boolean firstRoundPassed = false;
      volatile boolean validRxValues = false;
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
  //controlLoop
    boolean controlLoopActive = false;
    volatile boolean startNextRound = false;
  //lift control  
    boolean userLiftControlActive = true;//set false for practical use; will be set to true by start secuence
  //blinker
    volatile boolean onOrOff = false;
    int blinkInterval = 400000;//in us
  //IR
    int recieveTollerance = 3000; //tollerance time in us; min. 810
    volatile unsigned int irTimer = 0;
    volatile boolean on = false;
  //rpm calculation
    double lastTurnTimestamp = 0.00;
    double diffTime;
    double rotTime;
  //Debug Buffer
    String debugBuffer = "DEBUG START: ";
  //stat indicator  
    volatile boolean spinOff = false;
  
//interrupt functions
  //IR
    void IRFalling() {
      if(!on && spinOff) {
        startNextRound = true;
        //calc rpm
          diffTime = micros()-lastTurnTimestamp;
          lastTurnTimestamp = micros();
          rotTime=60*(1000000/diffTime);//(String)60*(1/(diffTime/1000000));
          debugBuffer += "\n"+(String)diffTime+","+(String)rotTime+",";
        //control loop to be started here...
        updateAngle();
      }
      irTimer = micros()+recieveTollerance;//offset the timer 3000us
      on=true;//indicate that something has been recieved
    }
    
  //PPM
    void rxFALLING() {//will be called when the ppm peak is over
      if(micros()-rxPre > 8000) {//if the current peak is the first peank after the the syncro break of 10ms
        rxPre = micros();
        channelNr = 0;//reset the channel number to syncronize again
        firstRoundCounter--;//the values in the first round are complete rubish, since there would'nt have been a first channel sync, this var indicates for the other functions, if the values are reliable
        if(firstRoundCounter == 0) firstRoundPassed = true;
      }
      else {
        rxData[channelNr] = micros()-rxPre;
        rxPre = micros();
        channelNr++;
      } 
      if(!validRxValues) {
        if(firstRoundPassed) {
           if((rxData[liftRx] < 1000) && (rxData[killSwRx] != rxData[pitchRx])) validRxValues = true;
        }
      }
    }
    
void setup() {
    Serial.begin(115200);
    HWSERIAL.begin(9600);
  
 
      pinMode(rx,INPUT_PULLUP);
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
  //start the servo Timer
    servoTimer.priority(254);
    servoTimer.begin(controlServos, 30000);

  
    attachInterrupt(digitalPinToInterrupt(rx), rxFALLING, FALLING);
      
  //waiting for RX
    HWSERIAL.print("Waiting for transmitter connection...");
    while(!validRxValues) {
      //nothing to do here
    }
    HWSERIAL.println("DONE");
  //activating kill switch
    killCheck.priority(150);
    killCheck.begin(killAll, 200000);
  
  
  //interrupts
    HWSERIAL.print("Activiating IR...");
    //ir
      attachInterrupt(digitalPinToInterrupt(ir), IRFalling, FALLING);
    HWSERIAL.println("DONE");

  
}

void loop() {
  //check for kill signal
    if(rxData[killSwRx] > 1800 && validRxValues) killAll();

  //adjust the motor speed
    regler.write(map(rxData[throttleRx], 990, 2000, 0, 180));

  //IR foo
    //Wenn die Zeit größer als der gewünschte Zeitstempel ist
    if((micros() >= irTimer)&& (irTimer != 0)) { //irTimer = 0 = disabled
     on=false;
     irTimer = 0;
    }
    
    if(on) {//Wenn Signal empfangen
      digitalWrite(LED, HIGH);
    }
    else {
      digitalWrite(LED, LOW);
    }
  delay(50);
}

void killAll() {
  if(rxData[killSwRx] > 1800 && validRxValues) {
    HWSERIAL.println("KILL");
    regler.write(10);
    delay(30);
    //cli();
    //servo.write(90);
    digitalWriteFast(LED, LOW);
    while(rxData[safetySwRx] > 1000) {}
    HWSERIAL.println(debugBuffer);
    cli();
    while(1);
  }
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

void controlServos() {
  if(validRxValues && userLiftControlActive) {
    servo.write(map(rxData[liftRx], 990, 2010, 80, 100));
  }
}

void blinkerFunction() {
  onOrOff = !onOrOff;
  digitalWriteFast(LED, onOrOff);
}

