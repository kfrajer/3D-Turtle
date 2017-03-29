

// stack for repeat 

StackElement seRepeat; 

class StackElement {

  // one element in the stack
  // holds the data ONE repeat needs. 


  int repeatHowOftenInTotal;  // max frame
  int currentRepeat=0; // current frame
  int lineNumberStart; 
  boolean active=true;  

  // constr 
  StackElement( int repeatHowOftenInTotalTEMP, 
    int lineNumberStartTEMP) {
      // 
    repeatHowOftenInTotal = repeatHowOftenInTotalTEMP;
    lineNumberStart       = lineNumberStartTEMP;
  }// constr 
  //
}