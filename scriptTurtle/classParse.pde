

class Parse {

  // parser

  boolean ignoreFollowingLines = false; 

  // CONSTRUCTOR  
  Parse() {
    // Empty
  } // CONSTRUCTOR 

  void parse(String txt) {
    // loop over entire script
    String[] a1 = split(txt, "\n") ; 

    int i=1; 
    for (String line : a1) {
      execute(line, i, false);
      i++;
    }
  }

  void execute(String fullLine, int lineNumber, boolean isFunctionCall) {

    // Executes one line.
    // Makes some checks, whether line is ok or not. 
    // This function does have 2 main purposes: 
    //     * Normal execution of script (boolean isFunctionCall is false) and 
    //     * Execution as function call (isFunctionCall is true), called by eval. 

    fullLine = trim(fullLine);

    if (fullLine.equals(""))
      return; 

    if (fullLine.indexOf("//")==0) {
      // ignore comments
      return;
    }

    String[] components = split(fullLine, " ");

    components[0]=trim(components[0].toUpperCase());

    if (ignoreFollowingLines) {
      // this situations means we are inside a function 
      if (components[0].equals("LEARN")) {
        state=stateError; 
        errorMsg="No LEARN inside another LEARN allowed.  \n"
          +"Your line was : '"
          +fullLine
          +"' (line number: " 
          +lineNumber
          +").";
      } else if (components[0].equals("]")) {
        ignoreFollowingLines = false;
      } 
      return;
    } //if

    // Testing: 
    if (components.length>2) {
      printArray ("length > 2: " + fullLine );
    }

    // standard commands like foward or left need to have 2 components:
    // command and parameter(value)
    if (isStandardCommand( components[0]) && 
      components.length!=2) {
      state=stateError; 
      errorMsg="Standard commands like forward need a number, \n"+
        "it must look like forward 40 or left 90. \n"
        +"Your line was : '"
        +fullLine
        +"' (line number: " 
        +lineNumber
        +").";
      return;
    }

    eval(components, fullLine, lineNumber, false);
  }   

  boolean isStandardCommand( String command ) {
    // returns true when comand is a standard command such as forward
    // which requires 1 numerical parameter 
    String cmds =
      "#FORWARD#BACKWARD#RIGHT#LEFT#NOSEDOWN#NOSEUP#ROLLRIGHT#ROLLLEFT#"
      +"SINK#RISE#SIDEWAYSRIGHT#SIDEWAYSLEFT#FORWARDJUMP#BACKWARDJUMP#";
    return 
      cmds.indexOf(command) > -1;
  }

  void eval(String [] components, String fullLine, int lineNumber, boolean isFunctionCall) {

    // eval and exec

    if (components[0].equals("FORWARD")) {
      t.forward( int(components[1]));
    } else if (components[0].equals("BACKWARD")) {
      t.backward( int(components[1]));
    } else if (components[0].equals("RIGHT")) {
      t.right( int(components[1]));
    } else if (components[0].equals("LEFT")) {
      t.left( int(components[1]));
    } else if (components[0].equals("NOSEDOWN")) {
      t.noseDown( int(components[1]));
    } else if (components[0].equals("NOSEUP")) {
      t.noseUp( int(components[1]) );
    } else if (components[0].equals("PENUP")) {
      // without param
      t.penUp();
    } else if (components[0].equals("PENDOWN")) {
      // without param
      t.penDown();
    } else if (components[0].equals("ROLLRIGHT")) {
      t.rollRight( int(components[1]) );
    } else if (components[0].equals("ROLLLEFT")) {
      t.rollLeft( int(components[1]) );
    } else if (components[0].equals("SHOWTURTLE")) {
      // without param
      t.showTurtle();
    } else if (components[0].equals("SINK")) {
      t.sink( int(components[1]) );
    } else if (components[0].equals("RISE")) {
      t.rise( int(components[1]) );
    } else if (components[0].equals("SIDEWAYSRIGHT")) {
      t.sidewaysRight( int(components[1]) );
    } else if (components[0].equals("SIDEWAYSLEFT")) {
      t.sidewaysLeft( int(components[1]) );
    } else if (components[0].equals("FORWARDJUMP")) {
      t.forwardJump( int(components[1]) );
    } else if (components[0].equals("BACKWARDJUMP")) {
      t.backwardJump( int(components[1]) );
    } else if (components[0].equals("GRIDON")) {
      // without param
      t.flagDrawGridOnFloor = true;
    } else if (components[0].equals("GRIDOFF")) {
      // without param
      t.flagDrawGridOnFloor = false;
    } else if (components[0].equals("LEARN")) {
      ignoreFollowingLines = true;
    } else if (components[0].equals("]")) {
      ignoreFollowingLines = false;
    } else if (components[0].equals(" ") || components[0].equals("")) {
      // should not occur
    } else if (callSubFunctions ( components[0], fullLine ) > -1 ) {
      // this is a function call. A function must be taught with Learn.
      int lineNumber2 = callSubFunctions ( components[0], fullLine );

      String[] arrayScript = split(tbox1.getText(), "\n") ; 

      int i = lineNumber2; 
      boolean keepOn=true; 
      while (i< arrayScript.length && keepOn ) {
        String line=arrayScript[i]; 
        execute(line, i, true);
        i++;
      }
    }
    //----------- 
    else {
      // Error
      state=stateError; 
      errorMsg="unknown command : "
        +fullLine
        +" (line number: " 
        +lineNumber
        +").";
      return;
    }
  } // func 

  int callSubFunctions ( String command, String fullLine ) {
    //

    String[] arrayScript = split(tbox1.getText(), "\n") ; 

    int i=1; 
    for (String line : arrayScript) {
      if (execute2(command, line, i))
        return i;
      i++;
    }

    return -1;
  } // method  

  boolean execute2(String command, String line, int lineNumber) {

    // one line

    line = trim(line);
    line=line.toUpperCase();

    if (line.equals(""))
      return false; 

    String[] components = split(line, " ");

    components[0]=trim(components[0].toUpperCase());
    if (components.length>1)
      components[1]=trim(components[1].toUpperCase());

    if ( components[0].equals("LEARN") ) {
      //
      if ( components[1].equals(command) ) {
        //
        return true;
      }
    }
    return false;
  }
}//class
// 