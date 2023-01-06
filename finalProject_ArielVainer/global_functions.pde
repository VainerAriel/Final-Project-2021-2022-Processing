void menu(PImage img, String gameName, int size, int spacing, int y) {
  background(255);
  tint(255, 175);
  image(img, 0, 0);
  textFont(f, size);
  textAlign(CENTER);
  fill(0);
  textLeading(spacing);
  text(gameName, 350, y);

  textSize(button[0]);
  text("Play", 350, 385);

  if (button(50, 300, 600, 125)) {
    button[0] = 90;
  } else { 
    button[0] = 80;
  }

  textSize(button[1]);
  text("Instructions", 350, 565);

  if (button(50, 475, 600, 125)) {
    button[1] = 90;
  } else { 
    button[1] = 80;
  }

  stroke(0);
  strokeWeight(10);
  noFill();
  rect(50, 300, 600, 125);
  rect(50, 475, 600, 125);

  tint(255, 255);
  imageMode(CENTER);
  image(x, 675, 25, 40, 40);
  imageMode(CORNER);
}
void instructions(PImage img, String gameName, int size, String inst, boolean white, int minusY, int plusY, int shorter) {
  background(255);
  tint(255, 175);
  image(img, 0, 0);

  fill(255);
  noStroke();
  if (white) {
    rect(50, 100+plusY, 600, 550-shorter);
  }
  textFont(f, size);
  textAlign(CENTER);
  fill(0);
  text(gameName, 350, 90-minusY);

  textSize(25);
  textLeading(50);
  text(inst, 350, 135+plusY);

  tint(255, 255);
  imageMode(CENTER);
  image(x, 675, 25, 40, 40);
  imageMode(CORNER);
}
