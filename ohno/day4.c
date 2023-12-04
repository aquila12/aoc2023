/* AoC2023 Day 3 */

#include "aoc.h"

#include "fcntl.h"
#include "unistd.h"
#include "sys/stat.h"
#include "sys/mman.h"

#include "stdio.h"
#include "stdint.h"

static const size_t mmap_len = 65536;

inline static int calibrate(char *buf, int limit, char delim) {
  int i;
  for(i = 0; i < limit && buf[i] != delim; ++i);

  return i;
}

static int parser(int(*process_card)(int, int, void *), void *buffer) {
  int sum = 0;

  int fd = open("../input/day4", O_RDONLY);
  if(!fd) return -1;

  struct stat fs;
  if (fstat(fd, &fs) == -1) { sum = -2; goto _close; }

  char *buf = mmap(NULL, mmap_len, PROT_READ, MAP_SHARED, fd, 0);
  if(buf == MAP_FAILED) { sum = -3; goto _close; }

  int i = 0;
  int line_number = 0;

  /* Calibrate; assume all lines formatted the same */
  // int pos_space = calibrate(buf, fs.st_size, ' '); // Card number not actually needed
  int pos_colon = calibrate(buf, fs.st_size, ':');
  int pos_pipe  = calibrate(buf, fs.st_size, '|');
  int pos_endl  = calibrate(buf, fs.st_size, '\n');

  while(i < fs.st_size) {
    int start = i;
    uint16_t winning[10] = { .0 };

    // Read winning numbers
    for(i = start + pos_colon + 2; i < start + pos_pipe; i += 3) {
      winning[buf[i] & 0xf] |= (1 << (buf[i + 1] & 0xf));
    }

    // Count matches
    int matches = 0;
    for(i = start + pos_pipe + 2; i < start + pos_endl; i += 3) {
      if(winning[buf[i] & 0xf] & (1 << (buf[i + 1] & 0xf)))
        ++matches;
    }

    sum += process_card(matches, line_number, buffer);

    // Next line
    ++line_number;
    i = start + pos_endl + 1;
  }

  // _munmap:
  munmap(buf, mmap_len);

  _close:
  close(fd);

  return sum;
}

static int points_for_card(int matches, int _i, void *_b) {
  return matches ? 1 << (matches - 1): 0;
}

static int part1() {
  return parser(points_for_card, 0);
}

static int copies_of_card(int matches, int index, void *buffer) {
  int *copies = buffer;
  int card_count = 1 + copies[index];

  for(int i=index + 1; i <= index + matches; ++i)
    copies[i] += card_count;

  return card_count;
}

static int part2() {
  int copies[1000] = { };
  return parser(copies_of_card, copies);
}

struct aoc_day day4 = {
  .part1 = { .impl = part1, .answer = 20855 },
  .part2 = { .impl = part2, .answer = 5489600 }
};
