
// tab Inits Mouse  

void mouseMoved() {
  // valid in all states 
  // store time since last mouse moved

  timeSinceLastMouseMoved=millis();
} //func

void mousePressed() {

  // (depending on state)

  // mouse pressed 

  // store time since last mouse moved / pressed  
  timeSinceLastMouseMoved = millis();

  // depending on state
  switch (state) {

  case stateEdit:  
    // when you edit your script 
    mousePressedForStateEdit();
    break;

  case stateRun:  
    // when you run your script
    // do nothing 
    // state=stateEdit; 
    break;

  case stateWelcomeScreen:
  case stateHelp:  
    // this ends the splash screen / the help etc.
    state = stateEdit;
    break; 

  case stateShowLogfile:
    // 4 scroll buttons  
    boolean done=false;
    for (int i=0; i<btnLengthInLogFile; i++) {
      if (rectButtonsStateLogFile.get(i).over() && !done) {
        done = true;
        doCommandMouseLogFile(i); // very important function 
        break;
      } // if
    } // for
    break; 

  case stateError:
  case stateWaitForSave:
  case stateWaitForLoad:
  case stateManually:
    // do nothing 
    break; 

  case stateManuallyHelp:
    state = stateManually;
    break; 

  default:
    // error 
    println ("Error 9032: unknown state in tab InputMouse : " 
      + state + ".");
    exit();
    break;
  } // switch 
  //
} // func

void mousePressedForStateEdit() {

  // upper left command bar 

  boolean done=false;

  for (int i=0; i<btnLengthInMainMenu; i++) {
    if (rectButtons.get(i).over() && !done) {
      done = true;
      doCommandMouse(i); // very important function 
      break;
    } // if
  } // for

  if (!done) {
    tbox1.mousePressed1();
  }
} //func 

void doCommandMouse(int commandNumber) {

  switch (commandNumber) {

  case 0:
    // run (play (>) button)
    state=stateRun;
    break;

  case 1:
    // init the loading process I
    loadWithInsert=false; 
    loadProgram();
    break;

  case 2:
    // save  
    saveProgram(); 
    break;

  case 3:
    // save as...
    saveProgramAs();
    break; 

  case 4:
    // New
    tbox1.initText(tbox1.textExample1); 
    tbox1.currentLine=0;
    tbox1.initNewLine();
    loadedFile=""; 
    fileName=""; 
    if (fileName.equals("")) {
      fileName="<Not a file>";
    }
    break; 

  case 5: 
    // init the loading process II
    loadWithInsert=true; 
    loadProgram();
    break;

  case 6: 
    //delete line
    tbox1.writeLineBackInArray(); 
    EditorLine[] before = (EditorLine[]) subset(tbox1.editorArray, 0, tbox1.currentLine);
    EditorLine[] after  = (EditorLine[]) subset(tbox1.editorArray, tbox1.currentLine+1);
    EditorLine[] dummy = (EditorLine[]) concat(before, after); 
    tbox1.editorArray=dummy;  // = tbox1.initText( join(dummy,"\n" );  
    tbox1.initNewLine();
    break; 

  case 7:
    state=stateHelp; 
    break;

  case 8: 
    instantiateBoxLogFile(); 
    state=stateShowLogfile;
    break; 

    // scrolling 
  case 10:
    // scrolling 
    tbox1.start--;
    if (tbox1.start<0)
      tbox1.start=0;
    break;

  case 11:
    // scrolling 
    tbox1.start++;
    if (tbox1.start > tbox1.editorArray.length-tbox1.linesInEditor)
      tbox1.start=tbox1.editorArray.length-tbox1.linesInEditor;
    break;

  case 9: 
    // manually steer
    // init state 
    // tbox1.writeLineBackInArray(); 
    // tbox1.initText("\n"); 
    manuallyLastCommand="";
    tbox1.currentLine = tbox1.editorArray.length-1;
    tbox1.initNewLine();
    loadedFile = ""; 
    fileName   = ""; 
    if (fileName.equals("")) {
      fileName="<Not a file>";
    }
    state = stateManually;
    break; 

  default:
    println ("Error 91: unknown command int: "
      +commandNumber
      +" +++++++++++++++++++++++++++++++++++++"); 
    exit(); 
    break;
  }//switch
}//func

void doCommandMouseLogFile(int commandNumber) {

  switch (commandNumber) {

    // scrolling 
  case 0:
    // scrolling 
    tboxLogFile1.start--;
    if (tboxLogFile1.start<0)
      tboxLogFile1.start=0;
    break;

  case 1:
    // scrolling 
    tboxLogFile1.start++;
    if (tboxLogFile1.start > tboxLogFile1.editorArray.length-tboxLogFile1.linesInEditor)
      tboxLogFile1.start=tboxLogFile1.editorArray.length-tboxLogFile1.linesInEditor;
    if (tboxLogFile1.start<0)
      tboxLogFile1.start=0;
    break;

  case 2:
    // scrolling 
    tboxLogFile2.start--;
    if (tboxLogFile2.start<0)
      tboxLogFile2.start=0;
    break;

  case 3:
    // scrolling 
    tboxLogFile2.start++;
    if (tboxLogFile2.start > tboxLogFile2.editorArray.length-tboxLogFile2.linesInEditor)
      tboxLogFile2.start=tboxLogFile2.editorArray.length-tboxLogFile2.linesInEditor;
    if (tboxLogFile2.start<0)
      tboxLogFile2.start=0;
    break;

  default:
    println ("Error 221: unknown command int: "
      +commandNumber); 
    exit(); 
    break;
  }//switch
}//func

void mouseWheel(MouseEvent event) {
  if (state==stateEdit) {
    // edit state 
    float e = event.getCount();
    println(e); 
    tbox1.mouseWheelTextArea(event);
  } else if (state==stateShowLogfile) {
    // in log file state 
    tboxLogFile1.mouseWheelTextArea(event);
    tboxLogFile2.mouseWheelTextArea(event);
  } // else if
}//func 
//