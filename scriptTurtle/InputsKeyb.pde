
// Inputs Keyboard  

void keyPressed() {

  switch (state) {

  case stateWelcomeScreen:
    // welcome screen
    if (key==ESC) {
      key=0; // kill
      state=stateEdit;
    }
    state=stateEdit;
    textSize(14);
    break; 

  case stateEdit:
    //editor mode
    keyPressedForEditState();
    break; 

  case stateRun: 
    // RUN 
    keyPressedForRunState() ;
    break;

  case stateHelp:
  case stateError:
  case stateShowLogfile:
    if (key==ESC) {
      key=0; // kill
    }
    state=stateEdit; 
    break; 

  case stateManually:
    // there is also another function named 
    // keyPressedForManuallyState_ManyTimes()
    keyPressedForManuallyState_OneTime(); 
    break; 

  case stateManuallyHelp:
    // just go back from the special help to the
    // stateManually
    if (key==ESC) {
      key=0; // kill Esc
    }
    state = stateManually;
    break; 

  default:
    //error
    println ("Error 104, unknown state ++++++++++++++++++++++   "
      +state);
    exit();
    state=stateEdit;
    break;
  }//switch 
  //
} //func

// ----------------------------------------------------------------------
// called by keyPressed()

void keyPressedForManuallyState_OneTime() {

  // this is called by FUNCTION keyPressed() and is  
  //  therefore called only once per key press 

  if (key==ESC) {
    key=0; // kill Esc
    state=stateEdit;
    return;
  } 

  if (  key==CODED ) {

    switch (keyCode) { 
      // empty
    }
  } //  coded 
  // -------------------------------------- 
  // NOT CODED : ------------------------
  else {
    switch (key) { 

    case BACKSPACE:
      //delete line
      tbox1.currentLine = tbox1.editorArray.length-1; 
      if (tbox1.currentLine<=0) {
        tbox1.currentLine=0;
        return;
      }

      // tbox1.writeLineBackInArray(); 
      EditorLine[] before = (EditorLine[]) subset(tbox1.editorArray, 0, tbox1.currentLine);
      EditorLine[] after  = (EditorLine[]) subset(tbox1.editorArray, tbox1.currentLine+1);
      EditorLine[] dummy = (EditorLine[]) concat(before, after); 
      tbox1.editorArray=dummy;  // = tbox1.initText( join(dummy,"\n" );  
      //tbox1.initNewLine();
      break; 

    case ' ':
      // t.penDown=false;
      insertALine(  "penup", false);
      break;

    case '0':
      // t.penDown=false;
      insertALine(  "pendown", false);
      break;

    case 'r': // reset 
      camera.reset(); 
      break; 

    case 'H': 
    case 'h': // help 
      // t.help(); 
      state=stateManuallyHelp;
      break;

      // ---------------------------------

    case 'c': //  
      insertALine(  "// -------------------------------", false); 
      break;

    case 'v': //  
      insertALine(  "REPEAT 4 ( ", false); 
      break;

    case 'b': //  
      insertALine(  "LEARN [ ", false); 
      break;

      // more numbers 

    case '1': //  
      insertALine(  "color RED", false); 
      break;

    case '2': //  
      insertALine(  "color GREEN", false); 
      break;

    case '3': //  
      insertALine(  "color BLUE", false);
      break;

    case '4': //  
      insertALine(  "box", false); 
      break;

    case '5': //  
      insertALine(  "sphere", false); 
      break;

    case '6': //  
      insertALine(  "ellipse 55", false);
      break;
    }
  }
}

void keyPressedForManuallyState_ManyTimes() {

  // this is called when variable keyPressed is true and 
  // can therefore be called many times 

  if (key==ESC) {
    key=0; // kill Esc
    state=stateEdit;
    return;
  } 

  if (  key==CODED ) {

    switch (keyCode) { 

    case UP: 
      insertALine(  "forward 1", true);  
      break; 

    case DOWN: //  
      insertALine(  "backward 1", true);  
      break;

    case LEFT: 
      insertALine(  "left 1", true);  
      break; 

    case RIGHT: //  
      insertALine(  "right 1", true);
      break;
    }
  } //  coded 
  // -------------------------------------- 
  // NOT CODED : ------------------------
  else {
    switch (key) { 

    case BACKSPACE:
      //delete line
      tbox1.currentLine = tbox1.editorArray.length-1; 
      if (tbox1.currentLine<=0) {
        tbox1.currentLine=0;
        return;
      }

      // tbox1.writeLineBackInArray(); 
      EditorLine[] before = (EditorLine[]) subset(tbox1.editorArray, 0, tbox1.currentLine);
      EditorLine[] after  = (EditorLine[]) subset(tbox1.editorArray, tbox1.currentLine+1);
      EditorLine[] dummy = (EditorLine[]) concat(before, after); 
      tbox1.editorArray=dummy;  // = tbox1.initText( join(dummy,"\n" );  
      //tbox1.initNewLine();
      break; 

      // WASD keys  

    case 'w': //  
      insertALine(  "noseDown 1", true);
      break; 

    case 's': //  
      insertALine(  "noseUp 1", true); 
      break;


    case 'a': //  
      insertALine(  "rollLeft 1", true);   // takes effect only after the next rotation 
      break; 

    case 'd': //  
      insertALine(  "rollRight 1", true); 
      break;

      // IJKL keys 


    case 'i': //  
      insertALine(  "rise 1", true);
      break; 

    case 'k': //  
      insertALine(  "sink 1", true); 
      break;

    case 'j': //  
      insertALine(  "sidewaysLeft 1", true);
      break; 

    case 'l': //  
      insertALine(  "sidewaysRight 1", true); 
      break;

      // ---------------------------------
      // more numbers 

    case '9': //  
      insertALine(  "", false); 
      break;

    case '8': //  
      insertALine(  "", false); 
      break;

    case '7': //  
      insertALine(  "", false); 
      break;
    }
  }
}

void keyPressedForEditState() {

  // keyboard input for Edit state

  if (key==ESC) {
    key=0; // kill
    return;
  } else if (key == '}') {
    // exit(); // not necessary / user uses the Window closing button
  } else if (key == '#') {
    state = stateRun;
  } else {
    // editor codes ! 
    tbox1.keyPressedInClassEditor();
  }
}

void keyPressedForRunState() {

  // not coded : 

  if (key==ESC) {
    key=0; // kill
  }

  switch (key) { 

  case 'r': // reset 
    camera.reset(); 
    break; 

  case 'h': // help 
    t.help(); 
    break; 

  case 'l': // toggle line type
    t.lineType = !t.lineType; 
    break; 

  case 'a':
    t.typeTurtlePShapeIsTurtle=
      !t.typeTurtlePShapeIsTurtle;
    break; 

  default: 
    // go back 
    println (log); 
    // println(log.substring(0, 200) ); 
    state=stateEdit;
    // camera.setActive(true); 
    break; 
    //
  }//switch
  //
}// func
//