

// The program 
// Allows to write, edit, load and save scripts to draw with a 3D-Turtle that moves in 3D space.
// Think of a water turtle that paints in the water in 3D.  
// In edit mode hit } to quit. 
// Script is Not case-sensitive. 
// You can use comments in the script with //.
// Program itself makes use of classes, tabs and a simple state model. 
// Examples see below. Examples are also attached as files. 
// Repository: https://github.com/Kango/3D-Turtle
// Tutorial: https://www.youtube.com/watch?v=ASlboq8C2FQ 

// Desiderata / wishes  
// You can write a function with key word LEARN. You cannot pass variables to it though.
// You can't use REPEAT n [ ... ] yet. 
// You don't have any variables yet. 

// Remarks / Errata: The editor
// I tried using G4P text area but it has difficulties in a P3D environment (fault is caused by processing, not by GaP).
// I haven't tried ControlP5. 
// Instead I used a text box by gotoloop and enhanced it a bit. Pos1 and End don't work due to a P3D issue.  
// There are still things to improve in the editor (e.g. backspace, DEL, Cursor all end at the line and don't go over line end/line beginning yet). No scrolling.

// Concept in Editor:
// When we use CRS up and down currentLine changes; 
// for CRS left and right currentColumn changes. 
// when working within one line by CRS left and right, by backspace and by delete,
// the line is internally split up into 2 strings, which are left and right from the 
// cursor. Thus it's easy to do backspace within a line etc. 

/************************************************************
 
 Help for turtle
 -------------------------------------------
 Imagine a turtle. You can tell it to go forward or turn left or right.
 Imagine it carries a pen so when it walks it draws a line behind it.
 You can now draw an image by telling the turtle where to go.
 
 Major commands are 
 * forward/backward(amount) to walk
 * left/right(amount) - to turn [amount is an angle in degrees from 0 to 360]
 * penUp so Turtle walks but does not draw. 
 * penDown Turtle draws again
 * END
 * showTurtle
 * // make a comment 
 You can make your own turtle commands like Rectangle by writing a function with LEARN Rectangle [ and use it by saying rectangle.
 
 The turtle is also a 3D Turtle, imagine a water turtle that draws a line behind it.
 Thus you can connect four rectangles to a cube.
 Major commands are 
 * noseDown/noseUp(degree) to turn down and up
 * rollRight/rollLeft(degree) to turn sidewise
 * sink/rise(amount) to go up and down
 ************************************************************/


// A word to the Commands
// 1. we can turn/roll the turtle around 3 axis (like a plane). They are:  
// ROLL / turn  : rollRight / rollLeft
// YAW / turn   : left / right
// PITCH        : noseDown noseUP


// 2. We can draw something: 
// forward
// backward 


// 3. We can move the turtle without drawing
// sink / rise (y value changes)
// jumpForward (go without drawing) (x) 
// sideWaysLeft / sideWaysRight     (y)


// 4. we can say penUp and penDown to determine whether we draw during walking / swimming or not

// Example
/*

 forward 44
 // Comment
 right 90
 forward 33
 nosedown 90
 forward 33
 
 rectangle
 forward 30
 triangle
 showTurtle
 
 LEARN rectangle [
 forward 30
 right 90
 forward 30
 Triangle
 right 90
 forward 30
 right 90
 forward 30
 right 90
 ]
 
 LEARN Triangle [
 forward 30
 right 120
 forward 30
 right 120
 forward 30
 right 120
 ]
 
 */