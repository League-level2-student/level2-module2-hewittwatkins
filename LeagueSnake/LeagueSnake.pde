//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.

  int x;
  int y;
  

// Add a constructor with parameters to initialize each variable.

  public Segment(int X2, int Y2) {
    this.x = X2;
    this.y = Y2;
  }
    

}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*

 Segment head;
 int foodX;
 int foodY;
 int direction = UP;
 int numFood = 0;
 ArrayList <Segment> segments = new ArrayList <Segment>();
 



//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  
  size(500, 500);
  head = new Segment(10,10);
  frameRate(20);
  dropFood();

}

void dropFood() {
  //Set the food in a new random location
    foodX = ((int)random(50)*10);
    foodY = ((int)random(50)*10);
    
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0, 0, 0);
  drawFood();
  move();
  drawSnake();
  
  checkBoundaries();
  eat();
}

void drawFood() {
  //Draw the food
  rect(foodX,foodY,10,10);
  fill(0,100,0);
  
  
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  
  rect(head.x,head.y,10,10);
  fill(100, 0, 0);
  manageTail();
  
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for (int i = 0; i < segments.size(); i++) {
    rect(segments.get(i).x, segments.get(i).y, 10, 10);
  }
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  Segment tail1 = new Segment(head.x ,head.y);
  segments.add(tail1);
  segments.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for (int i = 1; i < segments.size(); i++) {
    if (head.x == segments.get(i).x && head.y == segments.get(i).y) {
      numFood = 1;
      segments.clear();
      Segment tail1 = new Segment(head.x ,head.y);
      segments.add(tail1);
    }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (keyCode == 38 && direction != DOWN) {
    direction = UP;
  }
  else if (keyCode == 40 && direction != UP) {
    direction = DOWN;
  }
  else if (keyCode == 39 && direction != LEFT) {
    direction = RIGHT;
  }
  else if (keyCode == 37 && direction != RIGHT) {
    direction = LEFT; 
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
   
  switch(direction) {
  case UP:
    head.y -= 10;
    break;
  case DOWN:
    head.y += 10;
    break;
  case LEFT:
   head.x -= 10;
    break;
  case RIGHT:
   head.x +=10;
    break;    

  }
  
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if (head.x >= 500) {
   head.x = 10;
 }
 else if (head.x <= 0) {
   head.x = 490;
 }
 if (head.y >= 500) {
   head.y = 10;
 }
 else if (head.y <= 0) {
   head.y = 490;
 }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if (foodX == head.x && foodY == head.y) {
    numFood++;
    dropFood();
    Segment tail1 = new Segment(head.x ,head.y);
    segments.add(tail1);
    
  }
}
