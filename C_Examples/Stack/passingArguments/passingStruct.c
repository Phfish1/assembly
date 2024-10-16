struct largeStruct {
  char name[128];
  int age;
  double salary;
  float weight;
};

//
// In C you can pass an entire copy of a struct to another function,
// If you would to pass a pointer, you would change the ACTUALL value of struct
//
void leafFunction(struct largeStruct human) {
  human.age = 100;
  return;
}

int main() {

  struct largeStruct human1 = {
    "Philip",
    19,
    150000,
    72.5
  };

  leafFunction(human1);
  return 0;  
}