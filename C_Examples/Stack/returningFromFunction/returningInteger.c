//
// How does the System V ABI handle returning values from a function?
// A General rule is using the RAX and RDX registers for INTEGER or MEMORY classes
// And XMM0 and XMM1, or ST0 for returns requiering vector registers
//

// int integerFunction() {
//   int returnValue = 100;

//   return returnValue;
// }

int main() {

  long returnValue = integerFunction();
  return 0;
}