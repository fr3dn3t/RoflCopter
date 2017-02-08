#define HWSERIAL Serial1

const int klappe1 = 23;
int downCounter = 1000;
int i=100;
int u=200;
int e=250;


void setup() {
  pinMode(klappe1, OUTPUT);
  HWSERIAL.begin(9600);
}

void loop() {
  if(HWSERIAL.available()) {
    while(downCounter>4) {
      digitalWrite(klappe1, HIGH);
      delay(downCounter/2);
      digitalWrite(klappe1, LOW);
      delay(downCounter*2);
  
      downCounter = downCounter - (downCounter/3);
    }

    while(i>1) {
      digitalWrite(klappe1, HIGH);
      delay(4);
      digitalWrite(klappe1, LOW);
      delay(9);
      i--;
    }

    
    while(u>1) {
      digitalWrite(klappe1, HIGH);
      delay(4);
      digitalWrite(klappe1, LOW);
      delay(8);
      u--;
    }

    while(e>1) {
      digitalWrite(klappe1, HIGH);
      delay(4);
      digitalWrite(klappe1, LOW);
      delay(7);
      e--;
    }
  
  }
}
