#define HWSERIAL Serial1
#include <Servo.h> 

const int klappe0 = 23;
int downCounter = 1000;
int i=100;
int u=180;
int e=250;

Servo servo0;

int s0n = 121; 

void setup() {
  pinMode(klappe0, OUTPUT);
  HWSERIAL.begin(9600);
  servo0.attach(6);
  servo0.write(s0n);
}

void loop() {
  if(HWSERIAL.available()) {

    int i;
    for(i=s0n;i<s0n+30;i++) {
      servo0.write(i);
      delay(65);
    }
    for(i=s0n+30;i>s0n-25;i--) {
      servo0.write(i);
      delay(65);
    }
    for(i=s0n-30;i<s0n;i++) {
      servo0.write(i);
      delay(65);
    }

    delay(3000);
    
    while(downCounter>4) {
      digitalWrite(klappe0, HIGH);
      delay(downCounter/2);
      digitalWrite(klappe0, LOW);
      delay(downCounter*2);
  
      downCounter = downCounter - (downCounter/3);
    }

    while(i>1) {
      digitalWrite(klappe0, HIGH);
      delay(4);
      digitalWrite(klappe0, LOW);
      delay(9);
      i--;
    }

    
    while(u>1) {
      digitalWrite(klappe0, HIGH);
      delay(4);
      digitalWrite(klappe0, LOW);
      delay(8);
      u--;
    }

    while(e>1) {
      digitalWrite(klappe0, HIGH);
      delay(4);
      digitalWrite(klappe0, LOW);
      delay(7);
      e--;
    }
  }
  
  while(HWSERIAL.available()) {
    HWSERIAL.read();
  }
}
