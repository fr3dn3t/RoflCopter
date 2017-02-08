#include <Servo.h> 

Servo servo0;  
Servo servo1;

//Neutralwinkel der Servos
int s0n = 100; 
int s1n = 89;

   
void setup() {
  servo0.attach(5);
  servo1.attach(3);
  
  servo0.write(s0n);
  servo1.write(s1n);

}

void loop() {
  // put your main code here, to run repeatedly:

}
