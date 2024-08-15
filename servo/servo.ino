    int solenoidPin = 13; //This is the output pin on the Arduino
int doi;
#include <Servo.h>
#include <LiquidCrystal.h>

// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
const int rs = 4, en = 2, d4 = A0, d5 = A1, d6 = A2, d7 = A3;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

Servo myservo;  // create servo object to control a servo
// twelve servo objects can be created on most boards

int pos = 0;    // variable to store the servo position
void setup()
{
  Serial.begin(9600);
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object
  pinMode(solenoidPin, OUTPUT); //Sets that pin as an output
   // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
}
void loop()
{
if(Serial.available()>0)
{
    doi = Serial.read();
    //Serial.println(doi);
    //Serial.println("\n");
    //doi = doi - 48;
   if (doi == 1)
   {
    //Serial.println(1);
    digitalWrite(solenoidPin, HIGH); //Switch Solenoid ON
    //delay(1000); //Wait .15 Second
     //digitalWrite(solenoidPin, LOW);
     for (pos = 0; pos <= 180; pos += 1) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
    myservo.write(pos);              // tell servo to go to position in variable 'pos'
    delay(15);                       // waits 15ms for the servo to reach the position
    
  }
  lcd.print("unlocked!");


  delay(3000);
 

  for (pos = 180; pos>=0; pos -= 1) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
    myservo.write(pos);              // tell servo to go to position in variable 'pos'
    delay(15);                       // waits 15ms for the servo to reach the position
    
  }
  digitalWrite(solenoidPin, LOW);
  lcd.clear();
  lcd.print("locked!");
  delay(3000);
  lcd.clear();
  
    }
  else 
    {
       lcd.print("Wrong!");
       lcd.setCursor(0, 1);
       lcd.print("Try again!");
       delay(2000);
       lcd.clear();
    }
}
}
