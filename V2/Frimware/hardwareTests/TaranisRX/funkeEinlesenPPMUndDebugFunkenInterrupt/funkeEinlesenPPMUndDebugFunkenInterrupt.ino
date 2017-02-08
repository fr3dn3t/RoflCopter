#define HWSERIAL Serial2

//Definieren der Empfängerpins
int rx = 23;
//LED Pin
int led = 13;
//Initialisieren der Empfängerdaten Variablen
volatile int32_t rxData[] = {0,0,0,0,0,0,0,0};
//Initialisieren der Zeitvariablen für die Empfänger Interrupts
volatile uint32_t rxPre = 1;

volatile uint8_t channelNr = 0; 
volatile boolean init = false;

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

delay(1000);
  
  //Interrupts
  attachInterrupt(digitalPinToInterrupt(rx), rxFALLING, FALLING);  
  
}

void loop() {
  HWSERIAL.println("--------");
  for(int i=0; i<8;i++) {
    HWSERIAL.print("CH");
    HWSERIAL.print(i);
    HWSERIAL.print(": ");
    HWSERIAL.println(rxData[i]);
  }
  delay(1000);
}
