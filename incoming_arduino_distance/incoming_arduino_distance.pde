import processing.serial.*;
import processing.video.*;
Movie myMovie;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port


void setup() {
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  fullScreen();
  myMovie = new Movie(this, "sound.mp4");
  myMovie.loop();  
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); 

}

int threshhold = 20;

void draw()
{
  if ( myPort.available() > 0) 
  {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  print(val); //print it out in the console
  print(" is ");
  if (val != null) {
    String trimmedVal = trim(val);
    if (!trimmedVal.equals(null) && !trimmedVal.equals("")) {    
      
      
      int integerVal = Integer.parseInt(trimmedVal);
      println(integerVal);
      if (integerVal < threshhold) {
       image(myMovie, 0, 0, width, height);
      } else {
        
       background(0);
       noStroke();
       fill(0);
       rect(0, 0, width, height); 
      }
      //background(0);
      //textSize(32);
      //text(integerVal, 10, 30); 
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}