boolean loading = true;
int counter = 0;
float angle = 0;
void loadingScreen() {
  fSetup();
  fpSetup();
  snSetup();

  readSave();

  song = new SoundFile(this, "song.mp3");
  counter++;
  fS = loadImage("fillerMenuSmall.png");
  counter++;
  fpS = loadImage("flappyPandaSmall.png");
  counter++;
  snS = loadImage("snakeGameSmall.png");
  counter++;
  save = loadImage("save.png");
  counter++;
  saved = loadImage("saved.png");
  counter++;

  for (int i = 0; i<sound.length; i++) {
    sound[i] = loadImage((i+1)+".jpg");
    counter++;
  }

  song.loop();
  loading = false;
}
void drawCircle(float centerX, float centerY, int radius, int numPoints, color startColor, color endColor) {
  for (int i = 0; i < numPoints; i = i + 1) {
    float x = centerX + radius * cos(angle);
    float y = centerY + radius * sin(angle);

    color clr = lerpColor(startColor, endColor, i / numPoints);
    stroke(clr);
    point(x, y);

    angle = angle + TWO_PI / numPoints;
  }
}
