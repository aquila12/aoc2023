/* AoC2023 Day 1 */

#include "aoc.h"
#include "stdio.h"

static int sum_calibration_values(int (*find_digits)(char*,int,int)) {
  int sum = 0;

  FILE *input = fopen("../input/day1", "r");

  if(!input) {
    printf("failed to read input file!\n");
    return 0;
  }

  char *line = NULL;
  size_t buflen = 0;
  size_t linelen; // Strictly ssize_t, vscode warns though

  while ((linelen = getline(&line, &buflen, input)) != -1) {
    int first = find_digits(line, 0, linelen);
    int last = find_digits(line, linelen - 1, -1);

    sum += 10 * first + last;
  };

  fclose(input);

  return sum;
}

static int part1_digit(char *line, int start, int end) {
  for(int i = start; i != end; (start < end) ? ++i : --i) {
    char c = line[i];
    if(c >= '0' && c <= '9') return c - '0';
  }

  // No character found, this shouldn't occur
  return -1;
}

static int part1() {
  return sum_calibration_values(part1_digit);
}

static int part2_digit(char *line, int start, int end) {
  const char * const digits[] = {
    "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
  };

  const char * const stigid[] = {
    "eno", "owt", "eerht", "ruof", "evif", "xis", "neves", "thgie", "enin"
  };

  const char * const *digset = (start < end) ? digits : stigid;

  int matchpos[9] = {};

  for(int i = start; i != end; (start < end) ? ++i : --i) {
    char c = line[i];
    if(c >= '0' && c <= '9') return c - '0';

    for(int d = 0; d < 9; ++d) {
      if(c != digset[d][matchpos[d]++]) {
        matchpos[d] = 0;
        /* On no match, need to recheck the first character */
        /* Strictly speaking, we may need to backtrack smarter e.g. for "ninine" */
        if(c == digset[d][0]) ++matchpos[d];
      }

      if(digset[d][matchpos[d]] == '\0') return d + 1;
    }
  }

  // No character found, this shouldn't occur
  return -1;
}

static int part2() {
  return sum_calibration_values(part2_digit);
}

struct aoc_day day1 = {
  .part1 = { .impl = part1, .answer = 54951 },
  .part2 = { .impl = part2, .answer = 55218 }
};
