PImage pandaImg, pandaImg2, fire, bambooUp, bambooDown, fpMenu;
PImage[] japan = new PImage[4];
PImage[] explosions = new PImage[5];

int[] imgx = new int[4];
int[] imgy = new int[4];
int[] imgw = new int[4];
int screenSpeed = 2, score, wantedDist=220, savedTime = 0, highScore = 0;
float index = 0;
PVector explosion;
boolean gameOver, fpPlay = false, menu = true, out, exploded, fpInst, fixBug=true, newHighScore=false;
Panda panda;
ArrayList<Bamboo> bamboo = new ArrayList<Bamboo>();

void fpSetup() {
  panda=new Panda();
  bamboo.add(new Bamboo());

  pandaImg = loadImage("panda.png");
  counter++;

  pandaImg2 = loadImage("panda2.png");
  counter++;

  fire = loadImage("fire.png");
  counter++;

  bambooUp = loadImage("bambooUp.png");
  counter++;
  bambooDown = loadImage("bambooDown.png");
  counter++;
  fpMenu = loadImage("flappyPanda.png");
  counter++;
  f = createFont("f.ttf", 15);
  counter++;

  for (int i =0; i<japan.length; i++) {
    japan[i] = loadImage("japan"+(i+1)+".jpg");
    counter++;
  }
  for (int i =0; i<explosions.length; i++) {
    explosions[i] = loadImage("explosion"+i+".png");
    counter++;
  }

  highScore = 0;
}
void fpDifficulty() {
  for (int i = 0; i<bamboo.size(); i++) {
    Bamboo a = bamboo.get(i);
    if (i+1<bamboo.size()) {
      Bamboo b = bamboo.get((i+1));
      int dist = int(b.x-a.x);
      while (dist<wantedDist) {
        b.x++;
        dist = int(b.x-a.x);
      }
      while (dist>wantedDist) {
        b.x--;
        dist = int(b.x-a.x);
      }
    }
  }
  if (score<30) {
    screenSpeed = (floor(score/5))+2;
  } else {
    screenSpeed=8;
  }
  wantedDist = 220+screenSpeed*(screenSpeed+3);
}
void fpMoveBackground() {
  if (fixBug) {
    imgw[0] = -japan[0].width;
    imgx[1] = -imgw[0];
    imgw[1] = -japan[1].width;
    imgx[2] = -imgw[1]*2;
    imgw[2] = -japan[2].width;
    imgx[3] = -imgw[2]*3;
    imgw[3] = -japan[3].width;

    fixBug=false;
  }

  imgx[0] -= screenSpeed;

  if (imgx[0]-screenSpeed < imgw[0]) {
    imgx[0] = -imgw[1]*3 ;
  }

  imgx[1] -= screenSpeed;

  if (imgx[1]-screenSpeed < imgw[1]) {
    imgx[1] = -imgw[1]*3;
  }

  imgx[2] -= screenSpeed;

  if (imgx[2]-screenSpeed < imgw[2]) {
    imgx[2] = -imgw[1]*3;
  }

  imgx[3] -= screenSpeed;

  if (imgx[3]-screenSpeed < imgw[3]) {
    imgx[3] = -imgw[1]*3;
  }
  image(japan[0], imgx[0], imgy[0], 700, 650);
  image(japan[1], imgx[1], imgy[1], 700, 650);
  image(japan[2], imgx[2], imgy[2], 700, 650);
  image(japan[3], imgx[3], imgy[3], 700, 650);

  if (bamboo.size()<10) {
    bamboo.add(new Bamboo());
  }
}
void fpSettings() {
  panda.show();
  panda.update();  


  for (int i = bamboo.size() - 1; i >= 0; i--) {
    Bamboo bam = bamboo.get(i);
    bam.update();
    bam.show();
    if (bam.isHitting(panda)) {
      gameOver = true;
      boom((int) panda.pos.x+50, (int) panda.pos.y+50);
      exploded = true;
    }
    if (bam.isPassing(panda)) {
      if (!bam.passed) {
        if (panda.alive) {
          score+=1;
          bam.passed = true;
        }
      }
    }

    if (bam.x < -bam.w) {
      bamboo.remove(i);
    }
  }

  textFont(f, 75);
  textAlign(CORNER);
  text(score+" / " + highScore, 20, 70);

  imageMode(CENTER);
  image(x, 675, 25, 40, 40);
  imageMode(CORNER);
}

