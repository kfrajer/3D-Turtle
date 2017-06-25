
// Minor Functions / tools 

void instantiateBox() {

  // text editor box

  tbox1 = new TextBox(
    12, 80, // x, y
    400, height-110, // w, h
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor
}

void instantiateBoxLogFile() {

  // 2 text boxes for log file state

  // left for the script 

  tboxLogFile1 = new TextBoxDisplayOnly(
    12, 80, // x, y
    500, height-190, // w, h   
    tbox1.getText(), 
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor


  // ------------------------------------------------------

  // right for the log 

  String logHelpText=""; 

  if (trim(log).equals("")) {
    logHelpText="\n<You must run your Turtle Script once to \nsee the log data. >";
  } else {
    logHelpText=log;
  }

  tboxLogFile2 = new TextBoxDisplayOnly(
    width/2+ 12, 80,  // x, y
    500, height-190,  // w, h
    logHelpText, 
    color(65),     // textAreaTextColor
    color(255),    // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor
}

void statusBar() {

  // display a text in the corner
  noLights(); 
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  // noLights();
  // textMode(MODEL);
  textMode(SHAPE);

  // the rect of the status bar
  fill(111); // gray 
  noStroke(); 
  rect(0, height-19, width, 30);

  // the text 
  fill(0);
  textAlign(LEFT, BASELINE); 
  textSize(12);
  text(statusBarText+ " "+versionString, 
    3, height-4);

  //textSize(24); 
  textFont(font);
  textMode(MODEL);
  text(stateText, 19, 24); 

  // end HUD 
  hint(ENABLE_DEPTH_TEST);
  camera.endHUD();
}

void avoidClipping() {
  // avoid clipping : 
  // https : // 
  // forum.processing.org/two/discussion/4128/quick-q-how-close-is-too-close-why-when-do-3d-objects-disappear
  perspective(PI/3.0, (float) width/height, 1, 1000000);
}
//