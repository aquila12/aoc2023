/* AoC2023 Day 3 */

#include "aoc.h"

#include "fcntl.h"
#include "unistd.h"
#include "sys/stat.h"
#include "sys/mman.h"

#include "stdio.h"

static const size_t mmap_len = 65536;

struct thing {
  enum thing_type { NUMBER, SYMBOL } type;
  union {
    struct thing_sym { int col; char symbol; int ratio; int nums_adj; } sym;
    struct thing_num { int col0, col1, value; } num;
  };
};

struct row {
  int n_things;
  struct thing things[100];
};

static int found_node(
  struct thing *thing, struct row *this_row, struct row *last_row,
  int (*found_adjacent)(struct thing *, struct thing *)
) {
  int sum = 0;
  int num = thing->type == NUMBER;

  for(int n = 0; n<last_row->n_things; ++n) {
    struct thing *other = &last_row->things[n];
    if(num) {
      if(other->type == SYMBOL) {
        if(other->sym.col > thing->num.col1) break;
        if(other->sym.col >= thing->num.col0) sum += found_adjacent(thing, other);
      }
    } else {
      if(other->type == NUMBER) {
        if(other->num.col0 > thing->sym.col) break;
        if(other->num.col1 >= thing->sym.col) sum += found_adjacent(other, thing);
      }
    }
  }

  int t = this_row->n_things;
  if(t > 1) {
    struct thing *other = &this_row->things[t - 2];
    if(num) {
      if(other->type == SYMBOL && other->sym.col == thing->num.col0)
        sum += found_adjacent(thing, other);
    } else {
      if(other->type == NUMBER && thing->sym.col == other->num.col1)
        sum += found_adjacent(other, thing);
    }
  }

  return sum;
}

static int parser(
  int (*found_adjacent)(struct thing *, struct thing *),
  int (*after_row)(struct row *)
) {
  int sum = 0;

  int fd = open("../input/day3", O_RDONLY);
  if(!fd) return -1;

  struct stat fs;
  if (fstat(fd, &fs) == -1) { sum = -2; goto _close; }

  char *buf = mmap(NULL, mmap_len, PROT_READ, MAP_SHARED, fd, 0);
  if(buf == MAP_FAILED) { sum = -3; goto _close; }

  int i = 0;
  int width, numeral = 0, col;

  // Calibrate input - assume constant width (well-behaved input)
  for(width = 0; width < fs.st_size && buf[width] != '\n'; ++width);

  struct row row_a = { .n_things = 0 }, row_b = { .n_things = 0 };
  struct row *this_row = &row_a, *last_row = &row_b, *tmp_row;

  struct thing *this_thing;

  while(i < fs.st_size) {
    tmp_row = last_row;
    last_row = this_row;
    this_row = tmp_row;

    this_row->n_things = 0;
    col = 0;

    while(i < fs.st_size) {
      char c = buf[i++];
      if(c >= '0' && c <= '9') {
        if(!numeral) {
          this_thing = &this_row->things[this_row->n_things];
          this_thing->type = NUMBER;
          this_thing->num.col0 = col - 1;
        } else numeral *= 10;

        numeral += c - '0';
      } else {
        if(numeral) {
          this_thing->num.col1 = col;
          this_thing->num.value = numeral;
          ++this_row->n_things;
          numeral = 0;
          sum += found_node(this_thing, this_row, last_row, found_adjacent);
        }

        if(c == '\n') break; /* EOL Break clause */

        if(c != '.') {
          this_thing = &this_row->things[this_row->n_things];
          this_thing->type = SYMBOL;
          this_thing->sym.col = col;
          this_thing->sym.symbol = c;
          this_thing->sym.nums_adj = 0;
          this_thing->sym.ratio = 0;
          ++this_row->n_things;
          sum += found_node(this_thing, this_row, last_row, found_adjacent);
        }
      }
      ++col;
    }
    sum += after_row(last_row);
  }
  sum += after_row(this_row);

  // _munmap:
  munmap(buf, mmap_len);

  _close:
  close(fd);

  return sum;
}


/* NB This only works because no number is adjacent to two symbols */
static int found_adjacent_1(struct thing *num, struct thing *sym) {
  // printf(
  //   "%2d %c %2d %2d %d\t",
  //   sym->sym.col, sym->sym.symbol,
  //   num->num.col0, num->num.col1, num->num.value
  // );
  return num->num.value;
}

static int after_row_1(struct row*) { return 0; }

static int part1() {
  return parser(found_adjacent_1, after_row_1);
}

static int found_adjacent_2(struct thing *num, struct thing *sym) {
  if(sym->sym.symbol != '*') return 0;

  ++sym->sym.nums_adj;

  if(sym->sym.nums_adj == 1) sym->sym.ratio = num->num.value;
  else if(sym->sym.nums_adj == 2) sym->sym.ratio *= num->num.value;

  return 0;
}

static int after_row_2(struct row *row) {
  int sum = 0;

  for(int n=0; n < row->n_things; ++n) {
    struct thing *thing = &row->things[n];

    if(thing->type != SYMBOL) continue;
    if(thing->sym.symbol != '*') continue;
    // printf("* %d %d\t", thing->sym.nums_adj, thing->sym.ratio);
    if(thing->sym.nums_adj != 2) continue;

    sum += thing->sym.ratio;
  }

  // printf("\n");

  return sum;
}

static int part2() {
  return parser(found_adjacent_2, after_row_2);
}

struct aoc_day day3 = {
  .part1 = { .impl = part1, .answer = 537732, .runs = 1000 },
  .part2 = { .impl = part2, .answer = 84883664, .runs = 1000 }
};
