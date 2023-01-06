final int squareSize = 50; // squareSize

int[] colors = new int[6]; // color list
int[] button = new int[5];
int[] Colors = 
  {#954b88, 
  #ffaa47, 
  #ffdf50, 
  #ff538d, 
  #b9de39, 
  #44a6a9};

Square[][] square = new Square[10][10];  // grid
Square[] down = new Square[6]; // buttons 
Square[] neighborsSelf = new Square[4]; // neighbors of left side
Square[] neighborsOther = new Square[4]; // neighbors of right side
Square[] neighbors = new Square[4]; // making the grid shuffled

ArrayList<Square> sameColorSelf = new ArrayList(); // left group
ArrayList<Square> sameColorOther = new ArrayList(); // right group

boolean fTurn = true, gameWon, menu1 = true, instructions, fillerGame; // left side, gameWon, and menu
PImage no, fillerMenu, x; // photos
PFont f;

void fSetup() {
  // filler setup
  no = loadImage("no.jpg");
  counter++;
  x = loadImage("no.png");
  counter++;
  fillerMenu = loadImage("fillerMenu.tif");
  counter++;
  f = createFont("f.ttf", 15);
  counter++;

  for ( int i = 0; i<button.length; i++) {
    if (i<2) {
      button[i] = 80;
    }
    if (i<5) {
      button[i] = 40;
    }
  }

  fGrid();
  fFairness();
  fDownButtons();
}
void fGrid() {
  // making a random grid
  for (int i = 0; i<square.length; i++) {
    for (int j = 0; j<square.length; j++) {
      square[i][j] = new Square((i*squareSize), (j*squareSize), Colors[int(random(Colors.length))]);
    }
  }
  for (int i = 0; i<square.length; i++) {
    for (int j = 0; j<square.length; j++) {
      if (i>0) {
        neighbors[0] = square[i-1][j];
        while (neighbors[0].Color == square[i][j].Color) {
          square[i][j].Color = Colors[int(random(Colors.length))];
        }
      }
      if (i<(500/squareSize)-1) {
        neighbors[1] = square[i+1][j];
        while (neighbors[1].Color == square[i][j].Color) {
          square[i][j].Color = Colors[int(random(Colors.length))];
        }
      }
      if (j>0) {
        neighbors[2] = square[i][j-1];
        while (neighbors[2].Color == square[i][j].Color) {
          square[i][j].Color = Colors[int(random(Colors.length))];
        }
      }
      if (j<((500)/squareSize)-1) {
        neighbors[3] = square[i][j+1];
        while (neighbors[3].Color == square[i][j].Color) {
          square[i][j].Color = Colors[int(random(Colors.length))];
        }
      }
    }
  }
}
void fFairness() { 
  // making colors near it be different
  while (square[1][9].Color == square[0][9].Color) {
    square[1][9].Color = Colors[int(random(Colors.length))];
  }
  while (square[0][8].Color == square[0][9].Color) {
    square[0][8].Color = Colors[int(random(Colors.length))];
  }

  while (square[8][0].Color == square[9][0].Color) {
    square[8][0].Color = Colors[int(random(Colors.length))];
  }
  while (square[9][1].Color == square[9][0].Color) {
    square[9][1].Color = Colors[int(random(Colors.length))];
  }

  // making the array lists
  sameColorSelf.add(square[0][9]);
  sameColorOther.add(square[9][0]);

  // making sure the colors of the two players are not the same
  for (Square temp : sameColorSelf) {
    temp.setColor(Colors[int(random(Colors.length))]);
  }
  for (Square temp : sameColorOther) {
    Square self = sameColorSelf.get(0);
    while (self.Color == temp.Color) {
      temp.setColor(Colors[int(random(Colors.length))]);
    }
  }
}
void fDownButtons() {
  // making the buttons
  for (int i =0; i<down.length; i++) {
    down[i] = new Square(10+i*85, 530, Colors[i]);
  }
}
void fTwoPlayersOutline(ArrayList<Square> name) {
  for (Square a : name) {
    stroke(0);
    a.show();

    strokeWeight(7);
    stroke(255);
    line(0, 500, 500, 500);
    line(0, 0, 500, 0);
    line(0, 0, 0, 500);
    line(500, 0, 500, 500);
    strokeWeight(5);
  }
}

void fChangeNeighbors(ArrayList<Square> name, Square[] neighborName, int i, int j) {
  // checking if the colors of the neighbors is the same as your color
  for (int k = 0; k<name.size(); k++) {
    Square a = name.get(k);
    if (square[i][j] == a) {
      if (i>0) {
        neighborName[0] = square[i-1][j];
        if (neighborName[0].Color == square[i][j].Color) {
          name.add(neighborName[0]);
        }
      }
      if (i<(500/squareSize)-1) {
        neighborName[1] = square[i+1][j];
        if (neighborName[1].Color == square[i][j].Color) {
          name.add(neighborName[1]);
        }
      }
      if (j>0) {
        neighborName[2] = square[i][j-1];
        if (neighborName[2].Color == square[i][j].Color) {
          name.add(neighborName[2]);
        }
      }
      if (j<((500)/squareSize)-1) {
        neighborName[3] = square[i][j+1];
        if (neighborName[3].Color == square[i][j].Color) {
          name.add(neighborName[3]);
        }
      }
      stroke(0);
      square[i][j].show();
    }
  }
}
void fChangingColors() {
  // change the colors of the areas
  for (int i = 0; i<square.length; i++) {
    for (int j = 0; j<square.length; j++) {
      stroke(255);
      square[i][j].show();
      fChangeNeighbors(sameColorSelf, neighborsSelf, i, j);
      fChangeNeighbors(sameColorOther, neighborsOther, i, j);

      Set<Square> setSelf = new HashSet(sameColorSelf);
      Set<Square> setOther = new HashSet(sameColorOther);
      sameColorSelf.clear();
      sameColorOther.clear();
      sameColorSelf.addAll(setSelf);
      sameColorOther.addAll(setOther);
    }
  }
}
void fChangingButtons() {
  // buttons
  for (int i =0; i<down.length; i++) {
    stroke(0);
    strokeWeight(5);

    if (fTurn) {
      if (down[i].Color==square[0][9].Color || down[i].Color==square[9][0].Color) {
        down[i].showBlack();
      } else {
        down[i].show();
      }
    } else {
      if (down[i].Color==square[0][9].Color || down[i].Color==square[9][0].Color) {
        down[i].showBlack();
      } else {
        down[i].show();
      }
    }
  }
}

void fDraw() {
  if (!menu1 && !instructions) {
    fillerGame = true;
  } else {
    fillerGame = false;
  }
  if (menu1) {
    menu(fillerMenu, "Filler", 200, 50, 200);
  }
  if (instructions) {
    String instructions = 
      "Filler is a one-on-one game.\n"+
      "Each participant starts at one of the\n"+
      "map's corners at the start of the game.\n"+
      "To win, you must control the bigger\n"+
      "part of the map. The player must choose\n"+
      "one of the colours by clicking on one\n"+
      "of the squares in order to grow larger.\n"+
      "He cannot, however, pick between\n"+
      "his/his opponents' current colour.\n"+
      "The game is over once the map has\n"+
      "been entirely captured.";
    instructions(fillerMenu, "Filler", 100, instructions, true, 0, 0, 0);
  }
  if (fillerGame) {
    pushMatrix();
    translate(100, 50);

    fChangingColors();
    fChangingButtons();
    fill(0);
    textFont(f, 40);
    text("Home: " + sameColorSelf.size(), 0, -15);
    text("Away: " + sameColorOther.size(), 325, -15);

    // outlining their areas
    fTwoPlayersOutline(sameColorSelf);
    fTwoPlayersOutline(sameColorOther);

    imageMode(CENTER);
    tint(255);
    image(x, 575, -25, 40, 40);
    imageMode(CORNER);

    textSize(55);
    textAlign(CENTER);
    if (fTurn) {
      fill(225, 0, 50);
      pushMatrix();
      translate(-25, 250);
      rotate(PI*1.5);
      text("Home's turn!", 0, 0);
      popMatrix();
    } else {
      fill(50, 0, 225);
      pushMatrix();
      translate(530, 250);
      rotate(PI*0.5);
      text("Away's turn!", 0, 0);
      popMatrix();
    }

    textAlign(CORNER);
    textSize(40);

    fWinningGame();
    popMatrix();
  }
}
void fWinningGame() {
  if (sameColorSelf.size() + sameColorOther.size() == 100) {
    fTurn = true;
    gameWon = true;
    stroke(0);

    fill(0, 200);
    rect(75, 25, 350, 450);

    fill(255);
    textAlign(CENTER);
    if (sameColorSelf.size()>sameColorOther.size()) {
      text("HOME WINS!", 250, 100);
    } else if (sameColorSelf.size()<sameColorOther.size()) {
      text("AWAY WINS!", 250, 100);
    } else {
      text("YOU TIED!", 250, 100);
    }

    noFill();
    stroke(255);
    rect(100, 175, 300, 75);
    text("Play Again", 250, 225);

    rect(100, 275, 300, 75);
    text("Back to menu", 250, 325);

    rect(100, 375, 300, 75);
    text("Games menu", 250, 425);

    noLoop();
  }
}
void fMouse() {
  if (fillerGame) {
    for (int i =0; i<down.length; i++) {
      if (mouseX>=10+i*85+100 && mouseX<=10+squareSize+i*85+100 && mouseY>=530+50 && mouseY<=530+squareSize+50) {
        if (fTurn) {
          if (down[i].Color==square[0][9].Color || down[i].Color==square[9][0].Color) {
          } else {
            for (Square temp : sameColorSelf) {
              temp.setColor((down[i].Color));
              stroke(0);
            } 
            fTurn =false;
          }
        } else {
          if (down[i].Color==square[9][0].Color || down[i].Color==square[0][9].Color) {
          } else {
            for (Square temp : sameColorOther) {
              temp.setColor((down[i].Color));
              stroke(0);
            } 
            fTurn=true;
          }
        }
      }
    }

    if (gameWon) {
      if (mouseX>=200 && mouseX<=500 && mouseY>=225 && mouseY<=300) {
        loop();

        //clear();
        sameColorSelf.clear();
        sameColorOther.clear();
        //setup();
        fSetup();
        textAlign(CORNER);
        //grid();
        //downButtons();
        gameWon = false;
        fTurn = true;
      }
      if (button(200, 325, 300, 75)) {
        loop();
        menu1 = true;
        gameWon = false;
        fillerGame = false;
      }
    }

    if (button(650, 0, 50, 50)) {
      loop();
      menu1 = true;
      gameWon = false;
      fillerGame = false;
    }
  } else if (menu1) {
    if (button(50, 300, 600, 125)) {
      sameColorSelf.clear();
      sameColorOther.clear();
      //setup();
      fSetup();
      textAlign(CORNER);
      strokeWeight(4);
      menu1 = false;
      fTurn = true;
    }
    if (button(50, 475, 600, 125)) {
      instructions = true;
      menu1 = false;
    }
    if (button(650, 0, 50, 50)) {
      mainMenu = true;
      game[0] = false;
      instructions = false;
      menu1 = false;
    }
  } else if (instructions) {
    if (button(650, 0, 50, 50)) {
      instructions = false;
      menu1 = true;
    }
  }
}

class Square {
  PVector pos;
  color Color;
  Square(float x, float y, color ranColor) {
    Color = ranColor;
    pos = new PVector(x, y);
  }
  void show() {
    fill(Color);
    square(pos.x, pos.y, squareSize);
  }
  void showBlack() {
    tint(Color);
    //square(pos.x,pos.y,squareSize);
    image(no, pos.x, pos.y, squareSize, squareSize);
  }
  void setColor(color setColor) {
    Color = setColor;
  }
}
