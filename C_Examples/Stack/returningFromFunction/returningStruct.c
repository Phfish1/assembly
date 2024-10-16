struct smalStruct {
  long first;
  long second;
};

struct smalStruct structFunction() {
  struct smalStruct result;
  // Hypothetical large Multiplication
  result.first = 0x00000000AAAAAAAA;   // If doing a multiplication using MUL, the lowest order bytes
  result.second = 0x00FFFFFFFFFFFFFF;  // should be stored in the "second" local variable.
                                       // The variable declared second. This is because of how the stack
                                       // goes by storing and returning values and how MUL does.

  return result; 
}

int main() {
  struct smalStruct result = structFunction();
}