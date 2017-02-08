#define HWSERIAL Serial1

//Variablen
int ir = 22;
int unsigned irNow = 0;
int unsigned irPre = 0;
int unsigned letzteAusfuehrung = 0;
int unsigned umdrehungszeit = 0;
volatile unsigned int naechsteAusfuehrung = 0;
volatile unsigned int drehzahl;

//Interrupt Funktion
void irRISING () {
  irNow = micros();
  detachInterrupt(digitalPinToInterrupt(ir)); 
  //Wenn ein Zeitstempel der letzten Umdrehung vorliegt
  if(irPre != 0) {
    umdrehungszeit = irNow-irPre;
    drehzahl = 60000000/umdrehungszeit; //Umdrehungen / min
    naechsteAusfuehrung = irNow+umdrehungszeit/2; //Den Interrupt nach der hälfte der letzten Umdrehungszeit wieder aktivieren
  }
  irPre = irNow; //Jetzt Zeit als Zeitspempel der letzten Umdrehung für die nächste Ausführung setzen
}
  
  

void setup() {
  // put your setup code here, to run once:  
}

void loop() {
  //Wenn die Zeit größer als der gewünschte Zeitstempel ist UND der Zeitstempel nicht dem zuletzt ausgeführten entspricht (Interrupt nicht immer wieder aktivieren, sondern nur einmal (wiederholungen vermeiden))
  if((micros() >= naechsteAusfuehrung) && (letzteAusfuehrung != naechsteAusfuehrung)) {
   letzteAusfuehrung = naechsteAusfuehrung;
   HWSERIAL.println(drehzahl);
   attachInterrupt(digitalPinToInterrupt(ir), irRISING, RISING);
  }
}


