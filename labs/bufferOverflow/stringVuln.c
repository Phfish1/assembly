#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int exploit() {
  printf("You won!\n");
}

void vulnrableFunction(int scanCharacters) {
  char buffer[8];

  gets(buffer);
}

// MAIN has a diffrent stack setup than normal functions!
//  Therefore buffer overflow will be diffrent


int main() {

  vulnrableFunction(1);

}