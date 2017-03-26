

/**
 * Turtle3D RectBox
 * 2017-02-07 Jeremy Douglass - Processing 3.2.3
 * https:// forum.processing.org/two/discussion/20706/how-3d-turtle-like-in-logo-but-3d-math-problem
 we could use also modelX etc.  */

import peasy.*;
PeasyCam camera;

// program logic: states 
int state=0;  // 

// small text for each state
// you must enter this help to make a new state appears. 
// state is set to 0 when it's at the end of this array iirc 
String []stateDescription =  {
  "a line", 
  "a line pattern / demonstrates right and left turn", 
  "demonstrates forward and backward ", 
  "rect", 
  "demonstrates noseDown", 
  "demonstrates noseDown II", 
  "demonstrates noseUp", 
  "cube I (open on the right)", 
  "cube II (open on the bottom)", 
  "help"
} ; 

// The turtle
Turtle t = new Turtle(); 

// ------------------------------------------------------------
// processing core 

void setup() {
  size(1300, 800, P3D);

  // focus the cam on the center of the box
  camera = new PeasyCam(this, 25, 25, -25, 100);

  // help text 
  println ("Hit any key for next turtle graphic.\n\n");

  t.help();
}

void draw() {
  background(192);

  avoidClipping(); 

  lights();

  // the core 
  stateManagement();

  // status bar (HUD) 
  statusBar(); 
  //
}//func

// --------------------------------------------------------

void stateManagement() {

  switch (state) {

  case 0:
    // a line
    pushMatrix();
    t.setColor( t.GREEN ); 
    t.forward(50);
    t.dropAText(">"+0);
    t.right(90);
    t.dropAText(">"+1);
    t.forward(50);
    t.dropAText(">"+2);
    t.noseDown(90);
    t.dropAText(">"+3);
    //t.dropASphere();
    popMatrix();
    break; 

  case 1:
    // a line pattern
    // demonstrates right and left turn
    pushMatrix();

    translate(-60, 0, -200);

    t.forward(50);
    t.dropASphere();
    t.right(90);
    t.forward(50);
    t.left(90);
    t.forward(50);
    t.left(90);
    t.forward(50);
    t.right(90);
    t.forward(50);
    t.right(90);
    t.forward(50);

    t.left(90);
    t.forward(50);
    t.left(90);
    t.forward(50);

    t.right(90);
    t.forward(50);
    t.right(90);
    t.forward(50);

    t.left(90);
    t.forward(50);
    t.left(90);
    t.forward(50);
    popMatrix();
    break; 

  case 2:
    // lines
    // demonstrates forward and backward
    pushMatrix();
    t.forward(50);
    t.dropASphere();
    t.right(90);
    t.forward(50);
    t.left(90);
    t.backward(30);
    t.dropASphere();
    popMatrix();
    break; 

  case 3: 
    // rect
    pushMatrix();
    paint_A_Rectangle(50);
    popMatrix();
    break;

  case 4: 
    // demonstrates noseDown I
    pushMatrix();
    t.forward(50);
    t.dropASphere();
    t.noseDown(90);
    t.forward(50);
    t.dropASphere();
    popMatrix();
    break;

  case 5: 
    // demonstrates noseDown II
    pushMatrix();
    t.forward(50);
    t.dropASphere();
    t.noseDown(90);
    t.forward(50);
    t.dropASphere();
    t.noseDown(90);
    t.forward(50);
    t.dropASphere();
    popMatrix();
    break;

  case 6: 
    // demonstrates noseUp 
    pushMatrix();
    t.forward(50);
    t.dropASphere();
    t.noseDown(90);
    t.forward(50);
    t.dropASphere();
    t.noseUp(90);
    t.forward(50);
    t.dropASphere();
    popMatrix();
    break;

  case 7: 
    // cube I
    pushMatrix();
    paint_A_Box1(50);
    popMatrix();
    break;

  case 8: 
    // cube II 
    pushMatrix();
    paint_A_Box2(50);
    popMatrix();
    break;

  case 9:
    t.helpOnScreen();
    break; 

  default:
    //error
    println ("Error 102, unknown state ++++++++++++++++++++++");
    //exit();
    state=0;
    break;
  }//switch
}//func 

