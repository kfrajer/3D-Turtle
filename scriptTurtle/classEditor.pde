

class TextBox {

  // demands rectMode(CORNER)

  color textC, baseC, bordC, slctC;
  short x, y, 
    w, h;

  // Two examples of code: 
  String text1 = 
    "// comment this sketch\ngridON\nforward 44\n"
    +"right 90\nforward 33\n";

  String text2 = 
    "forward 44\n"
    +"right 90\nforward 33\n"
    +"nosedown 90\nforward 33\n\n"
    +"Rectangle\nforward 30\n"
    +"triangle\n"
    +"showTurtle\n\n"
    +""
    +"LEARN rectangle [\n"
    +"    forward 30\n"
    +"    right 90\n"
    +"    forward 30\n"
    +"    Triangle\n"
    +"    right 90\n"
    +"    forward 30\n"
    +"    right 90\n"
    +"    forward 30\n"
    +"    right 90\n"
    +"]\n\n"
    +"LEARN Triangle [\n"
    +"    forward 30\n"
    +"    right 120\n"
    +"    forward 30\n"
    +"    right 120\n"
    +"    forward 30\n"
    +"    right 120\n"
    +"]";  

  // this is the entire text of the editor text area 
  String[] editorArray = new String[220];

  // whether the blinking line is currentliy on or off 
  boolean showCursorAsLine=true; 

  // for cursor movements: 
  // When we use CRS up and down currentLine changes; 
  // for CRS left and right currentColumn changes.  
  int currentColumn = 0; // x-value measured in characters
  int currentLine = 0; // y-value measured in lines 

  // when working within one line by CRS left and right, by backspace and by delete,
  // the line is internally split up into 2 strings, which are left and right from the 
  // cursor. Thus it's easy to do backspace within a line etc. 
  String leftText="", rightText="";


  // constr 
  TextBox(int xx, int yy, 
    int ww, int hh, 
    color te, color ba, color bo, color se) {

    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;

    //xw = (short) (xx + ww);
    //yh = (short) (yy + hh);

    textC = te;

    baseC = ba;
    baseC = color(255);

    bordC = bo;
    slctC = se;

    editorArray = split(text1+"\n", "\n");

    currentLine=editorArray.length-1;
  } // constr 

  void display() {

    rectMode(CORNER); 
    fill(baseC);
    rect(x, y, w, h);

    fill(textC);

    float textx=x+3;
    float texty=y+2; 

    for (int i = 0; i < editorArray.length; i++) {

      if (i==currentLine) {
        // this is the current line of the cursor
        text(leftText + rightText, 
          textx, texty, 
          w, h);
        float leftWidth = textWidth(leftText);
        if ((frameCount%11) == 0) {
          showCursorAsLine= ! showCursorAsLine;
        }
        if (showCursorAsLine) {
          stroke(255, 0, 0); 
          strokeWeight(1); 
          line(textx+leftWidth, texty, 
            textx+leftWidth, texty+19);
          stroke(0);
        }
      } else {
        // other lines
        text(editorArray[i], 
          textx, texty, 
          w, h);
      }
      //next line
      texty+=13;
    }//for
    //
  }//method

  String getText() {
    return join (editorArray, "\n");
  }

  void keyPressedInClassEditor() {

    int len = editorArray[currentLine].length();

    if (key == CODED) {

      // CODED from now on.....

      if (keyCode == LEFT) {
        decreaseCurrentColumn();
      } else if (keyCode == RIGHT) {
        increaseCurrentColumn();
      } else if (keyCode == UP) {
        // previous line in text 
        writeLineBackInArray(); 
        currentLine--;
        if (currentLine<0)
          currentLine=0;
        initNewLine(); // currentColumn
      } else if (keyCode == DOWN) {
        // next line in text 
        writeLineBackInArray();    
        currentLine++;
        if (currentLine>editorArray.length-1)
          currentLine=editorArray.length-1;
        initNewLine(); // currentColumn
      } else {
        println (keyCode);
      }//else
    }
    // -------------
    else {

      // not coded

      if (key == BACKSPACE) {  
        if (leftText.length()>0) {
          leftText = leftText.substring(0, leftText.length()-1);
          currentColumn--;
          writeLineBackInArray();
        } else {
          currentColumn=0;
        }
      } else if (key == ENTER || key == RETURN) {
        doReturnKey();
      } else if (key == TAB) 
        leftText += "    ";
      else if (key == DELETE) {
        // getText() = "";
        if (rightText.length()-1>=0) {
          rightText = rightText.substring(1);
        }
      } else if (key >= ' ') {    
        // editorArray[currentLine] += str(k);
        leftText += str(key);
        writeLineBackInArray();
      } else {
        //
      }
      //
    } //else
  } //func

  void doReturnKey() {
    tbox1.editorArray[currentLine]=leftText; 
    String[] newLineArray=new String[1];
    newLineArray[0] = rightText; 
    // Splice one array of values into another
    editorArray = splice(editorArray, newLineArray, currentLine+1);
    currentLine++;
    currentColumn = 0;
    tbox1.initNewLine();
  }

  void spliceArray (String[] newArray) {
    // Splice one array of values into another
    editorArray = splice(editorArray, newArray, currentLine);
  }

  void initNewLine() {
    //
    if (currentColumn<0) {
      currentColumn=0;
    }
    if (editorArray.length<=0) {
      editorArray=new String[1];
      editorArray[0]="";
    }

    if (currentLine>=editorArray.length)
      currentLine=editorArray.length-1; 

    if (currentColumn < editorArray[currentLine].length()-1) {
      leftText  = editorArray[currentLine].substring( 0, currentColumn); 
      rightText = editorArray[currentLine].substring( currentColumn );
    } else {
      //
      currentColumn=editorArray[currentLine].length()-1;
      if (currentColumn<0)
        currentColumn=0; 
      leftText  = editorArray[currentLine].substring( 0, currentColumn); 
      rightText = editorArray[currentLine].substring( currentColumn);
    }//
  }

  void writeLineBackInArray() {
    editorArray[currentLine] = leftText + rightText;
  }

  void decreaseCurrentColumn() {
    currentColumn--;
    if (currentColumn<0)
      currentColumn=0;
    initNewLine() ;
  }

  void increaseCurrentColumn() {
    currentColumn++;
    if (currentColumn>editorArray[currentLine].length())
      currentColumn=editorArray[currentLine].length();
    // initNewLine();
    leftText  = editorArray[currentLine].substring( 0, currentColumn); 
    rightText = editorArray[currentLine].substring( currentColumn );
  }
  //
}//class 
//