//the racket can't be started successfully every time,
//there are still many bugs but can't fix it:(

import processing.sound.*;
SoundFile sound_score;
SoundFile sound_background;
SoundFile sound_gameover;

//move the mouse to get the ball, click the mouse to restart the game
float directionX=4;
float directionY=4;
float ballX=400;
float ballY=0;
float racketX=0;
float racketY=0;
PImage flex;
int score=0;


void setup() {

  size(800, 400);
  flex=loadImage("pixel-background-texture-red-copy-450w-633320276.png");
  sound_score= new SoundFile(this, "score_sound.wav");
  sound_background=new SoundFile(this, "410574__yummie__game-background-music-loop-short.mp3");
  sound_background.loop();
  sound_gameover=new SoundFile(this, "433644__dersuperanton__game-over-sound.wav");
}


void draw() {

  background(flex);
  displayRacket( racketX, racketY);
  moveRacket();
  displayBall(ballX, ballY);
  moveBall();
  returnBall();
  checkEdge();
  bounceBall();
  displayScore();
}



void displayRacket(float racketX, float racketY) {
  rect(racketX, racketY, 30, 100);
}


void moveRacket() {
  if (racketY>-1) {
    if (keyPressed) {
      if (key==CODED) {
        if (keyCode==UP) {
          racketY=racketY-4;
        }
      }
    }
  }
  if (racketY<305)

    if (keyPressed) {
      if (key==CODED) {
        if (keyCode==DOWN) {
          racketY=racketY+4;
        }
      }
    }
}

void returnBall() {
  if (keyPressed) {
    if (ballX<0) {
      ballX=400;
      ballY=200;
    }
  }
}

void displayBall(float ballX, float ballY) {
  ellipse(ballX, ballY, 20, 20);
}
void moveBall() {

  ballX=ballX+directionX;
  ballY=ballY+directionY;
}


//if ballX>width then turn around
void checkEdge() {
  if (ballX>width) 
  {
    directionX=-directionX;
  } 
  //if ballY>height then turn around
  if (ballY<0||ballY>height)
  {
    directionY=-directionY;
  }
}
//if ball touches board then turn the direction, otherwise keep moving
void displayScore() {
  text("SCORE:"+score, 600, 50);
  textSize(32);
}


void bounceBall() {
  if ((ballX>35)&&(ballX<40)&&(ballY>racketY-10)&&(ballY<racketY+110)) {
    directionX=-directionX;
    score=score+1;
    sound_score.play();
  }
  if (ballX<10) {
    score=0;
    text("GAMEOVER", 400, 200);
    textSize(32);
    sound_gameover.play();
  }
}
