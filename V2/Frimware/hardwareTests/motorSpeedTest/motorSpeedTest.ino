  #include <Servo.h>

    #define escPin   18

    Servo regler;

void setup() {
 regler.attach(escPin);
    regler.write(0);
    delay(5000);
    regler.write(180);
    delay(2000);
    regler.write(132);
    delay(2000);
    regler.write(0);
}

void loop() {
  // put your main code here, to run repeatedly:

}
