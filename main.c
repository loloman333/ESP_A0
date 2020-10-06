#include <stdio.h>

int add(int x, int y) {
    return x + y;
}

int main() {
    printf("Hello World.\n");
    int x = add(1, 2);
    printf("Hello int %d\n", x);
    return 0;
}
