/* AoC2023 Day 3 */

#include "aoc.h"

#include "fcntl.h"
#include "unistd.h"
#include "sys/stat.h"
#include "sys/mman.h"

#include "stdio.h"

static const size_t mmap_len = 65536;

struct thing_sym { int col; char symbol; int ratio; int nums_adj; } sym;
struct thing_num { int col0, col1, value; } num;

struct row {
  int n_syms, n_nums;
  struct thing_sym symbols[50];
  struct thing_num numbers[50];
};

inline static int found_num(
  struct thing_num *num, struct row *this_row, struct row *last_row,
  int (*found_adjacent)(struct thing_num *, struct thing_sym *)
) {
  int sum = 0;
  int lim = last_row->n_syms;

  for(int n = 0; n < lim; ++n) {
    struct thing_sym *sym = &last_row->symbols[n];

    if(sym->col < num->col0) continue;
    if(sym->col > num->col1) break;
    sum += found_adjacent(num, sym);
  }

  int t = this_row->n_syms;
  if(t) {
    struct thing_sym *sym = &this_row->symbols[t - 1];
    if(sym->col == num->col0)
      sum += found_adjacent(num, sym);
  }

  return sum;
}

inline static int found_sym(
  struct thing_sym *sym, struct row *this_row, struct row *last_row,
  int (*found_adjacent)(struct thing_num *, struct thing_sym *)
) {
  int sum = 0;
  int lim = last_row->n_nums;

  for(int n = 0; n < lim; ++n) {
    struct thing_num *num = &last_row->numbers[n];

    if(num->col1 < sym->col) continue;
    if(num->col0 > sym->col) break;
    sum += found_adjacent(num, sym);
  }

  int t = this_row->n_nums;
  if(t) {
    struct thing_num *num = &this_row->numbers[t - 1];
    if(num->col1 == sym->col)
      sum += found_adjacent(num, sym);
  }

  return sum;
}

static int parser(
  int (*found_adjacent)(struct thing_num *, struct thing_sym *),
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
  int width, numeral = 0, col, col0 = 0;

  // Calibrate input - assume constant width (well-behaved input)
  for(width = 0; width < fs.st_size && buf[width] != '\n'; ++width);

  struct row row_a = { .n_nums = 0, .n_syms = 0 }, row_b = { .n_nums = 0, .n_syms = 0 };
  struct row *this_row = &row_a, *last_row = &row_b, *tmp_row;

  while(i < fs.st_size) {
    tmp_row = last_row;
    last_row = this_row;
    this_row = tmp_row;

    this_row->n_nums = 0;
    this_row->n_syms = 0;
    col = 0;

    while(i < fs.st_size) {
      char c = buf[i++];
      if(c >= '0' && c <= '9') {
        if(!numeral) col0 = col - 1;
        else numeral *= 10;

        numeral += c - '0';
      } else {
        if(numeral) {
          struct thing_num *num = &this_row->numbers[this_row->n_nums];
          num->col0 = col0;
          num->col1 = col;
          num->value = numeral;
          ++this_row->n_nums;
          numeral = 0;
          sum += found_num(num, this_row, last_row, found_adjacent);
        }

        if(c == '\n') break; /* EOL Break clause */

        if(c != '.') {
          struct thing_sym *sym = &this_row->symbols[this_row->n_syms];
          sym->col = col;
          sym->symbol = c;
          sym->nums_adj = 0;
          sym->ratio = 0;
          ++this_row->n_syms;
          sum += found_sym(sym, this_row, last_row, found_adjacent);
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
static int found_adjacent_1(struct thing_num *num, struct thing_sym *sym) {
  // printf(
  //   "%2d %c %2d %2d %d\t",
  //   sym->sym.col, sym->sym.symbol,
  //   num->num.col0, num->num.col1, num->num.value
  // );
  return num->value;
}

static int after_row_1(struct row *_) { return 0; }

static int part1() {
  return parser(found_adjacent_1, after_row_1);
}

static int found_adjacent_2(struct thing_num *num, struct thing_sym *sym) {
  if(sym->symbol != '*') return 0;

  ++sym->nums_adj;

  if(sym->nums_adj == 1) sym->ratio = num->value;
  else if(sym->nums_adj == 2) sym->ratio *= num->value;

  return 0;
}

static int after_row_2(struct row *row) {
  int sum = 0;

  for(int n=0; n < row->n_syms; ++n) {
    struct thing_sym *sym = &row->symbols[n];

    if(sym->symbol != '*') continue;
    if(sym->nums_adj != 2) continue;

    sum += sym->ratio;
  }

  // printf("\n");

  return sum;
}

static int part2() {
  return parser(found_adjacent_2, after_row_2);
}

struct aoc_day day3 = {
  .part1 = { .impl = part1, .answer = 537732 },
  .part2 = { .impl = part2, .answer = 84883664 }
};
