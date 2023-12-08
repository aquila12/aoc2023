/* AoC2023 Day 7 */

#include "aoc.h"
#include "stdlib.h"
#include "stdio.h"

#define MAX_HANDS 2500

struct hand {
  int order;    // Sort order of the hand
  int bid;
};

/* Sorting network
  https://bertdobbelaere.github.io/sorting_networks.html#N5L9D5 */
/* Swap out of order numbers */
inline static void sn_connector(char* ary, int w1, int w2) {
  if(ary[w2] < ary[w1]) {
    char tmp = ary[w1];
    ary[w1] = ary[w2];
    ary[w2] = tmp;
  }
};
/* Actual network */
inline static void sort_hand(char *v) {
  sn_connector(v, 0, 3); sn_connector(v, 1, 4);
  sn_connector(v, 0, 2); sn_connector(v, 1, 3);
  sn_connector(v, 0, 1); sn_connector(v, 2, 4);
  sn_connector(v, 1, 2); sn_connector(v, 3, 4);
  sn_connector(v, 2, 3);
}

// /* Begin test code */
// static int is_hand_sorted(struct hand *i_hand) {
//   for(int x = 1; x < 5; ++x) {
//     if(i_hand->card[x] < i_hand->card[x-1]) return 0;
//   }

//   return 1;
// }

// static int day7_exhaustive_test_sort_hand() {
//   char i, j, k, l, m;
//   int pass = 0, fail = 0;

//   for(i = 0; i < 5; ++i)
//   for(j = 0; j < 5; ++j)
//   for(k = 0; k < 5; ++k)
//   for(l = 0; l < 5; ++l)
//   for(m = 0; m < 5; ++m) {
//     struct hand h = { .card = {i, j, k, l, m} };

//     sort_hand(&h.card);

//     if(is_hand_sorted(&h)) ++pass;
//     else ++fail;
//   }

//   printf("Pass %d / Fail %d\n", pass, fail);
//   exit(1);

//   return 0;
// }
// /* End test code */

/* Requires sorted hand as input */
static int hand_type(char *v, int jokers) {
  if(jokers == 5) return 0x50;

  int uniqs = 1;
  int run = 1;
  int max_run = 0;

  for(int i = 1; i < 5; ++i) {
    if(v[i] == v[i - 1]) {
      ++run;
    } else {
      run = 1;
      ++uniqs;
    }
    if(run > max_run) max_run = run;
  }

  int bonus = 0x10 * jokers;

  switch(max_run) {
    case 1: return bonus + 0x10;
    case 2: return bonus + ((uniqs == 3) ? 0x22 : 0x20);
    case 3: return bonus + ((uniqs == 2) ? 0x32 : 0x30);
    case 4: return bonus + 0x40;
    case 5: return 0x50;
  }

  return 999; // Never get here
}

static int compare_hands(const void *pa, const void *pb) {
  const struct hand *ha = pa, *hb = pb;

  return ha->order - hb->order;
}

static int camel_cards(const char* labels) {
  char value[128] = {};

  for(int i=0; i<14; ++i) { value[(int)labels[i]] = 13 - i; };

  struct hand hands[MAX_HANDS];
  int n_hands = 0;

  FILE *input = fopen("../input/day7", "r");

  if(!input) {
    printf("failed to read input file!\n");
    return -1;
  }

  char *line = NULL;
  size_t buflen = 0;
  size_t linelen; // Strictly ssize_t, vscode warns though

  char hand_to_sort[5];
  int i, bid, order, jokers;

  while ((linelen = getline(&line, &buflen, input)) != -1) {
    if(linelen < 7) continue; // Reject short lines

    order = 0;
    jokers = 0;

    for(i = 0; i < 5; ++i) {
      char v = value[(int)line[i]];
      if(!v) {
        ++jokers;
        hand_to_sort[i] = -i;
      } else hand_to_sort[i] = v;

      order <<= 4;
      order += v;
    }

    bid = 0;

    for(i = 6; i < linelen; ++i) {
      char c = line[i];
      if(c < '0' || c > '9') continue;

      bid *= 10;
      bid += c - '0';
    }

    struct hand *this_hand = &hands[n_hands++];

    sort_hand(hand_to_sort);
    this_hand->order = (hand_type(hand_to_sort, jokers) << 20) + order;
    this_hand->bid = bid;
  };

  if(line) free(line);

  fclose(input);
  qsort(hands, n_hands, sizeof(hands[0]), compare_hands);

  int total = 0;
  i = 0;
  while(i < n_hands) {
    bid = hands[i].bid;
    ++i;
    total += bid * i;
  }

  return total;
}

static int part1() {
  return camel_cards("AKQJT98765432 ");
}

static int part2() {
  return camel_cards("AKQT98765432 J");
}

struct aoc_day day7 = {
  .part1 = { .impl = part1, .answer = 247823654 },
  .part2 = { .impl = part2, .answer = 245461700 }
};
