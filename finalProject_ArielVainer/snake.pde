Snake snake;
Apple apple;

int gridSize = 30, speed = 10, snScore, snHighScore;
float num;
boolean dieScreen, snPlay, snMenu = true, snNewHighScore = false, snInst=false;
PImage appleImg, head, turn, body1, body2, snakeImg, snakeImg1, cup, trophy, snakeGame;
boolean[] dir = new boolean[4];

void snSetup() {
  frameRate(60);
  snake = new Snake();
  apple = new Apple();

  appleImg = loadImage("apple.png");
  appleImg.resize(40, 40);
  counter++;
  head = loadImage("head_left.png");
  head.resize(gridSize, gridSize);
  counter++;
  turn = loadImage("turn.png");
  turn.resize(gridSize, gridSize);
  counter++;
  body1 = loadImage("body1.png");
  body1.resize(gridSize, gridSize);
  counter++;
  body2 = loadImage("body2.png");
  body2.resize(gridSize, gridSize);
  counter++;
  snakeImg = loadImage("snake.png");
  snakeImg.resize(184, 50);
  counter++;
  snakeImg1 = loadImage("snake1.png");
  snakeImg1.resize(184, 50);
  counter++;
  cup = loadImage("cup.png");
  cup.resize(56, 50);
  counter++;
  trophy = loadImage("trophy.png");
  trophy.resize(40, 40);
  counter++;
  snakeGame = loadImage("snakeGame.png");
  counter++;

  dir[3] = true;
}
void snRotatePic(PImage img, int num, float x, float y) {
  pushMatrix();
  translate(x, y);
  rotate(radians(num));
  image(img, 0, 0);
  popMatrix();
}
void snBackground() {
  background(255);

  image(x, 655, 5, 40, 40);

  snRotatePic(snakeImg, 270, 0, height);
  snRotatePic(snakeImg, 90, 700, 50);
  snRotatePic(snakeImg1, 270, 0, 234);
  snRotatePic(snakeImg1, 90, 700, 466);

  snRotatePic(cup, 270, 0, 454);
  snRotatePic(cup, 270, 0, 378);
  snRotatePic(cup, 270, 0, 302);

  snRotatePic(cup, 90, 700, 398);
  snRotatePic(cup, 90, 700, 322);
  snRotatePic(cup, 90, 700, 246);

  stroke(0);
  noFill();
  rect(125, 0, 150, 50);
  rect(425, 0, 150, 50);

  image(appleImg, 235, 5);
  image(appleImg, 125, 5);

  image(trophy, 535, 5);
  image(trophy, 425, 5);

  textSize(40);
  fill(0);
  textAlign(CENTER);
  text(snScore, 200, 40);
  text(snHighScore, 500, 40);

  for (int i = 50; i<650; i+=gridSize) {
    num+=1;
    for (int j = 50; j<650; j+=gridSize) {

      if (round(num)%2==0) {
        fill(162, 209, 73);
      } else {
        fill(170, 215, 81);
      }
      num+=1;
      noStroke();
      rect(i, j, gridSize, gridSize);
    }
  }
}
void snDraw() {
  strokeWeight(3);
  if (snPlay) {
    snBackground();
    snSettings();
  }
  if (snMenu) {
    menu(snakeGame, "Snake", 200, 50, 220);
  }
  if (snInst) {
    String instructions =
      "Snake is a single-player game in which\n"+
      "the player plays as a snake with one\n"+
      "main goal.\n"+
      "Eat as many apples as you can to grow\n"+
      "as long as possible.\n"+
      "Use the arrow keys to control the snake.\n"+
      "Be careful not to hit eat your tail!\n";


    //"When the player collides with a pipe\n"+
    //"or the ground, the game ends.";
    instructions(snakeGame, "Snake", 100, instructions, true, -60, 90, 180);
  }
}
void snSettings() {
  if (snScore>=400) {
    dieScreen = true;
  }
  snake.show();
  snake.update();
  if (snake.isDying()) {

    dieScreen = true;
  }

  if (dieScreen) {
    if (snScore > snHighScore) {
      savedImg = false;
      snNewHighScore = true;
      snHighScore = snScore;
    }
    stroke(0);
    strokeWeight(1);
    fill(0, 200);
    rect(175, 125, 350, 450);

    if (snNewHighScore) {
      textFont(f, 40);


      fill(255);
      textAlign(CENTER);
      text("New High Score!", 350, 200);
    } else if (score >= 400) {
      textFont(f, 40);


      fill(255);
      textAlign(CENTER);
      text("YOU WON!", 350, 200);
    } else {
      textFont(f, 40);


      fill(255);
      textAlign(CENTER);
      text("YOU DIED!", 350, 200);
    }

    noFill();
    stroke(255);
    rect(200, 275, 300, 75);
    text("Play Again", 350, 325);

    rect(200, 375, 300, 75);
    text("Back to menu", 350, 425);

    rect(200, 475, 300, 75);
    text("Games menu", 350, 525);
  }

  apple.show();
  apple.update();
}
void setHeadDir(int num) {
  for (int i = 0; i<dir.length; i++) {
    dir[i] = false;
    dir[num] = true;
  }
}
void snKeys() {
  if (!dieScreen) {
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      snake.setDirection("left");
    } else if (keyCode == RIGHT || key == 'd' || key == 'D') {
      snake.setDirection("right");
    } else if (keyCode == UP || key == 'w' || key == 'W') {
      snake.setDirection("up");
    } else if (keyCode == DOWN || key == 's' || key == 'S') {
      snake.setDirection("down");
    }
  }
}


