/* AoC Day 8 */

#include "aoc.h"
#include "stdlib.h"
#include "stdio.h"

#define MAX_SEQUENCE 1000
#define MAX_NODES (26 * 26 * 26)

static int node_num(char *letters, int offset) {
  int i = letters[0 + offset] - 'A';
  int j = letters[1 + offset] - 'A';
  int k = letters[2 + offset] - 'A';

  return (i * 26 + j) * 26 + k;
}

static int parse(char *seq, int map[MAX_NODES][2]) {
  FILE *input = fopen("../input/day8", "r");

  if(!input) {
    printf("failed to read input file!\n");
    return -1;
  }

  char *line = NULL;
  size_t buflen = 0;
  size_t linelen;

  int sequence_length = 0;

  while ((linelen = getline(&line, &buflen, input)) != -1) {
    if(!sequence_length) {
      for(sequence_length = 0; sequence_length < linelen; ++sequence_length) {
        char c = line[sequence_length];
        if(c != 'L' && c != 'R') break;
        seq[sequence_length] = (c == 'L') ? 0 : 1;
      }
      continue;
    }

    if(linelen < 15) continue;

    int this_node = node_num(line, 0);
    int left_node = node_num(line, 7);
    int right_node = node_num(line, 12);

    map[this_node][0] = left_node;
    map[this_node][1] = right_node;
  }

  if(line) free(line);

  fclose(input);

  return sequence_length;
}

static int part1() {
  int map[MAX_NODES][2];
  char sequence[MAX_SEQUENCE];

  int n_seq = parse(sequence, map);

  int node = node_num("AAA", 0);
  int target = node_num("ZZZ", 0);

  int steps = 0;
  int i = 0;
  int d;
  while(node != target) {
    d = sequence[i++];
    if(i >= n_seq) i = 0;

    node = map[node][d];
    ++steps;
  }

  return steps;
}

static int part2() {
  return 0;
}

struct aoc_day day8 = {
  .part1 = { .impl = part1, .answer = 17141 },
  .part2 = { .impl = part2, .answer = UNKNOWN }
};
