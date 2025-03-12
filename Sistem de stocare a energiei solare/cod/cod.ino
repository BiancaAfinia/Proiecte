#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);

#include <BH1750.h>
BH1750 lightMeter;

#include <dht11.h>    //include codul bibliotecii:
dht11 DHT;
#define DHT11_PIN 7  //definiți DHT11 ca pin digital 7
#include <Servo.h>
Servo lr_servo;//definește numele servomotorului care se rotește la dreapta și la stânga
Servo ud_servo;//definește numele servomotorului care se rotește în sus și în jos

const byte interruptPin = 2; //pinul butonului; corupția este întreruptă

int lr_angle = 90;//setați unghiul inițial la 90 de grade
int ud_angle = 10;//setați unghiul inițial la 10 grade; păstrați panourile solare în poziție verticală pentru a detecta cea mai puternică lumină
int l_state = A0;//definiți intrarea analogică de tensiune a fotorezistorilor
int r_state = A1;
int u_state = A2;
int d_state = A3;
const byte buzzer = 6;  //setați buzzerul la pinul digital 6
const byte lr_servopin = 9;//definiți semnalul de control al servo-rotative dreapta și stanga
const byte ud_servopin = 10;//definește  semnalul de comandă al servomotorului rotativ în sensul acelor de ceasornic și în sensul invers acelor de ceasornic 

unsigned int light; //salvați variabila intensității luminii
byte error = 15;//Definiți intervalul de eroare pentru a preveni vibrațiile
byte m_speed = 10;//setați timpul de întârziere pentru a regla viteza servo; cu cât timpul este mai lung, cu atât viteza este mai mică
byte resolution = 1;   //setați precizia de rotație a servomotorului, unghiul minim de rotație 
int temperature;  //salvați variabila de temperatură
int humidity; //salvați variabila de umiditate

void setup() {
  Serial.begin(9600); //definiți rata de baud serială
  // Inițializarea I2C (Biblioteca BH1750 nu face acest lucru automat)
  Wire.begin();
  lightMeter.begin();

  lr_servo.attach(lr_servopin);  // setaţi pinul de control al servo
  ud_servo.attach(ud_servopin);   // setaţi pinul de control al servo
  pinMode(l_state, INPUT); //setați modul de pin
  pinMode(r_state, INPUT);
  pinMode(u_state, INPUT);
  pinMode(d_state, INPUT);

  pinMode(interruptPin, INPUT_PULLUP);  //pinul butonului este setat la modul pull-up de intrare
  attachInterrupt(digitalPinToInterrupt(interruptPin), adjust_resolution, FALLING); //xternal interrupt touch type is falling edge; adjust_resolution is interrupt service function ISR

  lcd.init();          // inițializați ecranul LCD
  lcd.backlight();     //set lumina de fundal LCD

  lr_servo.write(lr_angle);//reveniți la unghiul inițial
  delay(1000);
  ud_servo.write(ud_angle);
  delay(1000);

}

void loop() {
  ServoAction();  //servo efectuează acțiunea
  read_light(); //citiți intensitatea luminii de bh1750
  read_dht11(); //citiți valoarea temperaturii și umidității
  LcdShowValue(); //Lcd afișează valorile intensității luminii, temperaturii și umidității

  //serial monitor displays the resistance of the photoresistor and the angle of servo
  /*Serial.print(" L ");
  Serial.print(L);
  Serial.print(" R ");
  Serial.print(R);
  Serial.print("  U ");
  Serial.print(U);
  Serial.print(" D ");
  Serial.print(D);
  Serial.print("  ud_angle ");
  Serial.print(ud_angle);
  Serial.print("  lr_angle ");
  Serial.println(lr_angle);*/
  //  delay(1000);//During the test, the serial port data is received too fast, and it can be adjusted by adding delay time */
}

