
// tab for class EditorLine: One line of the text  

class EditorLine {

  // One line of the text  

  // text 
  String text1; 

  // when working within one line by CRS left and right, by backspace and by delete, by entering letters, 
  // the line is internally split up into 2 strings, which are left and right from the 
  // cursor. Thus it's easy to do backspace or inserting text within a line etc. (and not only at the end of the line) 
  String leftText="", rightText="";

  // whether the cursor/blinking line is currentliy on or off 
  boolean flagShowCursorAsLine=true;

  // constr 
  EditorLine(String s1) {
    text1=s1;
  } // constr 

  void display(int i, int currentLine, 
    float textx, float texty) {

    if (i==currentLine) {
      fill(0);
      // this is the current line of the cursor
      //text(leftText + rightText, 
      //  textx, texty, 
      //  w, h);

      text(leftText + rightText, 
        textx, texty);       
      showCursorAsLine(textx, texty);
    } else {
      // other lines
      fill(0);
      setColorError(); 
      text(text1, 
        textx, texty);
    }
  }

  void setColorError() {

    // default 
    fill(0);

    String textLocal = trim(text1);
    textLocal = textLocal.toUpperCase();

    if (textLocal.equals(""))
      return; 
    if (textLocal.indexOf("//")==0)
      return; 

    String[] textArrayLocal=split(textLocal, " ");  

    textArrayLocal[0]=trim(textArrayLocal[0]);

    if (textArrayLocal[0].indexOf("//")==0)
      return;       
    if (textArrayLocal[0].equals(""))
      return; 

    // println(textArrayLocal[0]);

    // we test if the word is a function name (LEARN) 
    int line1 = parser.lineNumberOfLearnCommand(textArrayLocal[0]);
    // if yes 
    if (line1>-1) {
      fill(0, 255, 0); // we set it green  
      return;
    }

    String testWord = "#" + 
      textArrayLocal[0]
      +"#"; 
    if (cmdsWithOneParameter.indexOf(testWord)<0 &&
      cmdsOther.indexOf(testWord)<0) {
      fill(255, 0, 0);
      return;
    }/// else if
    //
  }//func

  void showCursorAsLine(float textx, float texty) {

    float leftWidth = textWidth(leftText);

    if ((frameCount%11) == 0) {
      flagShowCursorAsLine = ! flagShowCursorAsLine;
    }

    if (flagShowCursorAsLine) {
      stroke(255, 0, 0); // RED  
      strokeWeight(1); 
      line(textx+leftWidth, texty, 
        textx+leftWidth, texty+19);
      stroke(0);
    }
  }//method

  void initLine(int currentColumn) {

    // when the cursor enters a new line, we need to prepare the line usage 

    if (currentColumn>text1.length()) {
      currentColumn=text1.length();
      if (currentColumn<0)
        currentColumn=0;
    }

    // prepare line
    // init two vars 
    leftText  = text1.substring( 0, currentColumn ); 
    rightText = text1.substring( currentColumn );
  }//method 

  void writeLineBackInArray() {
    text1 = leftText + rightText;
  }

  void increaseCurrentColumn(int currentColumn) {
    //  writeLineBackInArray(); 
    leftText  = text1.substring( 0, currentColumn); 
    rightText = text1.substring( currentColumn );
    //  initLine();
  }

  //
}// class 
//