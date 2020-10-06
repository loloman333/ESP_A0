#include <assert.h>

extern int add(int, int);

void test_add() {
    int result = add(7, 3);
    assert(result == 11);
}
