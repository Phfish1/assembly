#include <stdio.h>

int leafFunction(int myArray[4]) {
  return 0;
}


// How are arguments passed to functions
//
// First the arguments passed are classified:
//  INTEGER => General purpouse Register      {char, short, int, long, long long}
//  SSE     => Vector Register                {float, double, _Decimal32, _Decimal64}
//  MEMORY  => Via using the stack / memory   MAYBE!: {Structures, Arrays, Union} IF they are Larger than 4 Bytes
//    
// And More classes of course, but 
//
// INTEGER: General Purpouse Registers use order: {RDI, RSI, RDX, RCX, R8, R9}
// SSE: Vector Register use order:                {XMM0 -> XMM7}
//
// The AL Register might be used in some cases to specify how many Vector type registers used
//
// Booleans values are PASSED like this BL = (0000000x) "x" Being the true value of the Boolean
//
// There are some Registers that need to be preserved accross function calls
// Registers perserved across function calls: {RBX, RBP, RSP, R12-15}
//   Need to be "Callee-saved". A Common way to to this is to push it onto the stack, then POP when RETURNING
//
// IF there are not enough registers to fit the arguments, they will be pushed onto the stack!
//  Does the caller decrement the Stack Pointer (RSP)???
//


union un
{
  char a;
  int item;
}un;


int main() {
  
  return 0;
}

