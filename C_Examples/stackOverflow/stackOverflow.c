// The hypothesiz is, that since local variables are stored on the stack.
// That if we have a function with a lot of large stack defined local variables and call it recursivly
// it will cause a segmentation fault way faster than a function having less or zero local variables

// There is should also be a case where a single function have to many local variables,
// Even though its not calling another function, it is still storing its variables on the stack

// The Assembly compiled version of this program is availible inside this same folder called stackOverflow.s

#include <stdio.h>

int recursive(int count) {
  long largeLocalVariable[][10] = {
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, 
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
  };

  printf("%d\n", count);
  recursive(count+1);
}

int main() {
  recursive(0);
}