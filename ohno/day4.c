/* AoC2023 Day 3 */

#include "aoc.h"

#include "fcntl.h"
#include "unistd.h"
#include "sys/stat.h"
#include "sys/mman.h"

#include "stdio.h"

static const size_t mmap_len = 65536;

static int parser(
) {
  int sum = 0;

  int fd = open("../input/day4", O_RDONLY);
  if(!fd) return -1;

  struct stat fs;
  if (fstat(fd, &fs) == -1) { sum = -2; goto _close; }

  char *buf = mmap(NULL, mmap_len, PROT_READ, MAP_SHARED, fd, 0);
  if(buf == MAP_FAILED) { sum = -3; goto _close; }



  // _munmap:
  munmap(buf, mmap_len);

  _close:
  close(fd);

  return sum;
}

static int part1() {
  return parser();
}

static int part2() {
  return 0;
}

struct aoc_day day4 = {
  .part1 = { .impl = part1, .answer = UNKNOWN },
  .part2 = { .impl = part2, .answer = UNKNOWN }
};
