#define HWSERIAL Serial2

void setup() {
  delay(2000);
  // put your setup code here, to run once:
  Serial.begin(115200);
  HWSERIAL.begin(9600);
}

void loop() {
    if (HWSERIAL.available()) {
      Serial.write(HWSERIAL.read());
      }
    
    if (Serial.available())
      HWSERIAL.write(Serial.read());
}
