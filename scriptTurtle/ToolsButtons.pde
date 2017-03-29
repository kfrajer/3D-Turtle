

// 
// command buttons on the screen 
// functions and classes 

// -----------------------------------------------------------------------------------------
// Init Buttons

// for debugging and making new buttons set to true; 
// standard is false 
final boolean showButtonsForDebugging = false;  

// how many for edit mode 
final int btnLengthInMainMenu = 9;   // (in main menu (upper left corner))

final color colYellow     = color(244, 244, 44);

boolean locked;

// index
int btnStateColorOKNumber;
int btnStateColorCancelNumber;

int btnStateLoadImgOKNumber; 
int btnStateLoadImgCancelNumber; 

int btnStateHelpScreenMovieNumber;

// colors Buttons 
final color col1 = #ff0000;
final color col2 = #ffff00;
final color col3 = #000000;

// for the tool tip text 
int timeSinceLastMouseMoved=millis(); // store time since last mouse moved / pressed

ArrayList<RectButton> rectButtons = new ArrayList(); 

PImage iconLoad;

// --------------------------------------------------

void setupButtons() {

  // for the command-buttons on the right side of the screen
  int CmdButtonsX = width-70; 
  int CmdButtonsAbstand = 60; 
  int j = 0;

  // ---------------------------------------------

  // Init Buttons top left command bar, button 3 to 5 
  for (int x=0; x < btnLengthInMainMenu; x++) {    
    // Using a multiple of x means the buttons aren't all on top of each other (and 20 is the distance to the left screen border)
    int xPos = x*64 + 20; 
    rectButtons.add(new RectButton(xPos, 20, 52, 52, col1, col2, true, "commandBarMain", 0, "", "", null));
  } // for

  rectButtons.get(0).ToolTipText =  "Run the program, click me";
  rectButtons.get(0).Text = "Run";
  rectButtons.get(0).btnImage = loadImage("iconPlay.jpg");

  rectButtons.get(1).ToolTipText = "Load a sketch";
  rectButtons.get(1).Text = "Load";
  rectButtons.get(1).btnImage = iconLoad;

  rectButtons.get(2).ToolTipText = "Save sketch";
  rectButtons.get(2).Text = "Save";
  rectButtons.get(2).btnImage = loadImage("iconSave.jpg");

  rectButtons.get(3).ToolTipText = "Delete entire sketch (Warning!)";
  rectButtons.get(3).Text = "NEW";
  rectButtons.get(3).btnImage = loadImage("iconNew.jpg");

  rectButtons.get(4).ToolTipText = "Load file and insert into sketch";
  rectButtons.get(4).Text = "LoadInsert";
  rectButtons.get(4).btnImage = loadImage("iconInsertFile.jpg");

  rectButtons.get(5).ToolTipText = "Delete line from sketch";
  rectButtons.get(5).Text = "DeleteLine";
  rectButtons.get(5).btnImage = loadImage("iconDeleteLine.jpg");

  rectButtons.get(6).ToolTipText = "Help on commands";
  rectButtons.get(6).Text = "HelpCommands";
  rectButtons.get(6).btnImage = loadImage("iconHelp.jpg");

  rectButtons.get(7).ToolTipText = "Show Logfile";
  rectButtons.get(7).Text = "ShowLogfile";
  rectButtons.get(7).btnImage = loadImage("iconLogfile.jpg");

  rectButtons.get(8).ToolTipText = "Paste from Clipboard. ";
  rectButtons.get(8).Text = "paste";
  rectButtons.get(8).btnImage = loadImage("iconPasteFC.jpg");
}

void showButtons() { 
  // show buttons for all states  

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
// 