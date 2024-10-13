void testFunction3() {
  int j = 3;
}

void testFunction2(int arg1, int arg2) {
  int j = 2;
  testFunction3();
}


void testFunction() {
  int j = 1;
  testFunction2(j, 3);
}

int main() {
  int i = 10;
  long j = 20;
  int ji = 40;
  int b = 12;

  testFunction();

  return 0;
}