void IRFalling() {
  digitalWrite(13, HIGH);
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(22, INPUT);
  attachInterrupt(digitalPinToInterrupt(22), IRFalling, FALLING);
  pinMode(13, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(digitalRead(22));
  digitalWrite(13, LOW);
  delay(500);
}