// ------------------------------------------------------------
// Inputs 

void keyPressed() {

  if (key==ESC)
    return; // quit here  

  switch (key) { 

  case 'r': // reset 
    camera.reset(); 
    break; 

  case 'h': // help 
    t.help(); 
    break; 

  case 'l': // toggle line type
    t.lineType = !t.lineType; 
    break; 

  default: 
    state++;
    if (state>=stateDescription.length) {
      state=0;
      println("---------------------------- starting with state 0 again");
    }// if
    println("Graphic #"
      +state
      +": "
      +stateDescription[state]);
    break; 
    //
  }//switch
  //
}//func

// ------------------------------------------------------------
// some turtle graphics 

// in 2D 

void paint_A_Rectangle(int x) {
  for (int i=0; i<4; i++) {
    t.forward(x);
    // t.dropASphere();
    int redValue=i*70 + 40; 
    t.dropASphereColorRed(redValue); 
    // t.dropAText(str(i)); 
    // print(redValue+" - ");
    t.right(90);
  }
}

// in 3D

void paint_A_Box1(int x) {
  for (int i=0; i<3; i++) {
    paint_A_Rectangle(x);
    t.dropAText("N"+i);
    t.forward(x);
    t.dropAText(">"+i);

    t.noseDown(90);
  }
  // t.dropAText("N");
}

void paint_A_Box2(int x) {

  t.left(90); 

  for (int i=0; i<3; i++) {

    t.dropAText(">"+i);
    paint_A_Rectangle(x);
    t.forward(x);

    //t.rollRight(90); // ??? 
    t.noseDown(90);

    t.dropAText("2>"+i);
  }
}

// --------------------------------------------------------
// Minor Functions 

void statusBar() {

  // display a text in the corner
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);

  // the rect of the staus bar
  fill(111); // gray 
  noStroke(); 
  rect(0, height-19, width, 30);

  // the text 
  fill(0);
  textSize(12);
  text("Space Bar for next graphic, l - toggle line type, "
    +"Mouse to rotate and pan camera (peasycam), "
    +"Mouse wheel to zoom+-, r to reset camera, Esc to quit.  ", 
    3, height-4);

  hint(ENABLE_DEPTH_TEST);
  camera.endHUD();
}

void avoidClipping() {
  // avoid clipping : 
  // https : // forum.processing.org/two/discussion/4128/quick-q-how-close-is-too-close-why-when-do-3d-objects-disappear
  perspective(PI/3.0, (float) width/height, 1, 1000000);
}

// ===========================================================

class Turtle {

  // turtle variables and constants 

  // color constants 
  final color WHITE = color (255); 
  final color BLACK = color (0);

  final color GRAY = color (255/2);
  final color LIGHTGRAY = color (111);
  final color DARKGRAY  = color (222);

  final color RED = color (255, 0, 0);    // RGB  
  final color GREEN = color (0, 255, 0);
  final color BLUE = color (0, 0, 255);