void snMouse() {
  if (snPlay) {
    if (dieScreen) {
      if (button(200, 275, 300, 75)) {
        snake.tail.clear();
        snMenu=false;
        snPlay = true;
        snScore = 0;

        dieScreen = false;

        snNewHighScore = false;
      }
      if (button(200, 375, 300, 75)) {
        snMenu = true;
        snPlay = false;

        snNewHighScore = false;
      }
    }
    if (button(650, 0, 50, 50)) {
      snake.tail.clear();
      snMenu=true;
      snPlay = false;
      snScore = 0;

      dieScreen = false;

      snNewHighScore = false;
    }
  } else if (snMenu) {
    if (button(50, 300, 600, 125)) {
      snake.tail.clear();
      snMenu=false;
      snPlay = true;
      snScore = 0;

      dieScreen = false;

      snNewHighScore = false;
    }
    if (button(50, 475, 600, 125)) {
      snInst = true;
      snMenu = false;
    }
    if (button(650, 0, 50, 50)) {
      mainMenu = true;
      game[2] = false;
      snInst = false;
      snMenu = false;
    }
  } else if (snInst) {
    if (button(650, 0, 50, 50)) {
      snInst = false;
      snMenu = true;
    }
  }
}

class Snake {
  ArrayList<PVector> tail;
  PVector pos, vel;
  int size;
  String direction;
  boolean rotate;

