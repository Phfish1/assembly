// How are the basic data types handled / represented and stored in registers
  // Signed and Unsigned
    // char
    // short
    // int
    // long
    // long long 

    // SSE Register types
      // float 
      // double

    // Multiple Register types, (For example...)
      // __int128          [Uses general purpouse registers, but needs 2]
        // typedef struct {       // This is how its treated...
        //   long low, high;
        // } __int128;

      // __m256
      // __float128
      // _Decimal128
      // complexT / Complex long double


int main() {



  return 0;
}

