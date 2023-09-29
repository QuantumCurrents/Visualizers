void setup() {
  size(400, 400);
}


void draw() {
  background(133, 240, 242);
  fill(255,255,255);
  int rectSize = frameCount*3;
  float rotation = frameCount*0.01;
  rectMode(CENTER);
  noStroke();
  
  for (int i = 0; i < 4; i++) {
    int mod = (i + 1) * 50;
    pushMatrix();
    translate(100*i, 100*i);
    rotate(rotation);
    rect(0, 0, rectSize%(mod+50), rectSize%(mod+25));
    popMatrix();
  }

  println(rectSize%150, rectSize%200);
}
