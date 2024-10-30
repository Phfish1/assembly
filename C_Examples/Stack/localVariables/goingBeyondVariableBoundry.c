//
// What happens when we go beyond a variable's size boundry.
//  long array[8];
//  You try to access array[9]
// You are then accessing the Caller's RBP
//  If you change the value at array[10]
//  You are effectivly overwriting the functions Return Address
//    Acording to the System-V ABI 
// 

//
// Instead of returning to _start from main(), return to debug()
//

//
// Comiple without Stack Canaries: gcc -S -masm=intel -fno-asynchronous-unwind-tables -fno-stack-protector localVariables.c -o localVariables.s
//

#include <stdlib.h>

// Effective Address: 0x1149
int debug() {
  system("/bin/bash");

  return 0;
}

int main() {
  long array[8];
  
  array[9] = 0x555555555149;

  return 0;
}