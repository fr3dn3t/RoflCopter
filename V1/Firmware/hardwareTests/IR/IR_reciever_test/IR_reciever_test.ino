int ir = 22;

volatile unsigned int irTimer = 0;
volatile boolean on = false;

//Interrupt Funktion
void irFALLING () {
  irTimer = micros()+810;//den Timer um 810us (1 duetycycle) nach hinten verschieben
  on=true;//die variable on auf true setzen, da ja etwas empfangen wurde
}
  
void setup() {
  pinMode(ir, INPUT);
  attachInterrupt(digitalPinToInterrupt(ir), irFALLING, FALLING);
}

void loop() {
  //Wenn die Zeit größer als der gewünschte Zeitstempel ist
  if((micros() >= irTimer)&& (irTimer != 0)) { //irTimer = 0 = disabled
   on=false;
   irTimer = 0;
  }
  
  if(on) {//Wenn Signal empfangen
    //do something
  }
}


