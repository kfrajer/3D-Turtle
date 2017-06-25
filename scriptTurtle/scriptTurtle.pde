
/**
 *
 * Turtle3D with Turtle Script  
 * 
 * credits: Jeremy Douglass - thank you! 
 * https:// forum.processing.org/two/discussion/20706/how-3d-turtle-like-in-logo-but-3d-math-problem
 *
 * Thanks to PeasyCam 
 * Thanks to GoToLoop for the text input area
 * Thanks for drawLine programmed by James Carruthers
 * Thanks to Calsign
 *
 */

import peasy.*;

// the main classes ------------ 

// peasy cam 
PeasyCam camera;

// The turtle
Turtle t; 

// the editor
TextBox tbox1;

// the parser
Parse parser = new Parse();

// the states ----------------

// program logic: states 
final int stateWelcomeScreen = 0;  // unique numbers
final int stateEdit          = 1; 
final int stateRun           = 2; 
final int stateError         = 3; 
final int stateWaitForSave   = 4; 
final int stateWaitForLoad   = 5;
final int stateHelp          = 6;
final int stateShowLogfile   = 7;
int state = stateWelcomeScreen;  // current

// other variables --------------

String versionString = "Version 0.1.312";

// Misc 
String stateText=""; 
String statusBarText = "";
String errorMsg=""; // error msg 

// angle for rotating when rotating turtle  
float angle1; 
final float speedAngle=3.972;

// font 
PFont font; 

// logfile 
String log=""; 

// state show log file: no editor only text displaying 
TextBoxDisplayOnly tboxLogFile1, tboxLogFile2;

// standard commands with 1 parameter 
String cmdsWithOneParameter =
  "#FORWARD#BACKWARD#RIGHT#LEFT#NOSEDOWN#NOSEUP#ROLLRIGHT#ROLLLEFT#"
  +"#SINK#RISE#SIDEWAYSRIGHT#SIDEWAYSLEFT#FORWARDJUMP#BACKWARDJUMP#ELLIPSE#";

String cmdsOther =
  "#LEARN#REPEAT#END#BOX#SPHERE#)#]#//#SHOWTURTLE#ARROW#"
  +"TURTLE#COLOR#BACKGROUND#GRIDON#GRIDOFF#PENDOWN#PENUP#"
  +"GRIDCOLOR#ELLIPSE#SET#ADD#SUB#MULT#DIV#HELP#";

// ------------------------------------------------------------
// processing core 

void setup() {
  // 3D size 
  size(1300, 1000, P3D);

  // init new turtle
  t = new Turtle();

  // focus the cam on the center 
  camera = new PeasyCam(this, 25, 25, -25, 100);

  iconLoad = loadImage("iconLoad.jpg");

  // init buttons 
  setupButtons(); 

  // font 
  font=createFont("Arial", 24);
  textFont(font);

  // background etc. 
  background(192);
  avoidClipping();

  // text editor init 
  instantiateBox();

  // set the filename text 
  if (fileName.equals("")) {
    fileName="<Not a file>";
  }
} //func

void draw() {
  background(192);

  // the core 
  stateManagement();
  //
}//func
//