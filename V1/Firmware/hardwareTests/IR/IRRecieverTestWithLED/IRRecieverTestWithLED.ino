int ir = 0;
int led = 13;

int recieveTollerance = 2000; //tollerance time in us; min. 810

volatile unsigned int irTimer = 0;
volatile boolean on = false;

//Interrupt Funktion
void irFALLING () {
  irTimer = micros()+recieveTollerance;//den Timer um 810us (1 duetycycle) nach hinten verschieben
  on=true;//die variable on auf true setzen, da ja etwas empfangen wurde
}
  
void setup() {
  pinMode(ir, INPUT);
  pinMode(led, OUTPUT);
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
}


