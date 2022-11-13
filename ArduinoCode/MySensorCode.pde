const int pingPin = 7;
const int pingPin1 = 6;
const int pingPin2 = 5;
const int pingPin3 = 4;
const int pingPin4 = 3;
const int pingPin5 = 2;
int ledPin =  13;

void setup() {

  Serial.begin(115200);
  pinMode(ledPin, OUTPUT);  
}

void loop()
{
  digitalWrite(ledPin, HIGH);   // set the LED on

  long duration, cm, duration1, cm1, duration2, cm2, duration3, cm3, duration4, cm4, duration5, cm5;

  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);
  
  pinMode(pingPin1, OUTPUT);
  digitalWrite(pingPin1, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin1, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin1, LOW);

  pinMode(pingPin1, INPUT);
  duration1 = pulseIn(pingPin1, HIGH);

  pinMode(pingPin2, OUTPUT);
  digitalWrite(pingPin2, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin2, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin2, LOW);

  pinMode(pingPin2, INPUT);
  duration2 = pulseIn(pingPin2, HIGH);
  
  pinMode(pingPin3, OUTPUT);
  digitalWrite(pingPin3, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin3, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin3, LOW);

  pinMode(pingPin3, INPUT);
  duration3 = pulseIn(pingPin3, HIGH);

  pinMode(pingPin4, OUTPUT);
  digitalWrite(pingPin4, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin4, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin4, LOW);

  pinMode(pingPin4, INPUT);
  duration4 = pulseIn(pingPin4, HIGH);

  pinMode(pingPin5, OUTPUT);
  digitalWrite(pingPin5, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin5, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin5, LOW);

  pinMode(pingPin5, INPUT);
  duration5 = pulseIn(pingPin5, HIGH);


  cm = microsecondsToCentimeters(duration);
  cm1 = microsecondsToCentimeters(duration1);
  cm2 = microsecondsToCentimeters(duration2);
  cm3 = microsecondsToCentimeters(duration3);
  cm4 = microsecondsToCentimeters(duration4);
  cm5 = microsecondsToCentimeters(duration5);
  
  Serial.print(cm);
  Serial.print(" "); 
  Serial.print(cm1);
  Serial.print(" "); 
  Serial.print(cm2);
  Serial.print(" "); 
  Serial.print(cm3);
  Serial.print(" "); 
  Serial.print(cm4);
  Serial.print(" "); 
  Serial.print(cm5);
  Serial.println();
  delay(10);
}

long microsecondsToCentimeters(long microseconds)
{
  return microseconds / 29 / 2;
}
