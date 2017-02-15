#define HWSERIAL Serial2

void setup() {
  delay(2000);
  // put your setup code here, to run once:
  Serial.begin(115200);
  HWSERIAL.begin(9600);
  pinMode(13, OUTPUT);
  delay(2000);
  HWSERIAL.write("AT+ROLE0");
}

void loop() {
    if (HWSERIAL.available()) {
      Serial.write(HWSERIAL.read());
      digitalWriteFast(13, HIGH);
      }
    
    if (Serial.available())
      HWSERIAL.write(Serial.read());

   HWSERIAL.println("hallo");
   delay(1000);
}
