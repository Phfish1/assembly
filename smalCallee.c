void bar() {
  return;
}

int foo() {
  int a = 1;  // 4
  int b = 2;  // 8
  int c = 3;  // 12
  int d = 4;  // 16
  int e = 5;  // 24 -> BUT the standard is to align the stack always by 16, therefore the stack must allocate 32 Bytes
              //       AKA, the Stack Pointer (RSP) must subtract by 32
  bar();
  return 0;
}

int main() {
  
  return 0;
}