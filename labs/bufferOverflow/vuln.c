#include <string.h>
#include <stdio.h>
#include <stdlib.h>

//
// "argc" and "argv" are handled by the linux kernel
// In memory they are stored in the kernel area
//  ABOVE the stack
//

int exploit() {
  system("/bin/bash");
}

int main(int argc, char ** argv) {

  // Function local variables are stored on the STACK
  // They are referenced by using the Base Pointer
  //  Buffer == -64[RBP]

  char buffer[64];          // Allocates a buffer on the stack
  strcpy(buffer, argv[1]);  // Copies command line argument, into buffer

  // When writing to the buffer, the start address of that Buffer is
  //  -64[RBP]. That means if we write MORE data into the buffer, than what it was allocated
  // We will start writing the stack where the callers Base Pointer, and then the Return address lies!
  // IF we were to pass in an argument to code that

}