

class Parse {

  // parser

  boolean ignoreFollowingLines = false; 
  boolean endFlag=false;
  //  int howManyLoops; 
  boolean makeARepeat = false; 

  // CONSTRUCTOR  
  Parse() {
    // Empty
  } // CONSTRUCTOR 

  void parse(String txt) {
    // loop over entire script
    String[] arrayScript = split(txt, "\n") ; 

    log=""; 

    int i=0; 
    endFlag=false;
    while (i<arrayScript.length) { 
      //for (String line : arrayScript) {
      makeARepeat = false; 
      String line =      arrayScript[i]; 
      boolean dummy=execute(line, i, false);
      if (endFlag) 
        return; 
      if (makeARepeat) {
        i=seRepeat.lineNumberStart;
      }  
      i++;
    }
  }

  boolean execute(String fullLine, int lineNumber, boolean isFunctionCall) {

    // Executes one line.

    // Makes some checks, whether line is ok or not. 

    // This function does have 2 main purposes: 
    //     * Normal execution of script (boolean isFunctionCall is false) and 
    //     * Execution as function call (isFunctionCall is true), called by eval. 

    fullLine = trim(fullLine);

    if (fullLine.equals("")) {
      // ignore empty lines 
      return true;
    }

    if (fullLine.indexOf("//")==0) {
      // ignore comments
      return true;
    }

    String[] components = split(fullLine, " ");

    components[0]=trim(components[0].toUpperCase());

    //if (isFunctionCall&&ignoreFollowingLines) {
    //  println ("isFunctionCall&&ignoreFollowingLines    "
    //    +fullLine
    //    +" in "
    //    +lineNumber);
    //}

    if (!isFunctionCall) {
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
        return true;
      } //if
    } //if

    if (isFunctionCall) {
      if (components[0].equals("]")) {
        log += "end of function -------\n"; 
        return false; // don't keep on
      }
    }

    //// Testing: 
    //if (components.length>2) {
    //  printArray ("length > 2: " + fullLine );
    //}

    // standard commands like forward or left need to have 2 components:
    // command and parameter(value) [whereas showTurtle etc. has no parameter]
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
      return true;
    }

    eval(components, fullLine, lineNumber, isFunctionCall);

    return true; // keep on
  }   

  boolean isStandardCommand( String command ) {
    // returns true when command is a standard command such as forward
    // which requires one numerical parameter 
    String cmds =
      "#FORWARD#BACKWARD#RIGHT#LEFT#NOSEDOWN#NOSEUP#ROLLRIGHT#ROLLLEFT#"
      +"SINK#RISE#SIDEWAYSRIGHT#SIDEWAYSLEFT#FORWARDJUMP#BACKWARDJUMP#";
    return 
      cmds.indexOf(command) > -1;
  }

  void eval(String [] components, String fullLine, int lineNumber, boolean isFunctionCall) {

    // eval and exec

    if (isFunctionCall)
      log += "    "+fullLine+"\n";
    else 
    log += fullLine+"\n";

    if (components[0].equals("FORWARD")) {
      t.forward( int(components[1]));
    } else if (components[0].equals("BACKWARD")) {
      t.backward( int(components[1]));
    } else if (components[0].equals("END")) {
      // END
      if (!isFunctionCall) { // ????? 
        endFlag=true;
      }
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
    } else if (components[0].equals("HELP")) {
      // without param
      t.help();
    } else if (components[0].equals("PUSHMATRIX")) {
      // without param
      pushMatrix();
    } else if (components[0].equals("POPMATRIX")) {
      // without param
      popMatrix();
    } else if (components[0].equals("BACKGROUND")) {
      // param
      if (components.length==4) 
        background( int(components[1]), int(components[2]), int(components[3]));
    } else if (components[0].equals("GRIDCOLOR")) {
      // param
      if (components.length==4) 
        t.gridColor=color( int(components[1]), int(components[2]), int(components[3]));
    } else if (components[0].equals("REPEAT")) {
      // param
      int howManyLoops = int(components[1]);
      seRepeat = new  StackElement (howManyLoops, lineNumber) ;
    } else if (components[0].equals("COLOR")) {
      // param
      if (components.length==4) 
        t.turtleColor=color( int(components[1]), int(components[2]), int(components[3]));
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
    } else if (components[0].equals("PUSHPOS")) {
      // 1 param
      t.learnPosition( components[1] );
    } else if (components[0].equals("POPPOS")) {
      // 1 param
      t.retrievePosition( components[1] ) ;
    } else if (components[0].equals("LEARN")) {
      if (!isFunctionCall) {
        ignoreFollowingLines = true;
        log+="ignore\n";
      }
    } else if (components[0].equals("]")) {
      ignoreFollowingLines = false;
    } else if (components[0].equals(")")) {
      if (seRepeat.active) {
        seRepeat.currentRepeat++;
        if (seRepeat.currentRepeat<seRepeat.repeatHowOftenInTotal)
        { 
          makeARepeat = true;
        } else {
          makeARepeat = false;
          seRepeat=null;
        }
      }
    } else if (components[0].equals(" ") || components[0].equals("")) {
      // should not occur
    } else if ((lineNumberOfLearnCommand ( components[0] ) > -1) ) {
      // The String components[0] contains a function name. 
      // This is a function call. (A function must be taught with Learn.)
      // Here we want to execute the function. 
      runACommand(components);
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

  void runACommand (String[] components) {

    // this is a function call. A function must be taught with Learn.

    log+="function : -----------------\n"; 

    int lineNumber2 = lineNumberOfLearnCommand ( components[0] );

    String[] arrayScript = split(tbox1.getText(), "\n") ; 

    int i2 = lineNumber2; 
    ignoreFollowingLines=false; 
    boolean keepOn=true; 
    while ( i2 < arrayScript.length && keepOn ) {
      String line=arrayScript[i2]; 
      keepOn=execute(line, i2, true);
      i2++;
    }
  }

  int lineNumberOfLearnCommand ( String command ) {

    // Retruns a line number of the LEARN command line. 
    // If command is not defined as a function by LEARN, -1 is returned. 

    String[] arrayScript = split(tbox1.getText(), "\n") ; 

    int i=0;
    for (String line : arrayScript) {
      if (isLineWithLearnAndTheCorrectFunctionName(command, line))
        return i+1;
      i++;
    }

    return -1;
  } // method  

  boolean isLineWithLearnAndTheCorrectFunctionName(String command, String line) {

    // one line

    line = trim(line);
    line = line.toUpperCase();
    command = trim(command);
    command = command.toUpperCase(); 

    if (line.equals(""))
      return false;
    if (command.equals(""))
      return false;

    String[] components = split(line, " ");

    components[0]=trim(components[0].toUpperCase());
    if (components.length>1)
      components[1]=trim(components[1].toUpperCase());
    else return false; 

    if ( components[0].equals("LEARN") ) {
      //
      if ( components[1].equals(command) ) {
        //
        return true;
      }
    }
    return false;
  }
  //
}//class
// 