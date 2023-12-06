/* AoC2023 Day 6 */

#include "aoc.h"
#include "stdio.h"
#include "math.h"
#include "stdint.h"

#define CARD_SIZE 10

struct races {
  uint64_t times[CARD_SIZE];
  uint64_t distances[CARD_SIZE];
  int count;
};

static void parse_card(
  struct races *races,
  void (parse_line)(char *, size_t, struct races *)
) {
  FILE *input = fopen("../input/day6", "r");

  if(!input) {
    printf("failed to read input file!\n");
    return;
  }

  char *line = NULL;
  size_t buflen = 0;
  size_t linelen; // Strictly ssize_t, vscode warns though

  while ((linelen = getline(&line, &buflen, input)) != -1) {
    if(linelen) parse_line(line, linelen, races);
  };

  fclose(input);
}

static void parse_line_p1(char *line, size_t linelen, struct races *races) {
  int i;
  uint64_t n = 0;
  int j = 0;
  uint64_t *ary = (line[0] == 'T') ? races->times : races->distances;
  int j_ = races->count;

  for(i = 1; i < linelen; ++i) {
    char c = line[i];

    if(c < '0' || c > '9') {
      if(n) ary[j++] = n;
      n = 0;
    } else {
      n *= 10;
      n += c - '0';
    }
  }

  races->count = (j < j_) ? j : j_;
}

static int race_margin(uint64_t time, uint64_t distance) {
  int64_t a = -1, b = time, c = -distance;

  double sqrt_term = sqrt(b * b - 4 * a * c);
  double over_2a = 1.0f / (double)(2 * a);

  double x0 = ((double)-b + sqrt_term) * over_2a;
  double x1 = ((double)-b - sqrt_term) * over_2a;

  double min, max;

  if(x0 < x1) { min = x0; max = x1; }
  else { min = x1; max = x0; }

  return 1 + ceil(max - 1.0L) - floor(min + 1.0L);
};

static int part1() {
  struct races races = { .count = CARD_SIZE };
  parse_card(&races, parse_line_p1);

  int product = 1;
  for(int r = 0; r < races.count; ++r) {
    product *= race_margin(races.times[r], races.distances[r]);
  }
  return product;
}

static void parse_line_p2(char *line, size_t linelen, struct races *races) {
  int i;
  uint64_t n = 0;
  int j = 0;
  uint64_t *ary = (line[0] == 'T') ? races->times : races->distances;

  for(i = 1; i < linelen; ++i) {
    char c = line[i];

    if(c < '0' || c > '9');
    else {
      n *= 10;
      n += c - '0';
    }
  }

  ary[j++] = n;
}

static int part2() {
  struct races races = { .count = 1 };
  parse_card(&races, parse_line_p2);

  return race_margin(races.times[0], races.distances[0]);
}

struct aoc_day day6 = {
  .part1 = { .impl = part1, .answer = 1710720 },
  .part2 = { .impl = part2, .answer = 35349468 }
};
