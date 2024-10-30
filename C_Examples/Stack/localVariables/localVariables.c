//
// When a function is called it gets a Stack Frame dedicated to it
// Local Variables are only accessible to the function or functions which are called from it
//    You can of course not return local variables
//    What you can do is Return a Pointer to HEAP memory using Malloc.
//
// Single Local Variables (local's) are stored on the stack from TOP -> BOTTOM
//    long Array[8] == -64[RBP]
//    This array's items is stored "Big-Endian" ( array[0] == -64[RBP], array[1] == -56[RBP] ) 
//    And the items within the array is of course stored Little-Endian. 
//      (Array[0] == 0x1122334455667788), -64[RBP] == 88, -63[RBP] == 77
//
//    This means that if you where trying to access Array[9] (Outside the array bounds) You would access:
//      Array[9]    ==  0[RBP] == Caller's RBP
//      Array[10]   ==  8[RBP] == Return Address
//    


//
// Compiled using: gcc -S -masm=intel -fno-asynchronous-unwind-tables -fno-stack-protector localVariables.c -o localVariables.s
//

int pointerFunction(int *p) {
  int *test = p;

  int test2 = *p;

  return test2;
}

int main() {

  int array[8] = {1,2,3,4,5,6,7,8};   // Local Variable on Stack Frame

  // Passes into function the ADDRESS, NOT THE VALUE of first item in array,
  //  LEA RDI, (-32)[RBP]      ; LEA == Load Effective Address
  pointerFunction(&array[0]);

  // If you instead would like to pass in an integer
  //  MOV RDI, (-32)[RBP]     ; MOV's value at (-32)[RBP]
  // PointerFunction()
  //

  return 0;
}