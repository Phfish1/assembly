int leafFunction() {

  //
  // 128 Bytes of local variables. -(0)RBP Holds 
  long h1 = 1;        // 0-8
  long h2 = 2;        // 16 
  long h3 = 3;        // 24
  long h4 = 4;        // 32
  long h5 = 5;        // 40
  long h6 = 6;        // 48
  long h7 = 7;        // 56
  long h8 = 8;        // 64
  long h9 = 9;        // 72
  long h10 = 10;      // 80
  long h11 = 11;      // 88
  long h12 = 12;      // 96
  long h13 = 13;      // 104
  long h14 = 14;      // 112
  long h15 = 15;      // 120
  
  // The GCC compiler will at this point "allocate" 8 Bytes to the stack by doing
  //    SUB RSP, 8

  // 16 Bytes of local variables
  //  GCC will increment RSP by further 16 Bytes, 
  //  8 + 16 = 24 || => || SUB RSP, 24

  long h20 = 20;
  long h21 = 21;

  //leafFunction();
  return 0;
}


int main() {
  int test = 100;
  leafFunction();

  return 0;
}