#include <sys/stat.h>

extern char _end; // Provided by linker
static char *heap_end = &_end;

int _write(int file, char *ptr, int len) { return len; }
int _read(int file, char *ptr, int len) { return 0; }
int _close(int file) { return -1; }
int _lseek(int file, int ptr, int dir) { return 0; }
int _sbrk(int incr) {
  char *prev = heap_end;
  heap_end += incr;
  return (int)prev;
}
void _exit(int status) {
  while (1)
    ;
}
int _fstat(int file, struct stat *st) {
  st->st_mode = S_IFCHR;
  return 0;
}
int _isatty(int file) { return 1; }
