
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
final int stateManually      = 8; 
final int stateManuallyHelp  = 9; 
int state = stateWelcomeScreen;  // current

// other variables --------------

String versionString = "Version 0.1.314";

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

// for state manually 
String textForStatusBarManuallyOnTopScreen=""; 
String manuallyLastCommand=""; 

// standard commands with 1 parameter 
String cmdsWithOneParameter =
  "#FORWARD#BACKWARD#RIGHT#LEFT#NOSEDOWN#NOSEUP#ROLLRIGHT#ROLLLEFT#"
  +"#SINK#RISE#SIDEWAYSRIGHT#SIDEWAYSLEFT#FORWARDJUMP#BACKWARDJUMP#ELLIPSE#";

String cmdsOther =
  "#LEARN#REPEAT#END#BOX#SPHERE#)#]#//#SHOWTURTLE#ARROW#"
  +"TURTLE#COLOR#BACKGROUND#GRIDON#GRIDOFF#PENDOWN#PENUP#"
  +"GRIDCOLOR#ELLIPSE#SET#ADD#SUB#MULT#DIV#HELP#";

// manage load and save ----------------------------------------

String savePath=""; 
String loadPath=""; 
boolean loadWithInsert=false; 

String loadedFile = ""; 

String fileName = ""; 

// For the screen Buttons -------------------------------------

// for debugging and making new buttons set to true; 
// standard is false 
final boolean showButtonsForDebugging = false;  

// how many for edit mode 
final int btnLengthInMainMenu = 13;  // (in main menu (upper left corner))
final int btnLengthInLogFile  = 4;   // log file 

final color colYellow = color(244, 244, 44);

boolean locked;

// colors Buttons 
final color col1 = #ff0000;
final color col2 = #ffff00;
final color col3 = #000000;

// for the tool tip text 
int timeSinceLastMouseMoved=millis(); // store time since last mouse moved / pressed

ArrayList<RectButton> rectButtons = new ArrayList(); 

ArrayList<RectButton> rectButtonsStateLogFile = new ArrayList(); 

PImage iconLoad;


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
  if (state!=stateManually)
    background(192);

  // the core (see tab states)
  stateManagement();
  //
}//func
//