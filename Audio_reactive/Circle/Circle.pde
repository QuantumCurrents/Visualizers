import netP5.*;
import oscP5.*;

OscP5 oscP5;

float loudness = 0, loudnessLRDiff = 0, centroid = 0;

void setup() {
  size(1200, 800);
  oscP5 = new OscP5(this, 7080);
}

void draw() {
  background(loudness * 100, loudness * 10, loudness * 120);

  noStroke();
  fill(200 - loudness * 100, loudness * 50,loudness * 255);
  circle(width/2 - width*loudnessLRDiff*0.7, height/2, loudness * width * 0.3);
  circle(width/2 + width*loudnessLRDiff*0.7, height/2, loudness * width * 0.3);
  //fill(200 - centroid * 100, centroid * 50,180 - centroid * 120);
  circle(width/2, height - height*centroid, loudness * width * 0.6);
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  if (theOscMessage.checkAddrPattern("/loudness")) {
    loudness = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.checkAddrPattern("/loudnessLRDiff")) {
    loudnessLRDiff = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.checkAddrPattern("/centroid")) {
    centroid = theOscMessage.get(0).floatValue();
  }
}
