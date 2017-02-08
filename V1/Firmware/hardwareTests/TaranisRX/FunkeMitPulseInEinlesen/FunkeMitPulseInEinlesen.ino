#define HWSERIAL Serial1

int ch1 = 14;
int ch2 = 15;
int ch3 = 16;
int ch4 = 17;
int ch5 = 20;

void setup() {
        HWSERIAL.begin(9600);
        pinMode(13,OUTPUT);
        pinMode(ch1,INPUT);
        pinMode(ch2,INPUT);
        pinMode(ch3,INPUT);
        pinMode(ch4,INPUT);
        pinMode(ch5,INPUT);
}

void loop() {
              for(int i=10;i>1;i--) {
                digitalWrite(13, HIGH);
                HWSERIAL.println(i);
                delay(500);
                digitalWrite(13, LOW);
                delay(500);
              }
                int ch1Data=0;
               // int ch2Data=0;
                //int ch3Data=0;
                //int ch4Data=0;
               // int ch5Data=0;
                digitalWrite(13, HIGH);
              int pre = millis();
              for(int i=0;i<100;i++) {
                ch1Data=pulseIn(ch1,HIGH);
                //ch2Data=pulseIn(ch2,HIGH);
               // ch3Data=pulseIn(ch3,HIGH);
                //ch4Data=pulseIn(ch4,HIGH);
               // ch5Data=pulseIn(ch5,HIGH);
              }
              int post = millis();
              int diff = post-pre;
              diff = diff/100;
                HWSERIAL.println("CH1 Data"+ch1Data);
                //HWSERIAL.println("CH2 Data"+ch2Data);
                //HWSERIAL.println("CH3 Data"+ch3Data);
                //HWSERIAL.println("CH4 Data"+ch4Data);
                //HWSERIAL.println("CH5 Data"+ch5Data);
                HWSERIAL.println("Time"+(int)diff);
                digitalWrite(13,LOW);
                delay(50000);
}