  Snake() {
    tail = new ArrayList<PVector>();
    pos = new PVector(350, 350);
    vel = new PVector(0, 1);
    size = 1;
    direction = "down";
    rotate = false;
  }
  void show() {
    if (!dieScreen) {
      fill(255);
      imageMode(CENTER);
      for (int i = 0; i<dir.length; i++) {
        if (dir[i]) {
          pushMatrix();
          translate(pos.x+gridSize/2, pos.y+gridSize/2);
          rotate(radians(i*90));
          image(head, 0, 0, gridSize, gridSize);
          popMatrix();
        }
      }
      imageMode(CORNER);
      for (int i = 0; i<tail.size(); i++) {
        PVector v = tail.get(i);
        imageMode(CENTER);
        PVector s;
        if (tail.size()-1>i) {
          s = tail.get(i+1);
        } else {
          s = pos;
        }
        if (i>0) {
          PVector d = tail.get(i-1);
          if (v.x == d.x && v.y == s.y && d.x>s.x && d.y>s.y) { // up left
            rotateSnake(v, 0, turn);
          } else if (v.x == s.x && v.y == d.y && d.x>s.x && d.y>s.y) { // left up
            rotateSnake(v, 1, turn);
          } else if (v.x == d.x && v.y == s.y && d.x<s.x && d.y>s.y) { // up right
            rotateSnake(v, 1.5, turn);
          } else if (v.x == s.x && v.y == d.y && d.x<s.x && d.y>s.y) { // right up
            rotateSnake(v, 0.5, turn);
          } else if (v.x == d.x && v.y == s.y && d.x>s.x && d.y<s.y) { // down left
            rotateSnake(v, 0.5, turn);
          } else if (v.x == s.x && v.y == d.y && d.x>s.x && d.y<s.y) { // left down
            rotateSnake(v, 1.5, turn);
          } else if (v.x == d.x && v.y == s.y && d.x<s.x && d.y<s.y) { // down right
            rotateSnake(v, 1, turn);
          } else if (v.x == s.x && v.y == d.y && d.x<s.x && d.y<s.y) { // right down
            rotateSnake(v, 0, turn);
          } else {
            if (s.x>v.x) { // right
              rotateSnake(v, 0, body2);
            } else if (s.x<v.x) { // left
              rotateSnake(v, 0, body2);
            }
            if (s.y<v.y) { // up
              rotateSnake(v, 0, body1);
            } else if (s.y>v.y) { // down
              rotateSnake(v, 0, body1);
            }
          }
        } else {
          if (s.x>v.x) { // right
            rotateSnake(v, 0, body2);
          } else if (s.x<v.x) { // left
            rotateSnake(v, 0, body2);
          }
          if (s.y<v.y) { // up
            rotateSnake(v, 0, body1);
          } else if (s.y>v.y) { // down
            rotateSnake(v, 0, body1);
          }
        }
        //} else{

        //}
        //} else {

        //  rectMode(CENTER);
        //  pushMatrix();
        //  translate(v.x+15, v.y+15);
        //  fill(91, 123, 249);
        //  rotate(int(rotate * PI / 2);
        //  rect(0,0, 22, gridSize);
        //  popMatrix();
        //  rectMode(CORNER);
        //}
        imageMode(CORNER);
      }
      fill(0, 0, 255);

      //square(pos.x, pos.y, gridSize);
    }
  }
  void rotateSnake(PVector v, float num, PImage img) {
    pushMatrix();
    translate(v.x+gridSize/2, v.y+gridSize/2);
    rotate(radians(num*180));
    image(img, 0, 0);
    popMatrix();
  }
  void update() {
    if (frameCount%speed==0) {
      if (size > 0) {
        if (size == tail.size() && !tail.isEmpty()) {
          tail.remove(0);
        }
        tail.add(new PVector(pos.x, pos.y));
      }
      PVector tempVel = vel.mult(gridSize);
      pos.add(tempVel);
      vel.x/=gridSize;
      vel.y/=gridSize;
    }


    if (pos.x<50) {
      pos.x=650-gridSize;
    }
    if (pos.x>650-gridSize) {
      pos.x=50;
    }
    if (pos.y<50) {
      pos.y=650-gridSize;
    }
    if (pos.y>650-gridSize) {
      pos.y=50;
    }
  }

  boolean touchedApple(Apple a) {
    if (pos.x==a.pos.x && pos.y==a.pos.y) {
      size++;
      snScore++;
      return true;
    }
    return false;
  }

  void setDirection(String dir) {
    if (dir == "left") {
      if (direction != "right") {
        vel.x=-1;
        vel.y=0;
        direction = dir;
        setHeadDir(0);
        rotate = true;
      }
    } else if (dir == "right") {
      if (direction != "left") {
        vel.x=1;
        vel.y=0;
        direction = dir;
        setHeadDir(2);
        rotate = true;
      }
    } else if (dir == "up") {
      if (direction != "down") {
        vel.x=0;
        vel.y=-1;
        direction = dir;
        setHeadDir(1);
        rotate = false;
      }
    } else if (dir == "down") {
      if (direction != "up") {
        vel.x=0;
        vel.y=1;
        direction = dir;
        setHeadDir(3);
        rotate = false;
      }
    }
  }
  boolean isDying() {
    for (int i = 0; i < tail.size(); i++) {
      PVector tailPos = tail.get(i);
      if (pos.x==tailPos.x && pos.y==tailPos.y) {
        size = 1;
        tail.clear();
        return true;
      }
    }
    return false;
  }
}

class Apple {
  int x, y, size;
  PVector pos;
  Apple() {
    x = (int) random(1, (600-gridSize)/gridSize);
    y = (int) random(1, (600-gridSize)/gridSize);
    pos = new PVector(x*gridSize+50, y*gridSize+50);

    size = gridSize;
  }
  void show() {
    fill(255, 0, 0);
    imageMode(CENTER);
    image(appleImg, pos.x+gridSize/2, pos.y+gridSize/2, size, size);
    imageMode(CORNER);
  }
  void update() {
    if (snake.touchedApple(this)) {
      for (PVector v : snake.tail) {
        while (x*gridSize+50==v.x && y*gridSize+50==v.y || x*gridSize+50==snake.pos.x && y*gridSize+50==snake.pos.y) {
          x = (int) random(0, 600/gridSize);
          y = (int) random(0, 600/gridSize);
        }
      }
      pos = new PVector(x*gridSize+50, y*gridSize+50);
    }

    if (frameCount%10<5) {
      size++;
    } else {
      size--;
    }
  }
}
