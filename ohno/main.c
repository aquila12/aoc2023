/* Entry point */

#include "stdio.h"
#include "stdlib.h"
#include "aoc.h"
#include "time.h"

int null_implementation() { return 0; };

struct aoc_day skipped = {
  .part1 = { .impl = 0, .answer = UNKNOWN },
  .part2 = { .impl = 0, .answer = UNKNOWN }
};

extern struct aoc_day day1, day2, day3, day4, skipped, day6, day7, day8;

struct aoc_day* days[] = {
  &day1, &day2, &day3, &day4, &skipped, &day6, &day7, &day8
};

float tv_delta(struct timespec *start, struct timespec *end) {
  float sec = end->tv_sec - start->tv_sec;
  float ns = end->tv_nsec - start->tv_nsec;
  return (sec * 1000000.0) + (ns / 1000.0);
}

int float_by_value_asc(const void *pa, const void *pb) {
  const float *a = pa, *b = pb;
  return (*a < *b) ? -1 : (*a > *b) ? 1 : 0;
}

void run_part(struct aoc_part *part) {
  const int n_runs = 101;
  struct timespec t[n_runs + 1];

  if(part->impl) {
    printf("...");

    int answer = 0;

    if(clock_gettime(CLOCK_MONOTONIC, &t[0]))
      perror("WARNING: Failed to get system time");

    for(int n = 0; n < n_runs; ++n) {
      answer = part->impl();
      clock_gettime(CLOCK_MONOTONIC, &t[n+1]);
    }

    float times[n_runs];
    for(int n = 0; n < n_runs; ++n) times[n] = tv_delta(&t[n], &t[n + 1]);

    qsort(times, n_runs, sizeof(float), float_by_value_asc);

    printf("%9d", answer);
    if(answer == part->answer) printf(" (correct)");
    else printf(" (should be %d)", part->answer);

    printf(" in %5.1f us (avg of %d) ", tv_delta(&t[0], &t[100]) / n_runs, n_runs);
    printf(
      "[min %5.1f, 10p %5.1f, med %5.1f, 90p %5.1f, max %5.1f]",
      times[0], times[10], times[50], times[90], times[100]
    );
  } else {
    printf(" - no implementation");
  }
}

static void run_day(int d) {
  for(int p = 0; p < 2; ++p) {
    printf("Run day %2d part %d", d + 1, p + 1);
    run_part(&days[d]->parts[p]);
    printf("\n");
  }
}

int main(int argc, char* argv[]) {
  size_t n_days = sizeof(days) / sizeof(days[0]);

  printf("AoC 2023\n");
  printf("%ld days\n\n", n_days);

  if(argc > 1) {
    int day;
    if(!sscanf(argv[1], "%d", &day)) {
      printf("Bad day number: %s\n", argv[1]);
      return 1;
    } else if(day < 1 || day > n_days) {
      printf("Day number out of range: %d\n", day);
      return 1;
    }

    run_day(day-1);
  } else
    for(int d = 0; d < n_days; ++d) run_day(d);

  return 0;
}
