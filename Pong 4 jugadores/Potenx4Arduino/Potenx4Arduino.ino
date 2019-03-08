//sensores analogos
//Aca se guardan los valores del potenciometro
int sensorValue;
int sensorValue2;
int sensorValue3;
int sensorValue4;

//En donde se conecta el potenciometro
int inputPin = A0;
int inputPin2 = A1;
int inputPin3 = A2;
int inputPin4 = A3;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  //al dividirlo entre 4 me bota datos de 0-255 y no de 0-1023 que es lo normal
  sensorValue = analogRead(inputPin) / 4;
  sensorValue2 = analogRead(inputPin2) / 4;
  sensorValue3 = analogRead(inputPin3) / 4;
  sensorValue4 = analogRead(inputPin4) / 4;

  //imprimo el dato en consola DEC para poderlo ver yo, Byte para ke lo vea la makina, solo se imprime cuando no se este usando serial.write
  //Serial.println(sensorValue, DEC);
  //Serial.println(sensorValue2, DEC);
  //Serial.println(sensorValue3, DEC);
  //Serial.println(sensorValue4, DEC);

  // enviar el dato, no se debe usar cuando se use seriasl.print
  //Serial.write(sensorValue);
  Serial.print(sensorValue); //Esto para datos analogos
  Serial.print('T');
  Serial.print(sensorValue2);
  Serial.print('T');
  Serial.print(sensorValue3);
  Serial.print('T');
  Serial.print(sensorValue4);
  Serial.println();


  //cada 100 me envia el dato
  delay(100);
}
