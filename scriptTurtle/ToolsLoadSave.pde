
// manage load and save

String savePath=""; 
String loadPath=""; 
boolean loadWithInsert=false; 

void loadProgram() {
  //
  state=stateWaitForLoad;
  loadPath="";
  File start1 = new File(sketchPath("")+"/myPrograms/*.txt"); 
  selectInput("Select a file to write to:", "fileSelectedForLoad", start1);
}

void saveProgram() {
  //
  state=stateWaitForSave; 
  savePath="";
  File start1 = new File(sketchPath("")+"/myPrograms/*.txt");
  selectOutput("Select a file to write to:", "fileSelectedForSave", start1);
}

// ------------------------------------------------------------

void fileSelectedForSave(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    state=stateEdit;
  } else {
    savePath=selection.getAbsolutePath();
    println("User selected " + savePath);
  }
}

void fileSelectedForLoad(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    state=stateEdit;
  } else {
    loadPath=selection.getAbsolutePath(); 
    println("User selected " + selection.getAbsolutePath());
  }
}