
/**
 * credits:
 *
 * Turtle3D RectBox
 * 2017-02-07 Jeremy Douglass - Processing 3.2.3 - thank you! 
 * https:// forum.processing.org/two/discussion/20706/how-3d-turtle-like-in-logo-but-3d-math-problem
 
 * Thanks to PeasyCam 
 * Thanks to GoToLoop for the text input area
 *
 */

import peasy.*;

import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;

import java.awt.datatransfer.*;

import com.jogamp.newt.opengl.GLWindow;

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
final int stateWelcomeScreen = 0; 
final int stateEdit          = 1; 
final int stateRun           = 2; 
final int stateError         = 3; 
final int stateWaitForSave   = 4; 
final int stateWaitForLoad   = 5;
final int stateHelp          = 6;
final int stateShowLogfile   = 7;
int state = stateWelcomeScreen;  // 

// other variables --------------

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

// ------------------------------------------------------------
// processing core 

void setup() {
  // 3D size 
  size(1300, 1000, P3D);

  // init new turtle
  t = new Turtle(); 

  // focus the cam on the center of the box
  camera = new PeasyCam(this, 25, 25, -25, 100);

  // help text 
  println ("Hit any key for next page.\n\n");

  iconLoad = loadImage("iconLoad.jpg");

  setupButtons(); 

  // font 
  font=createFont("Arial", 24);
  textFont(font);

  // background etc. 
  background(192);
  avoidClipping();

  instantiateBox();
}//func

void draw() {
  background(192);
  avoidClipping(); 
  lights();

  // the core 
  stateManagement();

  // status bar (HUD) 
  statusBar(); 

  // Saves each frame as screen-0001.tif, screen-0002.tif, etc.
  // saveFrame("line-######.png");
  //
}//func
//