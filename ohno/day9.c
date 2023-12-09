/* AoC2023 Day 9 */

#include "aoc.h"
#include "stdio.h"
#include "stdlib.h"

static int next_value(int *seq, int len) {
  int *dif = alloca(sizeof(int) * (len - 1));
  int dif_zeroes = 1;

  for(int i = 1; i < len; ++i) {
    dif[i - 1] = seq[i] - seq[i - 1];
    if(dif[i - 1]) dif_zeroes = 0;
  }

  int last = seq[len - 1];
  return dif_zeroes ? last : last + next_value(dif, len - 1);
}

static int prev_value(int *seq, int len) {
  int *dif = alloca(sizeof(int) * (len - 1));
  int dif_zeroes = 1;

  for(int i = 1; i < len; ++i) {
    dif[i - 1] = seq[i] - seq[i - 1];
    if(dif[i - 1]) dif_zeroes = 0;
  }

  int first = seq[0];
  return dif_zeroes ? first : first - prev_value(dif, len - 1);
}

static int sum_values(int (*seq_fn)(int *, int)) {
  int sum = 0;

  FILE *input = fopen("../input/day9", "r");

  if(!input) {
    printf("failed to read input file!\n");
    return 0;
  }

  char *line = NULL;
  size_t buflen = 0;
  size_t linelen; // Strictly ssize_t, vscode warns though

  int ary[1000];
  int len = 0;
  int n, neg;

  while ((linelen = getline(&line, &buflen, input)) != -1) {
    len = n = neg = 0;
    for(int i = 0; i < linelen; ++i) {
      char c = line[i];

      if(c == '-') neg = 1;
      else if(c < '0' || c > '9') {
        ary[len++] = neg ? -n : n;
        n = neg = 0;
      } else {
        n *= 10;
        n += c - '0';
      }
    }

    sum += seq_fn(ary, len);;
  };

  if(line) free(line);

  fclose(input);

  return sum;
}

static int part1() {
  return sum_values(next_value);
}

static int part2() {
  return sum_values(prev_value);
}

struct aoc_day day9 = {
  .part1 = { .impl = part1, .answer = 2008960228 },
  .part2 = { .impl = part2, .answer = 1097 }
};
