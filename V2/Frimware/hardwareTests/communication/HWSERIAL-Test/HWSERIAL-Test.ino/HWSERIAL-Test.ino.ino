#define HWSERIAL Serial2

void setup() {
    // put your setup code here, to run once:
  Serial.begin(115200);
  HWSERIAL.begin(9600);
  pinMode(13, OUTPUT);
  delay(10000);
  //HWSERIAL.write("AT+CON884AEA6943F2");
  //HWSERIAL.write("AT+ROLE0");
  digitalWriteFast(13, HIGH);
}

void loop() {
    if (HWSERIAL.available()) {
      Serial.write(HWSERIAL.read());
      
      }
    
    if (Serial.available()) {
      HWSERIAL.write(Serial.read());
    }

      //HWSERIAL.println("hallo");

}

//884AEA6943F2 Dongle
//884AEA6942DA Copter
