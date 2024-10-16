
int *pointerFunction(int *array) {
  int *nextItem = array+1;
  
  return nextItem;
}

// Returning a pointer works just the same as returning a and passing an INTEGER

int main() {
  int array[] = {1,2,3,4}; // Creates a pointer

  // A function cannot return a pointer to it's own local variable
  //
  // So to return a pointer it must either allocate some on the HEAP
  // OR return a pointer it got passed as an argument. 
  //

  // Gets next item in array
  int *nextItem = pointerFunction(array);

  //printf("Seccond item in array: %d\n", *nextItem);
}