#include <Servo.h> 
 
Servo regler0;  

void setup() {
  delay(3000);
  // put your setup code here, to run once:
  regler0.attach(0);
  regler0.write(0);
  delay(5000);
  regler0.write(90);
}

void loop() {
 
}
