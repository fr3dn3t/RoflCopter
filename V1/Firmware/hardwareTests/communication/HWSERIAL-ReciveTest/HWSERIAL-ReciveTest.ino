#define HWSERIAL Serial2

void setup() {
  // put your setup code here, to run once:
HWSERIAL.begin(9600);
pinMode(13, OUTPUT);
}

void loop() {
  if (HWSERIAL.available()) {
    digitalWrite(13, HIGH);
  }
}

