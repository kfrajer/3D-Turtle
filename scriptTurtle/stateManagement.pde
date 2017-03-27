
// the pages in the tutorial

void stateManagement() {

  switch (state) {

  case stateWelcomeScreen:
    // welcome screen
    pushMatrix();
    stateText="\n\nWelcome to the turtle script program \n\n\n\n"
      +"In Edit Mode hit # to run, in run mode hit space to go back.\n\n\n"
      +"Hit any key to go on \n\n" ;
    statusBarText = "Welcome to the Turtle. Space Bar to go to the Turtle editor. ";
    t.onSurfaceX(47);
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    break;

  case stateEdit:
    // EDIT
    statusBarText = "EDIT MODE. # for Run the program. } to leave entirely.  ";
    lights(); 
    pushMatrix();
    stateText=""; 
    t.onSurfaceX(47);
    t.onSurfaceY(4);
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();

    // display a text 
    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);
    rectMode(CORNER);
    showButtons();

    fill(0);
    textSize(14); 
    tbox1.display();
    textSize(24);

    text("Edit Mode - save first then hit } to quit program.", 400, 55); 
    camera.endHUD();
    break;

  case stateRun:
    // RUN 
    camera.setActive(true); 
    statusBarText = "RUN MODE. L - toggle line type, "
      +"Mouse to rotate and pan camera (peasycam), "
      +"Mouse wheel to zoom+-, r to reset camera, Esc to quit.";
    background(0);
    pushMatrix();
    stateText="";
    t.drawGridOnFloor(); 
    t.setColor(color(0, 255, 0));
    t.penDown(); 
    parser.parse(tbox1.getText());
    // t.showTurtle(); 
    popMatrix();
    break;    

  case stateError: 
    pushMatrix();
    stateText="\n\n An Error occured \n\n\n\n"
      +errorMsg;
    statusBarText = "Error MODE. Space Bar to go back. ";
    t.onSurfaceX(47);
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    break; 

  case stateWaitForSave:
    //
    if (!savePath.equals("")) {
      state = stateEdit; 
      if (savePath.indexOf(".txt") < 0) 
        savePath+=".txt"; // very rough approach...
      saveStrings(savePath, tbox1.editorArray);
    }
    break;

  case stateWaitForLoad:
    // wait
    if (!loadPath.equals("")) {
      // waiting is over 
      state = stateEdit; 
      if (loadWithInsert) {
        //         
        tbox1.writeLineBackInArray();
        // load a separate array
        String[] loadedArray=loadStrings(loadPath);
        // Splice one array of values into another
        tbox1.spliceArray(loadedArray);
        loadedArray=null; 
        tbox1.initNewLine();
      } else {
        // classical loading 
        tbox1.editorArray = loadStrings(loadPath);
      }
    }
    break; 

  default:
    //error
    println ("Error 102, unknown state ++++++++++++++++++++++   "
      +state);
    exit();
    state=0;
    break;
  } //switch
} //func 
//