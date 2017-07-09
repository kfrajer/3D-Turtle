
// state manually 

void handleStateManually() {

  if (keyPressed) {
    keyPressedForManuallyState_ManyTimes();
  }

  avoidClipping(); 
  lights();
  camera.setActive(true); 
  statusBarText = "Manual MODE. Steer the Turtle with keys. H - Help. Use Cursor, wasd, ijkl etc. to steer Turtle. "
    +"Mouse to rotate and pan camera (peasycam), "
    +"Mouse wheel to zoom+-, r to reset camera, Esc to quit.";
  background(0);
  pushMatrix();
  stateText="";
  stroke(211); 
  // t.flagDrawGridOnFloor = true;
  t.drawGridOnFloor();
  //noStroke(); 
  t.setColor(color(0, 255, 0));
  fill(t.turtleColor);  
  t.penDown(); 
  parser.parse(tbox1.getText());
  t.showTurtle();
  popMatrix();
  // status bar (HUD) 
  statusBar();
  statusBarForManually();
}

void handleStateManuallyHelp() {
  background(0);
  statusBarText = "Help MODE for Manual Input Mode. Space Bar to go back. ";
  // t.help(); 
  // status bar (HUD)
  // display a text 
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(SHAPE);

  fill(255);
  textMode(SHAPE);

  textSize(14); 
  String t1="Help on Manually Teach the Turtle\n\n"
    +"H - This Help\n\n"
    +"Cursor keys\n"
    +"Crs up and down - forward and backward drawing \n"
    +"Crs l and r - turn left and right \n\n"

    +"WASD\n"
    +"W and S - Nose up and nose down - start diving  \n"
    +"A and D - Roll left and right  \n\n"

    +"IJKL\n"
    +"I and K - Rise and sink \n"
    +"J and L - sideways left and right  \n\n"

    +"Pen up and down: Space bar (pen up=don't draw) and 0 (pen down=draw). This can be seen after the Turtle walked several steps. \n\n"

    +"c - comment line with // ----- \nv - REPEAT line (place closing ) later in the code) \nb - LEARN line (place closing ] later)\n\n"

    +"1, 2 and 3 - color red, green and blue \n4, 5 and 6 - box, sphere and ellipse \n\n" 

    ;
  text( t1, 18, 25);
  camera.endHUD();
  //  println (helpText());

  statusBar();
}
//
void insertALine(String newText, boolean isAddableCommand ) {

  // inserts a line "newText" at end of code

  // isAddableCommand tells whether we can (potentially) add the text of the line to the previous line.
  // E.g. foward 1 in the previous line and foward 1 in the current line should result in
  // foward 2 (isAddableCommand is true).
  // Even with isAddableCommand being true, we do not always add the lines up; e.g.foward 1 and 
  // rollright 1 don't add up.
  // isAddableCommand is false for lines such as penUp which can't add up at all. 

  // first check whether this command, e.g. forward 1 is the same as the last one.
  if (isAddableCommand  &&  firstWord(manuallyLastCommand).equals(firstWord(newText))) {
    // yes, equal
    int dummy =  tbox1.currentLine-1; //     tbox1.editorArray.length-1;
    int result1 = int(secondWord(tbox1.editorArray[dummy].text1))+int( secondWord(newText));
    tbox1.editorArray[dummy].text1 = firstWord(newText) + " " +str(result1);
    textForStatusBarManuallyOnTopScreen=firstWord(newText) + " " +str(result1); 
    // QUIT here
    return;
  }

  tbox1.currentLine = tbox1.editorArray.length; 

  // new line inserted after the old line
  EditorLine[] newLineArray=new EditorLine[1];

  //
  newLineArray[0] = new EditorLine(newText);

  textForStatusBarManuallyOnTopScreen=newText; 

  // Splice one array of values into another
  tbox1.editorArray = (EditorLine[]) splice(tbox1.editorArray, newLineArray, tbox1.currentLine);

  tbox1.currentLine++;

  manuallyLastCommand=newText;
}

String firstWord(String lineString) {
  //returns "forward" from "forward 20" 
  if (lineString.equals(""))
    return"";
  String[]dummy=split(lineString, " ");
  return trim(dummy[0]);
}

String secondWord(String lineString) {
  //returns "20" from "forward 20" 
  if (lineString.equals(""))
    return"";
  String[]dummy=split(lineString, " ");
  if (dummy.length>1) 
    return trim(dummy[1]);
  else return "";
}

boolean isNumeric(String testWord) {
  // for int numbers, not float  

  testWord=trim(testWord); 
  if (testWord.equals(""))
    return false; 

  // first we check if a wrong char is present 
  for (int i=0; i<testWord.length(); i++) {
    if ("0123456789-".indexOf(testWord.charAt(i))<0) {
      return false;  // abort with false
    }//if
  }//for

  // second: to avoid that testWord might be "---"
  // we need to find one number
  boolean foundOne = false; 
  for (int i=0; i<testWord.length(); i++) {
    if ("0123456789".indexOf(testWord.charAt(i))>=0) {
      foundOne = true;
    }//if
  }//for

  if (!foundOne) 
    return false;

  // do we have a minus
  if (testWord.contains("-")) {
    // only one minus allowed 
    int countMinus=0;
    for (int i=0; i<testWord.length(); i++) 
      if (testWord.charAt(i)=='-')
        countMinus++;
    if  (countMinus>1) 
      return false;
    // -------------------
    if (testWord.indexOf('-')!=0)
      return false;
  }

  return true;
}//func

void statusBarForManually() {

  // display a text in the upper left corner

  noLights(); 
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  // noLights();
  // textMode(MODEL);
  textMode(SHAPE);

  // the rect of the status bar
  fill(111); // gray 
  noStroke(); 
  rect(0, 0, width, 30);

  // the text 
  fill(0);
  textAlign(LEFT, BASELINE); 
  textSize(12);
  text(textForStatusBarManuallyOnTopScreen, 
    13, 14);

  //textSize(24); 
  textFont(font);
  textMode(MODEL);
  //text(stateText, 19, 24); 

  // end HUD 
  hint(ENABLE_DEPTH_TEST);
  camera.endHUD();
}
//