
// class RectButton and Button  
// (two classes)

class RectButton extends Button {

  // constr 
  public RectButton (
    int ix, int iy, 
    int isizeX, int isizeY, 
    color icolor, 
    color ihighlight, 
    boolean iExist, 
    String iTag, 
    int iTag2, 
    String iText, 
    String iToolTipText, 
    PImage iBtnImage) {

    x = ix;
    y = iy;
    sizeX = isizeX;
    sizeY = isizeY;    
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    Exists = iExist;

    Tag = iTag; 
    Tag2 = iTag2;

    Text = iText;
    ToolTipText=iToolTipText;

    btnImage=iBtnImage;
  }

  boolean over() {
    if ( overRect(x, y, sizeX, sizeY) ) {
      over = true;
      return true;
    } else {
      over = false;
      return false;
    }
  }

  void display() {
    if (Exists) {

      showButtonForDebugging(); 

      if (btnImage!=null) {
        // Image 
        image(btnImage, x, y);

        if (showButtonsForDebugging) {
          // rect 
          stroke (255); 
          strokeWeight(1); 
          //fill(currentcolor, 30);
          noFill(); 
          rect(x, y, btnImage.width, btnImage.height);
        }
      } //   if (btnImage!=null) 
      else  if (Text != "") {

        // this is not in use (buttons don't have text)

        // rect 
        stroke (ButtonStrokeColor); 
        strokeWeight(0); 
        fill(currentcolor, 30);
        rect(x, y, sizeX, sizeY);        

        //text
        fill(0, 102, 153);
        textAlign(CENTER);
        textSize(16) ;
        text(Text, (x + (sizeX / 2.0)), (y + (sizeY / 2.0))+5);
        textAlign(LEFT);
      } // if (Text != "")
    } // if exists
  } // method display

  void showButtonForDebugging() {

    if (showButtonsForDebugging) {
      // rect 
      stroke (ButtonStrokeColor); 
      strokeWeight(0); 
      fill(currentcolor, 30);
      rect(x, y, sizeX, sizeY);        

      //text
      fill(0, 102, 153);
      textAlign(CENTER);
      textSize(16) ;
      text(Text, (x + (sizeX / 2.0)), (y + (sizeY / 2.0))+5);
      textAlign(LEFT);
    }
  }

  void setPosition ( int ix, int iy, 
    int isizeX, int isizeY) {
    // 
    x = ix;
    y = iy;
    sizeX = isizeX;
    sizeY = isizeY;
  } 
  //
} // class

// =========================================================================

class Button {

  int x, y;

  int sizeX;
  int sizeY;

  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;  
  boolean Exists = false;

  String Text = "";
  String ToolTipText = ""; 

  String Tag = "";
  int Tag2 = 0;

  int TagMark = 0; 
  color ButtonStrokeColor = color (255, 255, 255);

  PImage btnImage = new PImage(); 

  void update() {
    if (over()) {
      // Mouse over 
      currentcolor = highlightcolor;
    } else {
      // not Mouse over 
      currentcolor = basecolor;
    }
  } // update 

  void toolTip() {
    if (over()) {
      if (!ToolTipText.equals("")) {
        if (millis() - timeSinceLastMouseMoved > 800) {

          fill(colYellow); //  (242, 245, 75);
          noStroke();
          textSize (12);
          float tw = textWidth(ToolTipText)+8;
          float xLeft = x-(tw/2); 
          float xRight = x-(tw/2) + tw; 
          float xLeftText = x; 
          if (xRight>=width) { 
            xLeft= width-tw-2;
            xLeftText= xLeft + tw/2;
          } 
          if (xLeft< 2) { 
            xLeft=2;
            xLeftText= 2 + tw / 2;
          }
          rect (xLeft, y+sizeY+2, tw, 20);
          textAlign(CENTER);
          fill(0);
          text(ToolTipText, xLeftText, y+16+sizeY);
          textAlign(LEFT);
          textSize(16);
        } //  if
      } // if
    } // if
  } // func 

  boolean pressed() {
    if ( over()) {
      locked = true;
      return true;
    } else {
      locked = false;
      return false;
    }
  }  // pressed; 

  boolean over() {
    return true;
  } // over 

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  } // overRect
  //
} // class
//