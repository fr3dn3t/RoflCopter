#define HWSERIAL Serial2
#include <Servo.h> 
 
Servo regler;

//Definieren der Empfängerpins
int rx = 23;
//LED Pin
int led = 13;
//Initialisieren der Empfängerdaten Variablen
volatile int32_t rxData[] = {0,0,0,0,0,0,0,0};
//Initialisieren der Zeitvariablen für die Empfänger Interrupts
volatile uint32_t rxPre = 1;

volatile uint8_t channelNr = 0; 

//Interrupt Funktionen
//PPM
  void rxFALLING() {
    if(micros()-rxPre > 8000) {
      channelNr = 0;
    }
    else {
      rxData[channelNr] = micros()-rxPre;
      channelNr++;
    }
    rxPre = micros();   
  }


void setup() {
  // Serielles Funlkmodul initialisieren
        HWSERIAL.begin(9600);
        Serial.begin(115200);
  //LED Pin auf Output
        pinMode(led,OUTPUT);
  //Empfängerpins auf input
        pinMode(rx,INPUT);
  //Interrupt  
        attachInterrupt(digitalPinToInterrupt(rx), rxFALLING, FALLING);
  delay(1000);
  HWSERIAL.println("Ready when you are!");
  //auf stabilisierung der Werte warten
  regler.attach(18);
  regler.write(90);
  delay(1000);
  
  
}

void loop() {
  /*HWSERIAL.println("--------");
  for(int i=0; i<8;i++) {
    HWSERIAL.print("CH");
    HWSERIAL.print(i);
    HWSERIAL.print(": ");
    HWSERIAL.println(rxData[i]);
  }*/
  //Motor nur starten, wenn failsave switch off
  if(rxData[4] < 1000) {
    regler.write(map(rxData[0], 990, 2010, 0, 180));
  }
  else {
    regler.write(0);
  }
  //delay(20);
} 
    
  

