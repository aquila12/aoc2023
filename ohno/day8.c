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

  return (k * 26 + j) * 26 + i;
}

static int parse(char *seq, int map[MAX_NODES][2]) {
  FILE *input = fopen("../input/day8", "r");
  // FILE *input = fopen("../spec/examples/day8_2a", "r");

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

static int lcm(int *nums, int count) {
  // No, I'm not seeding primes, that's out of the question
  // The challenge already shortcuts on the general case of offset phases
  // So my solution shortcuts too
  int p100[] = {
    2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79,
    83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173,
    179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271,
    277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383,
    389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491,
    499, 503, 509, 521, 523, 541
  };

  int64_t product = 1;

  for(int i = 0; i < 100; ++i) {
    int c_max = 0, p = p100[i];

    // Iterate each number and find out how many times this factor goes in
    for(int j = 0; j < count; ++j) {
      int n = nums[j], c = 0;
      while((n % p) == 0) {
        n /= p;
        ++c;
      }

      if(c > c_max) c_max = c;
    }

    // Take the maximum count of this prime factor
    for(int j = c_max; j > 0; --j) product *= p;
  }

  return product;
}

static int part2() {
  int n;
  int map[MAX_NODES][2];
  for(n = 0; n < MAX_NODES; ++n) map[n][0] = -1;

  char sequence[MAX_SEQUENCE];

  int n_seq = parse(sequence, map);

  int aab = node_num("AAB", 0);
  int aaz = node_num("AAZ", 0);

  int node[50]; // Allow up to 50 start nodes
  int last_end[50], period[50];
  int n_walks = 0;
  for(n = 0; n < aab; ++n) {
    if(map[n][0] < 0) continue;

    last_end[n_walks] = 0;
    period[n_walks] = 0;
    node[n_walks++] = n;
    if(n_walks > 50) return -1;
  }
  // printf("Found %d walks\n", n_walks);

  int steps = 0;
  int i = 0;
  int d;

  // NB: On inspecting the input behaviour, the period is the same as the initial steps to completion
  while(1) {
    for(n = 0; n < n_walks; ++n) {
      if(node[n] < aaz) break;
    }

    // Unlikely!
    if(n == n_walks) return steps;

    // Detect periodicity
    for(n = 0; n < n_walks; ++n) {
      if(node[n] < aaz) continue;

      if(last_end[n]) period[n] = steps - last_end[n];
      last_end[n] = steps;
    }

    for(n = 0; n < n_walks; ++n) {
      if(!period[n]) break;
    }

    if(n == n_walks) {
      return lcm(period, n_walks);
    }


    d = sequence[i++];
    if(i >= n_seq) i = 0;

    for(n = 0; n < n_walks; ++n) node[n] = map[node[n]][d];
    ++steps;
  }

  return steps;
}

struct aoc_day day8 = {
  .part1 = { .impl = part1, .answer = 17141 },
  .part2 = { .impl = part2, .answer = 10818234074807 }
};
