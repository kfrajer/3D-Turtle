
// ------------------------------------------------------------
// Inputs 

void keyPressed() {

  switch (state) {

  case stateWelcomeScreen:
    // welcome screen
    if (key==ESC) {
      key=0; // kill
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

  case stateError:
    if (key==ESC) {
      key=0; // kill
    }
    state=stateEdit; 
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

void keyPressedForEditState() {

  // keyboard input for Edit state

  if (key==ESC) {
    key=0; // kill
    return;
  } else if (key == '}') {
    exit();
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

  default: 
    // go back 
    state=stateEdit;
    // camera.setActive(true); 
    break; 
    //
  }//switch
  //
}// func
//