

// Minor Functions 

void statusBar() {

  // display a text in the corner
  noLights(); 
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  textMode(SHAPE);

  // the rect of the status bar
  fill(111); // gray 
  noStroke(); 
  rect(0, height-19, width, 30);

  // the text 
  fill(0);
  textSize(12);
  text(statusBarText+ "     Version 0.1.3", 
    3, height-4);

  //textSize(24); 
  textFont(font);
  //  textMode(SHAPE);
  textMode(MODEL);
  text(stateText, 19, 24); 


  // end HUD 
  hint(ENABLE_DEPTH_TEST);
  camera.endHUD();
}

void avoidClipping() {
  // avoid clipping : 
  // https : // 
  // forum.processing.org/two/discussion/4128/quick-q-how-close-is-too-close-why-when-do-3d-objects-disappear
  perspective(PI/3.0, (float) width/height, 1, 1000000);
}

String GetTextFromClipboard () {
  // ??????????
  String text = (String) GetFromClipboard(DataFlavor.stringFlavor);

  return text;
}

Object GetFromClipboard (DataFlavor flavor) {

  // ??????????

  Object object = null;
  /*
  
   Clipboard clipboard = getJFrame(getSurface()).getToolkit().getSystemClipboard();
   
   // Clipboard clipboard = getSystemClipboard();
   Transferable contents = clipboard.getContents(null);
   Object object = null;
   
   if (contents != null && contents.isDataFlavorSupported(flavor))
   {
   try
   {
   object = contents.getTransferData(flavor);
   // println("Clipboard.GetFromClipboard() >> Object transferred from clipboard.");
   }
   
   catch (UnsupportedFlavorException e1) // Unlikely but we must catch it
   {
   println("Clipboard.GetFromClipboard() >> Unsupported flavor: " + e1);
   //~  e1.printStackTrace();
   }
   
   catch (java.io.IOException e2)
   {
   println("Clipboard.GetFromClipboard() >> Unavailable data: " + e2);
   //~  e2.printStackTrace();
   }
   }
   
   */
  return object;
} 

///static final javax.swing.JFrame getJFrame(final PSurface surf) {
//return
//  (javax.swing.JFrame)  ((processing.awt.PSurfaceAWT.SmoothCanvas)
//  surf.getNative()).getFrame();

// GLWindow winGL = (GLWindow) surf.getNative();
//return (javax.swing.JFrame)  winGL.getFrame();

// com.jogamp.newt.opengl.GLWindow win = ((com.jogamp.newt.opengl.GLWindow) surf.getNative());

//return (javax.swing.JFrame)  ( (processing.awt.PSurfaceAWT.SmoothCanvas)  win.getNative()).getFrame() ;

/*
//return
 (javax.swing.JFrame)  ((processing.awt.PSurfaceAWT.GLWindow)
 surf.getNative()).getFrame();
 
 */
//}
//