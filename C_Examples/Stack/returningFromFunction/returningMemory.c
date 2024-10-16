struct human {
  char name[128];
  int age;
};

struct human memoryFuncton() {
  struct human h1 = {
    "Philip",
    19
  };

  return h1;
}

int main() {
  struct human h2 = memoryFuncton();

  int age = h2.age;
}