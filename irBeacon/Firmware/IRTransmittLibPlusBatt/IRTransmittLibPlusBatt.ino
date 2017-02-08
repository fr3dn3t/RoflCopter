#include <IRcontinuous.h>

int ledPin = 6;


int irPin = 27;
int tonePin = 0;
int beepCounter = 0;


IRsend irsend;

boolean ledOn=false;
void setup() {
  Serial.begin(9600);

  pinMode(ledPin, OUTPUT);
  pinMode(irPin, OUTPUT);

  digitalWrite(irPin, LOW);
  digitalWrite(ledPin, HIGH);
  
  delay(5000);
  tone(tonePin, 800);       // Begin the tone
  delay(500);
  noTone(tonePin);
  
  delay(500);
  tone(tonePin, 800);       // Begin the tone
  delay(500);
  noTone(tonePin);
  
  delay(500);
  tone(tonePin, 1200);       // Begin the tone
  delay(700);
  noTone(tonePin);
}

void loop() {
  //sendRaw(int peak, int lengh, int hz)
  irsend.sendRaw(400, 100, 38);

  //Let the led blink to indicate active status
  if(ledOn) {
    ledOn = false;
    digitalWrite(ledPin, LOW);
  }
  else {
    ledOn = true;
    digitalWrite(ledPin, HIGH);
  }

  //a beep every x seconds to indicate active status
  //clear the tone when counter was reset
  if(beepCounter==0) {
    noTone(tonePin);
  }
  
  beepCounter++;

  //activete tone and reset counter when round x was passed
  if(beepCounter > 200) {
    beepCounter=0;
    tone(tonePin, 1200);
  }
  //delay(1500); //In this example, the signal will be repeated every 1.5 seconds, approximately.
}
