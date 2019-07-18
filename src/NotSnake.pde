int mapWidth = 21;
int mapHeight = 21;
int canvasWidth = 210;
int canvasHeight = 210;

int appleX = 0;
int appleY = 0;

int headX = 100;
int headY = 100;

int savedTime;
int speed = 500;

int score = 0;
int highscore = 0;

ArrayList<String> snakeXl;
ArrayList<String> snakeYl;
int[] snakeX;
int[] snakeY;

String direction = "up";

public void drawScreen(){
  background(25);
  stroke(255);
  fill(25);
  for(int x = 0; mapWidth >= x; x++){
    for(int y = 0; mapHeight >= y; y++){
      rect(x * 10, y * 10, 10, 10);
    }
  }
  fill(0, 255, 0);
  rect(headX, headY, 10, 10);
  fill(255, 0, 0);
  rect(appleX, appleY, 10, 10);
  fill(255, 255, 255);
  text("Score: " + score, 230, 110);
  text("High Score: " + highscore, 230, 130);
}

public void move(String dir){
  if(dir == "up"){
    headY -= 10;
  }
  if(dir == "down"){
    headY += 10;
  }
  if(dir == "left"){
    headX -= 10;
  }
  if(dir == "right"){
    headX += 10;
  }
}

void updateControlls(){
  if(keyCode == UP){
    direction = "up";
  }
  if(keyCode == DOWN){
    direction = "down";
  }
  if(keyCode == LEFT){
    direction = "left";
  }
  if(keyCode == RIGHT){
    direction = "right";
  }
}

void collisionDetector(){
  if(headX > canvasWidth || headX < 0 || headY < 0 || headY > canvasHeight){
    String[] hs = new String[1];
    hs[0] = String.valueOf(highscore);
    saveStrings("highscore.txt", hs);
    exit();
  }
  if(headX == appleX && headY == appleY){
    changeApple();
    score++;
    if(score > highscore){
      highscore = score;
      String[] hs = new String[1];
      hs[0] = String.valueOf(highscore);
      saveStrings("highscore.txt", hs);
    }
    speed -= 10;
  }
}

void changeApple(){
  appleX = int(float(int(random(20))) * 10);
  appleY = int(float(int(random(20))) * 10);
}

void setup(){
  size(320, 221); //Play area is 220x220
  savedTime = millis();
  changeApple();
  File f = dataFile("highscore.txt");
  boolean exist = f.isFile();
  if(exist){
    if(loadStrings("highscore.txt").length != 0){
      highscore = int(loadStrings("highscore.txt"))[loadStrings("highscore.txt").length - 1];
    }else{
      highscore = 0;
      String[] hs = new String[1];
      hs[0] = String.valueOf(highscore);
      saveStrings("highscore.txt", hs);
    }
  }else{
    highscore = 0;
    String[] hs = new String[1];
    hs[0] = String.valueOf(highscore);
    saveStrings("highscore.txt", hs);
  }
}

void draw(){
  int passedTime = millis() - savedTime;
  
  updateControlls();
  
  if (passedTime > speed) {
    move(direction);
    collisionDetector();
    drawScreen();
    savedTime = millis(); // Save the current time to restart the timer!
  }
}
