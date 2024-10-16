int leafFunction() {
  return 0;
}

int main() {
  int test = 0;

  //
  // Even though the variables in this condition are NOT in the case of 0 initialized
  // The stack pointer is still decremented to allocate enough memory for all of them
  //    THIS IS NOT a memory efficient condition, the stack frame for the main() function is the same size
  //    No matte if this condition is TRUE or FALSE
  //      Another method to consider is using the HEAP instead, 
  //      especially IF the main function is going to be called recursivly
  //

  if (test) {           
    int hello = 100;    
    long h1 = 3;
    long h2 = 40;
    long h3 = 50;
    long h4 = 60;
    long h5 = 70;
    long h6 = 80;
    long h7 = 90;
    long h8 = 120;

  }

  leafFunction();
  return 0;
}