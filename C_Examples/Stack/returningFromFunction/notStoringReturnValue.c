//
// Take a look at what happens when a function you call returns a MEMORY class / a large Struct
// But our CALLER function never stores the return value.
//    Will the caller function still allocate memory on the stack frame for the return value?
//    Even though it never gets stored anywhere the caller can reference in the source code.
//

struct largeStruct
{
  char name[123];
  int age;
};


struct largeStruct memoryFunction() {
  struct largeStruct human = {
    "Philip",
    19
  };
  
  // TEST-1 NO RETURN STATMENT IS DEFINED
  
  // TEST-2 A return statment is defined returning the local structure
  return human;
}

int main() {
  memoryFunction();

  return 0;
}
