

void mouseMoved() {
  // valid in all states 
  // store time since last mouse moved
  timeSinceLastMouseMoved=millis();
}

void mousePressed() {

  // (depending on state)

  // mouse pressed 

  // store time since last mouse moved / pressed  
  timeSinceLastMouseMoved = millis();

  // depending on state
  switch (state) {

  case stateEdit:  
    // when you edit your sketch
    mousePressedForStateEdit();
    break;

  case stateRun:  
    // when you run your sketch
    // do nothing 
    // state=stateEdit; 
    break;

  case stateWelcomeScreen:
  case stateHelp:
  case stateShowLogfile:
    // this ends the splash screen / the help
    state = stateEdit;
    break; 

  case stateError:
  case stateWaitForSave:
  case stateWaitForLoad:
    // do nothing 
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
    // New
    tbox1.editorArray = split(tbox1.text1, "\n");
    tbox1.currentLine=0;
    tbox1.currentColumn=0;
    tbox1.initNewLine();
    break; 

  case 4: 
    // init the loading process II
    loadWithInsert=true; 
    loadProgram();
    break;

  case 5: 
    //delete line
    tbox1.writeLineBackInArray(); 
    String[] before = (String[]) subset(tbox1.editorArray, 0, tbox1.currentLine);
    String[] after  = (String[]) subset(tbox1.editorArray, tbox1.currentLine+1);
    printArray(before); 
    printArray(after); 
    tbox1.editorArray =  (String[]) concat(before, after); 
    tbox1.initNewLine();
    break; 

  case 6:
    state=stateHelp; 
    break;

  case 7: 
    state=stateShowLogfile;
    break; 

  case 8:
    // paste from clipboard into code

    ///  String[] clipboardArray=split(GetTextFromClipboard(), "\n");
    // Splice one array of values into another
    //  tbox1.spliceArray(clipboardArray);
    // clipboardArray=null; 
    //  tbox1.initNewLine();
    break; 

  default:
    println ("Error 91: unknown command int: "
      +commandNumber); 
    exit(); 
    break;
  }//switch
}//func
//