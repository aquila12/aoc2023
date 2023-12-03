/* AoC2023 Day 2 */

#include "aoc.h"

#include "fcntl.h"
#include "unistd.h"
#include "sys/stat.h"
#include "sys/mman.h"

#include "stdio.h"

static const size_t mmap_len = 65536;

struct game {
  int id;
  int r, g, b;
};

inline static int read_numeral(char *buf, int *i, size_t limit) {
  int num = 0;
  while(*i < limit && buf[*i] <= '9' && buf[*i] >= '0') {
    num *= 10;
    num += buf[*i] - '0';
    ++*i;
  }
  return num;
}

static int sum_things(int (*what_to_sum)(struct game *)) {
  int sum = 0;

  int fd = open("../input/day2", O_RDONLY);
  if(!fd) return -1;

  struct stat fs;
  if (fstat(fd, &fs) == -1) { sum = -2; goto _close; }

  char *buf = mmap(NULL, mmap_len, PROT_READ, MAP_SHARED, fd, 0);
  if(buf == MAP_FAILED) { sum = -3; goto _close; }

  int i = 0;

  while(i < fs.st_size) {
    struct game g = { .r = 0, .g = 0, .b = 0 };

    i += 5; // Skip "Game "
    g.id = read_numeral(buf, &i, fs.st_size);

    // Check for \n
    while(i < fs.st_size && buf[i] != '\n') {
      i += 2; // Skip ": ", ", ", "; "

      int n = read_numeral(buf, &i, fs.st_size);
      ++i; // Skip " "

      // Store, skip colour word
      switch(buf[i]) {
        case 'r': if(n > g.r) g.r = n; i += 3; break;
        case 'g': if(n > g.g) g.g = n; i += 5; break;
        case 'b': if(n > g.b) g.b = n; i += 4; break;
        default:
        printf("Error: unexpected colour char %c\n", buf[i]);
        goto _munmap;
      }
    }

    ++i; // Skip \n

    sum += what_to_sum(&g);
  }

  _munmap:
  munmap(buf, mmap_len);

  _close:
  close(fd);

  return sum;
}

static int possible_game_ids(struct game *g) {
  if(g->r > 12 || g->g > 13 || g->b > 14) return 0;

  return g->id;
}

static int part1() {
  return sum_things(possible_game_ids);
}

static int game_powers(struct game *g) {
  return g->r * g->g * g->b;
}

static int part2() {
  return sum_things(game_powers);
}

struct aoc_day day2 = {
  .part1 = { .impl = part1, .answer = 2169, .runs = 1000 },
  .part2 = { .impl = part2, .answer = 60948, .runs = 1000 }
};
