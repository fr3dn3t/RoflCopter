#include <Servo.h> 
 
Servo regler0;  
Servo regler1;

void setup() {
  // put your setup code here, to run once:
  regler0.attach(4);
  regler1.attach(5);
  regler0.write(0);
  regler1.write(0);
}

void loop() {
  delay(5000);
  regler0.write(180);
  regler1.write(180);
  delay(3000);
  regler0.write(0);
  regler1.write(0);
  delay(5000);
}