void fpDying() {
  if (exploded) {
    imageMode(CENTER);
    if (index<5) {
      image(explosions[floor(index)], explosion.x, explosion.y);
      index+=.4;
    }
    imageMode(CORNER);
  }
  if (gameOver) {
    //imageMode(CENTER);
    //if (index<5) {
    //  image(explosions[floor(index)], explosion.x, explosion.y);
    //  index+=.3;
    //}
    //imageMode(CORNER);

    panda.alive=false;

    stroke(0);
    strokeWeight(1);
    fill(0, 200);
    rect(175, 125, 350, 450);

    if (score > highScore) {
      savedImg = false;
      newHighScore = true;
      highScore = score;
    } 
    if (newHighScore) {
      textFont(f, 40);


      fill(255);
      textAlign(CENTER);
      text("New High Score!", 350, 200);
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
}
void boom(int x, int y) {
  explosion = new PVector(x, y);
}
void fpDraw() {
  if (fpInst) {
    String instructions =   
      "Flappy Panda is a single-player game\n"+
      "the player controls a flying panda.\n"+
      "The player must move the panda through\n"+
      "pairs of bamboos with equal-sized gaps at\n"+
      "different heights.\n"+
      "The panda automatically falls and jupms\n"+
      "when space is pressed.\n"+
      "A player receives one point for each time\n"+
      "they pass through a pair of pipes.\n"+
      "When the player collides with a pipe\n"+
      "or the ground, the game ends.";
    instructions(fpMenu, "Flappy Panda", 70, instructions, true, 20, 0, 0);
  }
  if (menu) {
    menu(fpMenu, "Flappy\nPanda", 125, 140, 120);
    if (out) {
      int passingTime = millis() - savedTime;
      if (passingTime>5) {
        out=false;
        savedTime = millis();
      }
    }
  }
  if (fpPlay) {
    clear();
    fpMoveBackground();
    fpDifficulty();
    fpSettings();
    fpDying();
  }
}
void fpKeys() {
  if (fpPlay) {
    if (key==' ') {
      panda.jump();
    }
    if (gameOver) {
      if (keyCode == ENTER) {
        bamboo.clear();

        score = 0;
        gameOver = false;
        panda.alive = true;
        index = 0;
        exploded = false;

        newHighScore = false;
      }
    }
  }
}
void fpMouse() {
  if (fpPlay) {

    if (gameOver) {
      if (button(200, 275, 300, 75)) {
        bamboo.clear();

        score = 0;
        gameOver = false;
        panda.alive = true;
        index = 0;
        exploded = false;

        newHighScore = false;
      }
      if (button(200, 375, 300, 75)) {
        menu = true;
        fpPlay = false;
        out = true;

        newHighScore = false;
      }
    }
    if (button(650, 0, 50, 50)) {
      bamboo.clear();

      score = 0;
      gameOver = false;
      panda.alive = true;
      index = 0;
      exploded = false;

      menu=true;
      fpPlay = false;

      newHighScore = false;
    }
  } else if (menu && !out) {
    if (button(50, 300, 600, 125)) {
      bamboo.clear();

      score = 0;
      gameOver = false;
      panda.alive = true;
      index = 0;
      exploded = false;

      menu=false;
      fpPlay = true;
    }
    if (button(50, 475, 600, 125)) {
      fpInst = true;
      menu = false;
    }
    if (button(650, 0, 50, 50)) {
      mainMenu = true;
      game[1] = false;
      fpInst = false;
      menu = false;
      gameOver = false;
    }
  } else if (fpInst) {
    if (button(650, 0, 50, 50)) {
      fpInst = false;
      menu = true;
    }
  }
}

class Bamboo {
  float top, bottom, x, w, remainder, remainder2;
  int pipeNum, pipeNum2;
  boolean passed = false;
  Bamboo() {
    top = random(95, height-250);
    pipeNum = floor(top/95);
    remainder = top%95;
    bottom = top+250;
    pipeNum2 = floor((top+250)/95);
    remainder2 = (top+250)%95;
    x = width+50;
    w = 60;
  }
  void show() {
    fill(255);
    for (int i = 0; i<pipeNum; i++) {
      image(bambooUp, x, i*95, w, 95);

      if (i==pipeNum-1) {
        image(bambooUp, x, (i+1)*95, w, remainder);
      }
    }
    for (int i = 0; i<pipeNum2; i++) {
      image(bambooDown, x, bottom+(i*95), w, 95);

      if (i==pipeNum2-1) {
        image(bambooDown, x, bottom+(i*95), w, height);
      }
    }
    //rect(x,bottom,w,height-bottom);
  }
  void update() {
    x-=screenSpeed;
  }

  boolean isHitting(Panda p) {
    if (p.pos.y+80 >= 0 && p.pos.y<=top || p.pos.y <= height && p.pos.y+80>=bottom) {
      if (p.pos.x+70>=x && p.pos.x+40<=x+w) {
        return true;
      }
    }
    return false;
  }
  boolean isPassing(Panda p) {
    if (!this.isHitting(p)) {
      if (p.pos.x+70>=x && p.pos.x+40<=x+w) {
        return true;
      }
    }
    return false;
  }
}

class Panda {
  PVector pos, vel;
  float gravity, jumpForce;
  boolean alive;
  Panda() {
    pos = new PVector(50, height/2);
    vel = new PVector(0, 0);
    gravity=.5;
    jumpForce = 10;
    alive = true;
  }
  void show() {
    if (alive) {
      pushMatrix();
      translate(pos.x, pos.y);
      if (vel.y<0) {
        //rect(10, 10, 70, 80);
        image(pandaImg2, 0, 0, 100, 100);
      } else {
        //rect(10, 10, 70, 80);
        image(pandaImg, 0, 0, 100, 100);
      }
      popMatrix();
    }
  }
  void update() {
    if (alive) {
      vel.y+=gravity;
      pos.y+=vel.y;

      if (pos.y>height-100) {
        pos.y=height-100;
        vel.y=0;
      }
      if (pos.y<0) {
        pos.y=0;
        vel.y=0;
      }
    }
  }
  void jump() {
    if (alive) {
      vel.y = -jumpForce;
    }
  }
}
