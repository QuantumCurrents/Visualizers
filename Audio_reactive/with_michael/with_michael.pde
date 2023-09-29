import netP5.*;
import oscP5.*;

OscP5 oscP5;

float loudness = 0;
float centroid = 0;

float col = 0;
float sz = 0;

int mode = 0;

void setup() {
  size(800, 800);
  //fullScreen();
  oscP5 = new OscP5(this, 7080);
}

void draw() {

  if (mode == 0) {
    background(0);
    noStroke();
    fill(col, 0, 255);
    circle(width/2, height/2, sz);
  } else if (mode == 1) {
    background(255, col, 0);
    fill(255);
    rect(width * 0.25, height * 0.25, width / 2, height /2);
  }
}

void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/loudness")) {
    loudness = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.checkAddrPattern("/centroid")) {
    centroid = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.checkAddrPattern("/midinote")) {

    int note = theOscMessage.get(0).intValue();
    int velocity = theOscMessage.get(1).intValue();

    if (note == 0) {
      mode = 0;
    } else if (note == 1) {
      mode = 1;
    } else {
      sz = map(note, 60, 68, 50, 500);
      col = map(velocity, 0, 127, 0, 255);
    }
  }
}
