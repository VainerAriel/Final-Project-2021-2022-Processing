///////////////////////////////////////////////////////////////////////////////////// //<>// //<>//
// Name: Ariel Vainer                                                              //
// Date: 28/01/22                                                                  //
// Description: this program runs three different games in one program             //
/////////////////////////////////////////////////////////////////////////////////////

import java.util.*;
import processing.sound.*;

SoundFile song;

final int AMOUNT_OF_GAMES = 3;

// main variables
boolean[] game = new boolean[AMOUNT_OF_GAMES];
boolean mainMenu = true, savedImg=true;
PImage fS, fpS, snS, save, saved, loadingImg;
PImage[] sound = new PImage[4];
float i = 3;
int[] games = new int[3];

void setup() {
  size(700, 650);
  thread("loadingScreen"); // loading screen

  loadingImg = loadImage("loading.jpg");
}
void draw() {
  if (!loading) {
    background(255);

    song.amp(i/3); // sound

    if (!mainMenu) { // changing between games
      if (game[0]) {
        background(255);
        frameRate(60);
        fDraw();
      } else if (game[1]) {
        frameRate(60);
        fpDraw();
      } else if (game[2]) {
        frameRate(60);
        snDraw();
      }
      tint(255);
    } else { // main menu
      mainmenu();
    }
  } else {
    // loading screen
    background(255, 238, 228);
    imageMode(CENTER);
    image(loadingImg, 350, 225);

    noFill();
    rect(72, 472, 556, 56);
    fill(0);
    rect(75, 475, (counter*550)/40, 50);
  }
}
void keyPressed() {
  // different game keys
  if (!loading) {
    if (!mainMenu) {
      if (game[1]) {
        fpKeys();
      } else if (game[2]) {
        snKeys();
      }
    }
  }
}
void mouseReleased() {
  // different game presses
  if (!loading) {
    if (!mainMenu) {
      // pressing the buttons to turn to a certein color
      if (game[0]) {
        fMouse();
      } else if (game[1]) {
        fpMouse();
      } else if (game[2]) {
        snMouse();
      }
    } else {
      mainMouse();
    }
  }
}

void mainmenu() {
  // games menu
  
  tint(255, games[0]);
  image(fS, 0, 0);

  tint(255, games[1]);
  image(fpS, 0, 175);

  tint(255, games[2]);
  image(snS, 0, 350);

  fill(0, games[0]+50);
  textFont(f, 125);
  textAlign(CENTER);
  text("Filler", 350, 125);

  fill(0, games[1]+50);
  textSize(75);
  text("Flappy Panda", 350, 275);

  fill(0, games[2]+50);
  textSize(125);
  text("Snake", 350, 465);

  fill(255);
  strokeWeight(3);
  rect(50, 525, 100, 100);
  rect(550, 525, 100, 100);

  if (button(0, 0, 700, 150)) {
    games[0] = 100;
  } else {
    games[0] = 200;
  }
  if (button(0, 175, 700, 150)) {
    games[1] = 100;
  } else {
    games[1] = 200;
  }
  if (button(0, 350, 700, 150)) {
    games[2] = 100;
  } else {
    games[2] = 200;
  }
  imageMode(CENTER);

  tint(255, 255);
  if (savedImg) {
    image(saved, 100, 575, 75, 75);
  } else {
    image(save, 100, 575, 75, 75);
  }

  image(sound[(int)i], 600, 575, 90, 90);
  imageMode(CORNER);
}

void mainMouse() {
  // buttons
  if (button(0, 0, 700, 150)) {
    mainMenu = false;
    menu1 = true;
    game[0] = true;
    game[1] = false;
    game[2] = false;
  }
  if (button(0, 175, 700, 150)) {
    mainMenu = false;
    menu = true;
    game[0] = false;
    game[1] = true;
    game[2] = false;
  }
  if (button(0, 350, 700, 150)) {
    mainMenu = false;
    snMenu = true;
    game[0] = false;
    game[1] = false;
    game[2] = true;
  }
  if (button(50, 525, 100, 100)) {
    createSave();
    savedImg = true;
  }
  if (button(550, 525, 100, 100)) {
    i=(i+1)%4;
  }
}
boolean button(int x, int y, int w, int h) {
  if (mouseX>=x && mouseX<=x+w && mouseY>=y && mouseY<=y+h) {
    return true;
  } else {
    return false;
  }
}
