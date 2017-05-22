#  define PS0 0
#  define PS1 1
#  define PS2 2

 //vars for timer control
    
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
  flapTimer.begin(flapOn, timeToFlap);
            

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
