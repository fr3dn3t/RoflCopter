#define HWSERIAL Serial1
#include <Servo.h> 
 
Servo regler0;  
Servo regler1;
Servo servo0;  
Servo servo1;

//Servos um 20° anstellen
int s0n = 120; //neutral bei 100
int s1n = 93; //neutral bei 89

//Definieren der Empfängerpins
int ch1 = 14;
int ch2 = 15;
int ch3 = 16;
int ch4 = 17;
int ch5 = 20;

//LED Pin
int led = 13;

//IR
int ir = 22;
int recieveTollerance = 810; //tollerance time in us; min. 810

//Initialisieren der Empfängerdaten Variablen
volatile uint32_t ch1Data=121;
volatile uint32_t ch2Data=0;
volatile uint32_t ch3Data=0;
volatile uint32_t ch4Data=0;
volatile uint32_t ch5Data=0;

//Initialisieren der Zeitvariablen für die Empfänger Interrupts
volatile uint32_t ch1Pre=0;
volatile uint32_t ch2Pre=0;
volatile uint32_t ch3Pre=0;
volatile uint32_t ch4Pre=0;
volatile uint32_t ch5Pre=0;

//IR shared variables
volatile unsigned int irTimer = 0;
volatile boolean on = false;

//Interrupt Funktionen
void ch1RISING () {
  ch1Pre = micros();
  detachInterrupt(digitalPinToInterrupt(ch1)); 
  attachInterrupt(digitalPinToInterrupt(ch1), ch1FALLING, FALLING);
}
void ch1FALLING () {
  ch1Data = map(micros()-ch1Pre,987,2010,0,180);
  detachInterrupt(digitalPinToInterrupt(ch1)); 
  attachInterrupt(digitalPinToInterrupt(ch1), ch1RISING, RISING);  
}
void ch2RISING () {
  ch2Pre = micros();
  detachInterrupt(digitalPinToInterrupt(ch2)); 
  attachInterrupt(digitalPinToInterrupt(ch2), ch2FALLING, FALLING);
}
void ch2FALLING () {
  ch2Data = micros()-ch2Pre;
  detachInterrupt(digitalPinToInterrupt(ch2)); 
  attachInterrupt(digitalPinToInterrupt(ch2), ch2RISING, RISING); 
}
void ch3RISING () {
  ch3Pre = micros();
  detachInterrupt(digitalPinToInterrupt(ch3));
  attachInterrupt(digitalPinToInterrupt(ch3), ch3FALLING, FALLING); 
}
void ch3FALLING () {
  ch3Data = micros()-ch3Pre;
  detachInterrupt(digitalPinToInterrupt(ch3)); 
  attachInterrupt(digitalPinToInterrupt(ch3), ch3RISING, RISING); 
}
void ch4RISING () {
  ch4Pre = micros();
  detachInterrupt(digitalPinToInterrupt(ch4)); 
  attachInterrupt(digitalPinToInterrupt(ch4), ch4FALLING, FALLING);
}
void ch4FALLING () {
  ch4Data = micros()-ch4Pre;
  detachInterrupt(digitalPinToInterrupt(ch4)); 
  attachInterrupt(digitalPinToInterrupt(ch4), ch4RISING, RISING); 
}
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

//Interrupt Funktion
void irFALLING () {
  irTimer = micros()+recieveTollerance;//den Timer um 810us (1 duetycycle) nach hinten verschieben
  on=true;//die variable on auf true setzen, da ja etwas empfangen wurde
}

void setup() {
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

  //IR
  pinMode(ir, INPUT);
  
  // Serielles Funlkmodul initialisieren
        HWSERIAL.begin(9600);
  //LED Pin auf Output
        pinMode(led,OUTPUT);
  //Empfängerpins auf input
        pinMode(ch1,INPUT);
        pinMode(ch2,INPUT);
        pinMode(ch3,INPUT);
        pinMode(ch4,INPUT);
        pinMode(ch5,INPUT);

  //Interrupts
  attachInterrupt(digitalPinToInterrupt(ch1), ch1RISING, RISING);  
  attachInterrupt(digitalPinToInterrupt(ch2), ch2RISING, RISING); 
  attachInterrupt(digitalPinToInterrupt(ch3), ch3RISING, RISING);  
  attachInterrupt(digitalPinToInterrupt(ch4), ch4RISING, RISING); 
  attachInterrupt(digitalPinToInterrupt(ch5), ch5RISING, RISING); 

  attachInterrupt(digitalPinToInterrupt(ir), irFALLING, FALLING);
}

void loop() {
  //Wenn die Zeit größer als der gewünschte Zeitstempel ist
  if((micros() >= irTimer)&& (irTimer != 0)) { //irTimer = 0 = disabled
   on=false;
   irTimer = 0;
  }
  
  if(on) {//Wenn Signal empfangen
    digitalWrite(led, HIGH);
  }
  else {
    digitalWrite(led, LOW);
  }
  //HWSERIAL.println("--------");
  //HWSERIAL.println(ch1Data);
  //HWSERIAL.println(ch2Data);
  //HWSERIAL.println(ch3Data);
  //HWSERIAL.println(ch4Data);
  //HWSERIAL.println(ch5Data);
  regler0.write(ch1Data);
  regler1.write(ch1Data);
  //regler1.write(ch1Data);
  //delay(50);*/

}
