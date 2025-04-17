#include "crc.h"
#include <string.h>

typedef struct {
  int a, b;
} vector_t;

int main(void) {
  int a = 0;
  int b;
  memcpy(&b, &a, sizeof(int));
  /* strlen(); */
  return 0;
}
