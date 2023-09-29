import netP5.*;
import oscP5.*;

OscP5 oscP5;

float col = 0;
float sz = 0;
float pan = 0;
float loudness = 0;
float[] leftArray;
float[] rightArray;

void setup() {
  leftArray = new float[1499];
  rightArray = new float[1499];
  size(1200, 800);
  oscP5 = new OscP5(this, 7080);
}

void draw() {
  background(0);
  
  noStroke();
  fill(col,0,255);
  circle(width/2, height/2, sz);
  fill(200 - loudness * 100, loudness * 50,loudness * 255);
  circle(width*pan, height/2, loudness * width * 0.3);

}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  if (theOscMessage.checkAddrPattern("/midinote")) {
    int note = theOscMessage.get(0).intValue();
    int velo = theOscMessage.get(1).intValue();
    sz = map(note,30,90,50,500);
    col = map(velo,0,127,0,255);
  } else if (theOscMessage.checkAddrPattern("/pan")) {
    pan = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.checkAddrPattern("/loudness")) {
    loudness = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.checkAddrPattern("/waveformL")) {
    for(int i = 0; i < 1499; i++) {
      leftArray[i] = theOscMessage.get(i).floatValue();
    } 
  }
}
