import processing.serial.*;
Serial port;


//pos en y del jugador 1
float posY1;
//ubicacion del jugador1 en el centro
float ubicY1;

//pos en y del jugador 2
float posY2;
//ubicacion del jugador2 en el centro
float ubicY2;

//pos en x del jugador 3
float posX1;
//ubicacion del jugador3 en el centro
float ubicX1;


//pos en x del jugador 4
float posX2;
//ubicacion del jugador 4 en el centro
float ubicX2;


//ubicacion de la bola
float x=150;
float y=30;

//tamaño del jugador
int ancho=48;
int alto =200;

//dirección para el rebote de la bola
int dir=1;
int dir2=1;

//valores de los sensores de wiring como input
String sensores;
int pot1;
int pot2;
int pot3;
int pot4;

int vel = 5;

//--------------------------- Setup ---------------------------
void setup()
{
    size(1024, 768);
  
    noStroke();
  //port = new Serial(this, Serial.list()[1], 9600);
  port = new Serial(this, "/dev/cu.usbmodem14201", 9600); 
   
}


//------------------------Gráfica-----------------------------
void draw()
{
  //Color de fondo
  background(#26BA0C);

  //dibuja la bola
  stroke(255);
  fill(255);
  ellipse(x,y,15,15);

  //velocidad de la bola
  x=x+vel*dir;
  y=y+vel*dir2; 

  //si la bola se sale de la pantalla por la pared derecha, vuelva y aparesca desde la pared izquierda
  if(x>1024)  
  {
    x= width/2;    
    y = random (0,768);
  }
  
  //si la bola se sale de la pantalla por la pared izquierda, vuelva y aparesca desde la pared derecha
  if(x<0)
  {
    x= width/2;    
    y = random (0,768);
  }
  
  //Si sale por arriba aparece e nuevo
  if(y<0)
  {
    x= width/2;    
    y = random (0,768);
  }
  
  //Si sale por abajo aparece de nuevo
  if (y>768){
    x= width/2;    
    y = random (0,768);
  }


  
  //ubicacion del jugador con el sensor de wiring
  if (0 < port.available()) 
  { 
    
    //otra forma de enviar los datos a processing es no usando serial.write, sino serial.println, sin embargo en processing no se utiliza port.read(), sino port.readStringUntil('\n');
    sensores =  port.readStringUntil('\n'); //\n es lo mismo que el salto de linea del println  
        
    if(sensores != null) //Si no entra un null
    {
      println(sensores); //Se imprime la cadena de caracteres
      //se crea un arreglo que divide los datos y los guarda dentro del arreglo, para dividir los datos se hace con split cuando le llegue el caracter 'T',
      String[] datosSensor = split(sensores,'T'); //Split divide la cadena de caracteres por la T que escribimos en Arduino. 
      
      if(datosSensor.length == 4)
      {
        println(datosSensor[0]);
        println(datosSensor[1]);
        println(datosSensor[2]);
        println(datosSensor[3]);
        pot1 = int(trim(datosSensor[0])); //Trim elimina el espacio final     
        pot2 = int(trim(datosSensor[1])); //El parseo convierte nuestro valor String en una int 
        pot3 = int(trim(datosSensor[2]));
        pot4 = int(trim(datosSensor[3]));
      }     
    }
    
    posY1 = map(pot1,0,255,768,0);
    posY2 = map(pot2,0,255,768,0);
    posX1 = map(pot3,0,255,1024,0);
    posX2 = map (pot4,0,255,1024,0);
  
  }
  
  //jugar con el mouse
  //posY1 = mouseY;
  //posY1 = mouseY;
  //posX1 = mouseX;
  //posX2 = mouseX;
  
  // jugador 1
  ubicY1 = posY1-(alto/2);
  rect(0,ubicY1,ancho,alto);
  
  
  // jugador 2
  ubicY2 = posY2-(alto/2);
  rect(width-ancho,ubicY2,ancho,alto);
  
  
  //jugador 3
  ubicX1 = posX1-(ancho/2);
  rect(ubicX1,720,alto,ancho);
  
  
  //jugador 4  
  ubicX2 = posX2 - (ancho/2);
  rect(ubicX2,0,alto,ancho);

  //dibujar cancha
  strokeWeight(10); 
  noFill();
  stroke(255);
  rect(0,0,1024,768);

  //Rebote izquierda
  if(x > 0 && x <= ancho+20)
  {
    if(y >= posY1-alto && y <= posY1+alto )
    {
      dir *= -1;
    }
  }
  
  //Rebote derecha
  if(x <= width && x >= width-ancho-20)
  {
    if(y >= posY2-alto && y <= posY2+alto )
    {
      dir *= -1;
    }
  }
  
  
  //Rebote abajo
  
  if (y>720 && y>=ancho) {

    if (x>=posX1-alto && x <= posX1+alto) {
      dir2 = dir2*-1;
    }
  }
  
  //Rebote arriba
  if (y<alto && y <= ancho) {

    if (x>=posX2-alto && x <= posX2+alto) {
      dir2 = dir2*-1;
    }
  }
}
