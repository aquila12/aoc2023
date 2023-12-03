/* Entry point */

#include "stdio.h"
#include "aoc.h"
#include "time.h"

int null_implementation() { return 0; };

extern struct aoc_day day1, day2, day3;

struct aoc_day* days[] = {
  &day1, &day2, &day3
};

void run_part(struct aoc_part *part) {
  struct timespec t0, t1;

  if(part->impl) {
    printf("...");

    int answer = 0;

    clock_gettime(CLOCK_MONOTONIC, &t0);
    for(int i = 0; i < part->runs; ++i) answer = part->impl();
    clock_gettime(CLOCK_MONOTONIC, &t1);

    printf("%d", answer);
    if(answer == part->answer) printf(" (correct)");
    else printf(" (should be %d)", part->answer);

    __uint64_t delta = t1.tv_sec - t0.tv_sec;
    delta *= 1000000000;
    delta += (t1.tv_nsec - t0.tv_nsec);
    delta /= part->runs;
    printf(" in %ld ns", delta);
  } else {
    printf(" - no implementation\n");
  }
}

static void run_day(int d) {
  for(int p = 0; p < 2; ++p) {
    printf("Run day %d part %d", d + 1, p + 1);
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


}