/**********Funcția servo************/
void ServoAction(){
  int L = analogRead(l_state);//citiți valoarea analogică a tensiunii senzorului, 0-1023
  int R = analogRead(r_state);
  int U = analogRead(u_state);
  int D = analogRead(d_state);
  /**********************sistem de ajustare la stânga și la dreapta**********************/
  //  abs() este funcția de valoare absolută
  if (abs(L - R) > error && L > R) { //Determinați dacă eroarea se încadrează în intervalul acceptabil, altfel reglați transmisia de direcție
    lr_angle -= resolution;//reduce unghiul
    //    lr_servo.attach(lr_servopin);  // connect servo
    if (lr_angle < 0) { //limita unghiul de rotație al servo
      lr_angle = 0;
    }
    lr_servo.write(lr_angle);  //ieşi unghiul de servoiepuneţi unghiul de servo
    delay(m_speed);

  }
  else if (abs(L - R) > error && L < R) { //Determinați dacă eroarea se încadrează în intervalul acceptabil, altfel reglați transmisia de direcție
    lr_angle += resolution;//incrementeaza unghiul
    //    lr_servo.attach(lr_servopin);    // connect servo
    if (lr_angle > 180) { //limita unghiul de rotație al servo
      lr_angle = 180;
    }
    lr_servo.write(lr_angle);  //ieșirea unghiul de servo
    delay(m_speed);

  }
  else if (abs(L - R) <= error) { //Determinați dacă eroarea se încadrează în intervalul acceptabil, altfel reglați transmisia de direcție
    //    lr_servo.detach(); //eliberează pinul servo
    lr_servo.write(lr_angle); //ieșirea unghiul de servo
  }
  /**********************Sistemul de ajustare în sus și în jos**********************/
  if (abs(U - D) > error && U >= D) { //Determinați dacă eroarea se încadrează în intervalul acceptabil, altfel reglați transmisia de direcție
    ud_angle -= resolution;//reduce unghiul
    //    ud_servo.attach(ud_servopin);  // connect servo
    if (ud_angle < 10) { //limita unghiul de rotație al servo
      ud_angle = 10;
    }
    ud_servo.write(ud_angle);   //ieșirea unghiul de servo
    delay(m_speed);

  }
  else if (abs(U - D) > error && U < D) { //Determinați dacă eroarea se încadrează în intervalul acceptabil, altfel reglați transmisia de direcție
      ud_angle += resolution;//incrementeaza unghiul
    //    ud_servo.attach(ud_servopin);  // connect servo
    if (ud_angle > 90) { //limita unghiul de rotație al servo
      ud_angle = 90;
    }
    ud_servo.write(ud_angle);  //ieșirea unghiul de servo
    delay(m_speed);

  }
  else if (abs(U - D) <= error) { //Determinați dacă eroarea se încadrează în intervalul acceptabil. Dacă este, păstrați-l stabil și nu faceți nicio schimbare în unghi
    //    ud_servo.detach(); //eliberează pinul servo
    ud_servo.write(ud_angle); //ieșirea unghiul de servo
  }
}

void LcdShowValue() {
  char str1[5];
  char str2[2];
  char str3[2];
  dtostrf(light, -5, 0, str1); //Formați datele valorii luminii ca șir, aliniat la stânga
  dtostrf(temperature, -2, 0, str2);
  dtostrf(humidity, -2, 0, str3);
  //LCD1602 display
  //afişează valoarea intensităţii luminii
  lcd.setCursor(0, 0);
  lcd.print("Lumina:");
  lcd.setCursor(7, 0);
  lcd.print(str1);
  lcd.setCursor(11, 0);
  lcd.print("       ");
  
  //afişarea valorii temperaturii şi umidităţii
   lcd.setCursor(0, 1);
  lcd.print("T=");
  lcd.setCursor(2, 1);
  lcd.print(temperature);
  lcd.setCursor(4, 1);
  lcd.print("C");
   lcd.setCursor(6, 1);
  lcd.print("U=");
  lcd.setCursor(8, 1);
  lcd.print(humidity);
  lcd.setCursor(10, 1);
  lcd.print("%");

  //arată precizia rotației
  lcd.setCursor(13, 1);
  lcd.print("V=");
  lcd.setCursor(15, 1);
  lcd.print(resolution);
  /*if (light < 10) {
    lcd.setCursor(7, 0);
    lcd.print("        ");
    lcd.setCursor(6, 0);
    lcd.print(light);
    } else if (light < 100) {
    lcd.setCursor(8, 0);
    lcd.print("       ");
    lcd.setCursor(6, 0);
    lcd.print(light);
    } else if (light < 1000) {
    lcd.setCursor(9, 0);
    lcd.print("      ");
    lcd.setCursor(6, 0);
    lcd.print(light);
    } else if (light < 10000) {
    lcd.setCursor(9, 0);
    lcd.print("      ");
    lcd.setCursor(6, 0);
    lcd.print(light);
    } else if (light < 100000) {
    lcd.setCursor(10, 0);
    lcd.print("     ");
    lcd.setCursor(6, 0);
    lcd.print(light);
    }*/
}

void read_light(){
  light = lightMeter.readLightLevel();  //citiți intensitatea luminii detectată de BH1750
}

void read_dht11(){
  int chk;
  chk = DHT.read(DHT11_PIN);      // citeste data
  switch (chk) {
    case DHTLIB_OK:
      break;
    case DHTLIB_ERROR_CHECKSUM:   //verificaţi şi returnaţi eroarea
      break;
    case DHTLIB_ERROR_TIMEOUT:    //Timeout și eroare de returnare
      break;
    default:
      break;
  }
  temperature = DHT.temperature;
  humidity = DHT.humidity;
}

/*********Funcția care perturbă serviciul**************/
void adjust_resolution() {
  tone(buzzer, 800, 100);
  delay(10);  //întârziere pentru eliminarea vibrațiilor
  if (!digitalRead(interruptPin)){
    if(resolution < 3){
      resolution++;
    }else{
      resolution = 1;
    }
  }
}
