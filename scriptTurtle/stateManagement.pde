
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

    text("Edit Mode - save first then hit } to quit program.", 660, 55); 
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
    noStroke(); 
    t.setColor(color(0, 255, 0));
    fill(t.turtleColor);  
    t.penDown(); 
    parser.parse(tbox1.getText());
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
        tbox1.editorArray = loadStrings(loadPath);
        tbox1.initNewLine();
      }
    }
    break; 

  case stateHelp:
    background(0);
    statusBarText = "Help MODE. Space Bar to go back. ";
    t.help(); 
    break; 

  case stateShowLogfile:

    statusBarText = "Logfile MODE. Space Bar to go back. ";

    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);

    fill(255);
    textMode(SHAPE);

    fill(0);
    textSize(14); 

    text("Your Turtle program", 17, 25); 
    text(tbox1.getText(), 17, 64);  
    text("Your LogFile", width/2, 25); 

    String logHelpText=""; 

    if (trim(log).equals("")) {
      logHelpText="\n<You must run your Turtle program once to \nsee the log data. >";
    } else {
      logHelpText=log;
    }

    text(logHelpText
      +"\n\nWhat is it? A log file records what the Turtle program did "
      +"(This is a very simple log-file by the way). In a simple Turtle program, "
      +"the log files is almost the same as the Turtle program. "
      +"In a more complex Turtle program you see e.g. how Repeat and the functions (Learn) are handled.", 
      width/2, 64, width/2-22, height);

    stroke(255);
    line(width/2-4, 0, width/2-4, height);

    camera.endHUD();

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