#define HWSERIAL Serial2

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  HWSERIAL.begin(9600);
  delay(2000);
  //HWSERIAL.print("AT+PASS?");
}

void loop() {
    if (HWSERIAL.available()) {
      Serial.write(HWSERIAL.read());
      HWSERIAL.println("Hallo");}
    
    if (Serial.available())
      HWSERIAL.write(Serial.read());
}
