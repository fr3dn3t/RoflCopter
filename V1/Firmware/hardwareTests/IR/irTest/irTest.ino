const int irPin = 22;
const int led = 13;


void setup() {
  Serial.begin(9600);
  pinMode(irPin, INPUT);
  pinMode(led, OUTPUT);
  //attachInterrupt(digitalPinToInterrupt(irPin), irRISING, RISING); 
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(digitalRead(irPin));
}

void irRISING() {
  digitalWrite(led, HIGH);
  detachInterrupt(digitalPinToInterrupt(irPin)); 
  attachInterrupt(digitalPinToInterrupt(irPin), irFALLING, FALLING); 
}

void irFALLING() {
  digitalWrite(led, LOW);
  detachInterrupt(digitalPinToInterrupt(irPin)); 
  attachInterrupt(digitalPinToInterrupt(irPin), irRISING, RISING); 
  }

