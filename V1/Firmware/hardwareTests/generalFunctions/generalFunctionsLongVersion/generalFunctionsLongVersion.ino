int servo0PIN = 3;
int servo1PIN = 6;
int regler0PIN = 4;
int regler1PIN = 5;
int klappe0PIN = 23;
int klappe1PIN = 21;

boolean servo0HIGH = false;
boolean servo1HIGH = false;
boolean reglerHIGH = false;

long servo0Timer = 0;
long servo1Timer = 0;
long reglerTimer = 0;

void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:

}


//Funktionen zum Steuern der RC Komponenten mittels software PWM
//SERVO 0
void servo0Stellen() {//Funktion zum stellen des Servos 0
  if(servo0HIGH) {//ist auf den Pin gerade ein HIGH signal geschalet?
    digitalWrite(servo0PIN, LOW);//Signal auf LOW setzen
    servo0Timer = micros()+(20000-ch1data);//und 20000-ch1data microsekunden warten, um 50Hz framerate zu erreichen
  }
  else {//ist der Pin auf LOW
    digitalWrite(servo0PIN, HIGH);//auf HIGH setzen
    servo0Timer micros()+ch1data;//und solange warten, wie das signal es vorgibt
  }
}

//SERVO 1
void servo1Stellen() {//Funktion zum stellen des Servos 1
  if(servo1HIGH) {//ist auf den Pin gerade ein HIGH signal geschalet?
    digitalWrite(servo1PIN, LOW);//Signal auf LOW setzen
    servo1Timer = micros()+(20000-ch1data);//und 20000-ch1data microsekunden warten, um 50Hz framerate zu erreichen
  }
  else {//ist der Pin auf LOW
    digitalWrite(servo1PIN, HIGH);//auf HIGH setzen
    servo1Timer micros()+ch1data;//und solange warten, wie das signal es vorgibt
  }
}

//REGLER 0 und 1 werden immer gleichzeitig angesteuert
void reglerStellen() {//Funktion zum stellen des Reglers 0
  if(reglerHIGH) {//ist auf den Pin gerade ein HIGH signal geschalet?
    digitalWrite(regler0PIN, LOW);//Signal auf LOW setzen
    digitalWrite(regler1PIN, LOW);//Signal auf LOW setzen
    reglerTimer = micros()+(20000-ch1data);//und 20000-ch1data microsekunden warten, um 50Hz framerate zu erreichen
  }
  else {//ist der Pin auf LOW
    digitalWrite(regler0PIN, HIGH);//auf HIGH setzen
    digitalWrite(regler1PIN, HIGH);//auf HIGH setzen
    reglerTimer micros()+ch1data;//und solange warten, wie das signal es vorgibt
  }
}

//Kalppensteuerung
//KLAPPE 0
void klappe0Stellen() {//Funktion zum stellen der Kalppe 0
  if(klappe0HIGH) {//ist auf den Pin gerade ein HIGH signal geschalet?
    digitalWrite(klappe0PIN, LOW);//Signal auf LOW setzen
    klappe0Timer = 0;
  }
  else {//ist der Pin auf LOW
    digitalWrite(klappe0PIN, HIGH);//auf HIGH setzen
    klappe0Timer micros()+anstellzeit;
  }
}

//KLAPPE 0
void klappe1Stellen() {//Funktion zum stellen der Kalppe 0
  if(klappe1HIGH) {//ist auf den Pin gerade ein HIGH signal geschalet?
    digitalWrite(klappe1PIN, LOW);//Signal auf LOW setzen
    klappe1Timer = 0;
  }
  else {//ist der Pin auf LOW
    digitalWrite(klappe1PIN, HIGH);//auf HIGH setzen
    klappe1Timer micros()+anstellzeit;
  }
}
