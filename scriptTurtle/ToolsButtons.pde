
// command buttons on the screen 
// functions and classes 

// -----------------------------------------------------------------------------------------
// Init Buttons

// for debugging and making new buttons set to true; 
// standard is false 
final boolean showButtonsForDebugging = false;  

// how many for edit mode 
final int btnLengthInMainMenu = 12;  // (in main menu (upper left corner))
final int btnLengthInLogFile  = 4;   // log file 

final color colYellow = color(244, 244, 44);

boolean locked;

// colors Buttons 
final color col1 = #ff0000;
final color col2 = #ffff00;
final color col3 = #000000;

// for the tool tip text 
int timeSinceLastMouseMoved=millis(); // store time since last mouse moved / pressed

ArrayList<RectButton> rectButtons = new ArrayList(); 

ArrayList<RectButton> rectButtonsStateLogFile = new ArrayList(); 

PImage iconLoad;

// --------------------------------------------------

void setupButtons() {

  // for the command-buttons on the right side of the screen
  int CmdButtonsX = width-70; 
  int CmdButtonsAbstand = 60; 
  int j = 0;

  // ---------------------------------------------

  // Init Buttons top left command bar
  for (int x=0; x < btnLengthInMainMenu; x++) {    
    // Using a multiple of x means the buttons aren't all on top of each other (and 20 is the distance to the left screen border)
    int xPos = x*64 + 20; 
    rectButtons.add(new RectButton(xPos, 20, 52, 52, col1, col2, true, "commandBarMain", 0, "", "", null));
  } // for

  rectButtons.get(0).ToolTipText =  "Run the Turtle Script, click me";
  rectButtons.get(0).Text = "Run";
  rectButtons.get(0).btnImage = loadImage("iconPlay.jpg");

  rectButtons.get(1).ToolTipText = "Load a sketch";
  rectButtons.get(1).Text = "Load";
  rectButtons.get(1).btnImage = iconLoad;

  rectButtons.get(2).ToolTipText = "Save sketch";
  rectButtons.get(2).Text = "Save";
  rectButtons.get(2).btnImage = loadImage("iconSave.jpg");

  int i=3; 
  rectButtons.get(i).ToolTipText = "Save sketch As... with a new name.";
  rectButtons.get(i).Text = "Save As...";
  rectButtons.get(i).btnImage = loadImage("iconSaveAs.jpg");

  i=4; 
  rectButtons.get(i).ToolTipText = "Delete entire sketch (Warning!)";
  rectButtons.get(i).Text = "NEW";
  rectButtons.get(i).btnImage = loadImage("iconNew.jpg");

  i=5; 
  rectButtons.get(i).ToolTipText = "Load file and insert into sketch";
  rectButtons.get(i).Text = "LoadInsert";
  rectButtons.get(i).btnImage = loadImage("iconInsertFile.jpg");

  i=6;
  rectButtons.get(i).ToolTipText = "Delete line from Script";
  rectButtons.get(i).Text = "DeleteLine";
  rectButtons.get(i).btnImage = loadImage("iconDeleteLine.jpg");

  i=7;
  rectButtons.get(i).ToolTipText = "Help on commands";
  rectButtons.get(i).Text = "HelpCommands";
  rectButtons.get(i).btnImage = loadImage("iconHelp.jpg");

  i=8;
  rectButtons.get(i).ToolTipText = "Show Logfile";
  rectButtons.get(i).Text = "ShowLogfile";
  rectButtons.get(i).btnImage = loadImage("iconLogfile.jpg");

  i=9;
  rectButtons.get(i).ToolTipText = "Paste from Clipboard. ";
  rectButtons.get(i).Text = "paste";
  rectButtons.get(i).btnImage = loadImage("iconPasteFC.jpg");
  rectButtons.get(i).Exists=false; 

  i=10;
  rectButtons.get(i).ToolTipText = "Scroll up. ";
  rectButtons.get(i).Text = str((char)0x25B2) ; //"";
  rectButtons.get(i).btnImage = null;
  rectButtons.get(i).setPosition (  12+400, 80, // x, y
    16, 16); // w, h

  i=11;
  rectButtons.get(i).ToolTipText = "Scroll down. ";
  rectButtons.get(i).Text =  str((char)0x25BC); //  "";
  rectButtons.get(i).btnImage = null;
  rectButtons.get(i).setPosition (  12+400, 80+height-110-16, // x, y
    16, 16);


  // Init Buttons 
  for (int x=0; x < btnLengthInLogFile; x++) {    
    // Using a multiple of x means the buttons aren't all on top of each other (and 20 is the distance to the left screen border)
    int xPos = x*64 + 20; 
    rectButtonsStateLogFile.add(new RectButton(xPos, 20, 52, 52, col1, col2, true, "Log File", 0, "", "", null));
  } // for

  i=0;
  rectButtonsStateLogFile.get(i).ToolTipText = "Scroll up. ";
  rectButtonsStateLogFile.get(i).Text = str((char)0x25B2) ; //"";
  rectButtonsStateLogFile.get(i).btnImage = null;
  rectButtonsStateLogFile.get(i).setPosition (  12+500, 80, // x, y
    16, 16); // w, h

  i=1;
  rectButtonsStateLogFile.get(i).ToolTipText = "Scroll down. ";
  rectButtonsStateLogFile.get(i).Text =  str((char)0x25BC); //  "";
  rectButtonsStateLogFile.get(i).btnImage = null;
  rectButtonsStateLogFile.get(i).setPosition (  12+500, 80+height-190-16, // x, y
    16, 16);

  i=2;
  rectButtonsStateLogFile.get(i).ToolTipText = "Scroll up. ";
  rectButtonsStateLogFile.get(i).Text = str((char)0x25B2) ; //"";
  rectButtonsStateLogFile.get(i).btnImage = null;
  rectButtonsStateLogFile.get(i).setPosition (  width/2+12+500, 80, // x, y
    16, 16); // w, h

  i=3;
  rectButtonsStateLogFile.get(i).ToolTipText = "Scroll down. ";
  rectButtonsStateLogFile.get(i).Text =  str((char)0x25BC); //  "";
  rectButtonsStateLogFile.get(i).btnImage = null;
  rectButtonsStateLogFile.get(i).setPosition ( width/2+12+500, 80+height-190-16, // x, y
    16, 16);
  //
}//func 

void showButtons() { 
  // show buttons for state edit   

  for (RectButton btn : rectButtons) {
    btn.update();
    btn.display();
  }
  // buttons 
  for (RectButton btn : rectButtons) {
    btn.toolTip();
  }

  // for tool tip
  // getDataToDecideIfToolTipText();
} // func 

void showButtonsLogFile() { 
  // show buttons for all states  

  for (RectButton btn : rectButtonsStateLogFile) {
    btn.update();
    btn.display();
  }
  // buttons 
  for (RectButton btn : rectButtonsStateLogFile) {
    btn.toolTip();
  }

  // for tool tip
  // getDataToDecideIfToolTipText();
} // func 
// 