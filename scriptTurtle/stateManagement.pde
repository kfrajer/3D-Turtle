
// the different states

void stateManagement() {

  switch (state) {

  case stateWelcomeScreen:
    // welcome screen
    camera.reset(); 
    pushMatrix();
    stateText="\n\nWelcome to the Turtle Script program. \n\n\n\n"
      +"In Edit Mode hit # to run, in run mode hit space to go back.\n\n\n"
      +"Hit any key to go on \n\n" ;
    statusBarText = "Welcome to the Turtle. Press Space Bar to go to the Turtle editor. ";
    t.forwardJump(47);
    lights(); 
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    // display editor and texts 
    camera.beginHUD();
    // status bar (HUD)
    statusBar(); 
    camera.endHUD();
    break;

  case stateEdit:
    // EDIT

    // display editor and texts 
    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);
    rectMode(CORNER);

    statusBarText = "EDIT MODE. # for Run the Script.";
    stateText     = ""; 

    fill(0);
    textSize(14); 
    tbox1.display();
    textSize(24);
    // status bar (HUD) 
    statusBar(); 
    showButtons();

    fill(0);
    text("Edit Mode - save first before quitting the program.\nFile: "
      +fileName+"\n"
      +"Line number: "
      +tbox1.currentLine, 
      660, 55); 
    camera.endHUD();
    break;

  case stateRun:
    // RUN the Turtle Script 
    avoidClipping(); 
    lights();
    camera.setActive(true); 
    statusBarText = "RUN MODE. L - toggle line type, "
      +"Mouse to rotate and pan camera (peasycam), "
      +"Mouse wheel to zoom+-, r to reset camera, a to toggle TurtleBody, Esc to quit.";
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
    popMatrix();
    // status bar (HUD) 
    statusBar(); 
    break;    

  case stateError: 
    // error in code of the script 
    pushMatrix();
    stateText="\n\n An Error occured \n\n\n\n"
      +errorMsg;
    statusBarText = "Error MODE. Space Bar to go back. ";
    t.forwardJump(47);
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    // status bar (HUD) 
    statusBar(); 
    break; 

  case stateWaitForSave:
    // wait
    if (!savePath.equals("")) {
      state = stateEdit; 
      if (savePath.indexOf(".txt") < 0) {
        savePath+=".txt"; // very rough approach...
      }
      saveStrings(savePath, tbox1.getTextAsArray());

      fileName=nameFromPath(savePath);

      if (fileName.equals(""))
        fileName="<Not a file>";
    }//if
    // status bar (HUD) 
    statusBar(); 
    break;

  case stateWaitForLoad:
    // wait

    // check if the input has been made: 
    if (!loadPath.equals("")) {
      // yes, waiting is over 
      state = stateEdit; 
      if (loadWithInsert) {
        // loading and insert into existing sketch        
        tbox1.writeLineBackInArray();
        // load a separate array
        String[] loadedArray=loadStrings(loadPath);
        // Splice one array of values into another
        tbox1.spliceArray(loadedArray);
        loadedArray=null; 
        tbox1.initNewLine();
      } else {
        // classical loading 
        String[] temp = loadStrings(loadPath);
        tbox1.initText(join(temp, "\n")); 
        temp=null;          
        tbox1.start=0; 
        tbox1.initNewLine();
        fileName=nameFromPath(loadPath);
        if (fileName.equals("")) {
          fileName="<Not a file>";
        }
      }//else
    } // outer if
    // status bar (HUD) 
    statusBar(); 
    break; 

  case stateHelp:
    // help
    background(0);
    statusBarText = "Help MODE. Space Bar to go back. ";
    t.help(); 
    // status bar (HUD) 
    statusBar(); 
    break; 

  case stateShowLogfile:
    // show logfile
    statusBarText = "Logfile MODE. Space Bar to go back. ";

    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);

    // headers
    fill(0);
    textSize(24); 
    text("Your Turtle Script", 17, 35); 
    text("Your LogFile", width/2+17, 35); 

    // 2 boxes 
    fill(0);
    textSize(14); 
    tboxLogFile1.display();
    tboxLogFile2.display();

    // 2 help texts 
    textSize(14); 
    text("What is it? This is your Turtle Script.", 
      17, height-97, 
      width/2-22, height);
    text("What is it? A log file records what the Turtle Script did "
      +"(This is a very simple log-file by the way). \nIn a simple Turtle Script, "
      +"the log files is almost the same as the Turtle Script. "
      +"In a more complex Turtle Script you see e.g. how Repeat and the functions (Learn) are handled.", 
      width/2+17, height-97, 
      width/2-22, height);

    stroke(255);
    line(width/2-4, 0, width/2-4, height);

    // status bar (HUD) 
    statusBar(); 
    showButtonsLogFile();
    camera.endHUD();

    break; 

  default:
    //error
    println ("Error 102, unknown state ++++++++++++++++++++++   "
      +state);
    exit();
    state=0;
    break;
    //
  } //switch
} //func 
//