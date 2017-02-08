#include <Servo.h> 
 
Servo regler0;  
Servo regler1;
Servo servo0;  
Servo servo1;
int ledPin = 13;

//Neutralwinkel der Servos
int s0n = 121; 
int s1n = 100;
   
 
void setup() 
{ 
  //Pins vergeben
  regler0.attach(3);
  regler1.attach(4); 
  servo0.attach(5);
  servo1.attach(6);
  pinMode(ledPin, OUTPUT);

  //Regler + Servos in Neutralstellung
  regler0.write(0);
  regler1.write(0);
  servo0.write(s0n);
  servo1.write(s1n);

  delay(500);
  digitalWrite(ledPin,HIGH);
  delay(500);
  digitalWrite(ledPin,LOW);
  
  //Servos auf Freiheit in beide Richtungen prüfen
  int i;
  for(i=s0n;i<s0n+20;i++) {
    servo0.write(i);
    delay(50);
  }
  servo0.write(s0n);
  for(i=s0n;i>s0n-20;i--) {
    servo0.write(i);
    delay(50);
  }
  servo0.write(s0n);
  
  for(i=s1n;i<s1n+20;i++) {
    servo1.write(i);
    delay(50);
  }
  servo1.write(s1n);
  for(i=s1n;i>s1n-20;i--) {
    servo1.write(i);
    delay(50);
  }
  servo1.write(s1n);

  
  digitalWrite(ledPin,HIGH);
} 
 
 
void loop() 
{ 
    
   
} 

void servoStellen(int deg) {
  servo0.write(s0n+deg);
  servo1.write(s1n+deg);
}