  final color YELLOW = color (#FFF81F);

  // pen down true = turtle draws; 
  // pen down false = pen up = turtle does not draw
  boolean penDown = true;

  // turtle color 
  color turtleColor = RED; 

  boolean lineType = false; // true = classical line 

  // constr 
  Turtle () {
    // not much here yet 
    help();
  }// constr 

  // ------------------------------------------------------------
  // the typical core Turtle functions 

  void forward(int amount) {
    if (penDown) {
      // a 3D line 
      stroke(turtleColor); 

      if (lineType) 
        line(0, 0, 0, 
          amount, 0, 0);
      else
        drawLine(0, 0, 0, 
          amount, 0, 0, 2, turtleColor);
    }//if
    translate(amount, 0, 0);
  }

  void backward(int amount) {
    forward( - amount);
  }

  // YAW
  void right (float degree) {
    rotateZ(radians( degree ) );
  }

  void left (float degree) {
    rotateZ( - radians( degree ) );
  }

  // Pen 

  void penUp() {
    // turtle stops drawing now
    penDown = false;
  }

  void penDown() {
    // turtle draws now
    penDown = true;
  }

  // 3D - PITCH  

  void noseDown(float degree) {
    rotateY(radians(degree));
  }

  void noseUp(float degree) {
    rotateY( - radians(degree));
  }

  // 3D - ROLL  

  void rollRight(float degree) {
    rotateX(radians(degree));
  }

  void rollLeft(float degree) {
    rotateX( - radians(degree));
  }

  // color 

  void setColor(color col_) {
    turtleColor=col_;
  }

  // ------------------------------------------------------------
  // also Turtle functions, but not core functions  

  void forwardJump(int amount) {
    // like forward but pen is up.

    // When the pen now is up, turtle doesn't draw

    // store old position 
    boolean formerPenDown=penDown;

    // move pen up so that isn't on our drawing anymore 
    penDown=false; // don't  draw
    forward(amount);
    penDown=formerPenDown;
  }

  void backwardJump(int amount) {
    forward( - amount);
  }

  void dropASphere() {
    noStroke(); 
    fill(RED); // RED
    sphere(7); 
    stroke(0);
  }

  void dropASphereColorRed( int red ) {
    noStroke(); 
    fill(red, 0, 0); // a red tone
    sphere(7); 
    stroke(0);
  }

  void dropASphereColor( color col ) {
    noStroke(); 
    fill(col); // color
    sphere(7); 
    stroke(0);
  }

  void dropAText(String s) {
    pushMatrix(); 
    translate(9, 0); 
    text(s, 0, 0, 0); 
    popMatrix();
  }

  void help() {
    println (helpText());
  }

  void helpOnScreen() {
    // display a text 
    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(MODEL);

    fill(WHITE);
    text( helpText(), 18, 18);
    camera.endHUD();
  }

  void drawLine(float x1, float y1, float z1, 
    float x2, float y2, float z2, 
    float weight, 
    color strokeColour)
    // was called drawLine; programmed by James Carruthers
    // see <a href="http://processing.org/discourse/yabb2/YaBB.pl?num=1262458611/0#9" target="_blank" rel="nofollow">http://processing.org/discourse/yabb2/YaBB.pl?num=1262458611/0#9</a>
  {
    PVector p1 = new PVector(x1, y1, z1);
    PVector p2 = new PVector(x2, y2, z2);
    PVector v1 = new PVector(x2-x1, y2-y1, z2-z1);
    float rho = sqrt(pow(v1.x, 2)+pow(v1.y, 2)+pow(v1.z, 2));
    float phi = acos(v1.z/rho);
    float the = atan2(v1.y, v1.x);
    v1.mult(0.5);

    pushMatrix();
    translate(x1, y1, z1);
    translate(v1.x, v1.y, v1.z);
    rotateZ(the);
    rotateY(phi);
    noStroke();
    fill(strokeColour);
    // box(weight,weight,p1.dist(p2)*1.2);
    box(weight, weight, p1.dist(p2)*1.0);
    popMatrix();
  }

  String helpText() {

    String a1= "Help for turtle\n-------------------------------------------\n";
    a1+= ("Imagine a turtle. You can tell it to go forward or turn left or right.\n");
    a1+= ("Imagine it carries a pen so when it walks it draws a line behind it.\n");
    a1+= ("You can now draw an image by telling the turtle where to go.\n\n");
    a1+= ("Major commands are \n");
    a1+= ("     * forward/backward(amount) to walk\n"); 
    a1+= ("     * left/right(amount) - to turn [amount is an angle in degrees from 0 to 360]\n");
    a1+= ("     * penUp so Turtle walks but does not draw\n"); 
    a1+= ("     * penDown Turtle draws again\n");
    a1+= ("You can use all typical processing commands such as for-loop or a function.\n"); 
    a1+= ("You can make your own turtle commands like rectangle() by writing a function and use it.\n\n");
    a1+= ("The turtle is also a 3D Turtle, imagine a water turtle that draws a line behind it.\n");
    a1+= ("Thus you can connect four rectangles to a cube.\n");
    a1+= ("************************************************************\n\n");
    return a1;
  }
  //
}// class
//