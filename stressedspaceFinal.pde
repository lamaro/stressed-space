import ddf.minim.*;
import processing.serial.*;
String val;
Serial myPort;  // The serial port
Minim minim;
AudioPlayer player;
AudioPlayer playerStress;
static final int FADE = 2500;


void setup() {
  background(255);
  size(800,200);
  minim = new Minim(this);
  player = minim.loadFile("audiovoz.mp3");
  playerStress = minim.loadFile("audio_stress1.mp3");
  myPort = new Serial(this, Serial.list()[1], 115200);
  printArray(Serial.list());
  player.play();
  playerStress.play();
}

void draw() {
  background(255);
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, width );
    float x2 = map( i+1, 0, player.bufferSize(), 0, width );
    line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
    line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
  }
  float f = 233;
  while (myPort.available() > 0) {
    
    val = myPort.readStringUntil('\n');
    if (val != null){
      f = float(val);
      println(f);
      float volumen = map(f,0,233,100,-100);
      playerStress.shiftGain(playerStress.getGain(),volumen,FADE);
    }
  }
}
