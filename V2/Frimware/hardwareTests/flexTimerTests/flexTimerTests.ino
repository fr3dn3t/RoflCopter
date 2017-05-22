#  define PS0 0
#  define PS1 1
#  define PS2 2

 //vars for timer control
    uint16_t nextWait;//value to apply in the next interrupt cycle, set by main loop; 16bit int since the timer register is also 16bit
    int nextPrescaler;//value to apply in the next interrupt cycle - value between 0 - 4, set by main loop
    int prescaler[8] = {1,2,4,8,16,32,64,128}; //array with the fixed prescaler values for the internal timers
  
    int timeToFlap = 14339;
    int timeFlapOn = 10622;

    int prescalerFlapOn;
    int waitFlapOn;
    
    IntervalTimer flapTimer;

void setup() {
  Serial.begin(115200);
  pinMode(14, OUTPUT);
  delay(4000);
  
//----------------------------------------
//trigger 
  digitalWriteFast(14, HIGH);
  delay(10);
  digitalWriteFast(14, LOW);

  flapTimer.priority(100);
  flapTimer.begin(flapOn, timeToFlap);//indicate the program start by blinking
            

}

void flapOn() {
    digitalWriteFast(14, HIGH);
    flapTimer.end();
    flapTimer.begin(flapOff, timeFlapOn);
}

void flapOff() {
    digitalWriteFast(14, LOW);
    flapTimer.end();
}

void loop() {
  // put your main code here, to run repeatedly:

}
